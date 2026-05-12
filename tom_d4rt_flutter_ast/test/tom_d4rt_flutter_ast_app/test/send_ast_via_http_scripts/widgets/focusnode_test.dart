// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the Flutter widgets/FocusNode family.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a long, static gallery that walks through Flutter's
// focus subsystem from the framework's perspective. Eleven thematic sections
// cover:
//
//   1. Hero intro - what a FocusNode is, the focus tree, primary focus.
//   2. Class hierarchy CustomPainter - inheritance diagram for the node
//      family (Listenable -> ChangeNotifier -> DiagnosticableTreeMixin ->
//      FocusNode -> FocusScopeNode) plus the widget side.
//   3. Focus tree CustomPainter - a faked Scaffold/Form sample drawn as a
//      node-graph: root FocusScopeNode at the top, then a chain of
//      FocusNodes for the five form fields.
//   4. FocusNode anatomy table - debugLabel, canRequestFocus, skipTraversal,
//      descendantsAreFocusable, onKeyEvent, onKey, hasFocus, hasPrimaryFocus.
//   5. Six static Focus(...) widgets exercising different configuration
//      shapes (autofocus, focusNode, onKeyEvent, onFocusChange, debugLabel,
//      ExcludeFocus).
//   6. FocusTraversalGroup + four traversal policies (WidgetOrder,
//      ReadingOrder, Ordered/NumericFocusOrder, and a custom subclass of
//      DirectionalFocusTraversalPolicyMixin).
//   7. FocusableActionDetector - three cards demonstrating shortcuts/actions
//      pairs plus mouse-cursor handling.
//   8. Six code-block cards - idiomatic recipes for managing FocusNode in a
//      StatefulWidget, FocusScope.of(context).unfocus(), autofocus, request
//      focus chains, KeyEventResult and FocusTraversalGroup wrapping.
//   9. Comparison table - FocusNode vs FocusScopeNode vs FocusableAction-
//      Detector vs Focus widget, with axes such as "owns notifier",
//      "owns subtree", and "appears in widget tree".
//  10. Pitfalls panel - six callouts (dispose leaks, canRequestFocus toggle,
//      hasPrimaryFocus vs hasFocus, dialogs/route focus, autofocus race
//      with first frame, Hero + focus).
//  11. Cheat-sheet footer - chip groups for the FocusNode surface area.
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no
// `AnimationController`, and `requestFocus()` is never called at build time
// because `build` runs exactly once and there is no live FocusManager that
// would safely accept it. FocusNodes are still constructed so that their
// debug fields can be read for the anatomy table.
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
// We pick literal ARGB values so the demo is theme-independent. The palette
// borrows from Material's "indigo on porcelain" mood since the focus system
// is part of the cross-platform widgets layer, not Cupertino specifically.
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
const Color _kAccent = Color(0xFF4F46E5); // indigo
const Color _kAccentSoft = Color(0xFFEEF2FF);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentTeal = Color(0xFF14B8A6);
const Color _kAccentGreen = Color(0xFF22C55E);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentViolet = Color(0xFF8B5CF6);
const Color _kFocusRing = Color(0xFF60A5FA);
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
        colors: <Color>[Color(0xFF312E81), Color(0xFF4F46E5), Color(0xFF7C3AED)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33312E81),
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
                'focus_manager.dart',
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
          'FocusNode Family',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'The focus tree, primary focus, traversal policies, key '
          'dispatching and shortcuts - in one static gallery.',
          style: TextStyle(
            color: Color(0xFFE0E1F4),
            fontSize: 14.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            _pill('FocusNode', colour: const Color(0xFFFDE68A)),
            const SizedBox(width: 8.0),
            _pill('FocusScopeNode', colour: const Color(0xFF93C5FD)),
            const SizedBox(width: 8.0),
            _pill('FocusManager', colour: const Color(0xFFA7F3D0)),
            const SizedBox(width: 8.0),
            _pill('Traversal', colour: const Color(0xFFFBCFE8)),
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
          'What is a FocusNode?',
          subtitle:
              'A FocusNode is a Listenable that participates in Flutter\'s '
              'focus tree. Exactly one node holds the primary focus at any '
              'time; that is the node which receives raw key events.',
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
            'The focus tree is a parallel tree to the widget tree. Its '
            'nodes are FocusNode (leaves you can focus) and FocusScopeNode '
            '(groups that own a "first focus" within them). The tree is '
            'managed by a singleton FocusManager attached to '
            'WidgetsBinding.instance.focusManager.',
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
              'Listenable: addListener fires on hasFocus changes.',
              'attach()/detach() bind the node to an Element.',
              'requestFocus() walks up to nearest enclosing FocusScope.',
              'unfocus() can drop focus or escalate to the scope.',
            ])),
            const SizedBox(width: 12.0),
            Expanded(child: _bulletList(const <String>[
              'FocusScopeNode owns a "focusedChild" list.',
              'FocusTraversalGroup picks the sort order.',
              'FocusableActionDetector binds Shortcuts to Actions.',
              'Focus widget is the inline declarative form.',
            ])),
          ],
        ),
      ],
    ),
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
// SECTION 2 - CLASS HIERARCHY CUSTOMPAINTER
// ---------------------------------------------------------------------------
class _HierarchyPainter extends CustomPainter {
  const _HierarchyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint cardPaint = Paint()..color = const Color(0xFFFFFFFF);
    final Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFFD4D7E2);
    final Paint accent = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = _kAccent;
    final Paint dashed = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = const Color(0xFF94A3B8);

    final List<_HierarchyBox> boxes = <_HierarchyBox>[
      _HierarchyBox('Listenable', const Rect.fromLTWH(20, 12, 150, 36),
          const Color(0xFFE0E7FF)),
      _HierarchyBox('ChangeNotifier', const Rect.fromLTWH(20, 70, 170, 36),
          const Color(0xFFE0E7FF)),
      _HierarchyBox('DiagnosticableTreeMixin',
          const Rect.fromLTWH(20, 128, 220, 36), const Color(0xFFE0E7FF)),
      _HierarchyBox('FocusNode', const Rect.fromLTWH(50, 200, 160, 44),
          const Color(0xFFBFDBFE)),
      _HierarchyBox('FocusScopeNode', const Rect.fromLTWH(260, 200, 190, 44),
          const Color(0xFFFBCFE8)),
      _HierarchyBox('FocusAttachment', const Rect.fromLTWH(490, 200, 180, 44),
          const Color(0xFFFEF3C7)),
      _HierarchyBox('FocusManager', const Rect.fromLTWH(50, 280, 170, 40),
          const Color(0xFFC7D2FE)),
      _HierarchyBox('Focus (widget)', const Rect.fromLTWH(260, 280, 170, 40),
          const Color(0xFFA7F3D0)),
      _HierarchyBox('FocusScope (widget)',
          const Rect.fromLTWH(450, 280, 200, 40), const Color(0xFFA7F3D0)),
      _HierarchyBox('FocusTraversalGroup',
          const Rect.fromLTWH(50, 350, 210, 40), const Color(0xFFFDE68A)),
      _HierarchyBox('FocusTraversalPolicy (abstract)',
          const Rect.fromLTWH(290, 350, 290, 40), const Color(0xFFFDE68A)),
      _HierarchyBox('FocusableActionDetector',
          const Rect.fromLTWH(50, 420, 240, 40), const Color(0xFFFCA5A5)),
      _HierarchyBox('Shortcuts + Actions',
          const Rect.fromLTWH(320, 420, 230, 40), const Color(0xFFFCA5A5)),
    ];

    for (final _HierarchyBox b in boxes) {
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
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
          ),
        ),
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

    // arrows
    void arrow(Offset a, Offset b, {Paint? paint}) {
      final Paint p = paint ?? accent;
      canvas.drawLine(a, b, p);
      final double angle = math.atan2(b.dy - a.dy, b.dx - a.dx);
      const double tipLen = 7.0;
      final Path path = Path()
        ..moveTo(b.dx, b.dy)
        ..lineTo(b.dx - tipLen * math.cos(angle - math.pi / 7),
            b.dy - tipLen * math.sin(angle - math.pi / 7))
        ..lineTo(b.dx - tipLen * math.cos(angle + math.pi / 7),
            b.dy - tipLen * math.sin(angle + math.pi / 7))
        ..close();
      canvas.drawPath(path, Paint()..color = p.color);
    }

    arrow(const Offset(95, 48), const Offset(95, 70));
    arrow(const Offset(105, 106), const Offset(105, 128));
    arrow(const Offset(115, 164), const Offset(115, 200));
    arrow(const Offset(115, 164), const Offset(330, 200));
    arrow(const Offset(115, 164), const Offset(580, 200));

    // composition arrows (dashed look approximated)
    arrow(const Offset(135, 244), const Offset(135, 280), paint: dashed);
    arrow(const Offset(340, 244), const Offset(345, 280), paint: dashed);
    arrow(const Offset(345, 320), const Offset(345, 350), paint: dashed);
    arrow(const Offset(155, 320), const Offset(155, 350), paint: dashed);
    arrow(const Offset(170, 390), const Offset(170, 420), paint: dashed);
    arrow(const Offset(435, 390), const Offset(435, 420), paint: dashed);

    // legend
    final TextPainter legend = TextPainter(
      text: const TextSpan(
        text: '— inheritance         - - composition',
        style: TextStyle(
          color: _kInkTertiary,
          fontSize: 11.0,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    legend.paint(canvas, const Offset(20, 470));
  }

  @override
  bool shouldRepaint(_HierarchyPainter oldDelegate) => false;
}

class _HierarchyBox {
  const _HierarchyBox(this.label, this.rect, this.fill);
  final String label;
  final Rect rect;
  final Color fill;
}

Widget _hierarchySection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Class hierarchy',
          subtitle:
              'FocusNode is a ChangeNotifier. FocusScopeNode extends FocusNode '
              'with a focused-children stack. FocusManager owns the root scope.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 500.0,
          child: CustomPaint(
            painter: const _HierarchyPainter(),
            size: const Size(double.infinity, 500.0),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - FOCUS TREE CUSTOMPAINTER
// ---------------------------------------------------------------------------
class _FocusTreePainter extends CustomPainter {
  const _FocusTreePainter();

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

    final Paint scope = Paint()..color = const Color(0xFFFBCFE8);
    final Paint node = Paint()..color = const Color(0xFFBFDBFE);
    final Paint primary = Paint()..color = const Color(0xFFFDE68A);
    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = const Color(0xFF94A3B8);
    final Paint focusedBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = _kAccent;
    final Paint line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFF94A3B8);

    final List<_TreeBox> tree = <_TreeBox>[
      // root scope
      _TreeBox('FocusScopeNode #root\n(WidgetsApp)',
          const Rect.fromLTWH(180, 16, 220, 50), scope, border),
      // form scope
      _TreeBox('FocusScopeNode #form\n(Form _formScope)',
          const Rect.fromLTWH(180, 96, 220, 50), scope, border),
      // five field nodes
      _TreeBox('FocusNode\n"name"',
          const Rect.fromLTWH(20, 184, 110, 44), node, border),
      _TreeBox('FocusNode\n"email"',
          const Rect.fromLTWH(150, 184, 110, 44), node, border),
      _TreeBox('FocusNode\n"city" (PRIMARY)',
          const Rect.fromLTWH(280, 184, 130, 44), primary, focusedBorder),
      _TreeBox('FocusNode\n"zip"',
          const Rect.fromLTWH(430, 184, 110, 44), node, border),
      _TreeBox('FocusNode\n"submit"',
          const Rect.fromLTWH(560, 184, 110, 44), node, border),
    ];

    for (final _TreeBox b in tree) {
      final RRect rrect = RRect.fromRectAndRadius(
        b.rect,
        const Radius.circular(8.0),
      );
      canvas.drawRRect(rrect, b.fill);
      canvas.drawRRect(rrect, b.border);
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

    // edges
    void edge(Offset a, Offset b) {
      canvas.drawLine(a, b, line);
    }

    // root -> form scope
    edge(const Offset(290, 66), const Offset(290, 96));
    // form scope -> 5 fields
    edge(const Offset(290, 146), const Offset(290, 170));
    edge(const Offset(75, 170), const Offset(615, 170));
    edge(const Offset(75, 170), const Offset(75, 184));
    edge(const Offset(205, 170), const Offset(205, 184));
    edge(const Offset(345, 170), const Offset(345, 184));
    edge(const Offset(485, 170), const Offset(485, 184));
    edge(const Offset(615, 170), const Offset(615, 184));

    // Primary focus ring/badge
    final RRect ring = RRect.fromRectAndRadius(
      const Rect.fromLTWH(276, 180, 138, 52),
      const Radius.circular(10.0),
    );
    canvas.drawRRect(
      ring,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0
        ..color = _kFocusRing.withOpacity(0.6),
    );

    // Legend
    final List<_LegendItem> legendItems = <_LegendItem>[
      _LegendItem('FocusScopeNode', const Color(0xFFFBCFE8)),
      _LegendItem('FocusNode', const Color(0xFFBFDBFE)),
      _LegendItem('hasPrimaryFocus', const Color(0xFFFDE68A)),
    ];

    double lx = 20.0;
    const double ly = 250.0;
    for (final _LegendItem li in legendItems) {
      final RRect chip = RRect.fromRectAndRadius(
        Rect.fromLTWH(lx, ly, 14, 14),
        const Radius.circular(3.0),
      );
      canvas.drawRRect(chip, Paint()..color = li.colour);
      canvas.drawRRect(chip, border);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: li.label,
          style: const TextStyle(
            color: _kInkSecondary,
            fontSize: 11.0,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(lx + 20, ly - 1));
      lx += tp.width + 50;
    }
  }

  @override
  bool shouldRepaint(_FocusTreePainter oldDelegate) => false;
}

class _TreeBox {
  const _TreeBox(this.label, this.rect, this.fill, this.border);
  final String label;
  final Rect rect;
  final Paint fill;
  final Paint border;
}

class _LegendItem {
  const _LegendItem(this.label, this.colour);
  final String label;
  final Color colour;
}

Widget _focusTreeSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Focus tree for a sample Form',
          subtitle:
              'Scaffold -> Form -> 5 TextFormFields. The root scope owns the '
              'form scope, which owns five FocusNodes. One node is primary.',
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 280.0,
          child: CustomPaint(
            painter: const _FocusTreePainter(),
            size: const Size(double.infinity, 280.0),
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
            'Note: only the leaf-most FocusNode whose primaryFocus path '
            'leads back to the root has hasPrimaryFocus == true. All of '
            'its ancestors (including FocusScopeNodes) have hasFocus == true.',
            style: _kBodySoftStyle,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - FOCUSNODE ANATOMY TABLE
// ---------------------------------------------------------------------------
Widget _anatomyRow(
  String name,
  String type,
  String description, {
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
          width: 180.0,
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
          width: 150.0,
          child: Text(
            type,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(description, style: _kBodySoftStyle),
        ),
      ],
    ),
  );
}

Widget _anatomySection() {
  // Construct dummy nodes for diagnostic field readouts. Their values are
  // captured statically for the table - we never call .requestFocus() on them.
  final FocusNode labelled =
      FocusNode(debugLabel: 'Anatomy.example', skipTraversal: false);
  final FocusScopeNode scope = FocusScopeNode(debugLabel: 'Anatomy.scope');
  final String summaryLabelled = 'debugLabel="${labelled.debugLabel}", '
      'skipTraversal=${labelled.skipTraversal}, '
      'canRequestFocus=${labelled.canRequestFocus}';
  final String summaryScope =
      'debugLabel="${scope.debugLabel}", canRequestFocus='
      '${scope.canRequestFocus}';

  return _card(
    padding: EdgeInsets.zero,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 10.0),
          child: _cardTitle(
            'FocusNode anatomy',
            subtitle: 'The core configuration surface of FocusNode and its '
                'FocusScopeNode subclass.',
          ),
        ),
        Container(
          height: 1.0,
          color: _kHairline,
        ),
        _anatomyRow(
          'debugLabel',
          'String?',
          'Free-form label printed by toString() and used by the inspector. '
              'Does not affect behaviour - purely diagnostic.',
        ),
        _anatomyRow(
          'canRequestFocus',
          'bool',
          'Gate on whether requestFocus() may succeed. Toggling false while '
              'the node is focused causes it to drop focus.',
          colour: _kAccentBlue,
        ),
        _anatomyRow(
          'skipTraversal',
          'bool',
          'When true, traversal policies skip this node entirely. The node '
              'can still receive focus via direct requestFocus().',
          colour: _kAccentBlue,
        ),
        _anatomyRow(
          'descendantsAreFocusable',
          'bool',
          'When false, every descendant node is treated as un-focusable, '
              'including by traversal. Useful for disabling whole subtrees.',
          colour: _kAccentBlue,
        ),
        _anatomyRow(
          'descendantsAreTraversable',
          'bool',
          'Like descendantsAreFocusable but only blocks traversal; nodes can '
              'still receive programmatic focus.',
          colour: _kAccentBlue,
        ),
        _anatomyRow(
          'onKeyEvent',
          'FocusOnKeyEventCallback?',
          'New-style key handler. Returns KeyEventResult.{handled, ignored, '
              'skipRemainingHandlers}. Preferred over onKey.',
          colour: _kAccentGreen,
        ),
        _anatomyRow(
          'onKey',
          'FocusOnKeyCallback?',
          'Legacy raw-key handler. Still supported, but the new HardwareKeyboard '
              'pipeline routes through onKeyEvent first.',
          colour: _kAccentAmber,
        ),
        _anatomyRow(
          'hasFocus',
          'bool (getter)',
          'True if this node is on the primary-focus path. True for the '
              'leaf and every ancestor scope.',
          colour: _kAccentTeal,
        ),
        _anatomyRow(
          'hasPrimaryFocus',
          'bool (getter)',
          'True only for the leaf - the one node that currently receives '
              'key events.',
          colour: _kAccentTeal,
        ),
        _anatomyRow(
          'children / ancestors / descendants',
          'Iterable<FocusNode>',
          'Live walks of the focus subtree. Updated as attach/detach run.',
          colour: _kAccentViolet,
        ),
        _anatomyRow(
          'parent',
          'FocusNode?',
          'Logical parent in the focus tree, which is normally the nearest '
              'enclosing FocusScopeNode.',
          colour: _kAccentViolet,
        ),
        _anatomyRow(
          'context',
          'BuildContext?',
          'BuildContext of the Element the node is attached to, set by '
              'FocusAttachment when bound.',
          colour: _kAccentRose,
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _kCardSoft,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: _kHairline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Live diagnostics (built once):', style: _kCaptionStyle),
                const SizedBox(height: 4.0),
                Text(summaryLabelled, style: _kMonoInlineStyle),
                Text(summaryScope, style: _kMonoInlineStyle),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - SIX STATIC FOCUS() WIDGETS
// ---------------------------------------------------------------------------
Widget _focusVariantCard(
  String title,
  String body,
  Widget child,
  Color accent,
) {
  return Container(
    width: 280.0,
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(body, style: _kBodySoftStyle),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: child,
        ),
      ],
    ),
  );
}

Widget _focusVariantsSection() {
  // Six Focus() variants - constructed for their *configuration*, not for
  // runtime focus changes (build runs only once). Wrap each in IgnorePointer
  // so the static render is visually clean.

  final Focus v1 = Focus(
    autofocus: true,
    onFocusChange: (bool _) {},
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kAccentSoft,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _kAccent.withOpacity(0.3)),
      ),
      child: const Text(
        'autofocus: true',
        style: TextStyle(fontFamily: 'monospace', color: _kInk),
      ),
    ),
  );

  final Focus v2 = Focus(
    focusNode: FocusNode(debugLabel: 'v2'),
    debugLabel: 'card-v2',
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kAccentSoft,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _kAccentBlue.withOpacity(0.3)),
      ),
      child: const Text(
        'focusNode: FocusNode()',
        style: TextStyle(fontFamily: 'monospace', color: _kInk),
      ),
    ),
  );

  final Focus v3 = Focus(
    onKeyEvent: (FocusNode node, KeyEvent event) => KeyEventResult.ignored,
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kAccentSoft,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _kAccentGreen.withOpacity(0.3)),
      ),
      child: const Text(
        'onKeyEvent: (n,e)=>ignored',
        style: TextStyle(fontFamily: 'monospace', color: _kInk),
      ),
    ),
  );

  final Focus v4 = Focus(
    canRequestFocus: false,
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kAccentSoft,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _kAccentAmber.withOpacity(0.3)),
      ),
      child: const Text(
        'canRequestFocus: false',
        style: TextStyle(fontFamily: 'monospace', color: _kInk),
      ),
    ),
  );

  final Focus v5 = Focus(
    skipTraversal: true,
    onFocusChange: (bool _) {},
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kAccentSoft,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _kAccentRose.withOpacity(0.3)),
      ),
      child: const Text(
        'skipTraversal: true',
        style: TextStyle(fontFamily: 'monospace', color: _kInk),
      ),
    ),
  );

  final Widget v6 = ExcludeFocus(
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: _kAccentSoft,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: _kAccentViolet.withOpacity(0.3)),
      ),
      child: const Text(
        'ExcludeFocus(child:…)',
        style: TextStyle(fontFamily: 'monospace', color: _kInk),
      ),
    ),
  );

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Six Focus() configurations',
          subtitle:
              'The same widget rendered with different parameters. Each card '
              'annotates the property that is unique to it.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            _focusVariantCard(
              'autofocus: true',
              'Requests focus on first mount inside its enclosing scope. '
                  'Only one autofocused node may exist per scope.',
              IgnorePointer(child: v1),
              _kAccent,
            ),
            _focusVariantCard(
              'focusNode:',
              'Supplies an externally-owned FocusNode. The Focus widget will '
                  'not dispose it - you must.',
              IgnorePointer(child: v2),
              _kAccentBlue,
            ),
            _focusVariantCard(
              'onKeyEvent:',
              'Receives every KeyEvent while focused. Return handled, '
                  'ignored, or skipRemainingHandlers.',
              IgnorePointer(child: v3),
              _kAccentGreen,
            ),
            _focusVariantCard(
              'canRequestFocus: false',
              'Node still exists in the tree but cannot become primary. '
                  'Useful for read-only widgets.',
              IgnorePointer(child: v4),
              _kAccentAmber,
            ),
            _focusVariantCard(
              'skipTraversal: true',
              'Traversal (Tab / arrows) jumps over this node. It can still '
                  'be focused programmatically.',
              IgnorePointer(child: v5),
              _kAccentRose,
            ),
            _focusVariantCard(
              'ExcludeFocus()',
              'Wraps a subtree to mark every descendant non-focusable. '
                  'Equivalent to descendantsAreFocusable=false on a scope.',
              IgnorePointer(child: v6),
              _kAccentViolet,
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - FOCUSTRAVERSALGROUP + POLICIES
// ---------------------------------------------------------------------------
// WidgetOrderTraversalPolicy already mixes in DirectionalFocusTraversalPolicy
// Mixin upstream, so subclassing it directly is enough to demonstrate the
// directional traversal surface without re-mixing the mixin (which would
// collide on a private field). The subclass exists only as a named pivot.
class _DirectionalDemoPolicy extends WidgetOrderTraversalPolicy {
  _DirectionalDemoPolicy();
}

Widget _miniInput(String label, {Color colour = _kAccent}) {
  return IgnorePointer(
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: colour.withOpacity(0.45), width: 1.2),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 6.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: _kInk,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _policyCard(
  String title,
  String description,
  String policyClass,
  Widget child,
  Color accent,
) {
  return Container(
    width: 300.0,
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _pill(policyClass, colour: accent),
        const SizedBox(height: 8.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: _kInk,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(description, style: _kBodySoftStyle),
        const SizedBox(height: 10.0),
        child,
      ],
    ),
  );
}

Widget _traversalSection() {
  // WidgetOrder
  final FocusTraversalGroup g1 = FocusTraversalGroup(
    policy: WidgetOrderTraversalPolicy(),
    child: Column(
      children: <Widget>[
        _miniInput('Field A'),
        _miniInput('Field B'),
        _miniInput('Field C'),
      ],
    ),
  );

  // ReadingOrder
  final FocusTraversalGroup g2 = FocusTraversalGroup(
    policy: ReadingOrderTraversalPolicy(),
    child: Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(child: _miniInput('LTR top-left', colour: _kAccentBlue)),
          const SizedBox(width: 6.0),
          Expanded(child: _miniInput('LTR top-right', colour: _kAccentBlue)),
        ]),
        Row(children: <Widget>[
          Expanded(child: _miniInput('LTR bottom-left', colour: _kAccentBlue)),
          const SizedBox(width: 6.0),
          Expanded(
              child: _miniInput('LTR bottom-right', colour: _kAccentBlue)),
        ]),
      ],
    ),
  );

  // Ordered + NumericFocusOrder
  final FocusTraversalGroup g3 = FocusTraversalGroup(
    policy: OrderedTraversalPolicy(),
    child: Column(
      children: <Widget>[
        FocusTraversalOrder(
          order: const NumericFocusOrder(3.0),
          child: _miniInput('order: 3.0', colour: _kAccentGreen),
        ),
        FocusTraversalOrder(
          order: const NumericFocusOrder(1.0),
          child: _miniInput('order: 1.0', colour: _kAccentGreen),
        ),
        FocusTraversalOrder(
          order: const NumericFocusOrder(2.0),
          child: _miniInput('order: 2.0', colour: _kAccentGreen),
        ),
      ],
    ),
  );

  // Directional via custom mixin subclass
  final FocusTraversalGroup g4 = FocusTraversalGroup(
    policy: _DirectionalDemoPolicy(),
    child: Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(child: _miniInput('UL', colour: _kAccentViolet)),
          const SizedBox(width: 6.0),
          Expanded(child: _miniInput('UR', colour: _kAccentViolet)),
        ]),
        Row(children: <Widget>[
          Expanded(child: _miniInput('LL', colour: _kAccentViolet)),
          const SizedBox(width: 6.0),
          Expanded(child: _miniInput('LR', colour: _kAccentViolet)),
        ]),
      ],
    ),
  );

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'FocusTraversalGroup + policies',
          subtitle:
              'Each child subtree is grouped under a different policy that '
              'controls Tab/Shift-Tab and arrow-key navigation order.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            _policyCard(
              'Widget order',
              'Tab order follows the order children are inserted into the '
                  'widget tree - the simplest and default policy.',
              'WidgetOrderTraversalPolicy',
              g1,
              _kAccent,
            ),
            _policyCard(
              'Reading order',
              'Sorts by reading direction of the ambient Directionality - '
                  'left-to-right top-to-bottom for LTR locales.',
              'ReadingOrderTraversalPolicy',
              g2,
              _kAccentBlue,
            ),
            _policyCard(
              'Ordered',
              'Honours FocusTraversalOrder annotations on each descendant. '
                  'Combine with NumericFocusOrder or LexicalFocusOrder.',
              'OrderedTraversalPolicy',
              g3,
              _kAccentGreen,
            ),
            _policyCard(
              'Directional (custom)',
              'A trivial subclass mixing in DirectionalFocusTraversalPolicy'
                  'Mixin so arrow keys can navigate the 2x2 grid.',
              '_DirectionalDemoPolicy',
              g4,
              _kAccentViolet,
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - FOCUSABLEACTIONDETECTOR DEMO
// ---------------------------------------------------------------------------
class _DummyIntent extends Intent {
  const _DummyIntent(this.label);
  final String label;
}

class _DummyAction extends Action<_DummyIntent> {
  _DummyAction();
  @override
  Object? invoke(_DummyIntent intent) => null;
}

Widget _detectorTile(
  String title,
  String description,
  Map<ShortcutActivator, Intent> shortcuts,
  Map<Type, Action<Intent>> actions,
  MouseCursor cursor,
  Color accent,
) {
  final FocusableActionDetector detector = FocusableActionDetector(
    shortcuts: shortcuts,
    actions: actions,
    mouseCursor: cursor,
    onFocusChange: (bool _) {},
    onShowFocusHighlight: (bool _) {},
    onShowHoverHighlight: (bool _) {},
    child: Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withOpacity(0.4), width: 1.2),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 30.0,
            height: 30.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(
              Icons.keyboard,
              size: 18.0,
              color: Color(0xFFFFFFFF),
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
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(description, style: _kBodySoftStyle),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  return Container(
    width: 360.0,
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        IgnorePointer(child: detector),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: shortcuts.keys
              .map<Widget>(
                  (ShortcutActivator a) => _pill(_shortcutLabel(a), colour: accent))
              .toList(growable: false),
        ),
      ],
    ),
  );
}

String _shortcutLabel(ShortcutActivator a) {
  if (a is SingleActivator) {
    final StringBuffer sb = StringBuffer();
    if (a.control) sb.write('Ctrl+');
    if (a.shift) sb.write('Shift+');
    if (a.alt) sb.write('Alt+');
    if (a.meta) sb.write('Meta+');
    sb.write(a.trigger.keyLabel.isEmpty ? '?' : a.trigger.keyLabel);
    return sb.toString();
  }
  return a.runtimeType.toString();
}

Widget _focusableActionDetectorSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'FocusableActionDetector',
          subtitle:
              'A composite widget combining Focus, Shortcuts, Actions and a '
              'MouseRegion. Three tiles, three intent maps.',
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            _detectorTile(
              'Save shortcut',
              'Ctrl+S triggers a SaveIntent dispatched up the Actions chain.',
              <ShortcutActivator, Intent>{
                const SingleActivator(LogicalKeyboardKey.keyS, control: true):
                    const _DummyIntent('save'),
              },
              <Type, Action<Intent>>{_DummyIntent: _DummyAction()},
              SystemMouseCursors.click,
              _kAccent,
            ),
            _detectorTile(
              'Find shortcut',
              'Ctrl+F dispatches a FindIntent. Mouse cursor switches to text.',
              <ShortcutActivator, Intent>{
                const SingleActivator(LogicalKeyboardKey.keyF, control: true):
                    const _DummyIntent('find'),
              },
              <Type, Action<Intent>>{_DummyIntent: _DummyAction()},
              SystemMouseCursors.text,
              _kAccentBlue,
            ),
            _detectorTile(
              'Escape + Enter',
              'Enter confirms, Escape cancels. Two activators map to two '
                  'intents handled by the same Action map.',
              <ShortcutActivator, Intent>{
                const SingleActivator(LogicalKeyboardKey.enter):
                    const _DummyIntent('confirm'),
                const SingleActivator(LogicalKeyboardKey.escape):
                    const _DummyIntent('cancel'),
              },
              <Type, Action<Intent>>{_DummyIntent: _DummyAction()},
              SystemMouseCursors.basic,
              _kAccentGreen,
            ),
          ],
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - SIX CODE-BLOCK RECIPES
// ---------------------------------------------------------------------------
Widget _codeRecipesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _codeBlock(
        '''class _MyFormState extends State<MyForm> {
  late final FocusNode _name = FocusNode(debugLabel: 'name');
  late final FocusNode _email = FocusNode(debugLabel: 'email');

  @override
  void dispose() {
    _name.dispose();   // critical: avoids leaks
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(focusNode: _name),
      TextField(focusNode: _email),
    ]);
  }
}''',
        title: 'recipe_01_manage_focusnode_in_state.dart',
      ),
      _codeBlock(
        '''// Tap anywhere outside an input to dismiss the soft keyboard.
GestureDetector(
  behavior: HitTestBehavior.translucent,
  onTap: () => FocusScope.of(context).unfocus(),
  child: const MyForm(),
);''',
        title: 'recipe_02_unfocus_via_focusscope.dart',
      ),
      _codeBlock(
        '''// Autofocus inside a dialog. Only one autofocus is allowed per scope.
showDialog(
  context: context,
  builder: (_) => AlertDialog(
    content: TextField(autofocus: true),
  ),
);''',
        title: 'recipe_03_autofocus_in_dialog.dart',
      ),
      _codeBlock(
        '''// Move focus on submit, chaining nodes by hand.
TextField(
  focusNode: _name,
  textInputAction: TextInputAction.next,
  onSubmitted: (_) {
    _email.requestFocus();   // jump to the next field
  },
)''',
        title: 'recipe_04_request_focus_chain.dart',
      ),
      _codeBlock(
        '''// Custom key handler: swallow Enter inside a chat composer.
Focus(
  onKeyEvent: (FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter &&
        !HardwareKeyboard.instance.isShiftPressed) {
      _send();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  },
  child: TextField(maxLines: null),
);''',
        title: 'recipe_05_on_key_event.dart',
      ),
      _codeBlock(
        '''// Group two side panels so Tab cycles within the side panel first.
FocusTraversalGroup(
  policy: OrderedTraversalPolicy(),
  child: Column(children: [
    FocusTraversalOrder(
      order: const NumericFocusOrder(1),
      child: SearchField(),
    ),
    FocusTraversalOrder(
      order: const NumericFocusOrder(2),
      child: ResultList(),
    ),
  ]),
);''',
        title: 'recipe_06_traversal_group_wrap.dart',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - COMPARISON TABLE
// ---------------------------------------------------------------------------
Widget _comparisonCell(String text,
    {bool header = false, Color colour = _kInk}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    alignment: Alignment.centerLeft,
    decoration: BoxDecoration(
      color: header ? _kAccentSoft : null,
      border: const Border(
        right: BorderSide(color: _kHairline),
        bottom: BorderSide(color: _kHairline),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.0,
        color: colour,
        fontWeight: header ? FontWeight.w700 : FontWeight.w500,
      ),
    ),
  );
}

Widget _comparisonRow(List<Widget> cells) {
  return IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cells
          .map((Widget w) => Expanded(child: w))
          .toList(growable: false),
    ),
  );
}

Widget _comparisonSection() {
  return _card(
    padding: const EdgeInsets.all(0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 8.0),
          child: _cardTitle(
            'API surface comparison',
            subtitle:
                'Picking the right type: model node vs scope node vs Focus '
                'widget vs FocusableActionDetector.',
          ),
        ),
        Container(height: 1.0, color: _kHairline),
        _comparisonRow(<Widget>[
          _comparisonCell('Aspect', header: true),
          _comparisonCell('FocusNode', header: true, colour: _kAccentBlue),
          _comparisonCell('FocusScopeNode', header: true, colour: _kAccentRose),
          _comparisonCell('Focus (widget)', header: true, colour: _kAccentGreen),
          _comparisonCell('FocusableActionDetector',
              header: true, colour: _kAccentAmber),
        ]),
        _comparisonRow(<Widget>[
          _comparisonCell('Layer'),
          _comparisonCell('model'),
          _comparisonCell('model'),
          _comparisonCell('widget'),
          _comparisonCell('widget'),
        ]),
        _comparisonRow(<Widget>[
          _comparisonCell('Listenable'),
          _comparisonCell('yes'),
          _comparisonCell('yes (inherits)'),
          _comparisonCell('via inner node'),
          _comparisonCell('via inner Focus'),
        ]),
        _comparisonRow(<Widget>[
          _comparisonCell('Owns subtree'),
          _comparisonCell('no'),
          _comparisonCell('yes - focusedChild stack'),
          _comparisonCell('only its descendants'),
          _comparisonCell('shortcuts subtree'),
        ]),
        _comparisonRow(<Widget>[
          _comparisonCell('In widget tree'),
          _comparisonCell('no'),
          _comparisonCell('no'),
          _comparisonCell('yes'),
          _comparisonCell('yes'),
        ]),
        _comparisonRow(<Widget>[
          _comparisonCell('Handles raw keys'),
          _comparisonCell('via onKey/onKeyEvent'),
          _comparisonCell('inherited'),
          _comparisonCell('via onKeyEvent'),
          _comparisonCell('via Shortcuts->Actions'),
        ]),
        _comparisonRow(<Widget>[
          _comparisonCell('Mouse cursor'),
          _comparisonCell('-'),
          _comparisonCell('-'),
          _comparisonCell('-'),
          _comparisonCell('mouseCursor: param'),
        ]),
        _comparisonRow(<Widget>[
          _comparisonCell('Hover / highlight'),
          _comparisonCell('-'),
          _comparisonCell('-'),
          _comparisonCell('-'),
          _comparisonCell('onShowHoverHighlight'),
        ]),
        _comparisonRow(<Widget>[
          _comparisonCell('Auto-disposes'),
          _comparisonCell('no - caller owns'),
          _comparisonCell('no - caller owns'),
          _comparisonCell('only its internal node'),
          _comparisonCell('internal Focus does'),
        ]),
        _comparisonRow(<Widget>[
          _comparisonCell('Use when'),
          _comparisonCell('manual model'),
          _comparisonCell('grouping leaves'),
          _comparisonCell('inline focusable widget'),
          _comparisonCell('command-bar surface'),
        ]),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 - PITFALLS
// ---------------------------------------------------------------------------
Widget _pitfall(String emojiLike, String title, String body, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.06),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withOpacity(0.35)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 34.0,
          height: 34.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            emojiLike,
            style: const TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 14.0,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
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
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                  fontSize: 14.0,
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

Widget _pitfallsSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Pitfalls',
          subtitle: 'Six common ways to mis-wire focus and how to avoid them.',
        ),
        const SizedBox(height: 8.0),
        _pitfall(
          '01',
          'Dispose leaks',
          'A FocusNode you construct yourself owns a ChangeNotifier listener '
              'list. Forgetting to call dispose() in State.dispose() leaks '
              'callbacks and may keep the surrounding Element alive.',
          _kAccentRose,
        ),
        _pitfall(
          '02',
          'canRequestFocus toggle',
          'Setting canRequestFocus = false while a node is primary causes it '
              'to drop focus immediately, which can race with text-input '
              'focus and cause flicker. Toggle before the field becomes '
              'visible or pair it with FocusScope.of(context).unfocus().',
          _kAccentAmber,
        ),
        _pitfall(
          '03',
          'hasPrimaryFocus vs hasFocus',
          'hasFocus is true for any node on the primary path - including the '
              'enclosing FocusScopeNode. Use hasPrimaryFocus to detect "I am '
              'the leaf receiving keystrokes".',
          _kAccentBlue,
        ),
        _pitfall(
          '04',
          'Dialog/route focus',
          'Pushing a route creates a new FocusScope. If you call '
              'FocusScope.of(context) from a builder closure of the previous '
              'route, you will refer to the dismissed scope. Capture the '
              'scope before navigation, or reach for the dialog\'s context.',
          _kAccentGreen,
        ),
        _pitfall(
          '05',
          'Autofocus race',
          'autofocus is honoured only when the node attaches to a scope that '
              'has no other autofocus already pending. Two autofocus widgets '
              'in the same scope is a misconfiguration - only one wins, and '
              'the order is undefined.',
          _kAccentViolet,
        ),
        _pitfall(
          '06',
          'Focus inside Hero',
          'Hero transitions reparent a widget into the overlay during flight. '
              'Any Focus inside detaches and reattaches, which is enough to '
              'lose primary focus mid-animation. Prefer placing focusable '
              'inputs outside the Hero subtree, or accept the loss.',
          _kAccentTeal,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 11 - CHEAT-SHEET FOOTER
// ---------------------------------------------------------------------------
Widget _chipGroup(String title, List<String> chips, Color colour) {
  return Container(
    margin: const EdgeInsets.all(6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13.0,
            color: colour,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: chips
              .map<Widget>((String s) => _pill(s, colour: colour))
              .toList(growable: false),
        ),
      ],
    ),
  );
}

Widget _cheatSheetFooter() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 28.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'FocusNode cheat-sheet',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Quick mental index across the focus subsystem.',
          style: TextStyle(color: _kInkOnDarkSecondary, fontSize: 13.0),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          children: <Widget>[
            _chipGroup('Nodes', const <String>[
              'FocusNode',
              'FocusScopeNode',
              'FocusAttachment',
              'FocusManager',
            ], const Color(0xFF93C5FD)),
            _chipGroup('Widgets', const <String>[
              'Focus',
              'FocusScope',
              'ExcludeFocus',
              'FocusableActionDetector',
            ], const Color(0xFFA7F3D0)),
            _chipGroup('Policies', const <String>[
              'WidgetOrder',
              'ReadingOrder',
              'Ordered + NumericFocusOrder',
              'DirectionalMixin',
            ], const Color(0xFFFDE68A)),
            _chipGroup('FocusManager surface', const <String>[
              'primaryFocus',
              'rootScope',
              'highlightMode',
              'addHighlightModeListener',
            ], const Color(0xFFFBCFE8)),
            _chipGroup('Key handling', const <String>[
              'onKeyEvent',
              'KeyEventResult.handled',
              'KeyEventResult.ignored',
              'KeyEventResult.skipRemainingHandlers',
            ], const Color(0xFFFCA5A5)),
            _chipGroup('Shortcuts/Actions', const <String>[
              'SingleActivator',
              'CharacterActivator',
              'Intent / Action<T>',
              'Actions.invoke',
            ], const Color(0xFFC4B5FD)),
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
            'Tagline: "The focus tree is just a parallel tree. Build it '
            'declaratively with Focus/FocusScope, drive it imperatively with '
            'FocusNode, and let FocusManager mediate the rest."',
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
// The interpreter calls this function exactly once. All state must live in
// local variables; we never call requestFocus() at runtime because there is
// no second build pass and no driver to schedule the call against.
// ===========================================================================
dynamic build(BuildContext context) {
  print('FocusNode deep visual demo: building widget tree');

  // Inert FocusNodes constructed to demonstrate field defaults. They are
  // *not* attached to live widgets that would call requestFocus().
  final FocusNode demoNode = FocusNode(debugLabel: 'demo.node');
  final FocusScopeNode demoScope = FocusScopeNode(debugLabel: 'demo.scope');
  print('demoNode.hasFocus=${demoNode.hasFocus}');
  print('demoNode.hasPrimaryFocus=${demoNode.hasPrimaryFocus}');
  print('demoNode.canRequestFocus=${demoNode.canRequestFocus}');
  print('demoNode.skipTraversal=${demoNode.skipTraversal}');
  print('demoScope.debugLabel=${demoScope.debugLabel}');
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
          _sectionHeader(1, 'Why FocusNode exists',
              'A model layer above the widget tree for keystrokes.'),
          _heroIntroCard(),
          _sectionDivider(),

          // Section 2
          _sectionHeader(2, 'Class hierarchy',
              'From Listenable down to FocusableActionDetector.'),
          _hierarchySection(),
          _sectionDivider(),

          // Section 3
          _sectionHeader(3, 'Focus tree for a Form',
              'Scaffold -> Form -> 5 fields drawn as a node graph.'),
          _focusTreeSection(),
          _sectionDivider(),

          // Section 4
          _sectionHeader(4, 'FocusNode anatomy',
              'Configuration fields, diagnostic fields, tree fields.'),
          _anatomySection(),
          _sectionDivider(),

          // Section 5
          _sectionHeader(5, 'Six Focus() variants',
              'autofocus, custom node, onKeyEvent, gated, skip, excluded.'),
          _focusVariantsSection(),
          _sectionDivider(),

          // Section 6
          _sectionHeader(6, 'FocusTraversalGroup',
              'Four mini forms, four traversal policies.'),
          _traversalSection(),
          _sectionDivider(),

          // Section 7
          _sectionHeader(7, 'FocusableActionDetector',
              'Shortcuts + Actions + MouseRegion in one composite widget.'),
          _focusableActionDetectorSection(),
          _sectionDivider(),

          // Section 8
          _sectionHeader(8, 'Code recipes',
              'Six idiomatic snippets you will reach for again and again.'),
          _codeRecipesSection(),
          _sectionDivider(),

          // Section 9
          _sectionHeader(9, 'API surface comparison',
              'FocusNode vs FocusScopeNode vs Focus vs FocusableActionDetector.'),
          _comparisonSection(),
          _sectionDivider(),

          // Section 10
          _sectionHeader(10, 'Pitfalls',
              'Six callouts that commonly bite Flutter engineers.'),
          _pitfallsSection(),
          _sectionDivider(),

          // Section 11
          _sectionHeader(11, 'Cheat-sheet',
              'A compact map of the focus subsystem.'),
          _cheatSheetFooter(),
        ],
      ),
    ),
  );
}
