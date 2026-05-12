// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the advanced Shortcuts/Actions stack.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a long, static poster that walks through Flutter's
// Shortcuts + Actions infrastructure end-to-end. Ten thematic sections
// cover:
//
//   1. Hero intro - the conceptual model: Activator -> Intent -> Action.
//   2. Key-event flow CustomPainter - how a raw KeyEvent travels from the
//      engine through the focus tree into ShortcutManager, then into the
//      ActionDispatcher of an enclosing Actions widget.
//   3. Activator inventory - LogicalKeySet, SingleActivator, CharacterActivator
//      and the abstract ShortcutActivator contract, with their trigger and
//      modifier matrices laid out as a table.
//   4. Built-in intents matrix - DismissIntent, ActivateIntent, Directional-
//      FocusIntent, ScrollIntent, PrioritizedIntents, plus where Flutter
//      ships default Actions for each of them.
//   5. Worked Actions.invoke<T>() example - a step-by-step animation-free
//      walk through resolving an Intent to a callable Action via the nearest
//      enclosing Actions widget.
//   6. CallbackAction subclass + Action.overridable demo - four annotated
//      code-block cards explaining when to subclass Action directly versus
//      when to use the lightweight CallbackAction shortcut.
//   7. Comparison matrix - Shortcuts vs PlatformMenu vs FocusableAction-
//      Detector, axes such as "owns focus", "Intent-aware", "menu surface".
//   8. Intent dispatch table - conceptual snapshot of an Actions widget.
//   9. Pitfalls panel - six common traps: missing Actions ancestor, wrong
//      Intent type, modifier ordering, override scoping, isEnabled defaults,
//      and CharacterActivator vs SingleActivator for typed text.
//  10. Cheat-sheet footer - chip groups for the Shortcuts/Actions surface.
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no
// `AnimationController`, no live key events. We never call
// `Actions.invoke()` at build time because `build` runs exactly once on a
// non-driver interpreter; the widget tree is rendered statically.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// Theme-independent literal palette. The mood is "deep violet on porcelain"
// since Shortcuts and Actions live in the cross-platform widgets layer and
// we want to differentiate this gallery from the FocusNode poster.
const Color _kCanvas = Color(0xFFF3F4FB);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF8F9FC);
const Color _kCardDark = Color(0xFF161826);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineStrong = Color(0x33000000);
const Color _kInk = Color(0xFF14172A);
const Color _kInkSecondary = Color(0xFF3F4258);
const Color _kInkTertiary = Color(0xFF8A8DA1);
const Color _kInkOnDark = Color(0xFFEDEEF5);
const Color _kInkOnDarkSecondary = Color(0xFFA0A3B8);
const Color _kAccent = Color(0xFF6D28D9); // violet
const Color _kAccentSoft = Color(0xFFF3EBFF);
const Color _kAccentBlue = Color(0xFF1D4ED8);
const Color _kAccentTeal = Color(0xFF0D9488);
const Color _kAccentGreen = Color(0xFF15803D);
const Color _kAccentAmber = Color(0xFFB45309);
const Color _kAccentRose = Color(0xFFBE123C);
const Color _kAccentSlate = Color(0xFF334155);
const Color _kKeyCapBg = Color(0xFFF5F6FB);
const Color _kKeyCapBorder = Color(0xFFCBD0E0);
const Color _kKeyCapInk = Color(0xFF1F2233);
const Color _kCodeBg = Color(0xFF1B1D2A);
const Color _kCodeText = Color(0xFFE6E6F0);
const Color _kCodeAccent = Color(0xFF93C5FD);
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
// Top-level private helpers so the file can be read sequentially. None of
// them are widgets that need build-time state.

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

Widget _badge(String label, Color colour) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: colour,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget _keyCap(String label) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    constraints: const BoxConstraints(minWidth: 26.0),
    decoration: BoxDecoration(
      color: _kKeyCapBg,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: _kKeyCapBorder),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 0.0,
        ),
      ],
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 11.5,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w700,
        color: _kKeyCapInk,
      ),
    ),
  );
}

Widget _keyChord(List<String> keys) {
  final List<Widget> children = <Widget>[];
  for (int i = 0; i < keys.length; i++) {
    children.add(_keyCap(keys[i]));
    if (i != keys.length - 1) {
      children.add(const Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 13.0,
            color: _kInkTertiary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ));
    }
  }
  return Row(mainAxisSize: MainAxisSize.min, children: children);
}

Widget _codeBlock(String code, {String? title}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFF2A2D3C)),
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

Widget _bulletList(List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: items
        .map<Widget>((String s) => Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 6.0, right: 8.0),
                    width: 6.0,
                    height: 6.0,
                    decoration: const BoxDecoration(
                      color: _kAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(child: Text(s, style: _kBodySoftStyle)),
                ],
              ),
            ))
        .toList(growable: false),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 - HERO BANNER
// ---------------------------------------------------------------------------
Widget _heroBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF2E1065), Color(0xFF6D28D9), Color(0xFFA855F7)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x402E1065),
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
                'package:flutter/widgets.dart',
                style: TextStyle(
                  color: Color(0xFFEDEEF5),
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
                'shortcuts.dart / actions.dart',
                style: TextStyle(
                  color: Color(0xFFEDEEF5),
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
          'Shortcuts & Actions',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'Activators map key chords to Intents. Intents are dispatched to '
          'Actions by the nearest Actions widget. Overridable actions chain '
          'across the focus tree.',
          style: TextStyle(
            color: Color(0xFFE0E1F4),
            fontSize: 14.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          children: <Widget>[
            _pill('Shortcuts', colour: const Color(0xFFFDE68A)),
            _pill('Actions', colour: const Color(0xFFA7F3D0)),
            _pill('Intent', colour: const Color(0xFF93C5FD)),
            _pill('ActionDispatcher', colour: const Color(0xFFFBCFE8)),
            _pill('FocusableActionDetector', colour: const Color(0xFFFCA5A5)),
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
          'The activator -> intent -> action pipeline',
          subtitle:
              'Three independent abstractions composed in one direction. '
              'Each layer knows nothing about the next; the Actions widget '
              'glues them at runtime via Intent types.',
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
            'Mental model: Shortcuts is a key-to-Intent translator. Actions '
            'is an Intent-to-Action dispatcher. Both walk the focus tree to '
            'find a handler. Either layer can be overridden at any depth '
            'without touching the other.',
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
            Expanded(
                child: _bulletList(const <String>[
              'ShortcutActivator: trigger predicate over RawKeyEvent.',
              'Shortcuts widget: holds a Map<ShortcutActivator, Intent>.',
              'ShortcutManager: pluggable handler chain for that map.',
              'Intent: marker type the dispatcher keys off.',
            ])),
            const SizedBox(width: 12.0),
            Expanded(
                child: _bulletList(const <String>[
              'Action<T extends Intent>: handler bound to one Intent type.',
              'Actions widget: holds a Map<Type, Action<Intent>>.',
              'ActionDispatcher: orchestrates invokeAction on an Action.',
              'Action.overridable: stacks an action over an ancestor one.',
            ])),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - KEY-EVENT FLOW CUSTOMPAINTER
// ---------------------------------------------------------------------------
class _KeyFlowPainter extends CustomPainter {
  const _KeyFlowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint pageBg = Paint()..color = const Color(0xFFF8F9FC);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(12.0),
      ),
      pageBg,
    );

    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFCBD0E0);
    final Paint flowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..color = _kAccent;

    final List<_FlowBox> stations = <_FlowBox>[
      _FlowBox('Platform engine\nKeyEvent',
          const Rect.fromLTWH(20, 30, 170, 56), const Color(0xFFDDD6FE)),
      _FlowBox('HardwareKeyboard\n.instance',
          const Rect.fromLTWH(220, 30, 170, 56), const Color(0xFFDDD6FE)),
      _FlowBox('FocusManager\n.primaryFocus',
          const Rect.fromLTWH(420, 30, 170, 56), const Color(0xFFBFDBFE)),
      _FlowBox('Focus.onKeyEvent\n(walks up scope)',
          const Rect.fromLTWH(420, 110, 170, 56), const Color(0xFFBFDBFE)),
      _FlowBox('ShortcutManager\n.handleKeypress',
          const Rect.fromLTWH(420, 190, 170, 56), const Color(0xFFFDE68A)),
      _FlowBox('Lookup\nMap<Activator,Intent>',
          const Rect.fromLTWH(220, 190, 170, 56), const Color(0xFFFDE68A)),
      _FlowBox('Actions.invoke<I>\n(BuildContext, Intent)',
          const Rect.fromLTWH(20, 190, 170, 56), const Color(0xFFA7F3D0)),
      _FlowBox('ActionDispatcher\n.invokeAction',
          const Rect.fromLTWH(20, 270, 170, 56), const Color(0xFFA7F3D0)),
      _FlowBox('Action<I>\n.invoke(intent)',
          const Rect.fromLTWH(220, 270, 170, 56), const Color(0xFFFCA5A5)),
      _FlowBox('Action.overridable?\nchain to ancestor',
          const Rect.fromLTWH(420, 270, 170, 56), const Color(0xFFFCA5A5)),
    ];

    for (final _FlowBox b in stations) {
      final RRect rrect = RRect.fromRectAndRadius(
        b.rect,
        const Radius.circular(8.0),
      );
      canvas.drawRRect(rrect, Paint()..color = b.fill);
      canvas.drawRRect(rrect, borderPaint);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: b.label,
          style: const TextStyle(
            color: _kInk,
            fontSize: 11.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: b.rect.width - 8.0);
      tp.paint(
        canvas,
        Offset(
          b.rect.left + (b.rect.width - tp.width) / 2,
          b.rect.top + (b.rect.height - tp.height) / 2,
        ),
      );
    }

    void arrow(Offset a, Offset b) {
      canvas.drawLine(a, b, flowPaint);
      final double angle = math.atan2(b.dy - a.dy, b.dx - a.dx);
      const double tipLen = 8.0;
      final Path path = Path()
        ..moveTo(b.dx, b.dy)
        ..lineTo(b.dx - tipLen * math.cos(angle - math.pi / 7),
            b.dy - tipLen * math.sin(angle - math.pi / 7))
        ..lineTo(b.dx - tipLen * math.cos(angle + math.pi / 7),
            b.dy - tipLen * math.sin(angle + math.pi / 7))
        ..close();
      canvas.drawPath(path, Paint()..color = _kAccent);
    }

    // Top row left->right
    arrow(const Offset(190, 58), const Offset(220, 58));
    arrow(const Offset(390, 58), const Offset(420, 58));
    // top to middle row
    arrow(const Offset(505, 86), const Offset(505, 110));
    arrow(const Offset(505, 166), const Offset(505, 190));
    // middle row right->left
    arrow(const Offset(420, 218), const Offset(390, 218));
    arrow(const Offset(220, 218), const Offset(190, 218));
    // middle row to bottom row
    arrow(const Offset(105, 246), const Offset(105, 270));
    // bottom row left->right
    arrow(const Offset(190, 298), const Offset(220, 298));
    arrow(const Offset(390, 298), const Offset(420, 298));

    // legend strip at bottom
    final TextPainter legend = TextPainter(
      text: const TextSpan(
        text: 'flow direction: platform -> focus -> shortcuts -> actions -> '
            'dispatcher -> action invoke',
        style: TextStyle(
          color: _kInkTertiary,
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    legend.paint(canvas, const Offset(20, 340));
  }

  @override
  bool shouldRepaint(_KeyFlowPainter oldDelegate) => false;
}

class _FlowBox {
  const _FlowBox(this.label, this.rect, this.fill);
  final String label;
  final Rect rect;
  final Color fill;
}

Widget _keyFlowSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Key-event flow: platform -> focus -> shortcuts -> actions',
          subtitle: 'Each station hands the event to the next, and any '
              'station can short-circuit by returning KeyEventResult.handled.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 360.0,
          child: CustomPaint(
            painter: const _KeyFlowPainter(),
            size: const Size(double.infinity, 360.0),
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'A KeyEvent is delivered to the primary FocusNode first. As the '
            'focus walk climbs the FocusScope chain it gives each enclosing '
            'Shortcuts widget a chance to match the chord. The first match '
            'translates it to an Intent and hands it to the nearest Actions '
            'widget for dispatch.',
            style: _kBodySoftStyle,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - ACTIVATOR INVENTORY
// ---------------------------------------------------------------------------
Widget _activatorRow(
  String name,
  String trigger,
  String semantics,
  String example, {
  Color colour = _kAccent,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _kHairline)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170.0,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 13.0,
              fontFamily: 'monospace',
              color: colour,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 170.0,
          child: Text(
            trigger,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(semantics, style: _kBodySoftStyle),
              const SizedBox(height: 4.0),
              Text(
                example,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: _kInkTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _activatorInventorySection() {
  // Static, build-time-safe activator construction. These instances are not
  // attached to a Shortcuts widget; we just read their toString().
  const SingleActivator ctrlS = SingleActivator(
    LogicalKeyboardKey.keyS,
    control: true,
  );
  const CharacterActivator slash = CharacterActivator('/');
  final LogicalKeySet ctrlF = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.keyF,
  );

  final String ctrlSToString = ctrlS.toString();
  final String slashToString = slash.toString();
  final String ctrlFToString = ctrlF.toString();

  return _card(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 10.0),
          child: _cardTitle(
            'ShortcutActivator family',
            subtitle: 'Four concrete activators ship with Flutter. They all '
                'implement the same one-method ShortcutActivator interface.',
          ),
        ),
        Container(height: 1.0, color: _kHairline),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          color: _kCardSoft,
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 170.0,
                child: Text(
                  'Activator',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: _kInkSecondary,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              SizedBox(
                width: 170.0,
                child: Text(
                  'Trigger surface',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: _kInkSecondary,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Semantics & example',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: _kInkSecondary,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        _activatorRow(
          'ShortcutActivator',
          'abstract',
          'The base contract: bool accepts(RawKeyEvent, HardwareKeyboard) '
              'plus triggers (a set of LogicalKeyboardKey).',
          'Any custom subclass must implement accepts().',
        ),
        _activatorRow(
          'SingleActivator',
          'single trigger + mods',
          'A trigger key plus required modifier flags (ctrl/shift/alt/meta). '
              'Modifiers must be pressed before the trigger key.',
          'SingleActivator(LogicalKeyboardKey.keyS, control: true)',
          colour: _kAccentBlue,
        ),
        _activatorRow(
          'LogicalKeySet',
          'unordered key set',
          'Matches any KeyDown whose pressed-keys equal this set exactly. '
              'Order-independent, but more permissive than SingleActivator.',
          'LogicalKeySet(LogicalKeyboardKey.control, ...keyF)',
          colour: _kAccentBlue,
        ),
        _activatorRow(
          'CharacterActivator',
          'character produced',
          'Matches based on the typed character, not the physical key. '
              'Layout-independent. Required for "?" on a US keyboard.',
          'CharacterActivator("/")',
          colour: _kAccentTeal,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 14.0, 18.0, 4.0),
          child: Text(
            'Live toString() readouts (build-time constants):',
            style: _kCaptionStyle.copyWith(color: _kInkSecondary),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 4.0, 18.0, 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(ctrlSToString, style: _kMonoInlineStyle),
              const SizedBox(height: 4.0),
              Text(slashToString, style: _kMonoInlineStyle),
              const SizedBox(height: 4.0),
              Text(ctrlFToString, style: _kMonoInlineStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _activatorChordsPanel() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Reading common chords',
          subtitle: 'The same gesture expressed with each activator class.',
        ),
        const SizedBox(height: 14.0),
        _chordRow(
          'Save',
          <String>['Ctrl', 'S'],
          'SingleActivator(LogicalKeyboardKey.keyS, control: true)',
          'Preferred. Forces modifier ordering.',
        ),
        _chordRow(
          'Find',
          <String>['Ctrl', 'F'],
          'LogicalKeySet(control, keyF)',
          'Acceptable. Modifier-ordering agnostic.',
        ),
        _chordRow(
          'Help',
          <String>['?'],
          "CharacterActivator('?')",
          'Required for typed glyphs that depend on shift+keyboard layout.',
        ),
        _chordRow(
          'Command Palette',
          <String>['Ctrl', 'Shift', 'P'],
          'SingleActivator(LogicalKeyboardKey.keyP, control: true, shift: true)',
          'Add modifiers as named parameters.',
        ),
        _chordRow(
          'Escape',
          <String>['Esc'],
          'SingleActivator(LogicalKeyboardKey.escape)',
          'Often paired with DismissIntent.',
        ),
      ],
    ),
  );
}

Widget _chordRow(
  String label,
  List<String> keys,
  String code,
  String note,
) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _kHairline)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130.0,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: _kInk,
            ),
          ),
        ),
        SizedBox(width: 170.0, child: _keyChord(keys)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(code, style: _kMonoInlineStyle),
              const SizedBox(height: 2.0),
              Text(note, style: _kBodySoftStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - BUILT-IN INTENTS MATRIX
// ---------------------------------------------------------------------------
Widget _intentRow(
  String intentName,
  String defaultAction,
  String semantics,
  String firedBy, {
  Color colour = _kAccent,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _kHairline)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 190.0,
          child: Text(
            intentName,
            style: TextStyle(
              fontSize: 13.0,
              fontFamily: 'monospace',
              color: colour,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(
          width: 190.0,
          child: Text(
            defaultAction,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(semantics, style: _kBodySoftStyle),
              const SizedBox(height: 4.0),
              Text(
                'fired by: $firedBy',
                style: const TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: _kInkTertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _intentsMatrixSection() {
  return _card(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 10.0),
          child: _cardTitle(
            'Built-in Intents and their default Actions',
            subtitle: 'WidgetsApp installs a default Actions ancestor that '
                'binds these Intents to safe, no-op-friendly defaults.',
          ),
        ),
        Container(height: 1.0, color: _kHairline),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          color: _kCardSoft,
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 190.0,
                child: Text(
                  'Intent',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: _kInkSecondary,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              SizedBox(
                width: 190.0,
                child: Text(
                  'Default Action',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: _kInkSecondary,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Semantics & trigger',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: _kInkSecondary,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        _intentRow(
          'ActivateIntent',
          'ActivateAction',
          'Activate the currently focused widget. Button-like widgets '
              'subscribe a CallbackAction<ActivateIntent>.',
          'Enter, Space, gamepad A',
        ),
        _intentRow(
          'DismissIntent',
          'DismissAction',
          'Pop a modal, close a dropdown, or escape an editing mode. The '
              'default implementation calls Navigator.maybePop().',
          'Escape',
          colour: _kAccentBlue,
        ),
        _intentRow(
          'DirectionalFocusIntent',
          'DirectionalFocusAction',
          'Move focus in a TraversalDirection (up/down/left/right). Reads '
              'the FocusTraversalPolicy of the enclosing group.',
          'Arrow keys',
          colour: _kAccentBlue,
        ),
        _intentRow(
          'NextFocusIntent',
          'NextFocusAction',
          'Move focus to the next traversal node. Skips nodes with '
              'skipTraversal=true.',
          'Tab',
          colour: _kAccentBlue,
        ),
        _intentRow(
          'PreviousFocusIntent',
          'PreviousFocusAction',
          'Move focus to the previous traversal node.',
          'Shift+Tab',
          colour: _kAccentBlue,
        ),
        _intentRow(
          'ScrollIntent',
          'ScrollAction',
          'Scroll the nearest Scrollable by a unit (line/page) in a '
              'direction. Reads ScrollableState if found.',
          'Arrow keys (on focused Scrollable), PageUp/PageDown',
          colour: _kAccentTeal,
        ),
        _intentRow(
          'PrioritizedIntents',
          '(meta intent)',
          'Wraps an ordered list of candidate Intents. The dispatcher tries '
              'each in turn; the first whose Action.isEnabled returns true '
              'is invoked.',
          'Composite chords with fallbacks',
          colour: _kAccentRose,
        ),
        _intentRow(
          'VoidCallbackIntent',
          'CallbackAction wrapper',
          'A trivial Intent that carries a VoidCallback. Useful for inline '
              'shortcuts that do not warrant a custom Intent type.',
          'Any activator',
          colour: _kAccentAmber,
        ),
        const SizedBox(height: 12.0),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - WORKED ACTIONS.INVOKE EXAMPLE
// ---------------------------------------------------------------------------
Widget _step(
  int n,
  String title,
  String detail, {
  Color colour = _kAccent,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 26.0,
          height: 26.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            '$n',
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w700,
              fontSize: 13.0,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(detail, style: _kBodySoftStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _workedInvokeSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Worked example: Actions.invoke<SaveIntent>(context, intent)',
          subtitle: 'Step-by-step path the framework takes from the call '
              'site to a concrete Action.invoke().',
        ),
        const SizedBox(height: 14.0),
        _step(
            1,
            'Caller builds an Intent instance',
            'final SaveIntent intent = const SaveIntent(); '
                'Intents are typically const-constructed value objects.'),
        _step(
            2,
            'Actions.invoke walks ancestors',
            'Starting from context, the helper finds the first _ActionsScope '
                'whose actions map contains the intent\'s runtimeType.',
            colour: _kAccentBlue),
        _step(
            3,
            'Action is resolved',
            'The map lookup returns an Action<SaveIntent>. If that action is '
                'Action.overridable, the wrapper finds the next ancestor '
                'override and links it as defaultAction.',
            colour: _kAccentBlue),
        _step(
            4,
            'Action.isEnabled is consulted',
            'isEnabled(intent) returns false to opt out. Disabled actions are '
                'invisible to PrioritizedIntents fallback chains.',
            colour: _kAccentTeal),
        _step(
            5,
            'ActionDispatcher.invokeAction runs',
            'The Actions widget\'s ActionDispatcher (or the default one) '
                'calls Action.invoke(intent). It is allowed to be a normal '
                'method call - no future is required.',
            colour: _kAccentTeal),
        _step(
            6,
            'Result is returned to the caller',
            'invoke() returns Object?. Actions.invoke<I> returns Object? '
                'too. Most callers ignore it; some use it to read computed '
                'state back.',
            colour: _kAccentAmber),
        const SizedBox(height: 4.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: const Text(
            'Notice that step 5 says nothing about keys. Actions.invoke is the '
            'imperative API. Shortcuts.maybeOf() lets you invoke programmatically '
            'without simulating a KeyEvent. This is the seam used by menu items, '
            'context menus and tests.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.5,
              color: _kInk,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - CODE SNIPPET CARDS (CallbackAction, Action.overridable)
// ---------------------------------------------------------------------------
const String _callbackActionCode = '''
// Define a no-state Intent.
class SaveIntent extends Intent {
  const SaveIntent();
}

Widget build(BuildContext context) {
  return Shortcuts(
    shortcuts: const <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.keyS, control: true): SaveIntent(),
    },
    child: Actions(
      actions: <Type, Action<Intent>>{
        SaveIntent: CallbackAction<SaveIntent>(
          onInvoke: (SaveIntent intent) {
            // Side-effect call site. Returns Object? from invoke().
            print('Saving document...');
            return null;
          },
        ),
      },
      child: Focus(
        autofocus: true,
        child: const Center(child: Text('Press Ctrl+S')),
      ),
    ),
  );
}
''';

const String _customActionCode = '''
// Subclassing Action<T> when you need state, lifecycle, or
// isEnabled gating. CallbackAction cannot express any of those.
class SaveAction extends Action<SaveIntent> {
  SaveAction(this.controller);
  final DocumentController controller;

  @override
  bool isEnabled(SaveIntent intent) => controller.isDirty;

  @override
  Object? invoke(SaveIntent intent) {
    controller.persist();
    return null;
  }

  @override
  bool consumesKey(SaveIntent intent) => true;
}
''';

const String _overridableCode = '''
// Action.overridable lets a child install a richer action while
// preserving the ancestor as a fallback. The ancestor is invoked
// when the child action declares isEnabled == false for the intent
// or explicitly forwards via invokeAsOverride().
Widget build(BuildContext context) {
  return Actions(
    actions: <Type, Action<Intent>>{
      // Ancestor handles the generic case.
      DismissIntent: const _GenericDismissAction(),
    },
    child: Actions(
      actions: <Type, Action<Intent>>{
        // Child overrides only when a popup is open.
        DismissIntent: Action<DismissIntent>.overridable(
          defaultAction: const _PopupDismissAction(),
          context: context,
        ),
      },
      child: const _PopupScaffold(),
    ),
  );
}
''';

const String _focusableActionDetectorCode = '''
// FocusableActionDetector composes Focus + Shortcuts + Actions
// + MouseRegion in one widget. Use it when a custom widget wants
// keyboard activation without re-implementing the boilerplate.
FocusableActionDetector(
  shortcuts: const <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
    SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
  },
  actions: <Type, Action<Intent>>{
    ActivateIntent: CallbackAction<ActivateIntent>(
      onInvoke: (ActivateIntent _) {
        onPressed();
        return null;
      },
    ),
  },
  mouseCursor: SystemMouseCursors.click,
  child: const Padding(
    padding: EdgeInsets.all(8),
    child: Text('Custom button'),
  ),
)
''';

Widget _codeSnippetsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _card(
        child: _cardTitle(
          'Defining and binding an Action',
          subtitle:
              'Four progressively richer code-block cards. Read them in order '
              'to see how the surface area scales with the use case.',
        ),
      ),
      _codeBlock(_callbackActionCode,
          title: 'shortcuts_and_actions.dart - CallbackAction (simplest)'),
      _codeBlock(_customActionCode,
          title: 'save_action.dart - subclassing Action<T>'),
      _codeBlock(_overridableCode,
          title: 'overridable.dart - Action.overridable(defaultAction:)'),
      _codeBlock(_focusableActionDetectorCode,
          title: 'custom_button.dart - FocusableActionDetector'),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - COMPARISON MATRIX
// ---------------------------------------------------------------------------
Widget _comparisonHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    color: _kCardSoft,
    child: Row(
      children: const <Widget>[
        SizedBox(
          width: 220.0,
          child: Text(
            'Axis',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: _kInkSecondary,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Shortcuts',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: _kInkSecondary,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'FocusableActionDetector',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: _kInkSecondary,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'PlatformMenu',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: _kInkSecondary,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonCell(String text, {Color colour = _kInk, bool bold = false}) {
  return Padding(
    padding: const EdgeInsets.only(right: 6.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.5,
        fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        color: colour,
      ),
    ),
  );
}

Widget _comparisonRow(
  String axis,
  Widget shortcuts,
  Widget fad,
  Widget menu,
) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: _kHairline)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 220.0,
          child: Text(
            axis,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: _kInk,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(child: shortcuts),
        Expanded(child: fad),
        Expanded(child: menu),
      ],
    ),
  );
}

Widget _comparisonMatrixSection() {
  return _card(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 10.0),
          child: _cardTitle(
            'Shortcuts vs FocusableActionDetector vs PlatformMenu',
            subtitle:
                'Three widgets that all participate in key-driven activation, '
                'each with a different responsibility surface.',
          ),
        ),
        Container(height: 1.0, color: _kHairline),
        _comparisonHeaderRow(),
        _comparisonRow(
          'Owns focus',
          _comparisonCell('No - relies on enclosing Focus.', colour: _kAccentRose),
          _comparisonCell('Yes - wraps a Focus internally.',
              colour: _kAccentGreen),
          _comparisonCell('Indirect - menu bar focus.', colour: _kAccentAmber),
        ),
        _comparisonRow(
          'Holds Intent map',
          _comparisonCell('Yes - shortcuts: Map<Activator,Intent>.',
              colour: _kAccentGreen),
          _comparisonCell('Yes - same map type.', colour: _kAccentGreen),
          _comparisonCell('No - each item has its own callback.',
              colour: _kAccentRose),
        ),
        _comparisonRow(
          'Holds Action map',
          _comparisonCell('No - delegates to ancestor Actions.',
              colour: _kAccentRose),
          _comparisonCell('Yes - actions: Map<Type, Action<Intent>>.',
              colour: _kAccentGreen),
          _comparisonCell('Implicit - the onSelected callback.',
              colour: _kAccentAmber),
        ),
        _comparisonRow(
          'Surfaces in OS menu bar',
          _comparisonCell('No.', colour: _kAccentRose),
          _comparisonCell('No.', colour: _kAccentRose),
          _comparisonCell('Yes - via channel on macOS/iOS/Linux.',
              colour: _kAccentGreen),
        ),
        _comparisonRow(
          'Mouse cursor handling',
          _comparisonCell('No.', colour: _kAccentRose),
          _comparisonCell('Yes - mouseCursor parameter.',
              colour: _kAccentGreen),
          _comparisonCell('Driven by host platform.', colour: _kAccentAmber),
        ),
        _comparisonRow(
          'Tracks hover/focus states',
          _comparisonCell('No.', colour: _kAccentRose),
          _comparisonCell('Yes - onShowFocusHighlight, onShowHoverHighlight.',
              colour: _kAccentGreen),
          _comparisonCell('Platform-defined.', colour: _kAccentAmber),
        ),
        _comparisonRow(
          'Cost when child changes',
          _comparisonCell('Cheap - InheritedWidget read.',
              colour: _kAccentGreen),
          _comparisonCell('Moderate - Focus + MouseRegion + Inherited.',
              colour: _kAccentAmber),
          _comparisonCell('IPC + platform-side rebuild.', colour: _kAccentRose),
        ),
        _comparisonRow(
          'Best for',
          _comparisonCell('App-wide key bindings near root.', bold: true),
          _comparisonCell('Custom buttons / list items.', bold: true),
          _comparisonCell('Native menu bar items.', bold: true),
        ),
        const SizedBox(height: 12.0),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - DISPATCH TABLE (Intent -> Action lookup)
// ---------------------------------------------------------------------------
Widget _dispatchRow(
  String typeKey,
  String action,
  String enabled, {
  bool isHeader = false,
}) {
  final TextStyle keyStyle = isHeader
      ? const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: _kInkSecondary,
          fontFamily: 'monospace',
          letterSpacing: 0.4,
        )
      : const TextStyle(
          fontSize: 12.5,
          fontFamily: 'monospace',
          color: _kAccent,
          fontWeight: FontWeight.w700,
        );
  final TextStyle valueStyle = isHeader
      ? const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: _kInkSecondary,
          fontFamily: 'monospace',
          letterSpacing: 0.4,
        )
      : const TextStyle(
          fontSize: 12.5,
          fontFamily: 'monospace',
          color: _kInk,
        );
  final TextStyle infoStyle = isHeader
      ? const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: _kInkSecondary,
          letterSpacing: 0.4,
        )
      : const TextStyle(
          fontSize: 12.5,
          color: _kInkSecondary,
        );
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
    color: isHeader ? _kCardSoft : null,
    decoration: isHeader
        ? null
        : const BoxDecoration(
            border: Border(bottom: BorderSide(color: _kHairline)),
          ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 200.0, child: Text(typeKey, style: keyStyle)),
        SizedBox(width: 220.0, child: Text(action, style: valueStyle)),
        Expanded(child: Text(enabled, style: infoStyle)),
      ],
    ),
  );
}

Widget _dispatchTableSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Intent dispatch table (live snapshot)',
          subtitle: 'Conceptual map of the Actions widget at the WidgetsApp '
              'level. Read top-down to see which Intent runtimeType is '
              'served by which Action.',
        ),
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            children: <Widget>[
              _dispatchRow('Type key', 'Action<Intent>', 'isEnabled default',
                  isHeader: true),
              _dispatchRow('ActivateIntent', 'ActivateAction',
                  'true if focused widget accepts activation'),
              _dispatchRow('DismissIntent', 'DismissAction',
                  'Navigator.canPop(context)'),
              _dispatchRow(
                  'NextFocusIntent', 'NextFocusAction', 'always true'),
              _dispatchRow('PreviousFocusIntent', 'PreviousFocusAction',
                  'always true'),
              _dispatchRow('DirectionalFocusIntent', 'DirectionalFocusAction',
                  'true if a sibling node exists in that direction'),
              _dispatchRow('ScrollIntent', 'ScrollAction',
                  'true if a Scrollable is in scope'),
              _dispatchRow('PrioritizedIntents', '(meta-dispatcher)',
                  'OR over child intents'),
              _dispatchRow('SaveIntent', 'CallbackAction<SaveIntent>',
                  'user-defined, e.g. controller.isDirty'),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.25)),
          ),
          child: const Text(
            'Note: the dispatch table is *local* to each Actions widget. '
            'Lookups proceed leaf-to-root and the first match wins. '
            'Action.overridable lets a leaf wrap the ancestor entry instead '
            'of fully replacing it.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.5,
              color: _kInk,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - PITFALLS PANEL
// ---------------------------------------------------------------------------
Widget _pitfallCard(
  String title,
  String body,
  String fix, {
  Color colour = _kAccentRose,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: colour.withOpacity(0.35)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x0D000000),
          offset: Offset(0.0, 1.0),
          blurRadius: 3.0,
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 30.0,
          height: 30.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colour,
            shape: BoxShape.circle,
          ),
          child: const Text(
            '!',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: _kInk,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  _badge('pitfall', colour),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(body, style: _kBodyStyle),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: _kCardSoft,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: _kHairline),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'fix: ',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _kAccentGreen,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Expanded(child: Text(fix, style: _kBodySoftStyle)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallsSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _pitfallCard(
        'No enclosing Actions widget',
        'Shortcuts produces an Intent but the lookup fails silently. The '
            'KeyEvent is treated as ignored and bubbles up the focus tree. '
            'Nothing visible happens.',
        'Either add an Actions ancestor binding the Intent type, or rely on '
            'WidgetsApp\'s default Actions for the built-in intents.',
      ),
      _pitfallCard(
        'Intent map keys must be the Type, not an instance',
        'A common typo is actions: <Intent, Action<Intent>>{ const SaveIntent(): ... }. '
            'This compiles but never matches because the lookup uses '
            'intent.runtimeType, not an equality test.',
        'Use Type as the map key: <Type, Action<Intent>>{ SaveIntent: ... }.',
        colour: _kAccentAmber,
      ),
      _pitfallCard(
        'SingleActivator vs LogicalKeySet modifier ordering',
        'LogicalKeySet matches any time the same key set is pressed, '
            'regardless of order. SingleActivator demands modifiers be '
            'pressed before the trigger. Picking the wrong one breaks the '
            'shortcut on certain layouts.',
        'Default to SingleActivator. Use LogicalKeySet only when you '
            'deliberately want modifier-order-agnostic matching.',
        colour: _kAccentBlue,
      ),
      _pitfallCard(
        'CharacterActivator on physical-key intents',
        'Binding "/" with SingleActivator(LogicalKeyboardKey.slash) only '
            'works on US-layout keyboards. On a German layout the same '
            'physical position produces "-".',
        'Use CharacterActivator("/") when you mean "the user typed a slash".',
        colour: _kAccentTeal,
      ),
      _pitfallCard(
        'Action.overridable in the wrong scope',
        'A child Actions widget that uses Action.overridable but is *above* '
            'the action it tries to override yields no fallback. The '
            'override resolves to itself.',
        'Place Action.overridable strictly below the fallback Actions '
            'widget in the tree. The lookup walks from leaf to root.',
        colour: _kAccentRose,
      ),
      _pitfallCard(
        'Forgetting isEnabled in PrioritizedIntents',
        'PrioritizedIntents falls through to the next intent only when '
            'isEnabled returns false. CallbackAction defaults to '
            'isEnabled => true, so a chain with two CallbackActions always '
            'fires the first.',
        'Subclass Action<T> and implement isEnabled, or pass an isEnabled '
            'predicate to a custom CallbackAction subclass.',
        colour: _kAccentSlate,
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 - CHEAT-SHEET FOOTER
// ---------------------------------------------------------------------------
Widget _chipGroup(String label, List<String> chips, Color colour) {
  return Container(
    margin: const EdgeInsets.only(right: 12.0, bottom: 10.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0x14FFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairlineStrong),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: colour,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: chips
              .map<Widget>((String s) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: colour.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(999.0),
                      border: Border.all(color: colour.withOpacity(0.4)),
                    ),
                    child: Text(
                      s,
                      style: TextStyle(
                        color: colour,
                        fontSize: 11.5,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ))
              .toList(growable: false),
        ),
      ],
    ),
  );
}

Widget _cheatSheetFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairlineStrong),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cheat-sheet',
          style: TextStyle(
            color: _kInkOnDark,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Quick mental index across the shortcuts/actions stack.',
          style: TextStyle(color: _kInkOnDarkSecondary, fontSize: 13.0),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: <Widget>[
            _chipGroup('Activators', const <String>[
              'ShortcutActivator',
              'SingleActivator',
              'LogicalKeySet',
              'CharacterActivator',
            ], const Color(0xFFC4B5FD)),
            _chipGroup('Widgets', const <String>[
              'Shortcuts',
              'Actions',
              'FocusableActionDetector',
              'CallbackShortcuts',
            ], const Color(0xFFA7F3D0)),
            _chipGroup('Intents', const <String>[
              'ActivateIntent',
              'DismissIntent',
              'DirectionalFocusIntent',
              'ScrollIntent',
              'PrioritizedIntents',
              'VoidCallbackIntent',
            ], const Color(0xFF93C5FD)),
            _chipGroup('Actions', const <String>[
              'Action<T>',
              'CallbackAction<T>',
              'Action.overridable',
              'ActionDispatcher',
              'isEnabled',
              'consumesKey',
            ], const Color(0xFFFDE68A)),
            _chipGroup('Dispatch helpers', const <String>[
              'Actions.invoke',
              'Actions.maybeInvoke',
              'Actions.find',
              'Actions.handler',
            ], const Color(0xFFFBCFE8)),
            _chipGroup('Pitfalls', const <String>[
              'no enclosing Actions',
              'wrong map key',
              'modifier ordering',
              'override scope',
              'isEnabled defaults',
            ], const Color(0xFFFCA5A5)),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Tagline: "Shortcuts and Actions are decoupled on purpose. '
            'Intents are the lingua franca between the keymap layer and the '
            'behaviour layer - design those types first, the rest follows."',
            style: TextStyle(
              color: Color(0xFFEDEEF5),
              fontSize: 13.5,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. All state lives in local
// variables. We never call Actions.invoke() at build time because there is
// no second build pass; the focus tree is not driven; key events are not
// simulated. Everything is rendered statically.
// ===========================================================================
dynamic build(BuildContext context) {
  print('Shortcuts/Actions deep visual demo: building widget tree');

  // Inert build-time constructions to demonstrate type surfaces.
  const SingleActivator demoCtrlS = SingleActivator(
    LogicalKeyboardKey.keyS,
    control: true,
  );
  const CharacterActivator demoSlash = CharacterActivator('/');
  final LogicalKeySet demoSet = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.keyK,
  );
  print('demoCtrlS=$demoCtrlS');
  print('demoSlash=$demoSlash');
  print('demoSet=$demoSet');
  print('kDebugMode=$kDebugMode');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Section 1 - hero
          _heroBanner(),
          _sectionHeader(1, 'Activator -> Intent -> Action',
              'The three decoupled layers of Flutter\'s shortcut system.'),
          _heroIntroCard(),
          _sectionDivider(),

          // Section 2 - key event flow CustomPainter
          _sectionHeader(2, 'Key-event flow',
              'How a KeyEvent walks from the engine to an Action.invoke call.'),
          _keyFlowSection(),
          _sectionDivider(),

          // Section 3 - activator inventory
          _sectionHeader(3, 'ShortcutActivator inventory',
              'Four ways to say "this chord". Pick the right one.'),
          _activatorInventorySection(),
          _activatorChordsPanel(),
          _sectionDivider(),

          // Section 4 - built-in intents matrix
          _sectionHeader(4, 'Built-in Intents',
              'WidgetsApp ships defaults for these. Override per surface.'),
          _intentsMatrixSection(),
          _sectionDivider(),

          // Section 5 - worked Actions.invoke example
          _sectionHeader(5, 'Worked Actions.invoke<T> example',
              'Step-by-step from call site to Action.invoke.'),
          _workedInvokeSection(),
          _sectionDivider(),

          // Section 6 - code snippet cards
          _sectionHeader(6, 'Code snippet cards',
              'CallbackAction, custom subclass, Action.overridable, FAD.'),
          _codeSnippetsSection(),
          _sectionDivider(),

          // Section 7 - comparison matrix
          _sectionHeader(7, 'Comparison matrix',
              'Shortcuts vs FocusableActionDetector vs PlatformMenu.'),
          _comparisonMatrixSection(),
          _sectionDivider(),

          // Section 8 - dispatch table snapshot
          _sectionHeader(8, 'Intent dispatch table',
              'A conceptual snapshot of the root Actions widget.'),
          _dispatchTableSection(),
          _sectionDivider(),

          // Section 9 - pitfalls
          _sectionHeader(9, 'Pitfalls',
              'Six traps that bite when wiring Shortcuts to Actions.'),
          _pitfallsSection(),
          _sectionDivider(),

          // Section 10 - cheat sheet footer
          _sectionHeader(10, 'Cheat-sheet',
              'A compact map of the shortcuts/actions surface.'),
          _cheatSheetFooter(),
        ],
      ),
    ),
  );
}
