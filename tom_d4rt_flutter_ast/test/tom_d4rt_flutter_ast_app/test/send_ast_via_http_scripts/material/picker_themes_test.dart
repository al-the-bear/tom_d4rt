// D4rt test script: deep visual demo of picker theme data types.
// Covers DatePickerThemeData, TimePickerThemeData, MenuThemeData,
// MenuButtonThemeData, MenuBarThemeData, PopupMenuThemeData and
// DropdownMenuThemeData with mock picker previews + wiring sample.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// SKIN MODEL
// ---------------------------------------------------------------------------
// A compact reusable bag of colors and shapes used to construct three
// distinct DatePickerThemeData / TimePickerThemeData instances side by side.
class _Skin {
  const _Skin({
    required this.name,
    required this.surface,
    required this.onSurface,
    required this.header,
    required this.onHeader,
    required this.accent,
    required this.muted,
    required this.divider,
  });

  final String name;
  final Color surface;
  final Color onSurface;
  final Color header;
  final Color onHeader;
  final Color accent;
  final Color muted;
  final Color divider;
}

const _Skin _morning = _Skin(
  name: 'morning',
  surface: Color(0xFFFFFDF6),
  onSurface: Color(0xFF2A2300),
  header: Color(0xFFFFC629),
  onHeader: Color(0xFF2A2300),
  accent: Color(0xFFE08A00),
  muted: Color(0xFFB39B6A),
  divider: Color(0xFFEEDFB7),
);

const _Skin _midnight = _Skin(
  name: 'midnight',
  surface: Color(0xFF0B1530),
  onSurface: Color(0xFFE0E6FF),
  header: Color(0xFF1A2F66),
  onHeader: Color(0xFFCBD6FF),
  accent: Color(0xFF4F8CFF),
  muted: Color(0xFF6E7BB4),
  divider: Color(0xFF1F2B4D),
);

const _Skin _rose = _Skin(
  name: 'rose',
  surface: Color(0xFFFFF5F9),
  onSurface: Color(0xFF3A0E22),
  header: Color(0xFFD81B60),
  onHeader: Color(0xFFFFE9F1),
  accent: Color(0xFFAD1457),
  muted: Color(0xFFB58CA0),
  divider: Color(0xFFF1C4D7),
);

// ---------------------------------------------------------------------------
// THEME FACTORIES
// ---------------------------------------------------------------------------
DatePickerThemeData _datePickerFor(_Skin s) {
  return DatePickerThemeData(
    backgroundColor: s.surface,
    elevation: 6.0,
    shadowColor: const Color(0x33000000),
    surfaceTintColor: s.accent.withValues(alpha: 0.06),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
    headerBackgroundColor: s.header,
    headerForegroundColor: s.onHeader,
    headerHeadlineStyle: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
      color: s.onHeader,
    ),
    headerHelpStyle: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      color: s.onHeader.withValues(alpha: 0.80),
    ),
    dayStyle: TextStyle(fontSize: 14.0, color: s.onSurface),
    dayForegroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return s.onHeader;
      if (states.contains(WidgetState.disabled)) return s.muted;
      return s.onSurface;
    }),
    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return s.accent;
      return const Color(0x00000000);
    }),
    dayOverlayColor: WidgetStateProperty.all(s.accent.withValues(alpha: 0.10)),
    todayForegroundColor: WidgetStateProperty.all(s.accent),
    todayBackgroundColor: WidgetStateProperty.all(const Color(0x00000000)),
    todayBorder: BorderSide(color: s.accent, width: 1.0),
    yearStyle: TextStyle(fontSize: 16.0, color: s.onSurface),
    yearForegroundColor: WidgetStateProperty.all(s.onSurface),
    yearBackgroundColor: WidgetStateProperty.all(const Color(0x00000000)),
    yearOverlayColor: WidgetStateProperty.all(s.accent.withValues(alpha: 0.10)),
    weekdayStyle: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: s.muted,
    ),
    rangePickerBackgroundColor: s.surface,
    rangePickerElevation: 0.0,
    rangePickerShadowColor: const Color(0x00000000),
    rangePickerSurfaceTintColor: const Color(0x00000000),
    rangePickerHeaderBackgroundColor: s.header,
    rangePickerHeaderForegroundColor: s.onHeader,
    rangePickerHeaderHeadlineStyle: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
      color: s.onHeader,
    ),
    rangePickerHeaderHelpStyle: TextStyle(fontSize: 12.0, color: s.onHeader),
    rangeSelectionBackgroundColor: s.accent.withValues(alpha: 0.18),
    rangeSelectionOverlayColor: WidgetStateProperty.all(
      s.accent.withValues(alpha: 0.10),
    ),
    dividerColor: s.divider,
    cancelButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(s.muted),
    ),
    confirmButtonStyle: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(s.accent),
    ),
  );
}

TimePickerThemeData _timePickerFor(_Skin s) {
  return TimePickerThemeData(
    backgroundColor: s.surface,
    elevation: 6.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
    dialBackgroundColor: s.header.withValues(alpha: 0.18),
    dialHandColor: s.accent,
    dialTextColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return s.onHeader;
      return s.onSurface;
    }),
    dialTextStyle: TextStyle(fontSize: 14.0, color: s.onSurface),
    entryModeIconColor: s.accent,
    helpTextStyle: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: s.muted,
    ),
    hourMinuteShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: s.divider, width: 1.0),
    ),
    hourMinuteColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return s.accent.withValues(alpha: 0.18);
      }
      return s.divider.withValues(alpha: 0.30);
    }),
    hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return s.accent;
      return s.onSurface;
    }),
    hourMinuteTextStyle: const TextStyle(
      fontSize: 42.0,
      fontWeight: FontWeight.w300,
    ),
    dayPeriodBorderSide: BorderSide(color: s.divider, width: 1.0),
    dayPeriodColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return s.accent.withValues(alpha: 0.18);
      }
      return const Color(0x00000000);
    }),
    dayPeriodShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: s.divider, width: 1.0),
    ),
    dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return s.accent;
      return s.muted;
    }),
    dayPeriodTextStyle: const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: s.divider.withValues(alpha: 0.30),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 10.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: s.divider),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION HEADER UTILITY
// ---------------------------------------------------------------------------
Widget _sectionTitle(String number, String title, String subtitle, Color tint) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          tint.withValues(alpha: 0.18),
          tint.withValues(alpha: 0.04),
        ],
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: tint.withValues(alpha: 0.45), width: 1.5),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: tint,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12.0, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// MOCK DATE PICKER PREVIEW
// ---------------------------------------------------------------------------
Widget _datePickerPreview(_Skin s, DatePickerThemeData t) {
  final List<String> weekdays = <String>['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final List<Widget> dayCells = <Widget>[];
  for (int day = 1; day <= 28; day++) {
    final bool isSelected = day == 17;
    final bool isToday = day == 11;
    final Color bg = isSelected ? s.accent : const Color(0x00000000);
    final Color fg = isSelected ? s.onHeader : s.onSurface;
    dayCells.add(
      Container(
        width: 30.0,
        height: 30.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: isToday ? Border.all(color: s.accent, width: 1.2) : null,
        ),
        child: Text(
          '$day',
          style: TextStyle(
            color: isToday && !isSelected ? s.accent : fg,
            fontSize: 12.0,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: t.backgroundColor,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0x33000000),
          blurRadius: (t.elevation ?? 0.0) + 2.0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          color: t.headerBackgroundColor,
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('SELECT DATE', style: t.headerHelpStyle),
              const SizedBox(height: 8.0),
              Text('Wed, May 17', style: t.headerHeadlineStyle),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('May 2026', style: t.yearStyle),
                  Row(
                    children: <Widget>[
                      Icon(Icons.chevron_left, color: s.muted, size: 20.0),
                      const SizedBox(width: 8.0),
                      Icon(Icons.chevron_right, color: s.muted, size: 20.0),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: weekdays
                    .map((String w) => Text(w, style: t.weekdayStyle))
                    .toList(),
              ),
              const SizedBox(height: 6.0),
              Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children: dayCells,
              ),
              Divider(color: t.dividerColor, height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'CANCEL',
                    style: TextStyle(
                      color: s.muted,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    'OK',
                    style: TextStyle(
                      color: s.accent,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// MOCK TIME PICKER PREVIEW (dial style)
// ---------------------------------------------------------------------------
Widget _timePickerPreview(_Skin s, TimePickerThemeData t) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: t.backgroundColor,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0x33000000),
          blurRadius: (t.elevation ?? 0.0) + 2.0,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('SELECT TIME', style: t.helpTextStyle),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 80.0,
              height: 60.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: s.accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: s.divider, width: 1.0),
              ),
              child: Text(
                '10',
                style: TextStyle(
                  color: s.accent,
                  fontSize: 38.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                ':',
                style: TextStyle(
                  color: s.onSurface,
                  fontSize: 38.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              width: 80.0,
              height: 60.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: s.divider.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: s.divider, width: 1.0),
              ),
              child: Text(
                '45',
                style: TextStyle(
                  color: s.onSurface,
                  fontSize: 38.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 26.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: s.accent.withValues(alpha: 0.18),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8.0),
                    ),
                    border: Border.all(color: s.divider, width: 1.0),
                  ),
                  child: Text(
                    'AM',
                    style: TextStyle(
                      color: s.accent,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 40.0,
                  height: 26.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0x00000000),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(8.0),
                    ),
                    border: Border.all(color: s.divider, width: 1.0),
                  ),
                  child: Text(
                    'PM',
                    style: TextStyle(
                      color: s.muted,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 160.0,
                height: 160.0,
                decoration: BoxDecoration(
                  color: t.dialBackgroundColor,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 4.0,
                height: 70.0,
                margin: const EdgeInsets.only(bottom: 70.0),
                decoration: BoxDecoration(
                  color: t.dialHandColor,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              Container(
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                  color: t.dialHandColor,
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                top: 6.0,
                child: Text(
                  '12',
                  style: TextStyle(color: s.onSurface, fontSize: 12.0),
                ),
              ),
              Positioned(
                bottom: 6.0,
                child: Text(
                  '6',
                  style: TextStyle(color: s.onSurface, fontSize: 12.0),
                ),
              ),
              Positioned(
                left: 8.0,
                child: Text(
                  '9',
                  style: TextStyle(color: s.onSurface, fontSize: 12.0),
                ),
              ),
              Positioned(
                right: 8.0,
                child: Text(
                  '3',
                  style: TextStyle(color: s.onSurface, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.keyboard, color: t.entryModeIconColor, size: 20.0),
            Row(
              children: <Widget>[
                Text(
                  'CANCEL',
                  style: TextStyle(
                    color: s.muted,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.0,
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  'OK',
                  style: TextStyle(
                    color: s.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// LEGEND ROW: code field name -> visual swatch -> description.
// ---------------------------------------------------------------------------
Widget _legendRow(String field, Color swatch, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 18.0,
          height: 18.0,
          margin: const EdgeInsets.only(top: 2.0, right: 10.0),
          decoration: BoxDecoration(
            color: swatch,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: Colors.black26),
          ),
        ),
        SizedBox(
          width: 200.0,
          child: Text(
            field,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
              color: Color(0xFF1A237E),
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(fontSize: 12.0, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// MAIN BUILD
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  debugPrint('PickerThemes deep demo executing');

  // SECTION 1: Hero header
  final Widget heroHeader = Container(
    width: double.infinity,
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF1A237E),
          Color(0xFF5E35B1),
          Color(0xFFD81B60),
        ],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 18.0,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.palette_outlined, color: Colors.white, size: 32.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Picker themes: the M3 picker style atlas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'DatePickerThemeData, TimePickerThemeData, MenuThemeData, '
          'MenuButtonThemeData, MenuBarThemeData, PopupMenuThemeData and '
          'DropdownMenuThemeData drive every visual aspect of the Material '
          'picker/menu surfaces. The framework reads these via Theme.of and '
          'composes them with ThemeData.datePickerTheme, ThemeData.timePickerTheme '
          'and the various menu theme slots.',
          style: TextStyle(color: Colors.white, fontSize: 13.0, height: 1.5),
        ),
      ],
    ),
  );

  // SECTION 2: DatePicker anatomy
  final DatePickerThemeData morningDate = _datePickerFor(_morning);
  final DatePickerThemeData midnightDate = _datePickerFor(_midnight);
  final DatePickerThemeData roseDate = _datePickerFor(_rose);

  final Widget dateAnatomy = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade100),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 8.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'DatePickerThemeData anatomy',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Each field controls a specific part of the picker dialog. '
          'Hover the swatch to map the property onto the preview.',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                width: 280.0,
                child: _datePickerPreview(_morning, morningDate),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _legendRow(
                    'backgroundColor',
                    _morning.surface,
                    'Surface color of the dialog body.',
                  ),
                  _legendRow(
                    'headerBackgroundColor',
                    _morning.header,
                    'Sits behind the selected date headline.',
                  ),
                  _legendRow(
                    'headerForegroundColor',
                    _morning.onHeader,
                    'Foreground tint of headline + help.',
                  ),
                  _legendRow(
                    'dayBackgroundColor(selected)',
                    _morning.accent,
                    'Filled disc behind the selected day.',
                  ),
                  _legendRow(
                    'todayBorder.color',
                    _morning.accent,
                    'Outlines today when not selected.',
                  ),
                  _legendRow(
                    'weekdayStyle.color',
                    _morning.muted,
                    'Mon/Tue/Wed letters above the grid.',
                  ),
                  _legendRow(
                    'dividerColor',
                    _morning.divider,
                    'Splits action bar from the day grid.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // SECTION 3: Three DatePicker skins
  final Widget dateSkins = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Three DatePickerThemeData skins',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Same widget tree, three different theme instances. Morning is a '
          'soft yellow daylight skin, midnight is a deep cobalt night theme '
          'and rose is an editorial pink palette.',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        const SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 300.0,
                child: _datePickerPreview(_morning, morningDate),
              ),
              SizedBox(
                width: 300.0,
                child: _datePickerPreview(_midnight, midnightDate),
              ),
              SizedBox(
                width: 300.0,
                child: _datePickerPreview(_rose, roseDate),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    ),
  );

  // SECTION 4: TimePicker anatomy
  final TimePickerThemeData morningTime = _timePickerFor(_morning);
  final TimePickerThemeData midnightTime = _timePickerFor(_midnight);
  final TimePickerThemeData roseTime = _timePickerFor(_rose);

  final Widget timeAnatomy = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade100),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x11000000),
          blurRadius: 8.0,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'TimePickerThemeData anatomy',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'The dial-style time picker exposes a rich vocabulary of fields '
          'covering hour / minute fields, the analog dial and the AM/PM toggle.',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                width: 280.0,
                child: _timePickerPreview(_morning, morningTime),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _legendRow(
                    'dialBackgroundColor',
                    _morning.header.withValues(alpha: 0.18),
                    'Background of the analog dial circle.',
                  ),
                  _legendRow(
                    'dialHandColor',
                    _morning.accent,
                    'Color of the dial pointer.',
                  ),
                  _legendRow(
                    'dialTextColor',
                    _morning.onSurface,
                    'Hour numerals around the dial.',
                  ),
                  _legendRow(
                    'hourMinuteColor(selected)',
                    _morning.accent.withValues(alpha: 0.18),
                    'Fill of the active hour/minute field.',
                  ),
                  _legendRow(
                    'hourMinuteTextColor',
                    _morning.accent,
                    'Number rendered inside the selected field.',
                  ),
                  _legendRow(
                    'dayPeriodColor',
                    _morning.accent.withValues(alpha: 0.18),
                    'AM / PM toggle background when selected.',
                  ),
                  _legendRow(
                    'entryModeIconColor',
                    _morning.accent,
                    'Keyboard switch icon at the bottom.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // SECTION 5: Three TimePicker skins
  final Widget timeSkins = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Three TimePickerThemeData skins',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 320.0,
                child: _timePickerPreview(_morning, morningTime),
              ),
              SizedBox(
                width: 320.0,
                child: _timePickerPreview(_midnight, midnightTime),
              ),
              SizedBox(
                width: 320.0,
                child: _timePickerPreview(_rose, roseTime),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    ),
  );

  // SECTION 6: MenuTheme + MenuBar + MenuButton
  final MenuThemeData menuTheme = MenuThemeData(
    style: MenuStyle(
      backgroundColor: WidgetStateProperty.all(_midnight.header),
      surfaceTintColor: WidgetStateProperty.all(_midnight.accent),
      elevation: WidgetStateProperty.all(8.0),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    ),
  );

  final MenuBarThemeData menuBarTheme = MenuBarThemeData(
    style: MenuStyle(
      backgroundColor: WidgetStateProperty.all(_midnight.surface),
      elevation: WidgetStateProperty.all(2.0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      ),
    ),
  );

  final MenuButtonThemeData menuButtonTheme = MenuButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) return _midnight.onHeader;
        return _midnight.onSurface;
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return _midnight.accent.withValues(alpha: 0.20);
        }
        return const Color(0x00000000);
      }),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),
      ),
    ),
  );

  Widget menuStripFor(String label, IconData icon, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: active
            ? _midnight.accent.withValues(alpha: 0.20)
            : const Color(0x00000000),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 16.0,
            color: active ? _midnight.onHeader : _midnight.onSurface,
          ),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              color: active ? _midnight.onHeader : _midnight.onSurface,
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  final Widget menuBarPreview = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'MenuThemeData + MenuBarThemeData + MenuButtonThemeData',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6.0),
        Text(
          'MenuBar styled by MenuBarThemeData (bg=${menuBarTheme.style?.backgroundColor != null ? '#' : ''}'
          'midnight.surface), individual buttons styled by MenuButtonThemeData. '
          'The popup that opens below would inherit MenuThemeData.',
          style: const TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _midnight.surface,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x44000000),
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              menuStripFor('File', Icons.folder_open, false),
              const SizedBox(width: 4.0),
              menuStripFor('Edit', Icons.edit, true),
              const SizedBox(width: 4.0),
              menuStripFor('View', Icons.visibility, false),
              const SizedBox(width: 4.0),
              menuStripFor('Help', Icons.help_outline, false),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 60.0),
            width: 180.0,
            decoration: BoxDecoration(
              color: _midnight.header,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x55000000),
                  blurRadius: 10.0,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                menuStripFor('Undo', Icons.undo, false),
                menuStripFor('Redo', Icons.redo, false),
                Divider(color: _midnight.divider, height: 1.0),
                menuStripFor('Cut', Icons.content_cut, false),
                menuStripFor('Copy', Icons.copy, true),
                menuStripFor('Paste', Icons.paste, false),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // SECTION 7: PopupMenuThemeData
  final PopupMenuThemeData popupTheme = PopupMenuThemeData(
    color: _rose.surface,
    surfaceTintColor: _rose.accent.withValues(alpha: 0.08),
    elevation: 8.0,
    shadowColor: const Color(0x55000000),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
    textStyle: TextStyle(
      fontSize: 13.0,
      color: _rose.onSurface,
      fontWeight: FontWeight.w600,
    ),
    labelTextStyle: WidgetStateProperty.all(
      TextStyle(color: _rose.onSurface, fontSize: 13.0),
    ),
    iconColor: _rose.accent,
    iconSize: 18.0,
    enableFeedback: true,
    position: PopupMenuPosition.under,
  );

  final Widget popupPreview = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.pink.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'PopupMenuThemeData',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Custom shape, color, surfaceTintColor, elevation and textStyle. '
          'iconSize=${popupTheme.iconSize}, iconColor=accent.',
          style: const TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: BoxDecoration(
                color: _rose.surface,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _rose.divider),
              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.more_vert, color: _rose.accent, size: 20.0),
                  const SizedBox(width: 6.0),
                  Text(
                    'Open menu',
                    style: TextStyle(
                      color: _rose.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                color: popupTheme.color,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: popupTheme.shadowColor ?? const Color(0x00000000),
                    blurRadius: (popupTheme.elevation ?? 0.0) + 2.0,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.star_outline,
                      color: popupTheme.iconColor,
                      size: popupTheme.iconSize,
                    ),
                    title: Text('Star', style: popupTheme.textStyle),
                  ),
                  ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.share_outlined,
                      color: popupTheme.iconColor,
                      size: popupTheme.iconSize,
                    ),
                    title: Text('Share', style: popupTheme.textStyle),
                  ),
                  ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.delete_outline,
                      color: popupTheme.iconColor,
                      size: popupTheme.iconSize,
                    ),
                    title: Text('Delete', style: popupTheme.textStyle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // SECTION 8: DropdownMenuThemeData
  final DropdownMenuThemeData dropdownTheme = DropdownMenuThemeData(
    textStyle: TextStyle(
      fontSize: 14.0,
      color: _morning.onSurface,
      fontWeight: FontWeight.w600,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _morning.divider.withValues(alpha: 0.40),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 12.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: _morning.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: _morning.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: _morning.accent, width: 2.0),
      ),
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(_morning.surface),
      elevation: WidgetStateProperty.all(6.0),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 6.0),
      ),
    ),
  );

  final Widget dropdownPreview = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.amber.shade100),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'DropdownMenuThemeData',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Drives DropdownMenu trigger + opened-menu surface. '
          'textStyle, inputDecorationTheme and menuStyle compose '
          'a full M3 dropdown style. menuStyle.elevation: '
          '${dropdownTheme.menuStyle?.elevation?.resolve(<WidgetState>{})}.',
          style: const TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 220.0,
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: _morning.divider.withValues(alpha: 0.40),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: _morning.divider),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Sunrise', style: dropdownTheme.textStyle),
                  Icon(Icons.arrow_drop_down, color: _morning.accent),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                color: _morning.surface,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 12.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    color: _morning.accent.withValues(alpha: 0.12),
                    child: Row(
                      children: <Widget>[
                        Text('Sunrise', style: dropdownTheme.textStyle),
                        const Spacer(),
                        Icon(Icons.check, color: _morning.accent, size: 16.0),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Midday', style: dropdownTheme.textStyle),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Sunset', style: dropdownTheme.textStyle),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Midnight', style: dropdownTheme.textStyle),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // SECTION 9: Inheritance pattern
  final Widget inheritanceCard = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.account_tree, color: Colors.indigo),
            SizedBox(width: 8.0),
            Text(
              'Inheritance: Theme(data: ThemeData(datePickerTheme: ...))',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Wrap any subtree with Theme(data: ThemeData.copyWith(...)) to '
          'rebase picker themes for that subtree only. The framework reads '
          'DatePickerTheme.of(context), which falls back to the enclosing '
          'ThemeData.datePickerTheme.',
          style: TextStyle(fontSize: 12.0, color: Colors.black87, height: 1.4),
        ),
        const SizedBox(height: 12.0),
        Theme(
          data: ThemeData(
            useMaterial3: true,
            datePickerTheme: midnightDate,
            timePickerTheme: midnightTime,
            popupMenuTheme: popupTheme,
            menuTheme: menuTheme,
            menuBarTheme: menuBarTheme,
            menuButtonTheme: menuButtonTheme,
            dropdownMenuTheme: dropdownTheme,
          ),
          child: Builder(
            builder: (BuildContext inner) {
              final DatePickerThemeData scoped = DatePickerTheme.of(inner);
              final TimePickerThemeData scopedTime = TimePickerTheme.of(inner);
              return Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: scoped.backgroundColor,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: scoped.headerBackgroundColor ?? Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Scoped Theme — DatePickerTheme.of(context)',
                      style: TextStyle(
                        color: scoped.headerBackgroundColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'bg=${scoped.backgroundColor}\n'
                      'header=${scoped.headerBackgroundColor}\n'
                      'time.dialHand=${scopedTime.dialHandColor}',
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: Colors.white70,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  // SECTION 10: Light vs dark
  final Widget lightVsDark = Container(
    margin: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Light vs dark — composing both at once',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Pair the same picker layout with light + dark theme instances. '
          'Apps typically supply both via ThemeData.datePickerTheme + '
          'darkTheme.datePickerTheme.',
          style: TextStyle(fontSize: 12.0, color: Colors.black54),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Expanded(child: _datePickerPreview(_morning, morningDate)),
            Expanded(child: _datePickerPreview(_midnight, midnightDate)),
          ],
        ),
      ],
    ),
  );

  // SECTION 11: Cheat-sheet card
  final Widget cheatSheet = Container(
    margin: const EdgeInsets.all(12.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cheat-sheet: picker theme data types',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8.0),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(220.0),
            1: FixedColumnWidth(160.0),
            2: FlexColumnWidth(),
          },
          border: TableBorder.all(color: Colors.grey.shade300),
          children: <TableRow>[
            TableRow(
              decoration: BoxDecoration(color: Colors.indigo.shade100),
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Theme data',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Picker / surface',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Notable fields',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            const TableRow(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('DatePickerThemeData'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('showDatePicker'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'header*, dayStyle, dayForeground/Background, todayBorder, '
                    'rangePicker*, weekdayStyle, dividerColor.',
                  ),
                ),
              ],
            ),
            const TableRow(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('TimePickerThemeData'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('showTimePicker'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'dialBackground/Hand/TextColor, hourMinute*, dayPeriod*, '
                    'helpTextStyle, inputDecorationTheme, entryModeIconColor.',
                  ),
                ),
              ],
            ),
            const TableRow(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('MenuThemeData'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('SubMenu / MenuAnchor popup'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'MenuStyle bg, surfaceTint, elevation, padding, shape.',
                  ),
                ),
              ],
            ),
            const TableRow(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('MenuBarThemeData'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('MenuBar'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Background and shape of the bar itself.'),
                ),
              ],
            ),
            const TableRow(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('MenuButtonThemeData'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('MenuItemButton / SubmenuButton'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'ButtonStyle: foreground, background, padding, textStyle.',
                  ),
                ),
              ],
            ),
            const TableRow(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('PopupMenuThemeData'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('PopupMenuButton'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'color, surfaceTintColor, elevation, shape, textStyle, '
                    'iconColor, iconSize, position.',
                  ),
                ),
              ],
            ),
            const TableRow(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('DropdownMenuThemeData'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('DropdownMenu'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'textStyle, inputDecorationTheme, menuStyle.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // SECTION 12: Wiring example with a live IconButton.
  Future<void> openPicker() async {
    debugPrint('Pretending to open picker via showDatePicker(...)');
    // We deliberately do not await showDatePicker in d4rt to avoid modal
    // routes during the static script. The closure exists so the code path
    // is structurally exercised.
  }

  final Widget wiringExample = Theme(
    data: ThemeData(
      useMaterial3: true,
      datePickerTheme: roseDate,
      timePickerTheme: roseTime,
    ),
    child: Builder(
      builder: (BuildContext inner) {
        return Container(
          margin: const EdgeInsets.all(12.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: Colors.pink.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Wiring example — real IconButton + showDatePicker closure',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 6.0),
              const Text(
                'IconButton.onPressed builds a real callback. The wrapper '
                'Theme overrides DatePickerTheme so any opened dialog would '
                'inherit the rose skin.',
                style: TextStyle(fontSize: 12.0, color: Colors.black54),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    color: _rose.accent,
                    iconSize: 28.0,
                    tooltip: 'Open the date picker (wired)',
                    onPressed: openPicker,
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: _rose.accent.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: _rose.divider),
                    ),
                    child: Text(
                      'showDatePicker(context: inner, '
                      'firstDate: 2026-01-01, lastDate: 2026-12-31)',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: _rose.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                'Inner DatePickerTheme.of(context).headerBackgroundColor = '
                '${DatePickerTheme.of(inner).headerBackgroundColor}',
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  // ASSEMBLY
  return Scaffold(
    backgroundColor: const Color(0xFFF6F4FB),
    appBar: AppBar(
      backgroundColor: const Color(0xFF1A237E),
      foregroundColor: Colors.white,
      title: const Text('Picker themes — M3 picker style atlas'),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            heroHeader,
            _sectionTitle(
              '1',
              'Picker theme data — what & where',
              'How ThemeData routes each picker theme into widget code.',
              const Color(0xFF1A237E),
            ),
            _sectionTitle(
              '2',
              'DatePickerThemeData anatomy',
              'Map every field onto a real M3 date picker.',
              const Color(0xFF00897B),
            ),
            dateAnatomy,
            _sectionTitle(
              '3',
              'Three DatePicker skins',
              'morning / midnight / rose driven only by theme data.',
              const Color(0xFFE08A00),
            ),
            dateSkins,
            _sectionTitle(
              '4',
              'TimePickerThemeData anatomy',
              'Dial, hour/minute fields, AM/PM toggle.',
              const Color(0xFF5E35B1),
            ),
            timeAnatomy,
            _sectionTitle(
              '5',
              'Three TimePicker skins',
              'Same widget tree, three theme instances.',
              const Color(0xFF00838F),
            ),
            timeSkins,
            _sectionTitle(
              '6',
              'MenuThemeData / MenuBarThemeData / MenuButtonThemeData',
              'Faux menu strip with custom colors, padding and shape.',
              const Color(0xFF6A1B9A),
            ),
            menuBarPreview,
            _sectionTitle(
              '7',
              'PopupMenuThemeData',
              'Static popup-menu preview with custom shape/color/textStyle.',
              const Color(0xFFAD1457),
            ),
            popupPreview,
            _sectionTitle(
              '8',
              'DropdownMenuThemeData',
              'Faux dropdown trigger + opened menu with custom theme.',
              const Color(0xFFE08A00),
            ),
            dropdownPreview,
            _sectionTitle(
              '9',
              'Inheritance pattern',
              'Theme(data: ThemeData(datePickerTheme: ...)) wraps a subtree.',
              const Color(0xFF1A237E),
            ),
            inheritanceCard,
            _sectionTitle(
              '10',
              'Light vs dark variants',
              'Pair the same picker theme in light and dark.',
              const Color(0xFF263238),
            ),
            lightVsDark,
            _sectionTitle(
              '11',
              'Cheat-sheet',
              'Group the four theme-data types by their picker.',
              const Color(0xFF455A64),
            ),
            cheatSheet,
            _sectionTitle(
              '12',
              'Wiring example',
              'Render a real IconButton that points at showDatePicker.',
              const Color(0xFFD81B60),
            ),
            wiringExample,
            const SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  '— end of picker themes atlas —',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
