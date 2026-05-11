// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables
// D4rt test script: Deep visual demo of Cupertino localization.
//
// This file is part of the D4rt flutter-test corpus. It is intended to be
// executed by an analyzer-free, sandboxed Dart interpreter. The script
// exports exactly one top-level entry point - `dynamic build(BuildContext)`
// - which is invoked a single time, and which returns a Widget tree.
//
// The rendered output is a long static gallery that walks through the
// Cupertino localization stack offered by Flutter:
//
//   * CupertinoLocalizations - the contract that iOS widgets read from
//   * DefaultCupertinoLocalizations - the English-only built-in fallback
//   * GlobalCupertinoLocalizations.delegate - the real internationalised
//     implementation that ships in `flutter_localizations`
//   * WidgetsLocalizations - the shared base for ALL Flutter apps
//   * LocalizationsDelegate<T> - the interface used to plug in custom L10n
//   * Locale & Locale.fromSubtags - language/country/script identifiers
//   * Localizations.of<T>(context, T) - the lookup at widget-build time
//
// Each section is followed by a comparison panel, code-block cards with
// idiomatic usage, and a pitfalls panel calling out the most common
// mistakes. The script renders a static gallery: there is no `setState`,
// no `Timer`, no `Future` and no `AnimationController`. Every callback
// passed to live widgets is either `null` (read-only) or a no-op consumer.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// The demo deliberately uses literal ARGB colours instead of CupertinoColors
// resolved against context, because some helper widgets are constructed
// without a live CupertinoTheme. The constants below are kept close to the
// real iOS palette so the gallery still feels native.
const Color _kCanvas = Color(0xFFF2F2F7);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1C1C1E);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1C1C1E);
const Color _kInkSecondary = Color(0xFF3C3C43);
const Color _kInkTertiary = Color(0xFF8E8E93);
const Color _kInkOnDark = Color(0xFFEDEDF0);
const Color _kInkOnDarkSecondary = Color(0xFFA1A1A6);
const Color _kAccent = Color(0xFF007AFF); // systemBlue
const Color _kAccentGreen = Color(0xFF34C759);
const Color _kAccentOrange = Color(0xFFFF9500);
const Color _kAccentRed = Color(0xFFFF3B30);
const Color _kAccentIndigo = Color(0xFF5856D6);
const Color _kAccentPink = Color(0xFFFF2D55);
const Color _kAccentTeal = Color(0xFF30B0C7);
const Color _kAccentYellow = Color(0xFFFFD60A);
const Color _kAccentGrey = Color(0xFF8E8E93);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kRowAlt = Color(0xFFF7F7F8);

const TextStyle _kTitleStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.4,
);
const TextStyle _kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: _kInkSecondary,
);
const TextStyle _kCaptionStyle = TextStyle(
  fontSize: 12.0,
  color: _kInkTertiary,
  fontWeight: FontWeight.w500,
);
const TextStyle _kBodyStyle = TextStyle(
  fontSize: 14.0,
  height: 1.45,
  color: _kInk,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kMonoSmall = TextStyle(
  fontSize: 11.5,
  fontFamily: 'monospace',
  color: _kInkSecondary,
  height: 1.35,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPERS
// ---------------------------------------------------------------------------
// All helpers are top-level `_camelCase` functions returning `Widget`s. They
// are intentionally not made into StatelessWidget subclasses to keep the
// file approachable to anyone reading top-to-bottom.
Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(top: 28.0, bottom: 12.0, left: 18.0, right: 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccent,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$index',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kTitleStyle),
              const SizedBox(height: 2.0),
              Text(tagline, style: _kSubtitleStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _card({
  required Widget child,
  Color background = _kCardBg,
  EdgeInsets padding = _kCardPadding,
  EdgeInsets margin = const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairline),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _cardTitle(
  String title, {
  String? subtitle,
  Color titleColor = _kInk,
  Color subtitleColor = _kInkSecondary,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: titleColor,
          letterSpacing: -0.2,
        ),
      ),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 2.0),
        Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
      ],
    ],
  );
}

Widget _pill(String label, {Color colour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: colour,
      ),
    ),
  );
}

Widget _solidPill(String label, {Color colour = _kAccent, Color textColour = const Color(0xFFFFFFFF)}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: colour,
      borderRadius: BorderRadius.circular(999.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: textColour,
      ),
    ),
  );
}

Widget _codeBlock(String code, {String? title}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF2A2D32)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null) ...<Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5F56),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFBD2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Container(
                width: 10.0,
                height: 10.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF27C93F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _kCodeAccent,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
        Text(code, style: _kCodeStyle),
      ],
    ),
  );
}

Widget _sectionDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
    height: 1.0,
    color: _kHairline,
  );
}

Widget _kvRow(String key, String value, {Color valueColour = _kInk, bool mono = true}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 230.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12.0,
              color: _kInkSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              color: valueColour,
              fontWeight: FontWeight.w600,
              fontFamily: mono ? 'monospace' : null,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _tableHeaderCell(String text, {int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          color: _kInk,
          letterSpacing: 0.4,
        ),
      ),
    ),
  );
}

Widget _tableBodyCell(String text, {int flex = 1, bool mono = false, Color colour = _kInk}) {
  return Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 9.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          color: colour,
          fontFamily: mono ? 'monospace' : null,
          height: 1.35,
        ),
      ),
    ),
  );
}

Widget _bullet(String label, {Color colour = _kAccent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 6.0,
          height: 6.0,
          margin: const EdgeInsets.only(top: 7.0, right: 8.0),
          decoration: BoxDecoration(
            color: colour,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(label, style: _kBodyStyle),
        ),
      ],
    ),
  );
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. All state must live in
// local variables and be passed by closure to the widgets below.
// ===========================================================================
dynamic build(BuildContext context) {
  print('Cupertino localization deep visual demo executing');
  final math.Random rng = math.Random(11);
  final int dummyEntropy = rng.nextInt(100);
  print('  rng warm-up: $dummyEntropy');

  // -------------------------------------------------------------------------
  // INSTANTIATE THE DEFAULT LOCALIZATIONS
  // -------------------------------------------------------------------------
  // `DefaultCupertinoLocalizations()` is `const`-constructable and exposes
  // English-only strings. It is the value that ships with `flutter/cupertino`
  // when an app does NOT include `GlobalCupertinoLocalizations.delegate`.
  // -------------------------------------------------------------------------
  const DefaultCupertinoLocalizations defaultL10n = DefaultCupertinoLocalizations();
  print('  DefaultCupertinoLocalizations instantiated');

  // Property-style getters (constants per locale).
  final String alertLabel = defaultL10n.alertDialogLabel;
  final String amAbbrev = defaultL10n.anteMeridiemAbbreviation;
  final String pmAbbrev = defaultL10n.postMeridiemAbbreviation;
  final String copyLabel = defaultL10n.copyButtonLabel;
  final String cutLabel = defaultL10n.cutButtonLabel;
  final String pasteLabel = defaultL10n.pasteButtonLabel;
  final String selectAllLabel = defaultL10n.selectAllButtonLabel;
  final String searchPlaceholder = defaultL10n.searchTextFieldPlaceholderLabel;
  final String barrierLabel = defaultL10n.modalBarrierDismissLabel;
  final String todayLabel = defaultL10n.todayLabel;
  final DatePickerDateOrder dateOrder = defaultL10n.datePickerDateOrder;
  final DatePickerDateTimeOrder dateTimeOrder = defaultL10n.datePickerDateTimeOrder;

  // Function-style accessors (take an int / DateTime).
  final String year2025 = defaultL10n.datePickerYear(2025);
  final String month6 = defaultL10n.datePickerMonth(6);
  final String dayOfMonth15 = defaultL10n.datePickerDayOfMonth(15);
  final String hour9 = defaultL10n.datePickerHour(9);
  final String hour23 = defaultL10n.datePickerHour(23);
  final String minute45 = defaultL10n.datePickerMinute(45);
  final String mediumDate = defaultL10n.datePickerMediumDate(DateTime(2026, 5, 11));
  final String hoursLabel0 = defaultL10n.timerPickerHourLabel(0);
  final String hoursLabel1 = defaultL10n.timerPickerHourLabel(1);
  final String hoursLabel5 = defaultL10n.timerPickerHourLabel(5);
  final String minutesLabel0 = defaultL10n.timerPickerMinuteLabel(0);
  final String minutesLabel1 = defaultL10n.timerPickerMinuteLabel(1);
  final String minutesLabel45 = defaultL10n.timerPickerMinuteLabel(45);
  final String secondsLabel0 = defaultL10n.timerPickerSecondLabel(0);
  final String secondsLabel1 = defaultL10n.timerPickerSecondLabel(1);
  final String secondsLabel45 = defaultL10n.timerPickerSecondLabel(45);
  final String tabLabel = defaultL10n.tabSemanticsLabel(tabIndex: 2, tabCount: 5);
  final String datePickerHourSem9 = defaultL10n.datePickerHourSemanticsLabel(9);
  final String datePickerMinuteSem30 = defaultL10n.datePickerMinuteSemanticsLabel(30);
  print('  pulled ${alertLabel.length + amAbbrev.length} sample characters from the default L10n');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // The hero card explains the role of Cupertino localization and compares
  // it to Material localization at a glance.
  // -------------------------------------------------------------------------
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF007AFF),
          Color(0xFF5856D6),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33007AFF),
          offset: Offset(0.0, 4.0),
          blurRadius: 14.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(CupertinoIcons.globe, color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'Cupertino L10n',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'How Cupertino widgets read strings, formats and direction',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'Every Cupertino widget that exposes user-visible text - CupertinoTimerPicker, '
          'CupertinoDatePicker, the iOS context menu, the modal-route dismiss barrier - '
          'reads its strings from the nearest `CupertinoLocalizations`. '
          'In a stock Flutter app that is `DefaultCupertinoLocalizations`, which speaks only '
          'English. Add `GlobalCupertinoLocalizations.delegate` (from `flutter_localizations`) '
          'to your `CupertinoApp.localizationsDelegates` to switch on real iOS translations '
          'for ~80 locales.',
          style: TextStyle(
            fontSize: 14.0,
            height: 1.5,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('CupertinoLocalizations', colour: const Color(0xFFFFFFFF)),
            _pill('DefaultCupertinoLocalizations', colour: const Color(0xFFFFFFFF)),
            _pill('GlobalCupertinoLocalizations.delegate', colour: const Color(0xFFFFFFFF)),
            _pill('WidgetsLocalizations', colour: const Color(0xFFFFFFFF)),
            _pill('LocalizationsDelegate<T>', colour: const Color(0xFFFFFFFF)),
            _pill('Locale.fromSubtags', colour: const Color(0xFFFFFFFF)),
            _pill('Localizations.of<T>', colour: const Color(0xFFFFFFFF)),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0x55FFFFFF)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Icon(CupertinoIcons.lightbulb_fill, color: Color(0xFFFFD60A), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Cupertino L10n vs Material L10n: same shape (a `LocalizationsDelegate<T>`), '
                  'different `T`. The Material delegate fills `MaterialLocalizations`; the '
                  'Cupertino delegate fills `CupertinoLocalizations`. A hybrid app needs both.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFFFFFFFF),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - API SURFACE
  // -------------------------------------------------------------------------
  // The DefaultCupertinoLocalizations type advertises about 25 distinct
  // getters / methods. The card below renders one row per member so the
  // reader can see exactly what string each one produces for English.
  // -------------------------------------------------------------------------
  final Widget apiSurfaceCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.doc_text_search, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'DefaultCupertinoLocalizations - API Surface',
              subtitle: 'Every getter and method, with the English-locale value rendered live',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCanvas,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('alertDialogLabel', alertLabel),
              _kvRow('anteMeridiemAbbreviation', amAbbrev),
              _kvRow('postMeridiemAbbreviation', pmAbbrev),
              _kvRow('copyButtonLabel', copyLabel),
              _kvRow('cutButtonLabel', cutLabel),
              _kvRow('pasteButtonLabel', pasteLabel),
              _kvRow('selectAllButtonLabel', selectAllLabel),
              _kvRow('searchTextFieldPlaceholderLabel', searchPlaceholder),
              _kvRow('modalBarrierDismissLabel', barrierLabel),
              _kvRow('todayLabel', todayLabel),
              _kvRow('datePickerDateOrder', dateOrder.toString()),
              _kvRow('datePickerDateTimeOrder', dateTimeOrder.toString()),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCanvas,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('datePickerYear(2025)', year2025),
              _kvRow('datePickerMonth(6)', month6),
              _kvRow('datePickerDayOfMonth(15)', dayOfMonth15),
              _kvRow('datePickerHour(9)', hour9),
              _kvRow('datePickerHour(23)', hour23),
              _kvRow('datePickerMinute(45)', minute45),
              _kvRow('datePickerMediumDate(2026-05-11)', mediumDate),
              _kvRow('datePickerHourSemanticsLabel(9)', datePickerHourSem9),
              _kvRow('datePickerMinuteSemanticsLabel(30)', datePickerMinuteSem30),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCanvas,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('timerPickerHourLabel(0)', hoursLabel0),
              _kvRow('timerPickerHourLabel(1)', hoursLabel1),
              _kvRow('timerPickerHourLabel(5)', hoursLabel5),
              _kvRow('timerPickerMinuteLabel(0)', minutesLabel0),
              _kvRow('timerPickerMinuteLabel(1)', minutesLabel1),
              _kvRow('timerPickerMinuteLabel(45)', minutesLabel45),
              _kvRow('timerPickerSecondLabel(0)', secondsLabel0),
              _kvRow('timerPickerSecondLabel(1)', secondsLabel1),
              _kvRow('timerPickerSecondLabel(45)', secondsLabel45),
              _kvRow('tabSemanticsLabel(tabIndex:2,tabCount:5)', tabLabel),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kAccent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(CupertinoIcons.info_circle, color: _kAccent, size: 18.0),
              const SizedBox(width: 8.0),
              const Expanded(
                child: Text(
                  'These methods return `String` (or `String?` for timer-picker labels - some '
                  'locales legitimately have no label for a specific quantity). Callers never '
                  'instantiate DefaultCupertinoLocalizations themselves at runtime: the framework '
                  'looks it up via Localizations.of<CupertinoLocalizations>(context, ...).',
                  style: TextStyle(fontSize: 12.0, color: _kInk, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - LIVE PICKER LABEL SAMPLE
  // -------------------------------------------------------------------------
  // A static CupertinoTimerPicker (HMS mode) and a CupertinoDatePicker are
  // rendered side by side. Annotations call out which localization getter
  // is responsible for each visible label.
  // -------------------------------------------------------------------------
  final Widget timerPickerSample = SizedBox(
    height: 180.0,
    child: CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hms,
      initialTimerDuration: const Duration(hours: 1, minutes: 30, seconds: 15),
      onTimerDurationChanged: (Duration _) {},
    ),
  );

  final Widget datePickerSample = SizedBox(
    height: 200.0,
    child: CupertinoDatePicker(
      mode: CupertinoDatePickerMode.dateAndTime,
      initialDateTime: DateTime(2026, 5, 11, 9, 41),
      onDateTimeChanged: (DateTime _) {},
      use24hFormat: false,
    ),
  );

  final Widget livePickerCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.timer, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Live Picker - L10n in action',
              subtitle: 'Every visible word here comes from a CupertinoLocalizations getter',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _kCanvas,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                child: Text(
                  'CupertinoTimerPicker (HMS mode)',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: _kInk,
                  ),
                ),
              ),
              timerPickerSample,
              const SizedBox(height: 8.0),
              _bullet('"hours" / "hour" column header -> timerPickerHourLabel(n)', colour: _kAccent),
              _bullet('"min." column header -> timerPickerMinuteLabel(n)', colour: _kAccentIndigo),
              _bullet('"sec." column header -> timerPickerSecondLabel(n)', colour: _kAccentTeal),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _kCanvas,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                child: Text(
                  'CupertinoDatePicker (dateAndTime mode)',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: _kInk,
                  ),
                ),
              ),
              datePickerSample,
              const SizedBox(height: 8.0),
              _bullet('Date column ordering -> datePickerDateTimeOrder', colour: _kAccent),
              _bullet('"Today" label -> todayLabel', colour: _kAccentIndigo),
              _bullet('AM / PM tokens -> anteMeridiemAbbreviation / postMeridiemAbbreviation', colour: _kAccentOrange),
              _bullet('Hour values -> datePickerHour(n)', colour: _kAccentGreen),
              _bullet('Minute values -> datePickerMinute(n)', colour: _kAccentTeal),
              _bullet('Semantics labels -> datePickerHourSemanticsLabel(n) / datePickerMinuteSemanticsLabel(n)', colour: _kAccentPink),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - LOCALE GALLERY
  // -------------------------------------------------------------------------
  // Eight Locale cards demonstrating Locale.fromSubtags and how Cupertino
  // text would change once GlobalCupertinoLocalizations.delegate is wired
  // in. The "expected" strings below are illustrative - they show what
  // GlobalCupertinoLocalizations would produce in each locale.
  // -------------------------------------------------------------------------
  final List<_LocaleSample> localeSamples = <_LocaleSample>[
    const _LocaleSample(
      flag: 'EN',
      title: 'English (US)',
      languageCode: 'en',
      countryCode: 'US',
      sampleCopy: 'Copy',
      samplePaste: 'Paste',
      sampleAlert: 'Alert',
      colour: _kAccent,
    ),
    const _LocaleSample(
      flag: 'EN',
      title: 'English (UK)',
      languageCode: 'en',
      countryCode: 'GB',
      sampleCopy: 'Copy',
      samplePaste: 'Paste',
      sampleAlert: 'Alert',
      colour: _kAccentIndigo,
    ),
    const _LocaleSample(
      flag: 'DE',
      title: 'Deutsch',
      languageCode: 'de',
      countryCode: 'DE',
      sampleCopy: 'Kopieren',
      samplePaste: 'Einsetzen',
      sampleAlert: 'Warnung',
      colour: _kAccentOrange,
    ),
    const _LocaleSample(
      flag: 'FR',
      title: 'Français',
      languageCode: 'fr',
      countryCode: 'FR',
      sampleCopy: 'Copier',
      samplePaste: 'Coller',
      sampleAlert: 'Alerte',
      colour: _kAccentRed,
    ),
    const _LocaleSample(
      flag: 'JA',
      title: '日本語',
      languageCode: 'ja',
      countryCode: 'JP',
      sampleCopy: 'コピー',
      samplePaste: 'ペースト',
      sampleAlert: '警告',
      colour: _kAccentPink,
    ),
    const _LocaleSample(
      flag: 'AR',
      title: 'العربية',
      languageCode: 'ar',
      countryCode: 'EG',
      sampleCopy: 'نسخ',
      samplePaste: 'لصق',
      sampleAlert: 'تنبيه',
      colour: _kAccentGreen,
    ),
    const _LocaleSample(
      flag: 'ZH',
      title: '中文',
      languageCode: 'zh',
      countryCode: 'CN',
      sampleCopy: '复制',
      samplePaste: '粘贴',
      sampleAlert: '提醒',
      colour: _kAccentTeal,
    ),
    const _LocaleSample(
      flag: 'ES',
      title: 'Español (MX)',
      languageCode: 'es',
      countryCode: 'MX',
      sampleCopy: 'Copiar',
      samplePaste: 'Pegar',
      sampleAlert: 'Alerta',
      colour: _kAccentYellow,
    ),
  ];

  final List<Widget> localeCards = <Widget>[];
  for (final _LocaleSample sample in localeSamples) {
    final Locale locale = Locale.fromSubtags(
      languageCode: sample.languageCode,
      countryCode: sample.countryCode,
    );
    localeCards.add(_localeCard(sample, locale));
  }

  final Widget localeGalleryCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.flag, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Locale Gallery',
              subtitle: 'Eight Locales with the strings GlobalCupertinoLocalizations.delegate would provide',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: localeCards,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCanvas,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'These cards illustrate what `Localizations.of<CupertinoLocalizations>(context, '
            'CupertinoLocalizations).copyButtonLabel` resolves to per locale. The actual lookup '
            'happens through `GlobalCupertinoLocalizations.delegate`, which is a '
            '`LocalizationsDelegate<CupertinoLocalizations>` shipping with `flutter_localizations`.',
            style: TextStyle(fontSize: 12.0, color: _kInk, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - RTL HANDLING
  // -------------------------------------------------------------------------
  // CupertinoIcons and most layout widgets honour the ambient Directionality.
  // This section renders the same row of icons + label twice: once LTR and
  // once RTL, so the visual difference is obvious.
  // -------------------------------------------------------------------------
  Widget _directionDemo(TextDirection direction, String label, String text, Color tint) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: tint.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _solidPill(label, colour: tint),
              const SizedBox(width: 6.0),
              Text(
                'TextDirection.${direction == TextDirection.ltr ? 'ltr' : 'rtl'}',
                style: _kCaptionStyle,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Directionality(
            textDirection: direction,
            child: Row(
              children: <Widget>[
                const Icon(CupertinoIcons.back, size: 22.0, color: _kInk),
                const SizedBox(width: 8.0),
                const Icon(CupertinoIcons.chevron_left, size: 18.0, color: _kInkSecondary),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 14.0, color: _kInk),
                  ),
                ),
                const SizedBox(width: 12.0),
                const Icon(CupertinoIcons.chevron_right, size: 18.0, color: _kInkSecondary),
                const SizedBox(width: 8.0),
                const Icon(CupertinoIcons.forward, size: 22.0, color: _kInk),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget rtlCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.arrow_2_circlepath, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'RTL Handling',
              subtitle: 'Directionality flips chevrons, paddings and `back` icons automatically',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _directionDemo(TextDirection.ltr, 'LTR', 'Settings > Display & Brightness', _kAccent),
        const SizedBox(height: 10.0),
        _directionDemo(TextDirection.rtl, 'RTL', 'الإعدادات > الشاشة والإضاءة', _kAccentGreen),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCanvas,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _bullet('`CupertinoIcons.back` rotates by 180° when the ambient direction is RTL', colour: _kAccent),
              _bullet('`EdgeInsetsDirectional` and `AlignmentDirectional` resolve start/end based on Directionality', colour: _kAccentIndigo),
              _bullet('`WidgetsLocalizations.textDirection` is the source of truth - GlobalCupertinoLocalizations defers to it', colour: _kAccentOrange),
              _bullet('Without a Directionality ancestor, raw `Row`s and `Padding`s assume LTR', colour: _kAccentRed),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - CUSTOM LOCALIZATIONS DELEGATE
  // -------------------------------------------------------------------------
  // A skeleton of a custom delegate (extending LocalizationsDelegate<T>) with
  // every required method present. Rendered as a code block.
  // -------------------------------------------------------------------------
  final Widget customDelegateCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.gear_alt, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Custom LocalizationsDelegate<T>',
              subtitle: 'The interface every translation source must implement',
            ),
          ],
        ),
        _codeBlock(
          title: 'app_localizations.dart',
          '''/// Custom translation surface. Holds the strings the app cares about.
abstract class AppLocalizations {
  String get welcomeBanner;
  String greeting(String name);
  String itemsInCart(int n);
}

/// Two concrete implementations - one per supported locale.
class AppLocalizationsEn implements AppLocalizations {
  const AppLocalizationsEn();
  @override String get welcomeBanner => 'Welcome back';
  @override String greeting(String name) => 'Hi, \$name!';
  @override String itemsInCart(int n)   => n == 1 ? '1 item' : '\$n items';
}

class AppLocalizationsDe implements AppLocalizations {
  const AppLocalizationsDe();
  @override String get welcomeBanner => 'Willkommen zurück';
  @override String greeting(String name) => 'Hallo, \$name!';
  @override String itemsInCart(int n)   => n == 1 ? '1 Artikel' : '\$n Artikel';
}

/// The delegate is what `CupertinoApp.localizationsDelegates` accepts.
class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  // Decide which locales we actually translate.
  @override
  bool isSupported(Locale locale) =>
      const <String>{'en', 'de'}.contains(locale.languageCode);

  // Async hook in case translations need to be loaded from disk / network.
  @override
  Future<AppLocalizations> load(Locale locale) {
    switch (locale.languageCode) {
      case 'de': return SynchronousFuture(const AppLocalizationsDe());
      default:   return SynchronousFuture(const AppLocalizationsEn());
    }
  }

  // Tell Flutter whether the existing instance is still valid.
  @override
  bool shouldReload(AppLocalizationsDelegate _) => false;
}

/// Convenience accessor used inside widgets.
extension AppLocalizationsLookup on BuildContext {
  AppLocalizations get l => Localizations.of<AppLocalizations>(this, AppLocalizations)!;
}''',
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kAccent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _bullet('`isSupported(Locale)` is the gating predicate - Flutter walks delegates in order until one returns true', colour: _kAccent),
              _bullet('`load(Locale)` may be async, but returning a `SynchronousFuture<T>` is the common in-memory pattern', colour: _kAccentIndigo),
              _bullet('`shouldReload(old)` answers "do I need to rebuild dependents when the delegate list changes?"', colour: _kAccentOrange),
              _bullet('A delegate without `isSupported` for the active locale silently falls through to the next entry', colour: _kAccentRed),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - NUMBER / DATE FORMATTING
  // -------------------------------------------------------------------------
  // Four cards showcasing what DefaultCupertinoLocalizations emits when fed
  // representative inputs. Intended to be contrasted with intl.DateFormat.
  // -------------------------------------------------------------------------
  Widget _formatCard({required IconData icon, required String title, required String code, required String output, required Color tint}) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: tint.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: tint, size: 18.0),
              const SizedBox(width: 6.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: tint,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(code, style: _kMonoSmall),
          const SizedBox(height: 6.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: _kCardBg,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _kHairline),
            ),
            child: Text(
              output,
              style: const TextStyle(
                fontSize: 13.0,
                color: _kInk,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget formattingCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.number, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Date & Number Formatting',
              subtitle: 'What DefaultCupertinoLocalizations produces for representative inputs',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _formatCard(
          icon: CupertinoIcons.calendar_today,
          title: 'datePickerMediumDate',
          code: "defaultL10n.datePickerMediumDate(DateTime(2026, 5, 11))",
          output: mediumDate,
          tint: _kAccent,
        ),
        const SizedBox(height: 8.0),
        _formatCard(
          icon: CupertinoIcons.calendar,
          title: 'datePickerYear / Month / Day',
          code: "defaultL10n.datePickerYear(2025) + '/' + datePickerMonth(6) + '/' + datePickerDayOfMonth(15)",
          output: '$year2025 / $month6 / $dayOfMonth15',
          tint: _kAccentIndigo,
        ),
        const SizedBox(height: 8.0),
        _formatCard(
          icon: CupertinoIcons.clock,
          title: 'datePickerHour / Minute',
          code: "defaultL10n.datePickerHour(9) + ':' + datePickerMinute(45) + ' ' + anteMeridiemAbbreviation",
          output: '$hour9:$minute45 $amAbbrev',
          tint: _kAccentOrange,
        ),
        const SizedBox(height: 8.0),
        _formatCard(
          icon: CupertinoIcons.timer_fill,
          title: 'timerPickerHour / Minute / Second labels',
          code: "[h, m, s].map((n) => '\${defaultL10n.timerPickerXLabel(n)}').join(' ')",
          output: '$hoursLabel5 $minutesLabel45 $secondsLabel45',
          tint: _kAccentGreen,
        ),
        const SizedBox(height: 8.0),
        _formatCard(
          icon: CupertinoIcons.text_alignleft,
          title: 'tabSemanticsLabel',
          code: "defaultL10n.tabSemanticsLabel(tabIndex: 2, tabCount: 5)",
          output: tabLabel,
          tint: _kAccentTeal,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCanvas,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _bullet('CupertinoLocalizations is locale-aware but lightweight; for arbitrary patterns reach for `package:intl`', colour: _kAccent),
              _bullet('`intl.DateFormat.yMMMd(localeName).format(d)` covers most real-world date strings', colour: _kAccentIndigo),
              _bullet('`intl.NumberFormat.currency(...)` covers currency, decimal-comma vs decimal-point, and Eastern digits', colour: _kAccentOrange),
              _bullet('Pass the canonical locale name (`en_US`) to intl - not the `Locale` object directly', colour: _kAccentRed),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - COMPARISON TABLE
  // -------------------------------------------------------------------------
  // Side-by-side mapping of CupertinoLocalizations vs MaterialLocalizations
  // vs WidgetsLocalizations. The header row is bold; body rows alternate.
  // -------------------------------------------------------------------------
  Widget _comparisonRow(String widgetsRow, String cupertinoRow, String materialRow, {bool header = false, bool alt = false}) {
    final TextStyle style = header
        ? const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: _kInk,
            letterSpacing: 0.4,
          )
        : const TextStyle(fontSize: 12.0, color: _kInk, height: 1.35);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: header
            ? _kRowAlt
            : (alt ? const Color(0xFFFAFAFB) : const Color(0x00000000)),
        border: const Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 3, child: Text(widgetsRow, style: style)),
          Expanded(flex: 3, child: Text(cupertinoRow, style: style)),
          Expanded(flex: 4, child: Text(materialRow, style: style)),
        ],
      ),
    );
  }

  final Widget comparisonTable = _card(
    padding: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: <Widget>[
              const Icon(CupertinoIcons.rectangle_grid_2x2, color: _kAccent, size: 20.0),
              const SizedBox(width: 6.0),
              _cardTitle(
                'Cupertino vs Material vs Widgets - L10n stack',
                subtitle: 'Where each Localizations type lives, and what it gives you',
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: _kHairline)),
          ),
          child: Column(
            children: <Widget>[
              _comparisonRow('Aspect', 'CupertinoLocalizations', 'MaterialLocalizations / WidgetsLocalizations', header: true),
              _comparisonRow('Package', 'flutter/cupertino', 'flutter/material  +  flutter/widgets'),
              _comparisonRow('Default impl', 'DefaultCupertinoLocalizations', 'DefaultMaterialLocalizations + DefaultWidgetsLocalizations', alt: true),
              _comparisonRow('Real i18n', 'GlobalCupertinoLocalizations.delegate', 'GlobalMaterialLocalizations.delegate + GlobalWidgetsLocalizations.delegate'),
              _comparisonRow('Used by', 'CupertinoTimerPicker, CupertinoDatePicker, CupertinoTextField context menu, CupertinoActionSheet', 'MaterialBanner, TextField, DatePicker, NavigationBar, etc.', alt: true),
              _comparisonRow('Date order', 'datePickerDateOrder', 'firstDayOfWeekIndex / formatFullDate'),
              _comparisonRow('Copy/Paste labels', 'copyButtonLabel / pasteButtonLabel', 'copyButtonLabel / pasteButtonLabel (Material) - same name, distinct type', alt: true),
              _comparisonRow('Timer-picker labels', 'timerPickerHourLabel(n) -> String?', '-  (no Material equivalent)'),
              _comparisonRow('Search placeholder', 'searchTextFieldPlaceholderLabel', 'searchFieldLabel (Material)', alt: true),
              _comparisonRow('Text direction', '(inherits from WidgetsLocalizations.textDirection)', 'textDirection: TextDirection.ltr / rtl'),
              _comparisonRow('Required by app?', 'Yes, for any Cupertino widget with user-visible text', 'Yes, for any Material widget (`MaterialApp` adds the default automatically)', alt: true),
              _comparisonRow('Custom subclass?', 'Implement CupertinoLocalizations directly', 'Implement MaterialLocalizations directly (large surface!)'),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - SIX CODE-BLOCK CARDS
  // -------------------------------------------------------------------------
  // Each block is a self-contained snippet of idiomatic localization wiring.
  // -------------------------------------------------------------------------
  final Widget codeCupertinoApp = _codeBlock(
    title: 'cupertino_app_localizations.dart',
    '''CupertinoApp(
  // Locales the app *advertises*. The framework picks the best match.
  supportedLocales: const <Locale>[
    Locale('en', 'US'),
    Locale('en', 'GB'),
    Locale('de', 'DE'),
    Locale('fr', 'FR'),
    Locale('ja', 'JP'),
    Locale('ar', 'EG'),
    Locale('zh', 'CN'),
    Locale('es', 'MX'),
  ],
  localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
    DefaultCupertinoLocalizations.delegate, // fallback
    GlobalCupertinoLocalizations.delegate,  // iOS strings (real i18n)
    GlobalWidgetsLocalizations.delegate,    // TextDirection, etc.
    GlobalMaterialLocalizations.delegate,   // if any Material widget is in tree
    AppLocalizationsDelegate(),             // your own strings
  ],
  home: HomePage(),
);''',
  );

  final Widget codeLocalizationsOf = _codeBlock(
    title: 'localizations_of.dart',
    '''// Reading the active CupertinoLocalizations inside a widget.
class _SearchBar extends StatelessWidget {
  const _SearchBar();
  @override
  Widget build(BuildContext context) {
    // The framework injects the resolved CupertinoLocalizations here.
    final CupertinoLocalizations l = Localizations.of<CupertinoLocalizations>(
      context,
      CupertinoLocalizations,
    )!;
    return CupertinoSearchTextField(
      placeholder: l.searchTextFieldPlaceholderLabel,
    );
  }
}''',
  );

  final Widget codeLocaleResolution = _codeBlock(
    title: 'locale_resolution_callback.dart',
    '''// The locale-resolution callback gives the app the final say.
CupertinoApp(
  supportedLocales: const <Locale>[
    Locale('en', 'US'),
    Locale('de', 'DE'),
    Locale('zh', 'CN'),
  ],
  localeResolutionCallback: (Locale? deviceLocale, Iterable<Locale> supported) {
    if (deviceLocale == null) return supported.first;
    for (final Locale s in supported) {
      if (s.languageCode == deviceLocale.languageCode &&
          s.countryCode == deviceLocale.countryCode) {
        return s; // exact match
      }
    }
    for (final Locale s in supported) {
      if (s.languageCode == deviceLocale.languageCode) return s; // language match
    }
    return supported.first; // ultimate fallback
  },
  localizationsDelegates: GlobalCupertinoLocalizations.delegates,
  home: HomePage(),
);''',
  );

  final Widget codeSupportedLocales = _codeBlock(
    title: 'supported_locales_dynamic.dart',
    '''// Building the supported-locales list dynamically (from assets / config).
final List<Locale> supportedLocales = <Locale>[
  for (final String tag in const <String>['en-US', 'de-DE', 'fr-FR', 'ja-JP', 'ar-EG'])
    Locale.fromSubtags(
      languageCode: tag.split('-')[0],
      countryCode:  tag.split('-')[1],
    ),
];

CupertinoApp(
  supportedLocales: supportedLocales,
  localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  home: HomePage(),
);''',
  );

  final Widget codeCustomDelegateUsage = _codeBlock(
    title: 'custom_delegate_in_use.dart',
    '''// Wiring our custom AppLocalizationsDelegate into the app, and reading from
// it inside a widget via the BuildContext extension defined earlier.
CupertinoApp(
  supportedLocales: const <Locale>[Locale('en'), Locale('de')],
  localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
    AppLocalizationsDelegate(),
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  home: Builder(
    builder: (BuildContext context) {
      final AppLocalizations app = context.l;
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text(app.welcomeBanner)),
        child: Center(child: Text(app.greeting('Alex'))),
      );
    },
  ),
);''',
  );

  final Widget codeIntlIntegration = _codeBlock(
    title: 'intl_integration.dart',
    '''// Pair Cupertino L10n with `package:intl` for arbitrary date/number patterns.
import 'package:intl/intl.dart';

class _Banner extends StatelessWidget {
  final DateTime when;
  final int amountCents;
  const _Banner({required this.when, required this.amountCents});

  @override
  Widget build(BuildContext context) {
    final Locale l = Localizations.localeOf(context);
    final String tag = l.toLanguageTag(); // e.g. en-US, de-DE, ja-JP
    final String date = DateFormat.yMMMd(tag).format(when);
    final String price = NumberFormat.simpleCurrency(locale: tag)
        .format(amountCents / 100.0);
    return Text('\$date  -  \$price');
  }
}''',
  );

  final Widget codeBlocksSection = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.doc_text, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Idiomatic Usage - Code Snippets',
              subtitle: 'Six copy-pasteable patterns covering every part of the L10n stack',
            ),
          ],
        ),
        codeCupertinoApp,
        codeLocalizationsOf,
        codeLocaleResolution,
        codeSupportedLocales,
        codeCustomDelegateUsage,
        codeIntlIntegration,
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - PITFALLS
  // -------------------------------------------------------------------------
  // Six callouts covering the most common L10n mistakes.
  // -------------------------------------------------------------------------
  Widget _pitfall(IconData icon, String title, String body, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: tint, size: 22.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: tint,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: _kInk,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget pitfalls = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(CupertinoIcons.exclamationmark_triangle_fill, color: _kAccentOrange, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Pitfalls',
              subtitle: 'Six L10n mistakes that ship to production far too often',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfall(
          CupertinoIcons.xmark_octagon,
          'Forgetting GlobalCupertinoLocalizations.delegate',
          'Without it, every Cupertino widget renders English regardless of the user\'s system '
          'locale. The clue is that copy/paste menus, AM/PM labels and date-picker headings '
          'never translate. Add it alongside GlobalWidgetsLocalizations.delegate (and '
          'GlobalMaterialLocalizations.delegate if you also use Material widgets).',
          _kAccentRed,
        ),
        _pitfall(
          CupertinoIcons.text_quote,
          'Raw English strings bypassing the L10n surface',
          'Hard-coded `Text(\'Cancel\')` calls dodge the entire localization stack. The fix is '
          'to surface them through your AppLocalizations type or - if they map onto a built-in '
          'concept - through `Localizations.of<CupertinoLocalizations>(context, ...).cancelButtonLabel` '
          'when available.',
          _kAccentOrange,
        ),
        _pitfall(
          CupertinoIcons.clock,
          'AM/PM token mismatch',
          'Some locales (de_DE, ja_JP, fr_FR) prefer the 24-hour clock and use empty strings for '
          'anteMeridiemAbbreviation / postMeridiemAbbreviation. Pass `use24hFormat: true` to '
          'CupertinoDatePicker when the active locale doesn\'t use AM/PM, otherwise the picker '
          'will hide a meaningless column.',
          _kAccentIndigo,
        ),
        _pitfall(
          CupertinoIcons.calendar_badge_minus,
          'Hard-coded date formats',
          'Calling `\'\${d.day}/\${d.month}/\${d.year}\'` is wrong in 70% of the world. Use '
          '`defaultL10n.datePickerMediumDate(d)` for the picker, and `intl.DateFormat.yMMMd(tag).format(d)` '
          'everywhere else. The latter honours decimal-comma vs decimal-point, Eastern numerals '
          'and locale-specific month abbreviations.',
          _kAccentTeal,
        ),
        _pitfall(
          CupertinoIcons.arrow_2_circlepath,
          'Partial RTL coverage',
          'Wrapping a single sub-tree in `Directionality(textDirection: rtl)` while leaving the '
          'root LTR causes layout glitches: chevrons point the wrong way, paddings drift, and '
          'Hero animations flip mid-flight. Set the direction once at the app root via '
          'GlobalWidgetsLocalizations and let it cascade.',
          _kAccentPink,
        ),
        _pitfall(
          CupertinoIcons.tag_circle,
          'intl vs Dart-pkg locale parsing differences',
          '`Locale.fromSubtags(languageCode: \'zh\', scriptCode: \'Hans\', countryCode: \'CN\')` '
          'maps to the IETF tag `zh-Hans-CN`, but `intl.Intl.canonicalizedLocale(...)` may '
          'produce `zh_CN` (underscore, no script). Always pass `locale.toLanguageTag()` to '
          'intl APIs, never `locale.toString()`.',
          _kAccentGreen,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - FOOTER CHEAT-SHEET
  // -------------------------------------------------------------------------
  // Compact summary in a dark card. Chip groups call out the major types,
  // delegates, intl helpers and RTL tools.
  // -------------------------------------------------------------------------
  Widget _cheatChipGroup(String title, List<String> chips, Color tint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: _kInkOnDark,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: <Widget>[
              for (final String c in chips)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: tint.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999.0),
                    border: Border.all(color: tint.withOpacity(0.5)),
                  ),
                  child: Text(
                    c,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: tint,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  final Widget cheatSheet = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 24.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(CupertinoIcons.bookmark_fill, color: Color(0xFFFFD60A), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Cheat Sheet',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Everything you need to talk to the world from a Cupertino app.',
          style: TextStyle(fontSize: 12.0, color: _kInkOnDarkSecondary),
        ),
        const SizedBox(height: 14.0),
        _cheatChipGroup('Classes', const <String>[
          'CupertinoLocalizations',
          'DefaultCupertinoLocalizations',
          'MaterialLocalizations',
          'WidgetsLocalizations',
          'Locale',
          'Locale.fromSubtags',
        ], const Color(0xFF7DD3FC)),
        _cheatChipGroup('Delegates', const <String>[
          'DefaultCupertinoLocalizations.delegate',
          'GlobalCupertinoLocalizations.delegate',
          'GlobalWidgetsLocalizations.delegate',
          'GlobalMaterialLocalizations.delegate',
          'LocalizationsDelegate<T>',
        ], const Color(0xFFFFD60A)),
        _cheatChipGroup('intl integration', const <String>[
          "DateFormat.yMMMd(tag)",
          "DateFormat.Hm(tag)",
          "NumberFormat.currency(locale: tag)",
          "NumberFormat.decimalPattern(tag)",
          "Intl.canonicalizedLocale(tag)",
        ], const Color(0xFF34C759)),
        _cheatChipGroup('RTL helpers', const <String>[
          'Directionality(textDirection: rtl)',
          'EdgeInsetsDirectional',
          'AlignmentDirectional',
          'PositionedDirectional',
          'IconButton(direction: ...)',
        ], const Color(0xFFFF9500)),
        _cheatChipGroup('Lookup', const <String>[
          'Localizations.of<CupertinoLocalizations>(ctx, T)',
          'Localizations.localeOf(ctx)',
          'CupertinoApp.localizationsDelegates',
          'CupertinoApp.supportedLocales',
          'CupertinoApp.localeResolutionCallback',
        ], const Color(0xFFFF2D55)),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairlineDark),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Icon(CupertinoIcons.info_circle, color: Color(0xFFFFD60A), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Tagline: "If a string is visible, it is localizable. If a layout has a leading '
                  'edge, it is directional. Wire the delegates once at the root - then forget."',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: _kInkOnDark,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // ASSEMBLE THE FULL SCROLLABLE GALLERY
  // -------------------------------------------------------------------------
  // The 11 sections appear in the same numerical order as the spec.
  // -------------------------------------------------------------------------
  print('  building widget tree with 11 sections');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(2, 'API Surface', 'DefaultCupertinoLocalizations - every getter + method, rendered live'),
    apiSurfaceCard,
    _sectionHeader(3, 'Live Pickers', 'CupertinoTimerPicker and CupertinoDatePicker pulling from L10n'),
    livePickerCard,
    _sectionHeader(4, 'Locale Gallery', 'Eight Locales with the strings GlobalCupertinoLocalizations would resolve'),
    localeGalleryCard,
    _sectionHeader(5, 'RTL Handling', 'Directionality flipping CupertinoIcons and layout'),
    rtlCard,
    _sectionHeader(6, 'Custom Delegate', 'LocalizationsDelegate<T> skeleton with isSupported / load / shouldReload'),
    customDelegateCard,
    _sectionHeader(7, 'Formatting', 'DefaultCupertinoLocalizations samples for dates, times and timer labels'),
    formattingCard,
    _sectionDivider(),
    _sectionHeader(8, 'Comparison', 'Cupertino vs Material vs Widgets localization stack'),
    comparisonTable,
    _sectionHeader(9, 'Code Snippets', 'Six idiomatic patterns covering the whole stack'),
    codeBlocksSection,
    _sectionHeader(10, 'Pitfalls', 'Six L10n mistakes that ship to production far too often'),
    pitfalls,
    _sectionHeader(11, 'Cheat Sheet', 'Chip groups and a one-line tagline'),
    cheatSheet,
  ];
  print('  section widget count: ${sectionWidgets.length}');

  final Widget app = CupertinoApp(
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: _kAccent,
      scaffoldBackgroundColor: _kCanvas,
    ),
    home: CupertinoPageScaffold(
      backgroundColor: _kCanvas,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Cupertino L10n'),
        previousPageTitle: 'Gallery',
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sectionWidgets,
        ),
      ),
    ),
  );

  print('Cupertino localization deep visual demo built successfully');
  return app;
}

// ---------------------------------------------------------------------------
// SUPPORT TYPES
// ---------------------------------------------------------------------------
// `_LocaleSample` is a tiny immutable record used by the Locale-gallery
// section. It lives at the bottom of the file so the main `build()` is the
// first thing a reader sees after the helpers and constants.
class _LocaleSample {
  final String flag;
  final String title;
  final String languageCode;
  final String countryCode;
  final String sampleCopy;
  final String samplePaste;
  final String sampleAlert;
  final Color colour;
  const _LocaleSample({
    required this.flag,
    required this.title,
    required this.languageCode,
    required this.countryCode,
    required this.sampleCopy,
    required this.samplePaste,
    required this.sampleAlert,
    required this.colour,
  });
}

// ---------------------------------------------------------------------------
// LOCALE CARD HELPER
// ---------------------------------------------------------------------------
// Pulled out into its own top-level helper to keep `build()` flat and to
// keep all helpers at the same file-scope `_camelCase` convention.
// ---------------------------------------------------------------------------
Widget _localeCard(_LocaleSample sample, Locale locale) {
  return Container(
    width: 220.0,
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: sample.colour.withOpacity(0.4)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0A000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: sample.colour,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                sample.flag,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: 0.4,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                sample.title,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Locale.fromSubtags(${locale.languageCode}, ${locale.countryCode})',
          style: _kMonoSmall,
        ),
        const SizedBox(height: 2.0),
        Text(
          'IETF tag: ${locale.toLanguageTag()}',
          style: _kMonoSmall,
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: sample.colour.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'copyButtonLabel:',
                style: _kCaptionStyle.copyWith(color: sample.colour),
              ),
              Text(
                sample.sampleCopy,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'pasteButtonLabel:',
                style: _kCaptionStyle.copyWith(color: sample.colour),
              ),
              Text(
                sample.samplePaste,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'alertDialogLabel:',
                style: _kCaptionStyle.copyWith(color: sample.colour),
              ),
              Text(
                sample.sampleAlert,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: _kInk,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'GlobalCupertinoLocalizations.delegate would supply these.',
          style: _kCaptionStyle.copyWith(fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}
