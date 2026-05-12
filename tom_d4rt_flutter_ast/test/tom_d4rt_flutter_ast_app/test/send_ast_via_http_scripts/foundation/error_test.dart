// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of Flutter's error-reporting machinery.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a long, static gallery that walks through Flutter's
// error subsystem from the framework's perspective. Nine thematic sections
// cover:
//
//   1. Hero intro - why FlutterError exists, the error pipeline at a glance.
//   2. FlutterErrorDetails anatomy - every field (exception, stack, library,
//      context, informationCollector, errorWidget, silent, stackFilter)
//      rendered as a mock instance card with annotated rows.
//   3. ErrorWidget.builder customisation gallery - five mocked "red screen"
//      and "grey box" cards showing dev vs prod, plus three custom styles
//      (compact toast, full incident card, kid-friendly mascot).
//   4. DiagnosticsNode hierarchy - a tree diagram for the message bundle
//      that a FlutterError ships with: summary, descriptions, hints,
//      contexts, properties, stack-trace nodes.
//   5. presentError -> onError -> reportError flow diagram - lanes drawn as
//      static cards so the reader can see who calls whom.
//   6. ErrorSummary / ErrorDescription / ErrorHint role table - what each
//      DiagnosticsNode subclass is for, when to use it, severity, level.
//   7. Recipe code cards - six idiomatic snippets for throwing, wrapping,
//      reporting, silencing, customising ErrorWidget.builder, and writing
//      a stack filter.
//   8. Pitfalls & best-practice panel - eight callouts that bite teams.
//   9. Cheat-sheet footer - chip groups for the FlutterError surface.
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no
// `Stream`, no live `AnimationController`, no async/await, no for-in over
// BridgedInstance from Flutter APIs, and crucially **no thrown FlutterError
// at build time**. The script runs once and must succeed; every "error" you
// see on the screen is a hand-authored mock rendered with Containers and
// Texts, not a real assertion failure being caught.
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// We pick literal ARGB values so the demo is theme-independent. The palette
// borrows from a "lab notebook on porcelain" mood since error reports are
// developer-facing diagnostic material more than they are end-user UI.
const Color _kCanvas = Color(0xFFF4F5F8);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF8F9FC);
const Color _kCardDark = Color(0xFF1B1D2A);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1A1C25);
const Color _kInkSecondary = Color(0xFF424657);
const Color _kInkTertiary = Color(0xFF8C90A1);
const Color _kInkOnDark = Color(0xFFEDEEF5);
const Color _kInkOnDarkSecondary = Color(0xFFA3A6B8);
const Color _kAccent = Color(0xFFDC2626); // error red
const Color _kAccentSoft = Color(0xFFFEE2E2);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentTeal = Color(0xFF0D9488);
const Color _kAccentGreen = Color(0xFF16A34A);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentViolet = Color(0xFF7C3AED);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentSlate = Color(0xFF475569);
const Color _kErrorRed = Color(0xFFB91C1C);
const Color _kErrorRedDeep = Color(0xFF7F1D1D);
const Color _kErrorRedSoft = Color(0xFFFCA5A5);
const Color _kErrorPanel = Color(0xFFEF4444);
const Color _kErrorPanelSoft = Color(0xFFFEF2F2);
const Color _kGreyBox = Color(0xFFE5E7EB);
const Color _kGreyBoxBorder = Color(0xFFCBD5E1);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);

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
const TextStyle _kBodySoftStyle = TextStyle(
  fontSize: 13.0,
  height: 1.4,
  color: _kInkSecondary,
);
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.45,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const TextStyle _kMonoInlineStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kInk,
  height: 1.3,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);

// ---------------------------------------------------------------------------
// PRIVATE BUILDER HELPERS
// ---------------------------------------------------------------------------
// Helpers are top-level private functions returning Widgets. They are kept
// out of StatelessWidget subclasses so the file can be read top-to-bottom.

Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 30.0,
      bottom: 12.0,
      left: 18.0,
      right: 18.0,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
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
  EdgeInsets margin = const EdgeInsets.symmetric(
    horizontal: 18.0,
    vertical: 6.0,
  ),
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
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
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
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
    height: 1.0,
    color: _kHairline,
  );
}

Widget _kvRow(String key, String value, {Color valueColour = _kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: valueColour,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _bulletList(List<String> items, {Color bulletColour = _kAccent}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items.map<Widget>((String text) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 6.0, right: 9.0),
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: bulletColour,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(child: Text(text, style: _kBodySoftStyle)),
          ],
        ),
      );
    }).toList(),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 - HERO INTRO
// ---------------------------------------------------------------------------
Widget _heroBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF7F1D1D), Color(0xFFB91C1C), Color(0xFFDC2626)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33B91C1C),
          offset: Offset(0.0, 6.0),
          blurRadius: 18.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'package:flutter/foundation.dart',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'assertions.dart',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'FlutterError Machinery',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'How Flutter raises, formats, dispatches and renders errors - the '
          'pipeline from assert() to a red screen, in one static gallery.',
          style: TextStyle(
            color: Color(0xFFFEE2E2),
            fontSize: 14.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            _pill('FlutterError', colour: const Color(0xFFFEF3C7)),
            const SizedBox(width: 8.0),
            _pill('FlutterErrorDetails', colour: const Color(0xFFFCA5A5)),
            const SizedBox(width: 8.0),
            _pill('ErrorWidget', colour: const Color(0xFFFEE2E2)),
            const SizedBox(width: 8.0),
            _pill('Diagnostics', colour: const Color(0xFFA7F3D0)),
          ],
        ),
      ],
    ),
  );
}

Widget _heroIntroCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Why FlutterError exists',
          subtitle:
              'A typed error class, a typed details bundle and a central '
              'callback chain. Together they turn ad-hoc exceptions into '
              'structured, copy-pasteable, navigable bug reports.',
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: const Text(
            'When a framework or library raises a problem, it does not just '
            'throw a String. It builds a FlutterError out of DiagnosticsNode '
            'children (ErrorSummary, ErrorDescription, ErrorHint, '
            'DiagnosticsProperty, DiagnosticsStackTrace) and hands it to '
            'FlutterError.reportError. The static callbacks presentError and '
            'onError decide what happens next: print to console, send to '
            'Sentry, replace the affected widget with ErrorWidget, etc.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: _kInk,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _bulletList(const <String>[
              'FlutterError extends AssertionError and is a DiagnosticableTree.',
              'FlutterErrorDetails packages the exception with metadata.',
              'reportError -> onError -> presentError -> dumpErrorToConsole.',
              'ErrorWidget replaces the broken build()-throwing widget.',
            ], bulletColour: _kAccent)),
            const SizedBox(width: 16.0),
            Expanded(child: _bulletList(const <String>[
              'In debug mode, the default ErrorWidget is a red screen.',
              'In release mode, the default ErrorWidget is a grey box.',
              'ErrorWidget.builder lets you replace both globally.',
              'silent: true suppresses console output (use sparingly).',
            ], bulletColour: _kAccentAmber)),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - FlutterErrorDetails anatomy
// ---------------------------------------------------------------------------
Widget _detailsField(String name, String type, String desc, Color tagColour) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              name,
              style: const TextStyle(
                fontSize: 13.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                color: _kInk,
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: tagColour.withOpacity(0.16),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: tagColour,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(desc, style: _kBodySoftStyle),
      ],
    ),
  );
}

Widget _detailsAnatomyCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'FlutterErrorDetails fields',
          subtitle:
              'A snapshot of the bundle that reportError accepts. Every field '
              'has a default, so the smallest valid invocation is just '
              '`FlutterErrorDetails(exception: e)`.',
        ),
        const SizedBox(height: 12.0),
        _detailsField('exception', 'Object',
            'The thing that was thrown. Often a FlutterError, but can be '
            'any Object - even a String.',
            _kAccent),
        _detailsField('stack', 'StackTrace?',
            'The stack at the throw site. Will be filtered by FlutterError\'s '
            'stackFilter to drop framework-internal frames.',
            _kAccentSlate),
        _detailsField('library', 'String',
            'Human-readable origin: "widgets library", "rendering library", '
            '"gestures library". Drives the red-screen header.',
            _kAccentTeal),
        _detailsField('context', 'DiagnosticsNode?',
            'A DiagnosticsNode describing *where* the error occurred. Often '
            'an ErrorDescription like "during build()".',
            _kAccentBlue),
        _detailsField('informationCollector', 'InformationCollector?',
            'A nullary closure returning an Iterable<DiagnosticsNode>. Lets '
            'you defer expensive diagnostic gathering until the error is '
            'actually presented.',
            _kAccentViolet),
        _detailsField('silent', 'bool',
            'When true, presentError is not called for this report. Used by '
            'the framework for re-thrown errors that have already been '
            'reported once.',
            _kAccentAmber),
        _detailsField('errorWidget', 'Object?',
            'An optional pre-built error widget. Some frameworks set this '
            'instead of relying on ErrorWidget.builder.',
            _kAccentRose),
      ],
    ),
  );
}

Widget _detailsMockInstance() {
  return _card(
    background: _kCardDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'A FlutterErrorDetails instance, expanded',
          subtitle:
              'What an error from RenderBox.layout would look like in memory.',
          titleColor: _kInkOnDark,
          subtitleColor: _kInkOnDarkSecondary,
        ),
        const SizedBox(height: 12.0),
        _kvRow('exception', 'FlutterError("RenderBox was not laid out: ...")',
            valueColour: const Color(0xFFFCA5A5)),
        _kvRow('stack',
            '#0 RenderBox._getIntrinsicDimension ... (filtered: 17 frames)',
            valueColour: _kInkOnDarkSecondary),
        _kvRow('library', '"rendering library"',
            valueColour: const Color(0xFFFDE68A)),
        _kvRow('context',
            'ErrorDescription("during performLayout")',
            valueColour: const Color(0xFF93C5FD)),
        _kvRow('informationCollector',
            '() sync* { yield DiagnosticsProperty<...>("...", ...); }',
            valueColour: const Color(0xFFC4B5FD)),
        _kvRow('silent', 'false',
            valueColour: const Color(0xFFA7F3D0)),
        _kvRow('errorWidget', 'null',
            valueColour: _kInkOnDarkSecondary),
        _kvRow('stackFilter',
            'null  -> FlutterError.defaultStackFilter applied',
            valueColour: _kInkOnDarkSecondary),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - ErrorWidget.builder customisation gallery
// ---------------------------------------------------------------------------
Widget _mockRedScreen({
  required String summary,
  required String body,
  required String library,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _kErrorPanel,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kErrorRedDeep, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'EXCEPTION CAUGHT',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                library,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          summary,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: 'monospace',
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          body,
          style: const TextStyle(
            color: Color(0xFFFEE2E2),
            fontFamily: 'monospace',
            fontSize: 12.0,
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _mockGreyBox() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    padding: const EdgeInsets.all(20.0),
    height: 120.0,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: _kGreyBox,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: _kGreyBoxBorder),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 28.0,
          height: 28.0,
          decoration: const BoxDecoration(
            color: _kInkTertiary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            '!',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Something went wrong.',
          style: TextStyle(
            color: _kInkSecondary,
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _mockCompactToast() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kErrorRed),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 8.0,
          height: 8.0,
          decoration: const BoxDecoration(
            color: _kErrorPanel,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10.0),
        const Expanded(
          child: Text(
            'WidgetError: CartScreen failed to build (tap for details)',
            style: TextStyle(
              color: _kInkOnDark,
              fontSize: 12.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: _kErrorPanel.withOpacity(0.25),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Text(
            'INC#A-1729',
            style: TextStyle(
              color: Color(0xFFFCA5A5),
              fontSize: 10.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _mockIncidentCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _kErrorPanelSoft,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kErrorRedSoft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 34.0,
              height: 34.0,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: _kErrorRed,
                shape: BoxShape.circle,
              ),
              child: const Text(
                'X',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Something broke on this screen',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: _kErrorRedDeep,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    'We logged it. You can keep using the rest of the app.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: _kInkSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kErrorRedSoft),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Incident: INC-A-1729',
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: _kErrorRedDeep,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Module: cart_screen.dart   Build: 4.18.2+1907',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: _kInkSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _mockMascotCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF7ED),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFFDBA74)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: _kAccentAmber,
            shape: BoxShape.circle,
          ),
          child: const Text(
            ':(',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Oops! The chick tripped on a wire.',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'A custom ErrorWidget.builder lets you keep your brand voice '
                'even when something fails. Always pair with a real log.',
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.4,
                  color: _kInkSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _errorWidgetGallery() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Default in debug: the red screen',
              subtitle:
                  'ErrorWidget.builder returns _DefaultErrorWidget, which is '
                  'a Container painted red with a monospace summary on top.',
            ),
          ],
        ),
      ),
      _mockRedScreen(
        library: 'widgets library',
        summary:
            'FlutterError: A RenderFlex overflowed by 42 pixels on the right.',
        body:
            'The overflowing RenderFlex has an orientation of Axis.horizontal.\n'
            'The edge of the RenderFlex that is overflowing has been marked\n'
            'in the rendering with a yellow and black striped pattern.',
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Default in release: the grey box',
              subtitle:
                  'Release builds replace the red screen with a tiny grey '
                  'placeholder so end users do not see Flutter internals.',
            ),
          ],
        ),
      ),
      _mockGreyBox(),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Custom variant 1: compact dev toast',
              subtitle:
                  'Override ErrorWidget.builder during development to keep '
                  'the rest of the screen usable while a bad widget fails.',
            ),
          ],
        ),
      ),
      _mockCompactToast(),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Custom variant 2: production incident card',
              subtitle:
                  'In production, you usually want a styled, branded card '
                  'with an incident id, never raw stack traces.',
            ),
          ],
        ),
      ),
      _mockIncidentCard(),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Custom variant 3: kid-friendly mascot',
              subtitle:
                  'Consumer apps often pair a friendly mascot with a real '
                  'log call. The user sees the chick; engineering sees the '
                  'FlutterErrorDetails.',
            ),
          ],
        ),
      ),
      _mockMascotCard(),
      _codeBlock(
        '// Install once, at the top of main() - never at build time.\n'
        'ErrorWidget.builder = (FlutterErrorDetails details) {\n'
        '  if (kReleaseMode) {\n'
        '    return const IncidentCard();\n'
        '  }\n'
        '  return CompactDevToast(details: details);\n'
        '};',
        title: 'main.dart - ErrorWidget.builder install',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - DiagnosticsNode hierarchy
// ---------------------------------------------------------------------------
Widget _treeNode(String label, String type, Color colour,
    {bool isRoot = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(isRoot ? 0.18 : 0.10),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: colour.withOpacity(0.4)),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: colour,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.5,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
            color: colour,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            type,
            style: const TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _treeIndent(Widget child, {int depth = 1}) {
  return Padding(
    padding: EdgeInsets.only(left: 20.0 * depth),
    child: child,
  );
}

Widget _diagnosticsTreeCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'A FlutterError as a DiagnosticsNode tree',
          subtitle:
              'Every FlutterError is a DiagnosticableTree. Its children are '
              'the DiagnosticsNodes you passed to the constructor.',
        ),
        const SizedBox(height: 12.0),
        _treeNode('FlutterError', 'DiagnosticableTree', _kAccent, isRoot: true),
        _treeIndent(
          _treeNode('summary', 'ErrorSummary', _kErrorRed),
        ),
        _treeIndent(
          _treeNode('description', 'ErrorDescription', _kAccentSlate),
        ),
        _treeIndent(
          _treeNode('description', 'ErrorDescription', _kAccentSlate),
        ),
        _treeIndent(
          _treeNode('property', 'DiagnosticsProperty<Object>',
              _kAccentBlue),
        ),
        _treeIndent(
          _treeNode('property', 'IntProperty', _kAccentBlue),
        ),
        _treeIndent(
          _treeNode('hint', 'ErrorHint', _kAccentTeal),
        ),
        _treeIndent(
          _treeNode('hint', 'ErrorHint', _kAccentTeal),
        ),
        _treeIndent(
          _treeNode('context', 'ErrorDescription (level=info)',
              _kAccentViolet),
        ),
        _treeIndent(
          _treeNode('stack', 'DiagnosticsStackTrace', _kAccentRose),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'Order matters. The ErrorSummary always renders first and in '
            'bold; ErrorDescriptions come next as plain prose; ErrorHints '
            'are usually rendered with a "tip" prefix; DiagnosticsProperties '
            'render as key/value pairs; DiagnosticsStackTrace renders last.',
            style: _kBodySoftStyle,
          ),
        ),
      ],
    ),
  );
}

Widget _diagnosticsLevelTable() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'DiagnosticLevel values that errors use',
          subtitle:
              'Each DiagnosticsNode reports a level. The text-tree renderer '
              'uses it to decide what to print.',
        ),
        const SizedBox(height: 10.0),
        _kvRow('DiagnosticLevel.error',
            'ErrorSummary - always shown, bold, top of report',
            valueColour: _kErrorRedDeep),
        _kvRow('DiagnosticLevel.summary',
            'ErrorDescription used as a context node',
            valueColour: _kAccentSlate),
        _kvRow('DiagnosticLevel.info',
            'ErrorDescription, ErrorHint, default for props',
            valueColour: _kAccentBlue),
        _kvRow('DiagnosticLevel.warning',
            'Custom properties signalling something off',
            valueColour: _kAccentAmber),
        _kvRow('DiagnosticLevel.hidden',
            'Nodes excluded from default printing entirely',
            valueColour: _kInkTertiary),
        _kvRow('DiagnosticLevel.debug',
            'Nodes shown only in -v dumpRenderTree output',
            valueColour: _kInkTertiary),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - presentError -> onError -> reportError flow diagram
// ---------------------------------------------------------------------------
Widget _flowLane(String title, List<String> bullets, Color colour) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: colour.withOpacity(0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: colour,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: colour,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _bulletList(bullets, bulletColour: colour),
      ],
    ),
  );
}

Widget _flowArrow(String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: <Widget>[
        const SizedBox(width: 12.0),
        Container(
          width: 2.0,
          height: 18.0,
          color: _kInkTertiary,
        ),
        const SizedBox(width: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: _kInkSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _errorFlowCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'The dispatch chain: callsite -> log',
          subtitle:
              'Five static functions and two static callbacks. The arrows '
              'are the actual control flow inside FlutterError.',
        ),
        const SizedBox(height: 12.0),
        _flowLane(
          'callsite throws',
          const <String>[
            'Framework code: `throw FlutterError.fromParts(<DiagnosticsNode>[...])`.',
            'User code: `throw FlutterError("Something went wrong")`.',
            'Or: an async future completes with an error inside runApp\'s zone.',
          ],
          _kAccent,
        ),
        _flowArrow('caught by zone / Element.performRebuild / etc.'),
        _flowLane(
          'FlutterError.reportError(details)',
          const <String>[
            'The single funnel that all framework error paths use.',
            'Invokes `FlutterError.onError(details)` if non-null.',
            'If `silent: true`, presentError is skipped.',
          ],
          _kAccentAmber,
        ),
        _flowArrow('onError (mutable static callback)'),
        _flowLane(
          'FlutterError.onError',
          const <String>[
            'Default: `FlutterError.presentError`.',
            'Replace it in main() to send to Sentry, Crashlytics, etc.',
            'Set to null to silence everything (rarely a good idea).',
          ],
          _kAccentBlue,
        ),
        _flowArrow('presentError (also a static)'),
        _flowLane(
          'FlutterError.presentError',
          const <String>[
            'Default: `FlutterError.dumpErrorToConsole`.',
            'You can swap it for a logger that writes JSON to a file.',
            'Only called once for the same error within a frame.',
          ],
          _kAccentTeal,
        ),
        _flowArrow('dumpErrorToConsole'),
        _flowLane(
          'dumpErrorToConsole(details, forceReport: false)',
          const <String>[
            'Builds a text tree using TextTreeRenderer.',
            'Deduplicates: identical errors print once with a "+N" suffix.',
            'Uses debugPrint -> stderr in flutter test, stdout otherwise.',
          ],
          _kAccentGreen,
        ),
      ],
    ),
  );
}

Widget _presentVsReportTable() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'reportError vs onError vs presentError',
          subtitle: 'They look interchangeable but have very different jobs.',
        ),
        const SizedBox(height: 12.0),
        _kvRow('reportError', 'Entry point. Always call this. Never replace.',
            valueColour: _kAccentAmber),
        _kvRow('onError',
            'Callback you replace. Goes to Sentry / your logger.',
            valueColour: _kAccentBlue),
        _kvRow('presentError', 'The "render this to humans" step.',
            valueColour: _kAccentTeal),
        _kvRow('dumpErrorToConsole',
            'The default presenter. Pretty printer for DiagnosticsNode tree.',
            valueColour: _kAccentGreen),
        _kvRow('silent',
            'Field on FlutterErrorDetails. Skips presentError only.',
            valueColour: _kInkTertiary),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - ErrorSummary / Description / Hint role table
// ---------------------------------------------------------------------------
Widget _roleRow(String name, String purpose, String example, Color colour) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.07),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: colour.withOpacity(0.30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: colour,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                name,
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                purpose,
                style: _kBodyStyle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: Text(
            example,
            style: _kMonoInlineStyle,
          ),
        ),
      ],
    ),
  );
}

Widget _rolesCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'DiagnosticsNode roles in a FlutterError',
          subtitle:
              'Pick the right subclass for each line of your error message. '
              'It influences rendering, severity and tooling.',
        ),
        const SizedBox(height: 12.0),
        _roleRow(
          'ErrorSummary',
          'One-line headline. The first child of the DiagnosticsNode tree, '
              'and the only required one.',
          'ErrorSummary("RenderBox was not laid out before paint")',
          _kErrorRed,
        ),
        _roleRow(
          'ErrorDescription',
          'Body prose. Used to describe what was happening when the error '
              'fired and to add context.',
          'ErrorDescription("During performLayout, parent was a RenderFlex")',
          _kAccentSlate,
        ),
        _roleRow(
          'ErrorHint',
          'A nudge towards a solution. Rendered with a tip prefix in the '
              'console; designers can highlight in IDE plugins.',
          'ErrorHint("Consider wrapping the child in an Expanded widget")',
          _kAccentTeal,
        ),
        _roleRow(
          'DiagnosticsProperty<T>',
          'A key/value chunk of structured data: a Size, an Object, a List '
              '- whatever helps the reader.',
          'DiagnosticsProperty<RenderBox>("offending box", renderBox)',
          _kAccentBlue,
        ),
        _roleRow(
          'DiagnosticsStackTrace',
          'A specialised property for a StackTrace. Knows how to filter and '
              'pretty-print stack frames.',
          'DiagnosticsStackTrace("Stack when caught", stack)',
          _kAccentRose,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - Recipe code cards
// ---------------------------------------------------------------------------
Widget _recipesCards() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _codeBlock(
        '// Idiomatic throw: bundle of DiagnosticsNode children.\n'
        'throw FlutterError.fromParts(<DiagnosticsNode>[\n'
        '  ErrorSummary("CartScreen failed to build"),\n'
        '  ErrorDescription("during build() the cart had no items"),\n'
        '  ErrorHint("Did you forget to await loadCart()?"),\n'
        '  DiagnosticsProperty<int>("itemCount", 0),\n'
        ']);',
        title: '1. throw FlutterError.fromParts',
      ),
      _codeBlock(
        '// Wrap a foreign exception so framework tools still light up.\n'
        'try {\n'
        '  somethingRisky();\n'
        '} catch (e, s) {\n'
        '  FlutterError.reportError(FlutterErrorDetails(\n'
        '    exception: e,\n'
        '    stack: s,\n'
        '    library: "cart feature",\n'
        '    context: ErrorDescription("during checkout"),\n'
        '  ));\n'
        '}',
        title: '2. wrap an exception with FlutterErrorDetails',
      ),
      _codeBlock(
        '// Replace the global error sink (do this once, in main()).\n'
        'final FlutterExceptionHandler? defaultOnError = FlutterError.onError;\n'
        'FlutterError.onError = (FlutterErrorDetails details) {\n'
        '  myLogger.crash(details.exception, details.stack);\n'
        '  defaultOnError?.call(details); // still get the red screen in dev\n'
        '};',
        title: '3. FlutterError.onError - the Sentry hook',
      ),
      _codeBlock(
        '// Silence an error you know about - do not abuse this.\n'
        'FlutterError.reportError(FlutterErrorDetails(\n'
        '  exception: knownHarmlessException,\n'
        '  silent: true,\n'
        '));',
        title: '4. silent: true - skip presentError',
      ),
      _codeBlock(
        '// Branded ErrorWidget.builder install (see Section 3 gallery).\n'
        'ErrorWidget.builder = (FlutterErrorDetails details) {\n'
        '  return BrandedErrorCard(\n'
        '    summary: details.summary.toString(),\n'
        '    library: details.library ?? "unknown",\n'
        '  );\n'
        '};',
        title: '5. ErrorWidget.builder - branded UI fallback',
      ),
      _codeBlock(
        '// Custom stack filter that strips a vendor SDK from frames.\n'
        'FlutterError.demangleStackTrace = (StackTrace stack) {\n'
        '  final String text = stack.toString();\n'
        '  return StackTrace.fromString(\n'
        '    text.split("\\n")\n'
        '        .where((String line) => !line.contains("package:vendor_sdk"))\n'
        '        .join("\\n"),\n'
        '  );\n'
        '};',
        title: '6. demangleStackTrace - vendor-frame filter',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - Pitfalls / best-practice panel
// ---------------------------------------------------------------------------
Widget _pitfall(String tag, String title, String body, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.07),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withOpacity(0.30)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 11.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(body, style: _kBodySoftStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallsCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Eight pitfalls that bite teams',
          subtitle:
              'Picked from real bug reports against the framework and from '
              'app teams that wired up FlutterError.onError badly.',
        ),
        const SizedBox(height: 10.0),
        _pitfall(
          'P-01',
          'Replacing onError without falling through',
          'If you assign FlutterError.onError = myLogger and forget to call '
              'the previous handler, you also kill dumpErrorToConsole. Stash '
              'the default first, then call it after your custom code.',
          _kAccent,
        ),
        _pitfall(
          'P-02',
          'Throwing a String instead of FlutterError',
          'String exceptions still propagate, but they bypass the '
              'DiagnosticsNode tree and produce a barren console message. '
              'Always wrap them in FlutterError.fromParts.',
          _kAccentAmber,
        ),
        _pitfall(
          'P-03',
          'silent: true used as a workaround',
          'silent only hides the *user-facing* presentError call. The '
              'underlying state is still broken. Treat silent as a feature, '
              'not a release-engineering escape hatch.',
          _kAccentBlue,
        ),
        _pitfall(
          'P-04',
          'ErrorWidget.builder that itself throws',
          'If the builder throws, Flutter falls back to the default red box. '
              'Wrap branded fallback widgets in try/catch and verify they do '
              'not depend on uninitialised inherited widgets.',
          _kAccentRose,
        ),
        _pitfall(
          'P-05',
          'Ignoring details.context',
          'context tells you *when* the error happened ("during build"). '
              'Logging only details.exception loses half the signal.',
          _kAccentTeal,
        ),
        _pitfall(
          'P-06',
          'Stack filter that hides too much',
          'Filtering out everything that looks like a framework frame can '
              'erase the first frame inside your widget code. Keep the '
              'innermost user frame.',
          _kAccentViolet,
        ),
        _pitfall(
          'P-07',
          'Calling reportError from the wrong zone',
          'Errors raised outside of runZonedGuarded never reach onError. '
              'Use runZonedGuarded around runApp for catch-all support.',
          _kAccentGreen,
        ),
        _pitfall(
          'P-08',
          'Confusing FlutterError with PlatformException',
          'Method channel failures arrive as PlatformException. Wrap them '
              'in a FlutterError if you want them to flow through the same '
              'pipeline as widget-side errors.',
          _kAccentSlate,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - Cheat-sheet footer
// ---------------------------------------------------------------------------
Widget _chipGroup(String title, List<String> chips, Color colour) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color: colour,
            letterSpacing: -0.1,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: chips.map<Widget>((String c) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: colour.withOpacity(0.10),
                borderRadius: BorderRadius.circular(999.0),
                border: Border.all(color: colour.withOpacity(0.3)),
              ),
              child: Text(
                c,
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: colour,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _cheatSheetFooter() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Error machinery cheat-sheet',
          subtitle:
              'A compact map of every public symbol in the error subsystem.',
        ),
        const SizedBox(height: 8.0),
        _chipGroup(
          'core classes',
          const <String>[
            'FlutterError',
            'FlutterErrorDetails',
            'ErrorWidget',
            'DiagnosticableTree',
          ],
          _kAccent,
        ),
        _chipGroup(
          'DiagnosticsNode subclasses',
          const <String>[
            'ErrorSummary',
            'ErrorDescription',
            'ErrorHint',
            'ErrorSpacer',
            'DiagnosticsProperty<T>',
            'IntProperty',
            'StringProperty',
            'DiagnosticsStackTrace',
          ],
          _kAccentBlue,
        ),
        _chipGroup(
          'static callbacks',
          const <String>[
            'FlutterError.onError',
            'FlutterError.presentError',
            'FlutterError.demangleStackTrace',
            'ErrorWidget.builder',
          ],
          _kAccentTeal,
        ),
        _chipGroup(
          'static methods',
          const <String>[
            'FlutterError.reportError',
            'FlutterError.dumpErrorToConsole',
            'FlutterError.defaultStackFilter',
            'FlutterError.resetErrorCount',
            'FlutterError.fromParts',
          ],
          _kAccentAmber,
        ),
        _chipGroup(
          'FlutterErrorDetails fields',
          const <String>[
            'exception',
            'stack',
            'library',
            'context',
            'informationCollector',
            'silent',
            'errorWidget',
            'stackFilter',
          ],
          _kAccentViolet,
        ),
        _chipGroup(
          'related',
          const <String>[
            'AssertionError',
            'PlatformException',
            'runZonedGuarded',
            'WidgetsBinding',
            'BindingBase',
          ],
          _kAccentRose,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('FlutterError deep visual demo: building widget tree');

  // We DO NOT throw a FlutterError here. The whole script must complete
  // successfully. Instead we construct a *value-only* FlutterErrorDetails
  // and read its fields for the anatomy section. This is safe: no callback
  // chain is invoked because we never call FlutterError.reportError.
  final FlutterErrorDetails mock = FlutterErrorDetails(
    exception: 'mock-exception (string used to avoid an actual throw)',
    library: 'error_test demo',
    context: ErrorDescription('during build() (mocked)'),
    silent: true,
  );
  print('mock.exception=${mock.exception}');
  print('mock.library=${mock.library}');
  print('mock.silent=${mock.silent}');
  print('mock.context=${mock.context}');
  print('kDebugMode=$kDebugMode');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Section 1
          _heroBanner(),
          _sectionHeader(1, 'Why FlutterError exists',
              'Typed errors, typed bundles, a callback chain you can hook.'),
          _heroIntroCard(),
          _sectionDivider(),

          // Section 2
          _sectionHeader(2, 'FlutterErrorDetails anatomy',
              'Every field of the bundle that reportError accepts.'),
          _detailsAnatomyCard(),
          _detailsMockInstance(),
          _sectionDivider(),

          // Section 3
          _sectionHeader(3, 'ErrorWidget.builder gallery',
              'Default red screen, default grey box, and three custom UIs.'),
          _errorWidgetGallery(),
          _sectionDivider(),

          // Section 4
          _sectionHeader(4, 'DiagnosticsNode hierarchy',
              'How a FlutterError decomposes into a tree of nodes.'),
          _diagnosticsTreeCard(),
          _diagnosticsLevelTable(),
          _sectionDivider(),

          // Section 5
          _sectionHeader(5, 'presentError vs onError vs reportError',
              'The dispatch chain from callsite to console.'),
          _errorFlowCard(),
          _presentVsReportTable(),
          _sectionDivider(),

          // Section 6
          _sectionHeader(6, 'Summary, Description, Hint - roles',
              'Picking the right DiagnosticsNode subclass for each line.'),
          _rolesCard(),
          _sectionDivider(),

          // Section 7
          _sectionHeader(7, 'Code recipes',
              'Six idiomatic snippets for throwing, wrapping, and hooking.'),
          _recipesCards(),
          _sectionDivider(),

          // Section 8
          _sectionHeader(8, 'Pitfalls',
              'Eight callouts that commonly bite Flutter engineers.'),
          _pitfallsCard(),
          _sectionDivider(),

          // Section 9
          _sectionHeader(9, 'Cheat-sheet',
              'A compact map of the error subsystem.'),
          _cheatSheetFooter(),
        ],
      ),
    ),
  );
}
