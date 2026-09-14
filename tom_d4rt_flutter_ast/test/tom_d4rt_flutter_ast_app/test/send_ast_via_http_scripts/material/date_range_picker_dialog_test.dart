// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// Visual deep demo: showDateRangePicker / DateRangePickerDialog
// =====================================================================
//
// This file is a *visual* explainer for `showDateRangePicker(...)` and the
// private `DateRangePickerDialog` widget that backs it. The dialog is the
// Material 3 calendar/text-input experience that lets users pick a
// continuous range of dates (a `DateTimeRange`).
//
// We do NOT actually open the dialog at runtime. The function is async
// (`Future<DateTimeRange?>`) and we are restricted to a synchronous,
// single-`build` demo — so every "screenshot" of the dialog is a hand
// drawn mock made out of `Container`, `Row`, `Column`, `Text`, and a few
// custom paint-free widgets. The point is to *teach* the API surface
// while staying inside the harness sandbox.
//
// Outline (>= 9 sections):
//  1. Hero with a stylized "calendar with date-range highlighted" graphic
//  2. Anatomy of `showDateRangePicker(...)` — comprehensive parameter
//     table (param / type / default / description)
//  3. Two-pane mockup: `DatePickerEntryMode.calendar`
//  4. Two-pane mockup: `DatePickerEntryMode.input`
//  5. `DateTimeRange(start, end)` data shape panel
//  6. Localization & helpText / cancelText / saveText panel
//  7. `builder` parameter usage (theming) explainer panel
//  8. Recipe code listing — full `await showDateRangePicker(...)` call
//  9. Comparison vs `showDatePicker` (single-date) — table
// 10. Pitfalls (firstDate <= lastDate; initialDateRange in bounds; null on
//     dismiss)
// 11. Footer
//
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Top-level entry — single static `dynamic build(BuildContext)`.
// ---------------------------------------------------------------------

dynamic build(BuildContext context) {
  return const DateRangePickerDeepDemoApp();
}

// =====================================================================
// Palette and design tokens
// =====================================================================

const Color paletteBg = Color(0xFFF6F4EE);
const Color paletteSurface = Color(0xFFFFFFFF);
const Color paletteInk = Color(0xFF1F2933);
const Color paletteMuted = Color(0xFF52606D);
const Color paletteFaint = Color(0xFF9AA5B1);
const Color paletteAccent = Color(0xFF4F46E5);
const Color paletteAccentDeep = Color(0xFF312E81);
const Color paletteAccentSoft = Color(0xFFEEF2FF);
const Color paletteRange = Color(0xFFE0E7FF);
const Color paletteEdge = Color(0xFFE4E7EB);
const Color paletteWarn = Color(0xFFB54708);
const Color paletteWarnSoft = Color(0xFFFFF4ED);
const Color paletteOk = Color(0xFF166534);
const Color paletteOkSoft = Color(0xFFE7F8EE);
const Color paletteCode = Color(0xFF0F172A);
const Color paletteCodeInk = Color(0xFFE2E8F0);
const Color paletteCodeKey = Color(0xFF93C5FD);
const Color paletteCodeStr = Color(0xFFFCA5A5);
const Color paletteCodeNum = Color(0xFFF59E0B);
const Color paletteCodeCmt = Color(0xFF64748B);
const Color paletteHairline = Color(0xFFD9DEE3);

// =====================================================================
// Root app
// =====================================================================

class DateRangePickerDeepDemoApp extends StatelessWidget {
  const DateRangePickerDeepDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'showDateRangePicker — Visual Deep Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: paletteBg,
        primaryColor: paletteAccent,
        fontFamily: 'Roboto',
      ),
      home: const DateRangePickerDeepDemoPage(),
    );
  }
}

// =====================================================================
// Page scaffold
// =====================================================================

class DateRangePickerDeepDemoPage extends StatelessWidget {
  const DateRangePickerDeepDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paletteBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              SectionHero(),
              SectionGap(),
              SectionAnatomy(),
              SectionGap(),
              SectionCalendarMockup(),
              SectionGap(),
              SectionInputMockup(),
              SectionGap(),
              SectionDataShape(),
              SectionGap(),
              SectionLocalization(),
              SectionGap(),
              SectionBuilderParam(),
              SectionGap(),
              SectionRecipe(),
              SectionGap(),
              SectionComparison(),
              SectionGap(),
              SectionPitfalls(),
              SectionGap(),
              SectionFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// Shared layout primitives
// =====================================================================

class SectionGap extends StatelessWidget {
  const SectionGap({super.key, this.height = 28.0});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.tag,
    this.tagColor = paletteAccent,
  });

  final String title;
  final String? subtitle;
  final String? tag;
  final Color tagColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: paletteEdge),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: paletteInk,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
              if (tag != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: tagColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    tag!,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 13,
                color: paletteMuted,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class SoftPanel extends StatelessWidget {
  const SoftPanel({
    super.key,
    required this.child,
    this.color = paletteAccentSoft,
    this.padding = const EdgeInsets.all(14),
    this.borderColor,
  });
  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? paletteHairline),
      ),
      child: child,
    );
  }
}

class Pill extends StatelessWidget {
  const Pill(this.label,
      {super.key,
      this.color = paletteAccentSoft,
      this.textColor = paletteAccentDeep});
  final String label;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

class MonoText extends StatelessWidget {
  const MonoText(this.text,
      {super.key, this.color = paletteInk, this.size = 13.0});
  final String text;
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontFamilyFallback: const ['Menlo', 'Courier'],
        fontSize: size,
        color: color,
        height: 1.45,
      ),
    );
  }
}

// =====================================================================
// 1. Hero — stylized calendar with date-range highlighted
// =====================================================================

class SectionHero extends StatelessWidget {
  const SectionHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF312E81), Color(0xFF4F46E5), Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Pill(
                  'MATERIAL · DIALOG',
                  color: Color(0x33FFFFFF),
                  textColor: Colors.white,
                ),
                SizedBox(height: 12),
                Text(
                  'showDateRangePicker',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.5,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'A two-date Material picker that returns a DateTimeRange?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFE0E7FF),
                    height: 1.35,
                  ),
                ),
                SizedBox(height: 14),
                _HeroFactRow(label: 'Returns', value: 'Future<DateTimeRange?>'),
                SizedBox(height: 6),
                _HeroFactRow(
                    label: 'Modes', value: 'calendar · input · calendarOnly'),
                SizedBox(height: 6),
                _HeroFactRow(label: 'Dismiss', value: 'returns null'),
              ],
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            flex: 4,
            child: _HeroCalendarGraphic(),
          ),
        ],
      ),
    );
  }
}

class _HeroFactRow extends StatelessWidget {
  const _HeroFactRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFFC7D2FE),
              letterSpacing: 0.6,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeroCalendarGraphic extends StatelessWidget {
  const _HeroCalendarGraphic();

  @override
  Widget build(BuildContext context) {
    const double cellSize = 22;
    const TextStyle dayStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: paletteInk,
    );
    const TextStyle dayInRangeStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      color: paletteAccentDeep,
    );
    const TextStyle dayEndStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    );

    Widget cell(int day, {bool inRange = false, bool isEnd = false}) {
      Color bg = Colors.transparent;
      TextStyle style = dayStyle;
      BorderRadius radius = BorderRadius.zero;
      if (inRange && !isEnd) {
        bg = paletteRange;
        style = dayInRangeStyle;
      }
      if (isEnd) {
        bg = paletteAccentDeep;
        style = dayEndStyle;
        radius = BorderRadius.circular(999);
      }
      return Container(
        width: cellSize,
        height: cellSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: bg, borderRadius: radius),
        child: Text('$day', style: style),
      );
    }

    Widget header(String s) => SizedBox(
          width: cellSize,
          child: Text(
            s,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: paletteFaint,
              letterSpacing: 0.5,
            ),
          ),
        );

    return Container(
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.calendar_today,
                  size: 14, color: paletteAccentDeep),
              SizedBox(width: 6),
              Text(
                'March 2026',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: paletteInk,
                ),
              ),
              Spacer(),
              Icon(Icons.chevron_left, size: 16, color: paletteMuted),
              SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 16, color: paletteMuted),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              header('S'),
              header('M'),
              header('T'),
              header('W'),
              header('T'),
              header('F'),
              header('S'),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cell(1),
              cell(2),
              cell(3),
              cell(4),
              cell(5, isEnd: true),
              cell(6, inRange: true),
              cell(7, inRange: true),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cell(8, inRange: true),
              cell(9, inRange: true),
              cell(10, inRange: true),
              cell(11, inRange: true),
              cell(12, isEnd: true),
              cell(13),
              cell(14),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cell(15),
              cell(16),
              cell(17),
              cell(18),
              cell(19),
              cell(20),
              cell(21),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cell(22),
              cell(23),
              cell(24),
              cell(25),
              cell(26),
              cell(27),
              cell(28),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: paletteAccentSoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Mar 5 – Mar 12  ·  8 nights',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: paletteAccentDeep,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 2. Anatomy of showDateRangePicker — comprehensive parameter table
// =====================================================================

class SectionAnatomy extends StatelessWidget {
  const SectionAnatomy({super.key});

  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = [
      [
        'context',
        'BuildContext',
        'required',
        'Used to look up Navigator and locale.',
      ],
      [
        'firstDate',
        'DateTime',
        'required',
        'Earliest selectable date (inclusive).',
      ],
      [
        'lastDate',
        'DateTime',
        'required',
        'Latest selectable date (inclusive). Must be >= firstDate.',
      ],
      [
        'initialDateRange',
        'DateTimeRange?',
        'null',
        'Pre-selected range. Must lie within [firstDate..lastDate].',
      ],
      [
        'currentDate',
        'DateTime?',
        'DateTime.now()',
        'Date highlighted as "today" in the calendar.',
      ],
      [
        'initialEntryMode',
        'DatePickerEntryMode',
        'calendar',
        'calendar | calendarOnly | input | inputOnly.',
      ],
      [
        'helpText',
        'String?',
        'localized',
        'Title of the dialog. Defaults to "Select range".',
      ],
      [
        'cancelText',
        'String?',
        'localized',
        'Label for the cancel button (default "Cancel").',
      ],
      [
        'confirmText',
        'String?',
        'localized',
        'Label for the confirm/save action (also see saveText).',
      ],
      [
        'saveText',
        'String?',
        'localized',
        'Label for the SAVE action button (default "Save").',
      ],
      [
        'errorFormatText',
        'String?',
        'localized',
        'Shown when text input has invalid date format.',
      ],
      [
        'errorInvalidText',
        'String?',
        'localized',
        'Shown when input is out of [firstDate..lastDate].',
      ],
      [
        'errorInvalidRangeText',
        'String?',
        'localized',
        'Shown when start > end in input mode.',
      ],
      [
        'fieldStartHintText',
        'String?',
        'localized',
        'Hint inside the start TextField.',
      ],
      [
        'fieldEndHintText',
        'String?',
        'localized',
        'Hint inside the end TextField.',
      ],
      [
        'fieldStartLabelText',
        'String?',
        'localized',
        'Floating label of the start TextField.',
      ],
      [
        'fieldEndLabelText',
        'String?',
        'localized',
        'Floating label of the end TextField.',
      ],
      [
        'keyboardType',
        'TextInputType',
        'datetime',
        'Keyboard for input-mode TextFields.',
      ],
      [
        'builder',
        'TransitionBuilder?',
        'null',
        'Wrap dialog with Theme/Directionality/Localizations etc.',
      ],
      [
        'barrierDismissible',
        'bool',
        'true',
        'If true, tapping outside dismisses the dialog (returns null).',
      ],
      [
        'barrierColor',
        'Color?',
        'Colors.black54',
        'Color of the modal barrier behind the dialog.',
      ],
      [
        'barrierLabel',
        'String?',
        'null',
        'Semantics label for the modal barrier (a11y).',
      ],
      [
        'useRootNavigator',
        'bool',
        'true',
        'Whether to push the dialog onto the root navigator.',
      ],
      [
        'routeSettings',
        'RouteSettings?',
        'null',
        'Route settings for observers / analytics.',
      ],
      [
        'textDirection',
        'TextDirection?',
        'null',
        'Override LTR/RTL for the dialog subtree.',
      ],
      [
        'anchorPoint',
        'Offset?',
        'null',
        'Used by DisplayFeature-aware layouts (foldables).',
      ],
      [
        'switchToInputEntryModeIcon',
        'Icon?',
        'Icons.edit_outlined',
        'Icon for switching from calendar to input mode.',
      ],
      [
        'switchToCalendarEntryModeIcon',
        'Icon?',
        'Icons.calendar_today',
        'Icon for switching from input back to calendar.',
      ],
    ];

    return SectionCard(
      title: '2 · Anatomy of showDateRangePicker(...)',
      tag: 'API',
      subtitle:
          'Every parameter, its type, its default, and what it actually controls.',
      child: const _ParamTable(rows: rows),
    );
  }
}

class _ParamTable extends StatelessWidget {
  const _ParamTable({required this.rows});
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: paletteEdge),
        borderRadius: BorderRadius.circular(12),
        color: paletteSurface,
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: paletteAccentSoft,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: const [
                _HeaderCell('Parameter', flex: 4),
                _HeaderCell('Type', flex: 4),
                _HeaderCell('Default', flex: 3),
                _HeaderCell('Description', flex: 7),
              ],
            ),
          ),
          for (int i = 0; i < rows.length; i++)
            Container(
              decoration: BoxDecoration(
                color: i.isEven ? paletteSurface : const Color(0xFFFAFAFB),
                border: const Border(
                  top: BorderSide(color: paletteHairline),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BodyCell(rows[i][0], flex: 4, mono: true, bold: true),
                  _BodyCell(rows[i][1],
                      flex: 4, mono: true, color: paletteAccentDeep),
                  _BodyCell(rows[i][2],
                      flex: 3, mono: true, color: paletteMuted),
                  _BodyCell(rows[i][3], flex: 7),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell(this.text, {this.flex = 1});
  final String text;
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: paletteAccentDeep,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _BodyCell extends StatelessWidget {
  const _BodyCell(
    this.text, {
    this.flex = 1,
    this.mono = false,
    this.bold = false,
    this.color = paletteInk,
  });
  final String text;
  final int flex;
  final bool mono;
  final bool bold;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: mono ? 'monospace' : null,
          fontFamilyFallback: mono ? const ['Menlo', 'Courier'] : null,
          fontSize: 12,
          fontWeight: bold ? FontWeight.w800 : FontWeight.w500,
          color: color,
          height: 1.4,
        ),
      ),
    );
  }
}

// =====================================================================
// 3. Two-pane mockup: DatePickerEntryMode.calendar
// =====================================================================

class SectionCalendarMockup extends StatelessWidget {
  const SectionCalendarMockup({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '3 · Mode: DatePickerEntryMode.calendar',
      tag: 'CALENDAR',
      tagColor: paletteAccent,
      subtitle:
          'Default mode. Users pick start and end dates by tapping cells. '
          'Range Mar 5 – Mar 12 is shown selected.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            flex: 5,
            child: _CalendarDialogMock(),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ExplainerRow(
                  number: '01',
                  title: 'Header banner',
                  body:
                      'Shows helpText (e.g. "Select range") and the live range '
                      'in a large font. Adapts to portrait / landscape.',
                ),
                SizedBox(height: 10),
                _ExplainerRow(
                  number: '02',
                  title: 'Action row',
                  body:
                      'cancelText on the left, saveText on the right. The pencil '
                      'icon switches to input mode (switchToInputEntryModeIcon).',
                ),
                SizedBox(height: 10),
                _ExplainerRow(
                  number: '03',
                  title: 'Range visualization',
                  body:
                      'Endpoints rendered as filled circles; in-between days get '
                      'a soft band. Disabled days outside [firstDate..lastDate] '
                      'are greyed out.',
                ),
                SizedBox(height: 10),
                _ExplainerRow(
                  number: '04',
                  title: 'currentDate marker',
                  body:
                      'currentDate (defaults to DateTime.now()) gets a circular '
                      'outline so users can see "today" at a glance.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarDialogMock extends StatelessWidget {
  const _CalendarDialogMock();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: paletteEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: paletteAccentDeep,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(18, 14, 14, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.close, size: 18, color: Colors.white),
                    SizedBox(width: 12),
                    Text(
                      'SELECT RANGE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFC7D2FE),
                        letterSpacing: 1.0,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.edit_outlined, size: 18, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'Mar 5 – Mar 12',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '2026',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFC7D2FE),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const _CalendarBody(),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: const [
                Spacer(),
                _DialogButton('CANCEL', filled: false),
                SizedBox(width: 8),
                _DialogButton('SAVE', filled: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarBody extends StatelessWidget {
  const _CalendarBody();
  @override
  Widget build(BuildContext context) {
    final List<List<int>> month = [
      [-1, -1, -1, -1, -1, -1, 1],
      [2, 3, 4, 5, 6, 7, 8],
      [9, 10, 11, 12, 13, 14, 15],
      [16, 17, 18, 19, 20, 21, 22],
      [23, 24, 25, 26, 27, 28, 29],
      [30, 31, -1, -1, -1, -1, -1],
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Text(
                'March 2026',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: paletteInk,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, size: 18, color: paletteInk),
              Spacer(),
              Icon(Icons.chevron_left, size: 20, color: paletteMuted),
              SizedBox(width: 12),
              Icon(Icons.chevron_right, size: 20, color: paletteMuted),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              _WeekHead('S'),
              _WeekHead('M'),
              _WeekHead('T'),
              _WeekHead('W'),
              _WeekHead('T'),
              _WeekHead('F'),
              _WeekHead('S'),
            ],
          ),
          const SizedBox(height: 6),
          for (final List<int> row in month) _MonthRow(days: row),
        ],
      ),
    );
  }
}

class _WeekHead extends StatelessWidget {
  const _WeekHead(this.label);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: paletteFaint,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

class _MonthRow extends StatelessWidget {
  const _MonthRow({required this.days});
  final List<int> days;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          for (int i = 0; i < days.length; i++)
            Expanded(
              child: _DayCell(
                day: days[i],
                isStart: days[i] == 5,
                isEnd: days[i] == 12,
                inRange: days[i] >= 5 && days[i] <= 12,
                isToday: days[i] == 19,
              ),
            ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    this.isStart = false,
    this.isEnd = false,
    this.inRange = false,
    this.isToday = false,
  });
  final int day;
  final bool isStart;
  final bool isEnd;
  final bool inRange;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    if (day < 0) {
      return const SizedBox(height: 28);
    }
    final Widget content = Text(
      '$day',
      style: TextStyle(
        fontSize: 12,
        fontWeight: (isStart || isEnd) ? FontWeight.w800 : FontWeight.w500,
        color: (isStart || isEnd)
            ? Colors.white
            : (inRange ? paletteAccentDeep : paletteInk),
      ),
    );

    BoxDecoration? bandDeco;
    if (inRange && !isStart && !isEnd) {
      bandDeco = const BoxDecoration(color: paletteRange);
    }

    Widget endpoint() => Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: paletteAccentDeep,
            shape: BoxShape.circle,
          ),
          child: content,
        );

    Widget normal() => Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: isToday
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: paletteAccent, width: 1.4),
                )
              : null,
          child: content,
        );

    return SizedBox(
      height: 30,
      child: DecoratedBox(
        decoration: bandDeco ?? const BoxDecoration(),
        child: Center(
          child: (isStart || isEnd) ? endpoint() : normal(),
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton(this.label, {required this.filled});
  final String label;
  final bool filled;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: filled ? paletteAccentDeep : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: filled ? Colors.white : paletteAccentDeep,
        ),
      ),
    );
  }
}

class _ExplainerRow extends StatelessWidget {
  const _ExplainerRow(
      {required this.number, required this.title, required this.body});
  final String number;
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: paletteSurface,
        border: Border.all(color: paletteEdge),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: paletteAccentSoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: paletteAccentDeep,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: paletteInk,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: paletteMuted,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 4. Two-pane mockup: DatePickerEntryMode.input
// =====================================================================

class SectionInputMockup extends StatelessWidget {
  const SectionInputMockup({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '4 · Mode: DatePickerEntryMode.input',
      tag: 'INPUT',
      tagColor: const Color(0xFF0E7490),
      subtitle:
          'Two TextField inputs, suitable for when typing dates is faster than '
          'navigating a grid (e.g. flight booking on a desktop).',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(flex: 5, child: _InputDialogMock()),
          const SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                SoftPanel(
                  color: Color(0xFFE0F2FE),
                  borderColor: Color(0xFF7DD3FC),
                  child: Text(
                    'fieldStartHintText / fieldEndHintText fill the empty hint '
                    'placeholder; fieldStartLabelText / fieldEndLabelText drive '
                    'the floating labels.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF075985),
                      height: 1.45,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SoftPanel(
                  color: Color(0xFFFFF7ED),
                  borderColor: Color(0xFFFED7AA),
                  child: Text(
                    'errorFormatText / errorInvalidText / errorInvalidRangeText '
                    'replace the underline color with red and surface a helper '
                    'string under the field.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9A3412),
                      height: 1.45,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SoftPanel(
                  color: Color(0xFFEEF2FF),
                  borderColor: Color(0xFFC7D2FE),
                  child: Text(
                    'keyboardType defaults to TextInputType.datetime, which on '
                    'iOS / Android shows a keyboard tuned for digits and "/".',
                    style: TextStyle(
                      fontSize: 12,
                      color: paletteAccentDeep,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InputDialogMock extends StatelessWidget {
  const _InputDialogMock();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: paletteEdge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: paletteAccentDeep,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(18, 14, 14, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'ENTER DATES',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFC7D2FE),
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Start Date – End Date',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.calendar_today,
                    size: 18, color: Colors.white),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: const [
                    Expanded(
                      child: _MockTextField(
                        label: 'Start Date',
                        hint: 'mm/dd/yyyy',
                        value: '03/05/2026',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _MockTextField(
                        label: 'End Date',
                        hint: 'mm/dd/yyyy',
                        value: '03/12/2026',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: paletteOkSoft,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFA7F3D0)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.check_circle, size: 16, color: paletteOk),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Valid range: both dates inside [firstDate..lastDate].',
                          style: TextStyle(
                            fontSize: 12,
                            color: paletteOk,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: const [
                Spacer(),
                _DialogButton('CANCEL', filled: false),
                SizedBox(width: 8),
                _DialogButton('OK', filled: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MockTextField extends StatelessWidget {
  const _MockTextField({
    required this.label,
    required this.hint,
    required this.value,
  });
  final String label;
  final String hint;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: paletteAccentDeep,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: const BoxDecoration(
            color: Color(0xFFF4F6FA),
            borderRadius: BorderRadius.all(Radius.circular(6)),
            border: Border(
              bottom: BorderSide(color: paletteAccent, width: 2),
            ),
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontFamilyFallback: ['Menlo', 'Courier'],
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: paletteInk,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          hint,
          style: const TextStyle(
            fontSize: 10,
            color: paletteFaint,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// 5. DateTimeRange data shape panel
// =====================================================================

class SectionDataShape extends StatelessWidget {
  const SectionDataShape({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '5 · DateTimeRange — the returned value',
      tag: 'TYPE',
      tagColor: const Color(0xFF0F766E),
      subtitle:
          'showDateRangePicker() resolves to a Future<DateTimeRange?>. The class '
          'is a tiny immutable struct with two fields.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 5,
            child: _CodeBlock(
              language: 'dart',
              lines: <CodeLine>[
                CodeLine.cmt('// Two fields, both inclusive endpoints.'),
                CodeLine.code('final class DateTimeRange {'),
                CodeLine.code('  final DateTime start;'),
                CodeLine.code('  final DateTime end;'),
                CodeLine.code(
                    '  DateTimeRange({required this.start, required this.end})'),
                CodeLine.code('    : assert(!start.isAfter(end));'),
                CodeLine.code('}'),
                CodeLine.empty(),
                CodeLine.cmt('// Convenience: Duration spanned by the range.'),
                CodeLine.code(
                    'Duration get duration => end.difference(start);'),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                _FactBox(k: 'start', v: 'inclusive lower bound'),
                SizedBox(height: 8),
                _FactBox(k: 'end', v: 'inclusive upper bound'),
                SizedBox(height: 8),
                _FactBox(k: 'duration', v: 'end.difference(start)'),
                SizedBox(height: 8),
                _FactBox(
                    k: 'returns null', v: 'when user dismisses dialog'),
                SizedBox(height: 8),
                _FactBox(
                    k: 'normalized',
                    v: 'time-of-day stripped to midnight'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FactBox extends StatelessWidget {
  const _FactBox({required this.k, required this.v});
  final String k;
  final String v;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: paletteAccentSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFC7D2FE)),
      ),
      child: Row(
        children: [
          MonoText(k, color: paletteAccentDeep, size: 12),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(
                fontSize: 12,
                color: paletteAccentDeep,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 6. Localization & helpText / cancelText / saveText panel
// =====================================================================

class SectionLocalization extends StatelessWidget {
  const SectionLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '6 · Localization, labels and error strings',
      tag: 'I18N',
      tagColor: const Color(0xFF7C3AED),
      subtitle:
          'All string parameters are nullable; if you leave them null the dialog '
          'falls back to MaterialLocalizations for the active Locale.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _LocBlock(
                  title: 'Headers',
                  rows: const [
                    ['helpText', '"Select range"'],
                    ['saveText', '"Save"'],
                    ['cancelText', '"Cancel"'],
                    ['confirmText', 'used in input mode'],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LocBlock(
                  title: 'Field labels & hints',
                  rows: const [
                    ['fieldStartLabelText', '"Start Date"'],
                    ['fieldEndLabelText', '"End Date"'],
                    ['fieldStartHintText', '"mm/dd/yyyy"'],
                    ['fieldEndHintText', '"mm/dd/yyyy"'],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _LocBlock(
                  title: 'Errors',
                  rows: const [
                    ['errorFormatText', '"Invalid format."'],
                    ['errorInvalidText', '"Out of range."'],
                    ['errorInvalidRangeText', '"Invalid range."'],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SoftPanel(
            color: const Color(0xFFFAF5FF),
            borderColor: const Color(0xFFD8B4FE),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.info_outline, size: 16, color: Color(0xFF7C3AED)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tip — supplying these explicitly is the easiest way to '
                    'force a different language than the surrounding Locale, '
                    'or to use brand-specific phrasing like "Pick your stay".',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF581C87),
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LocBlock extends StatelessWidget {
  const _LocBlock({required this.title, required this.rows});
  final String title;
  final List<List<String>> rows;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE9D5FF)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Color(0xFF7C3AED),
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8),
          for (final List<String> r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: MonoText(r[0],
                        size: 11, color: const Color(0xFF581C87)),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 5,
                    child: Text(
                      r[1],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF6B21A8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// =====================================================================
// 7. builder parameter (theming) explainer panel
// =====================================================================

class SectionBuilderParam extends StatelessWidget {
  const SectionBuilderParam({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '7 · The `builder` parameter — theme & directionality',
      tag: 'BUILDER',
      tagColor: const Color(0xFF0F766E),
      subtitle:
          'builder wraps the dialog with extra inherited widgets — the canonical '
          'way to override Theme, Directionality, MediaQuery, or Localizations '
          'for the picker only.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            flex: 6,
            child: _CodeBlock(
              language: 'dart',
              lines: <CodeLine>[
                CodeLine.code('await showDateRangePicker('),
                CodeLine.code('  context: context,'),
                CodeLine.code('  firstDate: DateTime(2020),'),
                CodeLine.code('  lastDate: DateTime(2030),'),
                CodeLine.code(
                    '  builder: (BuildContext ctx, Widget? child) {'),
                CodeLine.code('    return Theme('),
                CodeLine.code('      data: ThemeData.dark().copyWith('),
                CodeLine.code(
                    '        colorScheme: const ColorScheme.dark('),
                CodeLine.code('          primary: Color(0xFF4F46E5),'),
                CodeLine.code('          onPrimary: Colors.white,'),
                CodeLine.code('          surface: Color(0xFF1F2933),'),
                CodeLine.code('          onSurface: Colors.white,'),
                CodeLine.code('        ),'),
                CodeLine.code('      ),'),
                CodeLine.code('      child: child!,'),
                CodeLine.code('    );'),
                CodeLine.code('  },'),
                CodeLine.code(');'),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                _FactBox(
                  k: 'Theme(...)',
                  v: 'override colors, text styles, button shapes',
                ),
                SizedBox(height: 8),
                _FactBox(
                  k: 'Directionality',
                  v: 'force RTL even in an LTR app',
                ),
                SizedBox(height: 8),
                _FactBox(
                  k: 'Localizations',
                  v: 'show the dialog in another language',
                ),
                SizedBox(height: 8),
                _FactBox(
                  k: 'MediaQuery',
                  v: 'simulate a different text scaler',
                ),
                SizedBox(height: 8),
                _FactBox(
                  k: 'child',
                  v: 'never null inside builder',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 8. Recipe code listing — full call
// =====================================================================

class SectionRecipe extends StatelessWidget {
  const SectionRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '8 · Full recipe — copy/paste call site',
      tag: 'RECIPE',
      tagColor: const Color(0xFFB45309),
      subtitle:
          'A complete realistic invocation; the function returns a Future, so we '
          'await it and handle the null (dismissed) case.',
      child: const _CodeBlock(
        language: 'dart',
        lines: <CodeLine>[
          CodeLine.cmt('// Inside an async event handler:'),
          CodeLine.code('final DateTime now = DateTime.now();'),
          CodeLine.code(
              'final DateTime first = DateTime(now.year, 1, 1);'),
          CodeLine.code(
              'final DateTime last  = DateTime(now.year + 1, 12, 31);'),
          CodeLine.code('final DateTimeRange initial = DateTimeRange('),
          CodeLine.code('  start: DateTime(now.year, 3, 5),'),
          CodeLine.code('  end:   DateTime(now.year, 3, 12),'),
          CodeLine.code(');'),
          CodeLine.empty(),
          CodeLine.code(
              'final DateTimeRange? picked = await showDateRangePicker('),
          CodeLine.code('  context:                       context,'),
          CodeLine.code('  firstDate:                     first,'),
          CodeLine.code('  lastDate:                      last,'),
          CodeLine.code('  initialDateRange:              initial,'),
          CodeLine.code('  currentDate:                   now,'),
          CodeLine.code(
              '  initialEntryMode:              DatePickerEntryMode.calendar,'),
          CodeLine.code('  helpText:                      "Pick your stay",'),
          CodeLine.code('  cancelText:                    "Discard",'),
          CodeLine.code('  confirmText:                   "Apply",'),
          CodeLine.code('  saveText:                      "Save",'),
          CodeLine.code(
              '  errorFormatText:               "Use mm/dd/yyyy",'),
          CodeLine.code(
              '  errorInvalidText:              "Outside allowed window",'),
          CodeLine.code(
              '  errorInvalidRangeText:         "Start must be before end",'),
          CodeLine.code('  fieldStartHintText:            "mm/dd/yyyy",'),
          CodeLine.code('  fieldEndHintText:              "mm/dd/yyyy",'),
          CodeLine.code('  fieldStartLabelText:           "Check-in",'),
          CodeLine.code('  fieldEndLabelText:             "Check-out",'),
          CodeLine.code(
              '  keyboardType:                  TextInputType.datetime,'),
          CodeLine.code('  barrierDismissible:            true,'),
          CodeLine.code('  barrierColor:                  Colors.black54,'),
          CodeLine.code(
              '  barrierLabel:                  "Pick range modal",'),
          CodeLine.code('  useRootNavigator:              true,'),
          CodeLine.code(
              '  routeSettings:                 const RouteSettings(name: "/range"),'),
          CodeLine.code(
              '  textDirection:                 TextDirection.ltr,'),
          CodeLine.code(
              '  anchorPoint:                   const Offset(0, 0),'),
          CodeLine.code(
              '  switchToInputEntryModeIcon:    const Icon(Icons.edit_outlined),'),
          CodeLine.code(
              '  switchToCalendarEntryModeIcon: const Icon(Icons.calendar_today),'),
          CodeLine.code('  builder: (ctx, child) => Theme('),
          CodeLine.code('    data: Theme.of(ctx).copyWith('),
          CodeLine.code(
              '      colorScheme: Theme.of(ctx).colorScheme.copyWith('),
          CodeLine.code('        primary: const Color(0xFF4F46E5),'),
          CodeLine.code('      ),'),
          CodeLine.code('    ),'),
          CodeLine.code('    child: child!,'),
          CodeLine.code('  ),'),
          CodeLine.code(');'),
          CodeLine.empty(),
          CodeLine.cmt('// Handle dismissal explicitly:'),
          CodeLine.code('if (picked == null) {'),
          CodeLine.code('  // user tapped Cancel or the barrier'),
          CodeLine.code('  return;'),
          CodeLine.code('} else {'),
          CodeLine.code(
              r'  print("from ${picked.start} to ${picked.end}");'),
          CodeLine.code('}'),
        ],
      ),
    );
  }
}

// =====================================================================
// 9. Comparison vs showDatePicker (single-date)
// =====================================================================

class SectionComparison extends StatelessWidget {
  const SectionComparison({super.key});

  @override
  Widget build(BuildContext context) {
    const List<List<String>> rows = [
      ['Returns', 'Future<DateTime?>', 'Future<DateTimeRange?>'],
      ['Number of dates', '1 (single)', '2 (start + end)'],
      [
        'Default mode',
        'DatePickerEntryMode.calendar',
        'DatePickerEntryMode.calendar',
      ],
      ['Initial value param', 'initialDate', 'initialDateRange'],
      ['Default action label', 'OK', 'Save'],
      ['Has range error string', 'no', 'errorInvalidRangeText'],
      [
        'Field labels',
        'fieldHintText / fieldLabelText',
        'fieldStartHintText / fieldEndHintText / fieldStartLabelText / fieldEndLabelText',
      ],
      ['Calendar layout', 'standard month grid', 'long scrolling month list'],
      [
        'Picks ranges',
        'no — single weekday only',
        'yes — supports any contiguous range',
      ],
      [
        'Switch entry mode icon',
        'switchToInputEntryModeIcon',
        'switchToInputEntryModeIcon (and -Calendar-)',
      ],
    ];

    return SectionCard(
      title: '9 · Comparison vs showDatePicker',
      tag: 'COMPARE',
      tagColor: const Color(0xFF0E7490),
      subtitle:
          'Side-by-side reference — useful when deciding which API best fits a '
          'given use case (booking vs deadline vs filter).',
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: paletteEdge),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFE0F2FE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: const [
                  Expanded(flex: 4, child: _CmpHead('Aspect')),
                  Expanded(flex: 6, child: _CmpHead('showDatePicker')),
                  Expanded(flex: 6, child: _CmpHead('showDateRangePicker')),
                ],
              ),
            ),
            for (int i = 0; i < rows.length; i++)
              Container(
                decoration: BoxDecoration(
                  color: i.isEven ? paletteSurface : const Color(0xFFFAFAFB),
                  border: const Border(
                    top: BorderSide(color: paletteHairline),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        rows[i][0],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: paletteInk,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: MonoText(rows[i][1], size: 11.5),
                    ),
                    Expanded(
                      flex: 6,
                      child: MonoText(rows[i][2],
                          size: 11.5, color: paletteAccentDeep),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CmpHead extends StatelessWidget {
  const _CmpHead(this.label);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: Color(0xFF075985),
        letterSpacing: 0.6,
      ),
    );
  }
}

// =====================================================================
// 10. Pitfalls
// =====================================================================

class SectionPitfalls extends StatelessWidget {
  const SectionPitfalls({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: '10 · Pitfalls and gotchas',
      tag: 'CAREFUL',
      tagColor: paletteWarn,
      subtitle:
          'These are the assertion failures and surprising behaviors most '
          'developers hit on the first integration.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _PitfallTile(
            title: 'firstDate must be <= lastDate',
            body:
                'The dialog asserts !firstDate.isAfter(lastDate). Swapping the '
                'two in code throws an AssertionError in debug.',
          ),
          SizedBox(height: 10),
          _PitfallTile(
            title: 'initialDateRange must lie inside [firstDate..lastDate]',
            body:
                'If initialDateRange.start < firstDate OR '
                'initialDateRange.end > lastDate, you get a debug-only '
                'assertion. Clamp before passing.',
          ),
          SizedBox(height: 10),
          _PitfallTile(
            title: 'initialDateRange.start <= initialDateRange.end',
            body:
                'DateTimeRange itself asserts !start.isAfter(end), so passing a '
                'reversed pair fails before even reaching the dialog.',
          ),
          SizedBox(height: 10),
          _PitfallTile(
            title: 'Returned value can be null',
            body:
                'If the user dismisses (Cancel, back button, barrier tap with '
                'barrierDismissible: true) you get null — always handle it.',
          ),
          SizedBox(height: 10),
          _PitfallTile(
            title: 'Time-of-day is dropped',
            body:
                'The picker normalizes to local midnight. Do not rely on '
                'milliseconds or hours surviving the round trip.',
          ),
          SizedBox(height: 10),
          _PitfallTile(
            title: 'useRootNavigator interaction',
            body:
                'Inside a nested Navigator (e.g. a tabbed shell), '
                'useRootNavigator: true (the default) bypasses the inner one. '
                'Set it to false if you want shell-level chrome to remain.',
          ),
        ],
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({required this.title, required this.body});
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: paletteWarnSoft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFED7AA)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded,
              size: 18, color: paletteWarn),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: paletteWarn,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7C2D12),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 11. Footer
// =====================================================================

class SectionFooter extends StatelessWidget {
  const SectionFooter({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: paletteAccentDeep,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.book_outlined, color: Colors.white, size: 18),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'showDateRangePicker · DateRangePickerDialog (private) · '
              'DatePickerEntryMode · DateTimeRange — Material library, '
              'flutter/material.dart',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFE0E7FF),
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              'visual deep demo',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Code-block primitive (color-coded but no real syntax parsing)
// =====================================================================

class CodeLine {
  const CodeLine.code(this.text)
      : isComment = false,
        isEmpty = false;
  const CodeLine.cmt(this.text)
      : isComment = true,
        isEmpty = false;
  const CodeLine.empty()
      : text = '',
        isComment = false,
        isEmpty = true;

  final String text;
  final bool isComment;
  final bool isEmpty;
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.language, required this.lines});
  final String language;
  final List<CodeLine> lines;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: paletteCode,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFFEF4444),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFFF59E0B),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
              ),
              const Spacer(),
              Text(
                language,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: paletteCodeCmt,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (int i = 0; i < lines.length; i++) _renderLine(i + 1, lines[i]),
        ],
      ),
    );
  }

  Widget _renderLine(int n, CodeLine line) {
    if (line.isEmpty) {
      return const SizedBox(height: 6);
    }
    Color color = paletteCodeInk;
    if (line.isComment) color = paletteCodeCmt;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '$n',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontFamilyFallback: ['Menlo', 'Courier'],
                fontSize: 11,
                color: paletteCodeCmt,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              line.text,
              style: TextStyle(
                fontFamily: 'monospace',
                fontFamilyFallback: const ['Menlo', 'Courier'],
                fontSize: 12,
                color: color,
                height: 1.45,
                fontStyle: line.isComment ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
