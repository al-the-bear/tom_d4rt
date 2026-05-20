// D4rt test script: Deep Demo - CupertinoDatePicker / CupertinoTimerPicker
// Comprehensive visual demonstration of every Cupertino picker mode:
// date, dateAndTime, time, monthYear; 12/24-hour formats; min/max dates;
// initialDateTime; minuteInterval; dateOrder; backgroundColor; sized
// containers; embedded in cards, nav bars, action panels, modal sheet
// previews, and a settings panel context.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;

dynamic build(BuildContext context) {
  // ===========================================================================
  // PALETTE / DESIGN TOKENS
  // ===========================================================================

  const Color paletteInk = Color(0xFF13233F);
  const Color paletteInkSoft = Color(0xFF4E5C7A);
  const Color paletteAccent = Color(0xFF0A84FF);
  const Color paletteAccentSoft = Color(0xFFD8ECFF);
  const Color paletteAccentDeep = Color(0xFF0050C9);
  const Color paletteTeal = Color(0xFF00B7C2);
  const Color paletteTealSoft = Color(0xFFCFF6F8);
  const Color paletteSunset = Color(0xFFFF8A4C);
  const Color paletteSunsetSoft = Color(0xFFFFE0CC);
  const Color paletteBerry = Color(0xFFB23A8B);
  const Color paletteBerrySoft = Color(0xFFF7D6EB);
  const Color paletteForest = Color(0xFF2F7D3A);
  const Color paletteForestSoft = Color(0xFFD2F0D6);
  const Color paletteAmber = Color(0xFFD89400);
  const Color paletteAmberSoft = Color(0xFFFFEFC2);
  const Color paletteRose = Color(0xFFE3486B);
  const Color paletteRoseSoft = Color(0xFFFFD7E1);
  const Color paletteSlate = Color(0xFF54627A);
  const Color paletteSlateSoft = Color(0xFFE0E4EE);
  const Color paletteOutline = Color(0xFFCED4DE);
  const Color paletteSurface = Color(0xFFF6F8FB);
  const Color paletteSurfaceAlt = Color(0xFFEBF1F8);
  const Color paletteCanvas = Color(0xFFEFF3F8);

  // ===========================================================================
  // HELPER WIDGETS
  // ===========================================================================

  Widget sectionShell({
    required String title,
    required String subtitle,
    required Color surface,
    required Color border,
    required Color titleColor,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: border, width: 1.4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: border.withValues(alpha: 0.30),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 14.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(19.0),
                topRight: Radius.circular(19.0),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  titleColor.withValues(alpha: 0.18),
                  titleColor.withValues(alpha: 0.05),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: titleColor.withValues(alpha: 0.30),
                  width: 1.0,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 10.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: titleColor,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      color: paletteInkSoft,
                      fontSize: 12.5,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget chipBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  Widget pickerFrame({
    required Widget child,
    required double height,
    required Color accent,
    Color? background,
  }) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: background ?? CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: accent.withValues(alpha: 0.35), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.10),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: child,
      ),
    );
  }

  Widget kvRow(String key, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140.0,
            child: Text(
              key,
              style: const TextStyle(
                color: paletteInkSoft,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: color ?? paletteInk,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCallout(String text, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: accent, width: 4.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(CupertinoIcons.info_circle_fill, color: accent, size: 18.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: paletteInk,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SHARED DATETIME REFERENCE POINTS
  // ===========================================================================

  final DateTime today = DateTime(2026, 5, 20, 14, 30);
  final DateTime epochStart = DateTime(2000, 1, 1, 0, 0);
  final DateTime epochEnd = DateTime(2099, 12, 31, 23, 45);
  final DateTime fiscalStart = DateTime(2026, 1, 1);
  final DateTime fiscalEnd = DateTime(2026, 12, 31, 23, 59);
  final DateTime breakfast = DateTime(2026, 5, 20, 7, 15);
  final DateTime meeting = DateTime(2026, 5, 20, 10, 0);
  final DateTime lunch = DateTime(2026, 5, 20, 12, 30);
  final DateTime evening = DateTime(2026, 5, 20, 19, 45);

  // ===========================================================================
  // HERO BANNER
  // ===========================================================================

  final Widget heroBanner = Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0F2A56),
          Color(0xFF1F4FA8),
          Color(0xFF4A8CDB),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 22.0,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.40),
                  width: 1.2,
                ),
              ),
              child: const Icon(
                CupertinoIcons.calendar_today,
                color: CupertinoColors.white,
                size: 38.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'CupertinoDatePicker — Deep Demo',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    'Every CupertinoDatePickerMode, 12/24h formats, date '
                    'ranges, minute intervals, dateOrder — and a tour of '
                    'CupertinoTimerPicker. All interpreted live by D4rt.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            chipBadge('mode.date', CupertinoColors.white),
            chipBadge('mode.dateAndTime', CupertinoColors.white),
            chipBadge('mode.time', CupertinoColors.white),
            chipBadge('mode.monthYear', CupertinoColors.white),
            chipBadge('use24hFormat', CupertinoColors.white),
            chipBadge('minuteInterval', CupertinoColors.white),
            chipBadge('dateOrder', CupertinoColors.white),
            chipBadge('TimerPicker', CupertinoColors.white),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 1 - MODE CATALOG (visual cards)
  // ===========================================================================

  final List<Map<String, dynamic>> modeCatalog = <Map<String, dynamic>>[
    <String, dynamic>{
      'mode': CupertinoDatePickerMode.date,
      'name': 'date',
      'icon': CupertinoIcons.calendar,
      'color': paletteAccent,
      'soft': paletteAccentSoft,
      'blurb':
          'Three wheels: month, day, year. Best for birthdays, deadlines, '
          'and any picker that does not need a time component.',
    },
    <String, dynamic>{
      'mode': CupertinoDatePickerMode.dateAndTime,
      'name': 'dateAndTime',
      'icon': CupertinoIcons.calendar_badge_plus,
      'color': paletteTeal,
      'soft': paletteTealSoft,
      'blurb':
          'Day-of-week column followed by hour, minute, (and AM/PM in 12h '
          'mode). The most flexible combined picker.',
    },
    <String, dynamic>{
      'mode': CupertinoDatePickerMode.time,
      'name': 'time',
      'icon': CupertinoIcons.clock,
      'color': paletteSunset,
      'soft': paletteSunsetSoft,
      'blurb':
          'Hour + minute wheels only. The 12h variant also shows an AM/PM '
          'column. Use for alarms or daily-recurring schedules.',
    },
    <String, dynamic>{
      'mode': CupertinoDatePickerMode.monthYear,
      'name': 'monthYear',
      'icon': CupertinoIcons.calendar_circle,
      'color': paletteBerry,
      'soft': paletteBerrySoft,
      'blurb':
          'Two wheels: month and year. Perfect for credit-card expiry, '
          'reporting periods, or fiscal selection.',
    },
  ];

  final List<Widget> modeChips = List<Widget>.generate(modeCatalog.length, (
    int i,
  ) {
    final Map<String, dynamic> spec = modeCatalog[i];
    final Color color = spec['color'] as Color;
    final Color soft = spec['soft'] as Color;
    final String name = spec['name'] as String;
    final IconData icon = spec['icon'] as IconData;
    final String blurb = spec['blurb'] as String;
    return Container(
      width: 240.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: soft.withValues(alpha: 0.70),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.50), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 42.0,
                height: 42.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: color.withValues(alpha: 0.45),
                      blurRadius: 10.0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(icon, color: CupertinoColors.white, size: 22.0),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'CupertinoDatePickerMode',
                      style: TextStyle(
                        color: color.withValues(alpha: 0.85),
                        fontSize: 10.0,
                        letterSpacing: 0.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '.$name',
                      style: TextStyle(
                        color: color,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            blurb,
            style: const TextStyle(
              color: paletteInk,
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  });

  final Widget section1 = sectionShell(
    title: '01 — CupertinoDatePickerMode catalog',
    subtitle:
        'The four picker modes at a glance. Each has its own wheel layout '
        'and typical use case.',
    surface: CupertinoColors.systemBackground,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Wrap(children: modeChips),
  );

  // ===========================================================================
  // SECTION 2 - MODE.DATE STANDARD
  // ===========================================================================

  final Widget section2 = sectionShell(
    title: '02 — mode: date — standard layout',
    subtitle:
        'Three wheels (month / day / year). Default dateOrder follows the '
        'platform locale and falls back to MDY.',
    surface: CupertinoColors.systemBackground,
    border: paletteAccentSoft,
    titleColor: paletteAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        infoCallout(
          'Tip: when mode is date, the time-component of initialDateTime '
          'is ignored. Provide a midnight-aligned DateTime to be safe.',
          paletteAccent,
        ),
        pickerFrame(
          height: 220.0,
          accent: paletteAccent,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: today,
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
        const SizedBox(height: 10.0),
        kvRow('mode', 'CupertinoDatePickerMode.date'),
        kvRow('initialDateTime', '2026-05-20'),
        kvRow('dateOrder', 'platform default (mdy)'),
        kvRow('height', '220 px'),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3 - MODE.DATE WITH MIN/MAX BOUNDS
  // ===========================================================================

  final Widget section3 = sectionShell(
    title: '03 — mode: date — clamped range',
    subtitle:
        'minimumDate and maximumDate restrict scrolling. Wheels grey out and '
        'snap back to bounds. Great for booking calendars.',
    surface: CupertinoColors.systemBackground,
    border: paletteForestSoft,
    titleColor: paletteForest,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: paletteForestSoft.withValues(alpha: 0.60),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: paletteForest.withValues(alpha: 0.35),
              width: 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(
                CupertinoIcons.lock_circle,
                color: paletteForest,
                size: 22.0,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Booking window',
                      style: TextStyle(
                        color: paletteForest,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Allowed: ${fiscalStart.toIso8601String().substring(0, 10)}'
                      ' to '
                      '${fiscalEnd.toIso8601String().substring(0, 10)}',
                      style: const TextStyle(
                        color: paletteInk,
                        fontSize: 11.5,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        pickerFrame(
          height: 220.0,
          accent: paletteForest,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: today,
            minimumDate: fiscalStart,
            maximumDate: fiscalEnd,
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
        const SizedBox(height: 10.0),
        kvRow('minimumDate', fiscalStart.toIso8601String()),
        kvRow('maximumDate', fiscalEnd.toIso8601String()),
        kvRow('initialDateTime', today.toIso8601String()),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 4 - DATE ORDER VARIATIONS (MDY/DMY/YMD/YDM)
  // ===========================================================================

  final List<Map<String, dynamic>> dateOrderCatalog = <Map<String, dynamic>>[
    <String, dynamic>{
      'order': DatePickerDateOrder.mdy,
      'name': 'mdy',
      'desc': 'Month / Day / Year',
      'flag': 'US English default',
      'color': paletteAccent,
    },
    <String, dynamic>{
      'order': DatePickerDateOrder.dmy,
      'name': 'dmy',
      'desc': 'Day / Month / Year',
      'flag': 'Most European locales',
      'color': paletteTeal,
    },
    <String, dynamic>{
      'order': DatePickerDateOrder.ymd,
      'name': 'ymd',
      'desc': 'Year / Month / Day',
      'flag': 'ISO-8601, East Asia',
      'color': paletteBerry,
    },
    <String, dynamic>{
      'order': DatePickerDateOrder.ydm,
      'name': 'ydm',
      'desc': 'Year / Day / Month',
      'flag': 'Rare; kazakh-style',
      'color': paletteAmber,
    },
  ];

  final List<Widget> dateOrderTiles =
      List<Widget>.generate(dateOrderCatalog.length, (int i) {
    final Map<String, dynamic> spec = dateOrderCatalog[i];
    final DatePickerDateOrder order = spec['order'] as DatePickerDateOrder;
    final String name = spec['name'] as String;
    final String desc = spec['desc'] as String;
    final String flag = spec['flag'] as String;
    final Color color = spec['color'] as Color;
    return Container(
      width: 320.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.40), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.10),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  name.toUpperCase(),
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      desc,
                      style: const TextStyle(
                        color: paletteInk,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      flag,
                      style: const TextStyle(
                        color: paletteInkSoft,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          pickerFrame(
            height: 180.0,
            accent: color,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: today,
              dateOrder: order,
              onDateTimeChanged: (DateTime _) {},
            ),
          ),
        ],
      ),
    );
  });

  final Widget section4 = sectionShell(
    title: '04 — dateOrder permutations',
    subtitle:
        'Four DatePickerDateOrder values rendered side-by-side so you can '
        'compare wheel arrangement in one glance.',
    surface: paletteCanvas,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Wrap(children: dateOrderTiles),
  );

  // ===========================================================================
  // SECTION 5 - MODE.DATEANDTIME 24H
  // ===========================================================================

  final Widget section5 = sectionShell(
    title: '05 — mode: dateAndTime — 24-hour format',
    subtitle:
        'Day-of-week column on the left, then hour (00-23) and minute. '
        'Common in European business apps and military scheduling.',
    surface: CupertinoColors.systemBackground,
    border: paletteTealSoft,
    titleColor: paletteTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            chipBadge('use24hFormat: true', paletteTeal),
            const SizedBox(width: 8.0),
            chipBadge('shows day-of-week', paletteTeal),
            const SizedBox(width: 8.0),
            chipBadge('no AM/PM column', paletteTeal),
          ],
        ),
        const SizedBox(height: 10.0),
        pickerFrame(
          height: 220.0,
          accent: paletteTeal,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: meeting,
            use24hFormat: true,
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
        const SizedBox(height: 10.0),
        kvRow('mode', 'dateAndTime'),
        kvRow('initialDateTime', meeting.toIso8601String()),
        kvRow('use24hFormat', 'true'),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 6 - MODE.DATEANDTIME 12H
  // ===========================================================================

  final Widget section6 = sectionShell(
    title: '06 — mode: dateAndTime — 12-hour format',
    subtitle:
        'Same mode, but use24hFormat is false. An AM/PM column appears at '
        'the right edge.',
    surface: CupertinoColors.systemBackground,
    border: paletteSunsetSoft,
    titleColor: paletteSunset,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            chipBadge('use24hFormat: false', paletteSunset),
            const SizedBox(width: 8.0),
            chipBadge('AM / PM wheel visible', paletteSunset),
          ],
        ),
        const SizedBox(height: 10.0),
        pickerFrame(
          height: 220.0,
          accent: paletteSunset,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            initialDateTime: evening,
            use24hFormat: false,
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
        const SizedBox(height: 10.0),
        kvRow('initialDateTime', evening.toIso8601String()),
        kvRow('use24hFormat', 'false'),
        kvRow('expected AM/PM', 'PM (7:45 PM)'),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 - MODE.TIME 24H
  // ===========================================================================

  final Widget section7 = sectionShell(
    title: '07 — mode: time — 24-hour, full-minute resolution',
    subtitle:
        'Only hour and minute columns are rendered. Lightweight, perfect '
        'for daily alarms and recurring schedules.',
    surface: CupertinoColors.systemBackground,
    border: paletteAccentSoft,
    titleColor: paletteAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        pickerFrame(
          height: 200.0,
          accent: paletteAccent,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: breakfast,
            use24hFormat: true,
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            chipBadge('07:15', paletteAccent),
            const SizedBox(width: 8.0),
            chipBadge('minuteInterval: 1', paletteAccent),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 - MODE.TIME 12H
  // ===========================================================================

  final Widget section8 = sectionShell(
    title: '08 — mode: time — 12-hour with AM/PM',
    subtitle:
        'Hour wheel switches to 1-12, and a third column shows AM or PM. '
        'Familiar to US English speakers.',
    surface: CupertinoColors.systemBackground,
    border: paletteAmberSoft,
    titleColor: paletteAmber,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        pickerFrame(
          height: 200.0,
          accent: paletteAmber,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: lunch,
            use24hFormat: false,
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
        const SizedBox(height: 10.0),
        kvRow('initialDateTime', lunch.toIso8601String()),
        kvRow('use24hFormat', 'false'),
        kvRow('AM/PM at start', 'PM'),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 9 - MINUTE INTERVAL VARIATIONS
  // ===========================================================================

  final List<int> minuteIntervals = <int>[1, 5, 10, 15, 30];
  final List<Color> intervalColors = <Color>[
    paletteAccent,
    paletteTeal,
    paletteForest,
    paletteSunset,
    paletteBerry,
  ];

  final List<Widget> intervalTiles =
      List<Widget>.generate(minuteIntervals.length, (int i) {
    final int interval = minuteIntervals[i];
    final Color color = intervalColors[i];
    return Container(
      width: 230.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.40), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.10),
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '$interval',
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'every $interval min',
                      style: TextStyle(
                        color: color,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '60/$interval = ${60 ~/ interval} slots',
                      style: const TextStyle(
                        color: paletteInkSoft,
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          pickerFrame(
            height: 160.0,
            accent: color,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: meeting,
              minuteInterval: interval,
              use24hFormat: true,
              onDateTimeChanged: (DateTime _) {},
            ),
          ),
        ],
      ),
    );
  });

  final Widget section9 = sectionShell(
    title: '09 — minuteInterval (1 / 5 / 10 / 15 / 30)',
    subtitle:
        'minuteInterval must divide 60 evenly. Use larger values for '
        'meeting schedulers and smaller for alarms.',
    surface: paletteSurfaceAlt,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Wrap(children: intervalTiles),
  );

  // ===========================================================================
  // SECTION 10 - MODE.MONTHYEAR
  // ===========================================================================

  final Widget section10 = sectionShell(
    title: '10 — mode: monthYear — credit-card expiry style',
    subtitle:
        'Two wheels: month and year. The picker fits compactly in a payment '
        'form or a reporting period selector.',
    surface: CupertinoColors.systemBackground,
    border: paletteBerrySoft,
    titleColor: paletteBerry,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[
                Color(0xFF4B2D6F),
                Color(0xFFB23A8B),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Card expiry',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                '•••• •••• •••• ${today.year}',
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Valid through ${today.month.toString().padLeft(2, '0')}/'
                '${today.year}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        pickerFrame(
          height: 180.0,
          accent: paletteBerry,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.monthYear,
            initialDateTime: today,
            minimumDate: DateTime(today.year, today.month),
            maximumDate: DateTime(today.year + 10, 12),
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
        const SizedBox(height: 10.0),
        kvRow('mode', 'monthYear'),
        kvRow(
          'minimumDate',
          'current month (${today.year}-${today.month.toString().padLeft(2, '0')})',
        ),
        kvRow('maximumDate', '+10 years'),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 11 - BACKGROUNDCOLOR VARIATIONS
  // ===========================================================================

  final List<Map<String, dynamic>> bgVariants = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'systemBackground',
      'color': CupertinoColors.systemBackground,
      'accent': paletteAccent,
    },
    <String, dynamic>{
      'name': 'systemGroupedBackground',
      'color': CupertinoColors.systemGroupedBackground,
      'accent': paletteSlate,
    },
    <String, dynamic>{
      'name': 'tertiarySystemBackground',
      'color': CupertinoColors.tertiarySystemBackground,
      'accent': paletteForest,
    },
    <String, dynamic>{
      'name': 'lightBlush (#FFF5F2)',
      'color': const Color(0xFFFFF5F2),
      'accent': paletteRose,
    },
    <String, dynamic>{
      'name': 'mintLeaf (#E9F8EF)',
      'color': const Color(0xFFE9F8EF),
      'accent': paletteForest,
    },
    <String, dynamic>{
      'name': 'duskNavy (#1F2A44)',
      'color': const Color(0xFF1F2A44),
      'accent': paletteAccent,
    },
  ];

  final List<Widget> bgTiles = List<Widget>.generate(bgVariants.length, (
    int i,
  ) {
    final Map<String, dynamic> spec = bgVariants[i];
    final String name = spec['name'] as String;
    final Color color = spec['color'] as Color;
    final Color accent = spec['accent'] as Color;
    return Container(
      width: 260.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: accent.withValues(alpha: 0.30), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: paletteOutline,
                    width: 1.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: paletteInk,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          pickerFrame(
            height: 150.0,
            accent: accent,
            background: color,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: today,
              backgroundColor: color,
              onDateTimeChanged: (DateTime _) {},
            ),
          ),
        ],
      ),
    );
  });

  final Widget section11 = sectionShell(
    title: '11 — backgroundColor variations',
    subtitle:
        'CupertinoDatePicker.backgroundColor tints the entire wheel canvas. '
        'Useful for matching surrounding cards or dark surfaces.',
    surface: paletteCanvas,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Wrap(children: bgTiles),
  );

  // ===========================================================================
  // SECTION 12 - SIZED CONTAINERS
  // ===========================================================================

  final Widget section12 = sectionShell(
    title: '12 — sized containers (compact / regular / tall)',
    subtitle:
        'CupertinoDatePicker needs a bounded height. Three layouts show how '
        'the wheels behave when the container shrinks or grows.',
    surface: CupertinoColors.systemBackground,
    border: paletteSlateSoft,
    titleColor: paletteSlate,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Compact (140 px) — tight fit',
          style: TextStyle(
            color: paletteInk,
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        pickerFrame(
          height: 140.0,
          accent: paletteSlate,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: today,
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Regular (216 px) — standard iOS bottom sheet',
          style: TextStyle(
            color: paletteInk,
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        pickerFrame(
          height: 216.0,
          accent: paletteSlate,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: today,
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Tall (300 px) — extended visibility',
          style: TextStyle(
            color: paletteInk,
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        pickerFrame(
          height: 300.0,
          accent: paletteSlate,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: today,
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 13 - INSIDE A CUPERTINO CARD
  // ===========================================================================

  final Widget section13 = sectionShell(
    title: '13 — embedded inside a CupertinoListSection card',
    subtitle:
        'A picker nestled into a grouped settings card. Note the matching '
        'background color and rounded corners.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: CupertinoListSection.insetGrouped(
      header: const Text('PROJECT DEADLINE'),
      footer: const Text(
        'Changes are saved automatically and synchronised to the team.',
      ),
      children: <Widget>[
        const CupertinoListTile(
          leading: Icon(CupertinoIcons.flag_fill, color: paletteAccent),
          title: Text('Milestone date'),
          subtitle: Text('Tap a wheel to adjust'),
          trailing: CupertinoListTileChevron(),
        ),
        Container(
          color: CupertinoColors.systemBackground,
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: SizedBox(
            height: 200.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime(2026, 8, 15),
              backgroundColor: CupertinoColors.systemBackground,
              onDateTimeChanged: (DateTime _) {},
            ),
          ),
        ),
        const CupertinoListTile(
          leading: Icon(CupertinoIcons.bell_fill, color: paletteSunset),
          title: Text('Reminder'),
          subtitle: Text('1 day before, 9:00 AM'),
          trailing: CupertinoListTileChevron(),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 14 - INSIDE CUPERTINO NAVIGATION BAR CONTEXT
  // ===========================================================================

  final Widget section14 = sectionShell(
    title: '14 — full CupertinoPageScaffold preview',
    subtitle:
        'A miniaturised page with navigation bar, content header and a '
        'picker. Shows the typical "Schedule" screen.',
    surface: paletteCanvas,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Container(
      height: 420.0,
      decoration: BoxDecoration(
        color: CupertinoColors.systemGroupedBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: paletteOutline, width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: const BoxDecoration(
                color: CupertinoColors.systemBackground,
                border: Border(
                  bottom: BorderSide(
                    color: paletteOutline,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: const <Widget>[
                  Icon(
                    CupertinoIcons.chevron_left,
                    color: paletteAccent,
                    size: 20.0,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'Back',
                    style: TextStyle(
                      color: paletteAccent,
                      fontSize: 15.0,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'New Event',
                    style: TextStyle(
                      color: paletteInk,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Save',
                    style: TextStyle(
                      color: paletteAccent,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12.0),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBackground,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: const <Widget>[
                        Icon(
                          CupertinoIcons.textformat,
                          color: paletteSlate,
                          size: 20.0,
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            'Quarterly review',
                            style: TextStyle(
                              color: paletteInk,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemBackground,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: <Widget>[
                              const Icon(
                                CupertinoIcons.calendar,
                                color: paletteAccent,
                                size: 20.0,
                              ),
                              const SizedBox(width: 10.0),
                              const Expanded(
                                child: Text(
                                  'Starts',
                                  style: TextStyle(
                                    color: paletteInk,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: paletteAccentSoft,
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: const Text(
                                  '2026-05-20 14:30',
                                  style: TextStyle(
                                    color: paletteAccentDeep,
                                    fontFamily: 'monospace',
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 0.5,
                          margin: const EdgeInsets.only(left: 42.0),
                          color: paletteOutline,
                        ),
                        SizedBox(
                          height: 180.0,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.dateAndTime,
                            initialDateTime: today,
                            use24hFormat: true,
                            onDateTimeChanged: (DateTime _) {},
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
      ),
    ),
  );

  // ===========================================================================
  // SECTION 15 - ACTIONS PANEL (CONFIRM/CANCEL)
  // ===========================================================================

  final Widget section15 = sectionShell(
    title: '15 — picker with confirm / cancel actions panel',
    subtitle:
        'The classic "Action Sheet" pattern: cancel on the left, save on '
        'the right. Buttons styled with CupertinoButton.',
    surface: CupertinoColors.systemBackground,
    border: paletteRoseSoft,
    titleColor: paletteRose,
    child: Container(
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: paletteOutline, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 44.0,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: paletteOutline,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: paletteRose,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Choose date',
                  style: TextStyle(
                    color: paletteInk,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: paletteAccent,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 216.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: today,
              use24hFormat: true,
              onDateTimeChanged: (DateTime _) {},
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 16 - MODAL SHEET PREVIEW
  // ===========================================================================

  final Widget section16 = sectionShell(
    title: '16 — modal sheet preview (showCupertinoModalPopup pattern)',
    subtitle:
        'A faithful mock of the modal bottom sheet that Cupertino apps '
        'show when invoking showCupertinoModalPopup.',
    surface: paletteCanvas,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Container(
      height: 360.0,
      decoration: BoxDecoration(
        color: paletteInk.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 20.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: const <Widget>[
                  Icon(
                    CupertinoIcons.doc_text,
                    color: paletteSlate,
                    size: 20.0,
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Tap the field below to schedule the export...',
                      style: TextStyle(
                        color: paletteInkSoft,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              decoration: const BoxDecoration(
                color: CupertinoColors.systemBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 8.0),
                    width: 40.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: paletteOutline,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Schedule export',
                    style: TextStyle(
                      color: paletteInk,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 200.0,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.dateAndTime,
                      initialDateTime: today,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime _) {},
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: () {},
                      child: const Text('Schedule'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 17 - SETTINGS PANEL CONTEXT (LIST OF PICKERS)
  // ===========================================================================

  final Widget section17 = sectionShell(
    title: '17 — settings panel context (working hours)',
    subtitle:
        'Two time pickers side by side build a familiar "from / to" range '
        'editor for a productivity app.',
    surface: paletteSurface,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: paletteOutline, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Working hours',
            style: TextStyle(
              color: paletteInk,
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Define the daily window in which notifications are delivered.',
            style: TextStyle(
              color: paletteInkSoft,
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Start',
                      style: TextStyle(
                        color: paletteForest,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                      ),
                    ),
                    pickerFrame(
                      height: 170.0,
                      accent: paletteForest,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime(2026, 5, 20, 9, 0),
                        minuteInterval: 15,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime _) {},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'End',
                      style: TextStyle(
                        color: paletteRose,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                      ),
                    ),
                    pickerFrame(
                      height: 170.0,
                      accent: paletteRose,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime(2026, 5, 20, 18, 0),
                        minuteInterval: 15,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime _) {},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 18 - CUPERTINO TIMER PICKER MODES
  // ===========================================================================

  final List<Map<String, dynamic>> timerModes = <Map<String, dynamic>>[
    <String, dynamic>{
      'mode': CupertinoTimerPickerMode.hm,
      'name': 'hm',
      'desc': 'Hours and minutes — long-form timers',
      'initial': const Duration(hours: 1, minutes: 30),
      'color': paletteAccent,
    },
    <String, dynamic>{
      'mode': CupertinoTimerPickerMode.ms,
      'name': 'ms',
      'desc': 'Minutes and seconds — short focus sessions',
      'initial': const Duration(minutes: 25),
      'color': paletteTeal,
    },
    <String, dynamic>{
      'mode': CupertinoTimerPickerMode.hms,
      'name': 'hms',
      'desc': 'Hours, minutes and seconds — full precision',
      'initial': const Duration(hours: 0, minutes: 5, seconds: 30),
      'color': paletteBerry,
    },
  ];

  final List<Widget> timerTiles =
      List<Widget>.generate(timerModes.length, (int i) {
    final Map<String, dynamic> spec = timerModes[i];
    final CupertinoTimerPickerMode mode =
        spec['mode'] as CupertinoTimerPickerMode;
    final String name = spec['name'] as String;
    final String desc = spec['desc'] as String;
    final Duration initial = spec['initial'] as Duration;
    final Color color = spec['color'] as Color;
    return Container(
      width: 320.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.10),
            blurRadius: 12.0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  name.toUpperCase(),
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    fontSize: 12.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  desc,
                  style: const TextStyle(
                    color: paletteInk,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          pickerFrame(
            height: 180.0,
            accent: color,
            child: CupertinoTimerPicker(
              mode: mode,
              initialTimerDuration: initial,
              onTimerDurationChanged: (Duration _) {},
            ),
          ),
        ],
      ),
    );
  });

  final Widget section18 = sectionShell(
    title: '18 — CupertinoTimerPicker — hm / ms / hms',
    subtitle:
        'The sibling widget for measuring intervals. Same wheel style, '
        'different unit columns.',
    surface: paletteCanvas,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Wrap(children: timerTiles),
  );

  // ===========================================================================
  // SECTION 19 - TIMER PICKER WITH MINUTE INTERVAL + SECOND INTERVAL
  // ===========================================================================

  final Widget section19 = sectionShell(
    title: '19 — TimerPicker advanced — minute & second intervals',
    subtitle:
        'TimerPicker also accepts minuteInterval and secondInterval. Both '
        'must divide 60.',
    surface: CupertinoColors.systemBackground,
    border: paletteTealSoft,
    titleColor: paletteTeal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            chipBadge('minuteInterval: 5', paletteTeal),
            const SizedBox(width: 8.0),
            chipBadge('secondInterval: 15', paletteTeal),
          ],
        ),
        const SizedBox(height: 10.0),
        pickerFrame(
          height: 200.0,
          accent: paletteTeal,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hms,
            initialTimerDuration: const Duration(
              hours: 1,
              minutes: 30,
              seconds: 15,
            ),
            minuteInterval: 5,
            secondInterval: 15,
            onTimerDurationChanged: (Duration _) {},
          ),
        ),
        const SizedBox(height: 10.0),
        kvRow('mode', 'hms'),
        kvRow('initial', '1h 30m 15s'),
        kvRow('minuteInterval', '5'),
        kvRow('secondInterval', '15'),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 20 - API REFERENCE TABLE
  // ===========================================================================

  final List<Map<String, String>> apiRows = <Map<String, String>>[
    <String, String>{
      'name': 'mode',
      'type': 'CupertinoDatePickerMode',
      'desc': 'date | dateAndTime | time | monthYear',
    },
    <String, String>{
      'name': 'initialDateTime',
      'type': 'DateTime?',
      'desc': 'Starting value for the wheels',
    },
    <String, String>{
      'name': 'minimumDate',
      'type': 'DateTime?',
      'desc': 'Lower bound (inclusive) for date and dateAndTime modes',
    },
    <String, String>{
      'name': 'maximumDate',
      'type': 'DateTime?',
      'desc': 'Upper bound (inclusive) for date and dateAndTime modes',
    },
    <String, String>{
      'name': 'minimumYear',
      'type': 'int',
      'desc': 'Lower year bound for date and monthYear modes',
    },
    <String, String>{
      'name': 'maximumYear',
      'type': 'int?',
      'desc': 'Upper year bound for date and monthYear modes',
    },
    <String, String>{
      'name': 'minuteInterval',
      'type': 'int',
      'desc': 'Minute wheel step — must divide 60',
    },
    <String, String>{
      'name': 'use24hFormat',
      'type': 'bool',
      'desc': 'Switches 12h/AM-PM versus 24h hour display',
    },
    <String, String>{
      'name': 'dateOrder',
      'type': 'DatePickerDateOrder?',
      'desc': 'Override wheel order: mdy / dmy / ymd / ydm',
    },
    <String, String>{
      'name': 'backgroundColor',
      'type': 'Color?',
      'desc': 'Tints the entire picker surface',
    },
    <String, String>{
      'name': 'showDayOfWeek',
      'type': 'bool',
      'desc': 'Toggles the day-of-week leading column in date mode',
    },
    <String, String>{
      'name': 'itemExtent',
      'type': 'double',
      'desc': 'Pixel height of a single wheel row',
    },
    <String, String>{
      'name': 'onDateTimeChanged',
      'type': 'ValueChanged<DateTime>',
      'desc': 'Required callback fired on every wheel change',
    },
  ];

  final List<Color> apiColors = <Color>[
    paletteAccent,
    paletteTeal,
    paletteBerry,
    paletteSunset,
    paletteForest,
    paletteAmber,
    paletteRose,
  ];

  final List<Widget> apiTiles = List<Widget>.generate(apiRows.length, (int i) {
    final Map<String, String> row = apiRows[i];
    final String name = row['name'] ?? '';
    final String type = row['type'] ?? '';
    final String desc = row['desc'] ?? '';
    final Color color = apiColors[i % apiColors.length];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: color, width: 4.0),
          top: const BorderSide(color: paletteOutline, width: 0.5),
          right: const BorderSide(color: paletteOutline, width: 0.5),
          bottom: const BorderSide(color: paletteOutline, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170.0,
            child: Text(
              name,
              style: TextStyle(
                color: color,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 13.0,
              ),
            ),
          ),
          SizedBox(
            width: 200.0,
            child: Text(
              type,
              style: const TextStyle(
                color: paletteInkSoft,
                fontFamily: 'monospace',
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(
                color: paletteInk,
                fontSize: 12.0,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  });

  final Widget section20 = sectionShell(
    title: '20 — API reference table',
    subtitle:
        'A condensed lookup table of every CupertinoDatePicker parameter '
        'demonstrated in the preceding sections.',
    surface: paletteCanvas,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Column(children: apiTiles),
  );

  // ===========================================================================
  // SECTION 21 - SHOWDAYOFWEEK TOGGLE
  // ===========================================================================

  final Widget section21 = sectionShell(
    title: '21 — showDayOfWeek toggle',
    subtitle:
        'A flag introduced in newer Flutter versions: prepends a weekday '
        'column to the date wheels. Compare on/off side by side.',
    surface: CupertinoColors.systemBackground,
    border: paletteSunsetSoft,
    titleColor: paletteSunset,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'showDayOfWeek: false',
                style: TextStyle(
                  color: paletteInk,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              pickerFrame(
                height: 200.0,
                accent: paletteSunset,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: today,
                  onDateTimeChanged: (DateTime _) {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'showDayOfWeek: true',
                style: TextStyle(
                  color: paletteInk,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              pickerFrame(
                height: 200.0,
                accent: paletteSunset,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: today,
                  showDayOfWeek: true,
                  onDateTimeChanged: (DateTime _) {},
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 22 - ITEM EXTENT EXPERIMENT
  // ===========================================================================

  final List<double> extents = <double>[28.0, 36.0, 48.0];
  final List<Color> extentColors = <Color>[
    paletteTeal,
    paletteAccent,
    paletteBerry,
  ];

  final List<Widget> extentTiles =
      List<Widget>.generate(extents.length, (int i) {
    final double extent = extents[i];
    final Color color = extentColors[i];
    return Container(
      width: 260.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.45), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                CupertinoIcons.arrow_up_arrow_down,
                color: paletteSlate,
                size: 18.0,
              ),
              const SizedBox(width: 8.0),
              Text(
                'itemExtent = $extent',
                style: TextStyle(
                  color: color,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          pickerFrame(
            height: 180.0,
            accent: color,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: meeting,
              itemExtent: extent,
              use24hFormat: true,
              onDateTimeChanged: (DateTime _) {},
            ),
          ),
        ],
      ),
    );
  });

  final Widget section22 = sectionShell(
    title: '22 — itemExtent variations',
    subtitle:
        'itemExtent controls the height of each wheel row. Smaller values '
        'pack more options into view; larger values look bolder.',
    surface: paletteSurfaceAlt,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Wrap(children: extentTiles),
  );

  // ===========================================================================
  // SECTION 23 - WIDE EPOCH WINDOW (2000 - 2099)
  // ===========================================================================

  final Widget section23 = sectionShell(
    title: '23 — wide epoch window (2000 — 2099)',
    subtitle:
        'A century-spanning range. Useful for historical records, '
        'archaeology apps, or long-term retirement planning.',
    surface: CupertinoColors.systemBackground,
    border: paletteForestSoft,
    titleColor: paletteForest,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        pickerFrame(
          height: 220.0,
          accent: paletteForest,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: today,
            minimumDate: epochStart,
            maximumDate: epochEnd,
            onDateTimeChanged: (DateTime _) {},
          ),
        ),
        const SizedBox(height: 8.0),
        kvRow('minimumDate', epochStart.toIso8601String()),
        kvRow('maximumDate', epochEnd.toIso8601String()),
        kvRow('span', '~100 years'),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 24 - DUAL-LANGUAGE / RTL HINT
  // ===========================================================================

  final Widget section24 = sectionShell(
    title: '24 — RTL / localised reading-order hint',
    subtitle:
        'Wrap the picker in a Directionality widget to flip wheel order. '
        'Below: the same date in left-to-right and right-to-left contexts.',
    surface: paletteCanvas,
    border: paletteOutline,
    titleColor: paletteAccentDeep,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'TextDirection.ltr',
                style: TextStyle(
                  color: paletteInk,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              pickerFrame(
                height: 180.0,
                accent: paletteAccent,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: today,
                    onDateTimeChanged: (DateTime _) {},
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'TextDirection.rtl',
                style: TextStyle(
                  color: paletteInk,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              pickerFrame(
                height: 180.0,
                accent: paletteRose,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: today,
                    onDateTimeChanged: (DateTime _) {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 25 - CLOSING NOTES
  // ===========================================================================

  final Widget section25 = Container(
    margin: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF13233F),
          Color(0xFF2A4374),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Icon(
                CupertinoIcons.checkmark_seal_fill,
                color: CupertinoColors.white,
                size: 24.0,
              ),
            ),
            const SizedBox(width: 10.0),
            const Expanded(
              child: Text(
                'End of demo',
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          'You have just toured every Cupertino picker mode, format flag, '
          'and presentational context. Combine these techniques to build '
          'rich scheduling UIs that feel native to iOS.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            chipBadge('25 sections', CupertinoColors.white),
            chipBadge('4 picker modes', CupertinoColors.white),
            chipBadge('3 timer modes', CupertinoColors.white),
            chipBadge('4 dateOrder values', CupertinoColors.white),
            chipBadge('5 minuteIntervals', CupertinoColors.white),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // PAGE ASSEMBLY
  // ===========================================================================

  final List<Widget> pageChildren = <Widget>[
    heroBanner,
    section1,
    section2,
    section3,
    section4,
    section5,
    section6,
    section7,
    section8,
    section9,
    section10,
    section11,
    section12,
    section13,
    section14,
    section15,
    section16,
    section17,
    section18,
    section19,
    section20,
    section21,
    section22,
    section23,
    section24,
    section25,
  ];

  return CupertinoPageScaffold(
    backgroundColor: paletteCanvas,
    navigationBar: const CupertinoNavigationBar(
      middle: Text('CupertinoDatePicker Deep Demo'),
      backgroundColor: CupertinoColors.systemBackground,
    ),
    child: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(14.0),
        children: pageChildren,
      ),
    ),
  );
}
