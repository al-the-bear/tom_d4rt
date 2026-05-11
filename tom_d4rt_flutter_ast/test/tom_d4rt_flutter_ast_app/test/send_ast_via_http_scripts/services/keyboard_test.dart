// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_import, unnecessary_import, no_leading_underscores_for_local_identifiers, dead_code
// D4rt test script: Deep visual demo of Flutter's `services` keyboard API.
//
// This file is part of the D4rt flutter-test corpus. It is intended to be
// executed by an analyzer-free, sandboxed Dart interpreter. The script
// exports exactly one top-level entry point - `dynamic build(BuildContext)`
// - which is invoked a single time, and which returns a Widget tree.
//
// The rendered output is a long static gallery that walks through the
// keyboard subsystem in `package:flutter/services.dart`:
//
//   * KeyEvent (abstract) with the three concrete subtypes
//     KeyDownEvent / KeyUpEvent / KeyRepeatEvent
//   * KeyEventManager - the bridge that fans events out
//   * KeyEventResult enum - handled / ignored / skipRemainingHandlers
//   * LogicalKeyboardKey - logical-layer key identifiers
//   * PhysicalKeyboardKey - USB-HID-coded physical key positions
//   * KeyboardKey - shared abstract base
//   * KeyboardLockMode - numLock / capsLock / scrollLock
//   * HardwareKeyboard (modern) and RawKeyboard (legacy)
//
// Each section is followed by code blocks illustrating idiomatic usage, a
// comparison table, and a pitfalls panel. No `setState`, `Timer`, `Future`,
// `AnimationController` or listener registration is used anywhere.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
const Color _kCanvas = Color(0xFFF4F6FB);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF161A23);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF101321);
const Color _kInkSecondary = Color(0xFF3B405A);
const Color _kInkTertiary = Color(0xFF7A819A);
const Color _kInkOnDark = Color(0xFFEDEFF7);
const Color _kInkOnDarkSecondary = Color(0xFFA1A6BD);
const Color _kAccent = Color(0xFF3D5AFE);
const Color _kAccentGreen = Color(0xFF21C77E);
const Color _kAccentOrange = Color(0xFFFF8A1F);
const Color _kAccentRed = Color(0xFFE53E5A);
const Color _kAccentIndigo = Color(0xFF6357E0);
const Color _kAccentPink = Color(0xFFEC2C77);
const Color _kAccentTeal = Color(0xFF14B6C4);
const Color _kAccentAmber = Color(0xFFE8B400);
const Color _kCodeBg = Color(0xFF1A1D26);
const Color _kCodeText = Color(0xFFE6EAF2);
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
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.4,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);

const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPERS
// ---------------------------------------------------------------------------
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

Widget _pill(String label, {Color colour = _kAccent, Color textColour = _kAccent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: colour.withOpacity(0.32)),
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

Widget _heroPill(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: const Color(0x55FFFFFF)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: Color(0xFFFFFFFF),
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

Widget _chipKey(String label, {Color colour = _kAccent, double width = 70.0}) {
  return Container(
    width: width,
    margin: const EdgeInsets.all(4.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: colour.withOpacity(0.10),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: colour.withOpacity(0.32)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: colour,
        fontFamily: 'monospace',
      ),
      textAlign: TextAlign.center,
    ),
  );
}

// ---------------------------------------------------------------------------
// CUSTOM PAINTERS
// ---------------------------------------------------------------------------
class _HierarchyPainter extends CustomPainter {
  const _HierarchyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint nodeFill = Paint()..color = const Color(0xFFEEF1FF);
    final Paint nodeFillRoot = Paint()..color = const Color(0xFFE8ECFF);
    final Paint nodeStroke = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final Paint arrow = Paint()
      ..color = _kAccentIndigo
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    final double w = size.width;
    final double h = size.height;

    // Root: KeyEvent at top centre.
    final Rect root = Rect.fromCenter(
      center: Offset(w * 0.5, 32.0),
      width: 180.0,
      height: 44.0,
    );
    final RRect rootR = RRect.fromRectAndRadius(root, const Radius.circular(10.0));
    canvas.drawRRect(rootR, nodeFillRoot);
    canvas.drawRRect(rootR, nodeStroke);
    _drawLabel(canvas, 'KeyEvent', root.center, bold: true);

    // Three leaves along the bottom row.
    final double leafY = h - 32.0;
    final List<String> leaves = <String>['KeyDownEvent', 'KeyUpEvent', 'KeyRepeatEvent'];
    final List<Offset> leafCentres = <Offset>[
      Offset(w * 0.18, leafY),
      Offset(w * 0.50, leafY),
      Offset(w * 0.82, leafY),
    ];
    for (int i = 0; i < leaves.length; i++) {
      final Rect r = Rect.fromCenter(
        center: leafCentres[i],
        width: 150.0,
        height: 40.0,
      );
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(10.0));
      canvas.drawRRect(rr, nodeFill);
      canvas.drawRRect(rr, nodeStroke);
      _drawLabel(canvas, leaves[i], r.center);

      // Arrow from root bottom to leaf top.
      final Offset start = Offset(root.center.dx, root.bottom);
      final Offset end = Offset(r.center.dx, r.top);
      canvas.drawLine(start, end, arrow);
      _drawArrowHead(canvas, start, end, arrow);
    }
  }

  void _drawLabel(Canvas canvas, String text, Offset centre, {bool bold = false}) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: _kAccent,
          fontSize: 13.0,
          fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, centre - Offset(tp.width / 2.0, tp.height / 2.0));
  }

  void _drawArrowHead(Canvas canvas, Offset from, Offset to, Paint paint) {
    final double dx = to.dx - from.dx;
    final double dy = to.dy - from.dy;
    final double len = math.sqrt(dx * dx + dy * dy);
    if (len == 0.0) {
      return;
    }
    final double ux = dx / len;
    final double uy = dy / len;
    const double arrowSize = 8.0;
    final Offset tip = to;
    final Offset base1 = Offset(
      tip.dx - arrowSize * ux + arrowSize * 0.5 * uy,
      tip.dy - arrowSize * uy - arrowSize * 0.5 * ux,
    );
    final Offset base2 = Offset(
      tip.dx - arrowSize * ux - arrowSize * 0.5 * uy,
      tip.dy - arrowSize * uy + arrowSize * 0.5 * ux,
    );
    final Path p = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(base1.dx, base1.dy)
      ..lineTo(base2.dx, base2.dy)
      ..close();
    canvas.drawPath(p, Paint()..color = paint.color);
  }

  @override
  bool shouldRepaint(_HierarchyPainter oldDelegate) => false;
}

class _FocusFlowPainter extends CustomPainter {
  const _FocusFlowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint stroke = Paint()
      ..color = _kAccentIndigo
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final Paint handled = Paint()..color = const Color(0xFFDFF6E2);
    final Paint ignored = Paint()..color = const Color(0xFFFFF1D6);
    final Paint skip = Paint()..color = const Color(0xFFFFE0E6);
    final Paint platform = Paint()..color = const Color(0xFFE6E8FF);

    final double w = size.width;
    final double h = size.height;

    // 4 vertical nodes: HardwareKeyboard -> FocusManager -> Focus widgets ->
    // Result (handled/ignored).
    final List<String> nodes = <String>[
      'HardwareKeyboard',
      'FocusManager',
      'Focus.onKeyEvent',
      'KeyEventResult',
    ];
    final List<Paint> fills = <Paint>[platform, platform, platform, platform];
    final List<Rect> rects = <Rect>[];
    final double slotH = h / nodes.length;
    for (int i = 0; i < nodes.length; i++) {
      final Rect r = Rect.fromCenter(
        center: Offset(w * 0.5, slotH * (i + 0.5)),
        width: 200.0,
        height: 36.0,
      );
      rects.add(r);
      final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(10.0));
      canvas.drawRRect(rr, fills[i]);
      canvas.drawRRect(rr, stroke);
      _drawLabel(canvas, nodes[i], r.center);
    }
    for (int i = 0; i < rects.length - 1; i++) {
      final Offset start = Offset(rects[i].center.dx, rects[i].bottom);
      final Offset end = Offset(rects[i + 1].center.dx, rects[i + 1].top);
      canvas.drawLine(start, end, stroke);
    }

    // Branch labels alongside the last edge.
    _drawSideLabel(canvas, 'handled', Offset(w * 0.78, rects[3].center.dy - 30.0), handled);
    _drawSideLabel(canvas, 'ignored', Offset(w * 0.78, rects[3].center.dy), ignored);
    _drawSideLabel(canvas, 'skipRemainingHandlers', Offset(w * 0.78, rects[3].center.dy + 30.0), skip);
  }

  void _drawLabel(Canvas canvas, String text, Offset centre) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: _kAccentIndigo,
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, centre - Offset(tp.width / 2.0, tp.height / 2.0));
  }

  void _drawSideLabel(Canvas canvas, String text, Offset centre, Paint fill) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: _kInk,
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    final Rect r = Rect.fromCenter(
      center: centre,
      width: tp.width + 14.0,
      height: tp.height + 8.0,
    );
    final RRect rr = RRect.fromRectAndRadius(r, const Radius.circular(6.0));
    canvas.drawRRect(rr, fill);
    tp.paint(canvas, r.center - Offset(tp.width / 2.0, tp.height / 2.0));
  }

  @override
  bool shouldRepaint(_FocusFlowPainter oldDelegate) => false;
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ===========================================================================
dynamic build(BuildContext context) {
  print('Services keyboard deep visual demo executing');
  final math.Random rng = math.Random(11);
  final int dummyEntropy = rng.nextInt(1000);
  print('  rng warm-up: $dummyEntropy');

  // Probe HardwareKeyboard state up-front. Wrapped defensively because
  // the d4rt analyzer-free harness may not provide a fully bound
  // ServicesBinding.
  String hwInstanceLabel = 'HardwareKeyboard.instance: <unavailable>';
  String hwLockModes = '<unavailable>';
  String hwPhysical = '<unavailable>';
  String hwLogical = '<unavailable>';
  try {
    final HardwareKeyboard hw = HardwareKeyboard.instance;
    hwInstanceLabel = 'HardwareKeyboard.instance: ${hw.runtimeType}';
    hwLockModes = hw.lockModesEnabled.toString();
    hwPhysical = hw.physicalKeysPressed.length.toString();
    hwLogical = hw.logicalKeysPressed.length.toString();
  } catch (e) {
    print('  HardwareKeyboard.instance unavailable: $e');
  }
  print('  $hwInstanceLabel');
  print('  lockModesEnabled: $hwLockModes');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF3D5AFE),
          Color(0xFF6357E0),
          Color(0xFFEC2C77),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x333D5AFE),
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
            Icon(Icons.keyboard_alt_outlined, color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Text(
              'Flutter Keyboard',
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
          'KeyEvent / HardwareKeyboard / LogicalKeyboardKey / PhysicalKeyboardKey',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'The `services` library exposes a unified, platform-agnostic keyboard model. '
          'HardwareKeyboard is the modern singleton that fans key events out to the '
          'Focus tree as KeyDownEvent / KeyUpEvent / KeyRepeatEvent. LogicalKeyboardKey '
          'and PhysicalKeyboardKey identify keys by their layout-aware label and their '
          'USB HID position respectively. KeyEventResult lets handlers signal whether '
          'they consumed an event, skipped, or want to stop the dispatch chain.',
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
            _heroPill('KeyEvent hierarchy'),
            _heroPill('HardwareKeyboard'),
            _heroPill('Logical / Physical'),
            _heroPill('Focus.onKeyEvent'),
            _heroPill('Shortcuts / Intents'),
            _heroPill('LockModes'),
            _heroPill('RawKeyboard (legacy)'),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color(0x22000000),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.bolt, color: Color(0xFFFFD60A), size: 18.0),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  hwInstanceLabel,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'monospace',
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
  // SECTION 2 - KEYEVENT HIERARCHY DIAGRAM
  // -------------------------------------------------------------------------
  final Widget hierarchyCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.account_tree_outlined, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'KeyEvent hierarchy',
              subtitle: 'Abstract KeyEvent + three concrete subtypes used everywhere in Flutter\'s key dispatch',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 220.0,
          decoration: BoxDecoration(
            color: const Color(0xFFFAFBFF),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline),
          ),
          child: const CustomPaint(
            painter: _HierarchyPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('KeyEvent', colour: _kAccent),
            _pill('KeyDownEvent', colour: _kAccentGreen, textColour: _kAccentGreen),
            _pill('KeyUpEvent', colour: _kAccentOrange, textColour: _kAccentOrange),
            _pill('KeyRepeatEvent', colour: _kAccentIndigo, textColour: _kAccentIndigo),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'KeyEvent is abstract and immutable: every concrete event carries `physicalKey`, '
          '`logicalKey`, optional `character`, a `timeStamp`, and a `synthesized` flag. '
          'KeyDownEvent and KeyRepeatEvent additionally carry a character payload; '
          'KeyUpEvent does not.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - KEYEVENT PAYLOAD TABLE
  // -------------------------------------------------------------------------
  final KeyDownEvent sampleDownA = const KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    character: 'a',
    timeStamp: Duration.zero,
  );
  final KeyUpEvent sampleUpA = const KeyUpEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    timeStamp: Duration(milliseconds: 120),
  );
  final KeyRepeatEvent sampleRepeatA = const KeyRepeatEvent(
    physicalKey: PhysicalKeyboardKey.keyA,
    logicalKey: LogicalKeyboardKey.keyA,
    character: 'a',
    timeStamp: Duration(milliseconds: 240),
  );
  final KeyDownEvent sampleShiftB = const KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyB,
    logicalKey: LogicalKeyboardKey.keyB,
    character: 'B',
    timeStamp: Duration(milliseconds: 360),
  );
  final KeyDownEvent sampleCtrlC = const KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.keyC,
    logicalKey: LogicalKeyboardKey.keyC,
    timeStamp: Duration(milliseconds: 480),
  );
  final KeyDownEvent sampleEnter = const KeyDownEvent(
    physicalKey: PhysicalKeyboardKey.enter,
    logicalKey: LogicalKeyboardKey.enter,
    timeStamp: Duration(milliseconds: 600),
  );

  final List<KeyEvent> sampleEvents = <KeyEvent>[
    sampleDownA,
    sampleUpA,
    sampleRepeatA,
    sampleShiftB,
    sampleCtrlC,
    sampleEnter,
  ];
  final List<String> sampleLabels = <String>[
    'A pressed (down)',
    'A released (up)',
    'A held (repeat)',
    'Shift+B',
    'Ctrl+C',
    'Enter',
  ];

  Widget _payloadHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF1F3FA),
        border: Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(flex: 4, child: Text('label', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _kInk, letterSpacing: 0.4))),
          Expanded(flex: 5, child: Text('physicalKey', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _kInk, letterSpacing: 0.4))),
          Expanded(flex: 5, child: Text('logicalKey', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _kInk, letterSpacing: 0.4))),
          Expanded(flex: 3, child: Text('char', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _kInk, letterSpacing: 0.4))),
          Expanded(flex: 3, child: Text('time', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _kInk, letterSpacing: 0.4))),
          Expanded(flex: 3, child: Text('synth', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _kInk, letterSpacing: 0.4))),
          Expanded(flex: 4, child: Text('runtimeType', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _kInk, letterSpacing: 0.4))),
        ],
      ),
    );
  }

  Widget _payloadRow(KeyEvent e, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(flex: 4, child: Text(label, style: const TextStyle(fontSize: 11.5, color: _kInk, fontWeight: FontWeight.w600))),
          Expanded(flex: 5, child: Text(e.physicalKey.debugName ?? '?', style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _kInkSecondary))),
          Expanded(flex: 5, child: Text(e.logicalKey.debugName ?? '?', style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _kInkSecondary))),
          Expanded(flex: 3, child: Text(e.character ?? '-', style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _kAccent))),
          Expanded(flex: 3, child: Text('${e.timeStamp.inMilliseconds}ms', style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _kInkTertiary))),
          Expanded(flex: 3, child: Text(e.synthesized ? 'true' : 'false', style: const TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: _kInkTertiary))),
          Expanded(flex: 4, child: Text(e.runtimeType.toString(), style: const TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: _kAccentIndigo))),
        ],
      ),
    );
  }

  final Widget payloadTable = _card(
    padding: const EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: <Widget>[
              const Icon(Icons.table_rows_outlined, color: _kAccent, size: 20.0),
              const SizedBox(width: 6.0),
              _cardTitle(
                'KeyEvent payload table',
                subtitle: 'Six concrete event instances, each constructed literally and rendered field-by-field',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        _payloadHeader(),
        for (int i = 0; i < sampleEvents.length; i++)
          _payloadRow(sampleEvents[i], sampleLabels[i]),
        Padding(
          padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 14.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _kCodeBg,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'first.toString(): ${sampleEvents.first.toString()}',
              style: _kCodeStyle,
            ),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - LOGICALKEYBOARDKEY GALLERY
  // -------------------------------------------------------------------------
  final List<LogicalKeyboardKey> letterKeys = const <LogicalKeyboardKey>[
    LogicalKeyboardKey.keyA,
    LogicalKeyboardKey.keyB,
    LogicalKeyboardKey.keyC,
    LogicalKeyboardKey.keyD,
    LogicalKeyboardKey.keyE,
    LogicalKeyboardKey.keyF,
    LogicalKeyboardKey.keyG,
    LogicalKeyboardKey.keyZ,
  ];
  final List<LogicalKeyboardKey> digitKeys = const <LogicalKeyboardKey>[
    LogicalKeyboardKey.digit0,
    LogicalKeyboardKey.digit1,
    LogicalKeyboardKey.digit2,
    LogicalKeyboardKey.digit3,
    LogicalKeyboardKey.digit9,
  ];
  final List<LogicalKeyboardKey> functionKeys = const <LogicalKeyboardKey>[
    LogicalKeyboardKey.f1,
    LogicalKeyboardKey.f2,
    LogicalKeyboardKey.f3,
    LogicalKeyboardKey.f4,
    LogicalKeyboardKey.f12,
  ];
  final List<LogicalKeyboardKey> navKeys = const <LogicalKeyboardKey>[
    LogicalKeyboardKey.arrowUp,
    LogicalKeyboardKey.arrowDown,
    LogicalKeyboardKey.arrowLeft,
    LogicalKeyboardKey.arrowRight,
    LogicalKeyboardKey.home,
    LogicalKeyboardKey.end,
    LogicalKeyboardKey.pageUp,
    LogicalKeyboardKey.pageDown,
  ];
  final List<LogicalKeyboardKey> modifierKeys = const <LogicalKeyboardKey>[
    LogicalKeyboardKey.shiftLeft,
    LogicalKeyboardKey.shiftRight,
    LogicalKeyboardKey.controlLeft,
    LogicalKeyboardKey.controlRight,
    LogicalKeyboardKey.altLeft,
    LogicalKeyboardKey.altRight,
    LogicalKeyboardKey.metaLeft,
    LogicalKeyboardKey.metaRight,
  ];
  final List<LogicalKeyboardKey> specialKeys = const <LogicalKeyboardKey>[
    LogicalKeyboardKey.escape,
    LogicalKeyboardKey.tab,
    LogicalKeyboardKey.enter,
    LogicalKeyboardKey.space,
    LogicalKeyboardKey.backspace,
    LogicalKeyboardKey.delete,
  ];

  Widget _keyGroup(String title, List<LogicalKeyboardKey> keys, Color colour) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6.0,
                height: 14.0,
                decoration: BoxDecoration(
                  color: colour,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(title, style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: _kInk)),
              const SizedBox(width: 8.0),
              Text('(${keys.length})', style: _kCaptionStyle),
            ],
          ),
          const SizedBox(height: 6.0),
          Wrap(
            children: <Widget>[
              for (final LogicalKeyboardKey k in keys)
                _chipKey(
                  k.debugName ?? 'key#${k.keyId}',
                  colour: colour,
                  width: 92.0,
                ),
            ],
          ),
        ],
      ),
    );
  }

  final Widget logicalGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.keyboard_outlined, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'LogicalKeyboardKey gallery',
              subtitle: '30+ layout-aware keys grouped by category - letters, digits, function, navigation, modifiers, special',
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        _keyGroup('Letters', letterKeys, _kAccent),
        _keyGroup('Digits', digitKeys, _kAccentTeal),
        _keyGroup('Function keys', functionKeys, _kAccentIndigo),
        _keyGroup('Navigation', navKeys, _kAccentGreen),
        _keyGroup('Modifiers', modifierKeys, _kAccentOrange),
        _keyGroup('Special', specialKeys, _kAccentPink),
        const SizedBox(height: 8.0),
        const Text(
          'Each chip shows the LogicalKeyboardKey.debugName. The numeric keyId is the '
          'integer ID assigned by Flutter\'s keyboard map; debugName is the friendly label.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - PHYSICALKEYBOARDKEY USB HID GALLERY
  // -------------------------------------------------------------------------
  final List<PhysicalKeyboardKey> physicalKeys = const <PhysicalKeyboardKey>[
    PhysicalKeyboardKey.keyA,
    PhysicalKeyboardKey.keyB,
    PhysicalKeyboardKey.keyC,
    PhysicalKeyboardKey.keyZ,
    PhysicalKeyboardKey.digit0,
    PhysicalKeyboardKey.digit1,
    PhysicalKeyboardKey.digit9,
    PhysicalKeyboardKey.space,
    PhysicalKeyboardKey.enter,
    PhysicalKeyboardKey.escape,
    PhysicalKeyboardKey.tab,
    PhysicalKeyboardKey.backspace,
    PhysicalKeyboardKey.shiftLeft,
    PhysicalKeyboardKey.shiftRight,
    PhysicalKeyboardKey.controlLeft,
    PhysicalKeyboardKey.altLeft,
    PhysicalKeyboardKey.metaLeft,
    PhysicalKeyboardKey.f1,
    PhysicalKeyboardKey.f12,
    PhysicalKeyboardKey.arrowUp,
    PhysicalKeyboardKey.arrowDown,
    PhysicalKeyboardKey.capsLock,
    PhysicalKeyboardKey.numLock,
    PhysicalKeyboardKey.scrollLock,
  ];

  Widget _hidTile(PhysicalKeyboardKey k) {
    return Container(
      width: 160.0,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFF),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            k.debugName ?? 'phys#${k.usbHidUsage}',
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: _kInk,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            children: <Widget>[
              const Icon(Icons.fingerprint, size: 14.0, color: _kAccentIndigo),
              const SizedBox(width: 4.0),
              Text(
                '0x${k.usbHidUsage.toRadixString(16).toUpperCase().padLeft(8, '0')}',
                style: const TextStyle(
                  fontSize: 10.5,
                  color: _kAccentIndigo,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          Text(
            'usbHidUsage = ${k.usbHidUsage}',
            style: const TextStyle(
              fontSize: 10.0,
              color: _kInkTertiary,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  final Widget physicalGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.memory_outlined, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'PhysicalKeyboardKey - USB HID gallery',
              subtitle: '24 physical key slots showing debugName + decimal + hex USB HID usage codes',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            for (final PhysicalKeyboardKey k in physicalKeys) _hidTile(k),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Physical keys identify the location of a key on the keyboard regardless of '
          'layout - the chosen scheme is the USB HID Usage table, so the same code '
          'works on macOS, Windows, Linux, Android, iOS and the web.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - RAWKEYBOARD VS HARDWAREKEYBOARD COMPARISON TABLE
  // -------------------------------------------------------------------------
  Widget _compRow(String topic, String hardware, String raw, {bool header = false}) {
    final TextStyle style = header
        ? const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: _kInk, letterSpacing: 0.4)
        : const TextStyle(fontSize: 12.0, color: _kInk, height: 1.45);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: header ? const Color(0xFFF1F3FA) : const Color(0x00000000),
        border: const Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(flex: 3, child: Text(topic, style: style)),
          Expanded(flex: 4, child: Text(hardware, style: style)),
          Expanded(flex: 4, child: Text(raw, style: style)),
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
              const Icon(Icons.compare_arrows, color: _kAccent, size: 20.0),
              const SizedBox(width: 6.0),
              _cardTitle(
                'HardwareKeyboard vs RawKeyboard',
                subtitle: 'Modern singleton vs the legacy listener API - and the KeyEventManager that bridges them',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: _kHairline)),
          ),
          child: Column(
            children: <Widget>[
              _compRow('Topic', 'HardwareKeyboard', 'RawKeyboard', header: true),
              _compRow('Status', 'Recommended since Flutter 3.4', 'Deprecated, scheduled for removal'),
              _compRow('Event type', 'KeyEvent (KeyDownEvent, KeyUpEvent, KeyRepeatEvent)', 'RawKeyEvent (RawKeyDownEvent, RawKeyUpEvent)'),
              _compRow('Listener model', 'addHandler returns bool to consume', 'addListener void-returning, no consumption signal'),
              _compRow('Singleton', 'HardwareKeyboard.instance', 'RawKeyboard.instance'),
              _compRow('Regularization', 'Yes - synthesized events fill gaps', 'No - native events passed through verbatim'),
              _compRow('Focus integration', 'Focus(onKeyEvent: ...) preferred', 'RawKeyboardListener widget (also deprecated)'),
              _compRow('Repeat events', 'Yes, separate KeyRepeatEvent class', 'RawKeyDownEvent fires repeatedly'),
              _compRow('Lock modes', 'lockModesEnabled Set<KeyboardLockMode>', 'modifiersPressed bitmask via ModifierKey'),
              _compRow('Bridge', 'KeyEventManager.keyMessageHandler', 'Same KeyEventManager translates to RawKeyEvent'),
              _compRow('Platforms', 'All - mobile, web, desktop, embedded', 'All - but missing newer keys on some platforms'),
              _compRow('Synthesized flag', 'KeyEvent.synthesized', 'Not exposed'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF5E0),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _kAccentOrange.withOpacity(0.4)),
            ),
            child: Row(
              children: const <Widget>[
                Icon(Icons.info_outline, color: _kAccentOrange, size: 18.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'KeyEventManager (services/key_event_manager.dart) is the bridge: it receives '
                    'platform messages, builds RawKeyEvent + KeyEvent pairs, and dispatches to both '
                    'RawKeyboard.instance and HardwareKeyboard.instance. New code should ignore '
                    'RawKeyboard entirely.',
                    style: TextStyle(fontSize: 12.0, color: _kInk, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - KEYEVENTRESULT ENUM SHOWCASE
  // -------------------------------------------------------------------------
  Widget _resultCard(KeyEventResult value, String description, Color colour) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colour.withOpacity(0.32)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 12.0,
            height: 12.0,
            margin: const EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
              color: colour,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'KeyEventResult.${value.name}',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: colour,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(description, style: _kBodyStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget resultShowcase = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.alt_route, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'KeyEventResult enum',
              subtitle: 'Three answers a Focus.onKeyEvent handler can give back to the dispatch machinery',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _resultCard(
          KeyEventResult.handled,
          'The handler consumed the event. Dispatch stops. The platform should not '
          'forward this key to text input or other widgets.',
          _kAccentGreen,
        ),
        _resultCard(
          KeyEventResult.ignored,
          'The handler did nothing. Dispatch continues up the Focus tree and ultimately '
          'lets the platform handle the key normally.',
          _kAccentOrange,
        ),
        _resultCard(
          KeyEventResult.skipRemainingHandlers,
          'Stop calling any further onKeyEvent callbacks for this event but allow it to '
          'reach the platform (i.e. let the OS show its IME / type a character).',
          _kAccentRed,
        ),
        const SizedBox(height: 12.0),
        Container(
          height: 220.0,
          decoration: BoxDecoration(
            color: const Color(0xFFFAFBFF),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline),
          ),
          child: const CustomPaint(
            painter: _FocusFlowPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'The flow: HardwareKeyboard dispatches to FocusManager, which walks the focus '
          'chain calling Focus.onKeyEvent for each ancestor. Each callback returns one of '
          'the KeyEventResult values shown above.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - CODE-BLOCK CARDS
  // -------------------------------------------------------------------------
  final Widget codeFocusBlock = _codeBlock(
    title: 'focus_on_key_event.dart',
    '''Focus(
  autofocus: true,
  onKeyEvent: (FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.escape) {
      _close();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  },
  child: const _MyEditor(),
);''',
  );

  final Widget codeHardwareBlock = _codeBlock(
    title: 'hardware_keyboard_isPressed.dart',
    '''// Query state directly at any time - no listener required.
final bool isCtrlDown = HardwareKeyboard.instance
    .isLogicalKeyPressed(LogicalKeyboardKey.controlLeft) ||
  HardwareKeyboard.instance
    .isLogicalKeyPressed(LogicalKeyboardKey.controlRight);

if (isCtrlDown && event.logicalKey == LogicalKeyboardKey.keyS) {
  _save();
}''',
  );

  final Widget codeShortcutsBlock = _codeBlock(
    title: 'shortcuts_intents.dart',
    '''Shortcuts(
  shortcuts: <ShortcutActivator, Intent>{
    const SingleActivator(LogicalKeyboardKey.keyS, control: true):
        const SaveIntent(),
    const SingleActivator(LogicalKeyboardKey.keyZ, control: true):
        const UndoIntent(),
    const SingleActivator(LogicalKeyboardKey.keyZ, control: true, shift: true):
        const RedoIntent(),
  },
  child: Actions(
    actions: <Type, Action<Intent>>{
      SaveIntent: CallbackAction<SaveIntent>(onInvoke: (_) => _save()),
    },
    child: const _Document(),
  ),
);''',
  );

  final Widget codeRawBlock = _codeBlock(
    title: 'raw_keyboard_listener_legacy.dart',
    '''// LEGACY - RawKeyboardListener is deprecated.
// Kept here so older code is recognizable.
RawKeyboardListener(
  focusNode: FocusNode(),
  autofocus: true,
  onKey: (RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter) {
      _submit();
    }
  },
  child: const _MyForm(),
);

// Modern replacement: Focus(onKeyEvent: ...) returning KeyEventResult.''',
  );

  final Widget codeLockModeBlock = _codeBlock(
    title: 'lock_modes.dart',
    '''final Set<KeyboardLockMode> locks =
    HardwareKeyboard.instance.lockModesEnabled;

final bool numLockOn  = locks.contains(KeyboardLockMode.numLock);
final bool capsOn     = locks.contains(KeyboardLockMode.capsLock);
final bool scrollOn   = locks.contains(KeyboardLockMode.scrollLock);

if (capsOn) print('Caps lock is currently engaged');''',
  );

  final Widget codeGlobalBlock = _codeBlock(
    title: 'global_key_handler.dart',
    '''// Global handler - returns true to consume the event for the entire app.
bool _onKey(KeyEvent event) {
  if (event is KeyDownEvent &&
      event.logicalKey == LogicalKeyboardKey.f1) {
    _showHelp();
    return true; // consume
  }
  return false;  // let Focus tree handle it
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HardwareKeyboard.instance.addHandler(_onKey);
  runApp(const App());
}''',
  );

  final Widget codeBlocksSection = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.code, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Idiomatic usage - code snippets',
              subtitle: 'Six dark macOS-window code cards showing the keyboard API in action',
            ),
          ],
        ),
        codeFocusBlock,
        codeHardwareBlock,
        codeShortcutsBlock,
        codeRawBlock,
        codeLockModeBlock,
        codeGlobalBlock,
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - KEYBOARDLOCKMODE GALLERY
  // -------------------------------------------------------------------------
  // Three lock modes. We attempt to read the live state from
  // HardwareKeyboard.instance.lockModesEnabled but always wrap that
  // in try/catch because the d4rt test harness may not have a fully
  // bound ServicesBinding.
  Set<KeyboardLockMode> live;
  try {
    live = HardwareKeyboard.instance.lockModesEnabled;
  } catch (_) {
    live = const <KeyboardLockMode>{};
  }

  Widget _lockCard(KeyboardLockMode mode, String description, IconData icon, Color colour) {
    final bool engaged = live.contains(mode);
    return Container(
      margin: const EdgeInsets.all(6.0),
      width: 220.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colour.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: colour, size: 22.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'KeyboardLockMode.${mode.name}',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: colour,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: engaged ? _kAccentGreen.withOpacity(0.18) : _kInkTertiary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: (engaged ? _kAccentGreen : _kInkTertiary).withOpacity(0.4),
              ),
            ),
            child: Text(
              engaged ? 'engaged' : 'disabled',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: engaged ? _kAccentGreen : _kInkTertiary,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(fontSize: 12.0, color: _kInk, height: 1.4),
          ),
          const SizedBox(height: 6.0),
          Text(
            'logicalKey: ${mode.logicalKey.debugName ?? mode.logicalKey.keyId}',
            style: const TextStyle(
              fontSize: 10.5,
              color: _kInkTertiary,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  final Widget lockModeGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.lock_outline, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'KeyboardLockMode',
              subtitle: 'numLock / capsLock / scrollLock - read via HardwareKeyboard.instance.lockModesEnabled',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Wrap(
          children: <Widget>[
            _lockCard(
              KeyboardLockMode.numLock,
              'Number-pad keys produce digits instead of cursor motion.',
              Icons.numbers,
              _kAccentIndigo,
            ),
            _lockCard(
              KeyboardLockMode.capsLock,
              'Letter keys produce uppercase output without holding Shift.',
              Icons.text_fields,
              _kAccentOrange,
            ),
            _lockCard(
              KeyboardLockMode.scrollLock,
              'Cursor keys scroll the document rather than moving the caret.',
              Icons.swap_vert,
              _kAccentTeal,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCodeBg,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'live lockModesEnabled.length = ${live.length}',
            style: _kCodeStyle,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - PITFALLS
  // -------------------------------------------------------------------------
  Widget _pitfall(IconData icon, String title, String body, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: tint.withOpacity(0.32)),
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
                Text(body, style: _kBodyStyle),
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
            const Icon(Icons.warning_amber_outlined, color: _kAccentOrange, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Pitfalls',
              subtitle: 'Six mistakes that bite developers wiring up keyboard handling',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _pitfall(
          Icons.history_toggle_off,
          'RawKeyboard / RawKeyEvent are deprecated',
          'Anything starting with `Raw` (RawKeyboard, RawKeyEvent, RawKeyDownEvent, '
          'RawKeyboardListener) is scheduled for removal. New code should use '
          'HardwareKeyboard, KeyEvent, KeyDownEvent and Focus(onKeyEvent:) instead.',
          _kAccentRed,
        ),
        _pitfall(
          Icons.font_download_outlined,
          'character vs logicalKey - they are not interchangeable',
          'logicalKey is a LogicalKeyboardKey identifier (== to LogicalKeyboardKey.keyA on AZERTY too). '
          'character is the Unicode string the key would have produced ("a", "A", "@"). For shortcuts '
          'use logicalKey; for displaying text-input echoes use character.',
          _kAccentOrange,
        ),
        _pitfall(
          Icons.web_asset,
          'Synthesized events on web and after focus loss',
          'When the app gains focus while a modifier was already held, Flutter emits a synthesized '
          'KeyDownEvent (event.synthesized == true) so the press/release pairing stays balanced. '
          'Make sure your handler treats synthesized events the same as real ones.',
          _kAccentIndigo,
        ),
        _pitfall(
          Icons.keyboard_capslock,
          'Shift on logicalKey is not the same as on physicalKey',
          'PhysicalKeyboardKey.shiftLeft identifies the leftmost shift hardware. '
          'LogicalKeyboardKey.shift is the abstract modifier. SingleActivator(... , shift: true) '
          'matches either left or right shift; comparing logicalKey == shiftLeft does not.',
          _kAccentGreen,
        ),
        _pitfall(
          Icons.delete_outline,
          'Forgetting to dispose Focus / FocusNode leaks listeners',
          'A Focus that subscribes to onKeyEvent indirectly holds platform resources. '
          'If the surrounding widget owns the FocusNode it must call node.dispose() in its '
          'State.dispose, otherwise the node stays registered with FocusManager forever.',
          _kAccentTeal,
        ),
        _pitfall(
          Icons.schedule,
          'Key repeat rate is platform-dependent',
          'Some platforms emit KeyRepeatEvent at the OS-configured repeat rate; '
          'others only emit a single KeyDownEvent and then a long pause before the next. '
          'For games and editors that need consistent timing, drive your own timer from the '
          'first KeyDownEvent and stop on KeyUpEvent.',
          _kAccentPink,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - FOOTER CHEAT-SHEET
  // -------------------------------------------------------------------------
  Widget _cheatGroup(String title, List<String> entries, Color tint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6.0,
                height: 14.0,
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: _kInkOnDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: <Widget>[
              for (final String e in entries)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: tint.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(999.0),
                    border: Border.all(color: tint.withOpacity(0.5)),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      color: tint,
                      fontFamily: 'monospace',
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
            Icon(Icons.bookmark_border, color: Color(0xFFFFD60A), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Keyboard cheat sheet',
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
          'flutter/services keyboard API at a glance.',
          style: TextStyle(fontSize: 12.0, color: _kInkOnDarkSecondary),
        ),
        const SizedBox(height: 12.0),
        _cheatGroup(
          'Hierarchy',
          const <String>[
            'KeyEvent',
            'KeyDownEvent',
            'KeyUpEvent',
            'KeyRepeatEvent',
          ],
          const Color(0xFF7DD3FC),
        ),
        _cheatGroup(
          'Top-level singletons',
          const <String>[
            'HardwareKeyboard.instance',
            'RawKeyboard.instance',
            'KeyEventManager (internal)',
            'ServicesBinding.keyboard',
          ],
          _kAccentGreen,
        ),
        _cheatGroup(
          'Key identifiers',
          const <String>[
            'LogicalKeyboardKey',
            'PhysicalKeyboardKey',
            'KeyboardKey (abstract base)',
            '.keyId',
            '.usbHidUsage',
            '.debugName',
            '.keyLabel',
          ],
          _kAccentAmber,
        ),
        _cheatGroup(
          'Focus integration',
          const <String>[
            'Focus(onKeyEvent:)',
            'FocusNode',
            'FocusManager',
            'KeyEventResult.handled',
            'KeyEventResult.ignored',
            'KeyEventResult.skipRemainingHandlers',
          ],
          _kAccentOrange,
        ),
        _cheatGroup(
          'Shortcuts / Intents',
          const <String>[
            'Shortcuts(shortcuts:)',
            'Actions(actions:)',
            'SingleActivator(LogicalKeyboardKey, control:, shift:, alt:, meta:)',
            'CharacterActivator',
            'Intent / Action<Intent>',
          ],
          _kAccentIndigo,
        ),
        _cheatGroup(
          'Lock modes',
          const <String>[
            'KeyboardLockMode.numLock',
            'KeyboardLockMode.capsLock',
            'KeyboardLockMode.scrollLock',
            'lockModesEnabled',
          ],
          _kAccentPink,
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF20242F),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairlineDark),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.bolt, color: Color(0xFFFFD60A), size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Prefer HardwareKeyboard + Focus(onKeyEvent:) + Shortcuts/Actions. '
                  'Avoid RawKeyboard, RawKeyEvent and RawKeyboardListener - all deprecated.',
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
  print('  building widget tree with 11 sections');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(2, 'KeyEvent Hierarchy', 'KeyEvent / KeyDownEvent / KeyUpEvent / KeyRepeatEvent'),
    hierarchyCard,
    _sectionHeader(3, 'KeyEvent Payload Table', 'Six concrete events constructed literally'),
    payloadTable,
    _sectionHeader(4, 'LogicalKeyboardKey Gallery', '30+ keys grouped by category'),
    logicalGallery,
    _sectionHeader(5, 'PhysicalKeyboardKey Gallery', '24 USB-HID-coded physical key slots'),
    physicalGallery,
    _sectionDivider(),
    _sectionHeader(6, 'RawKeyboard vs HardwareKeyboard', 'Modern singleton vs deprecated listener API'),
    comparisonTable,
    _sectionHeader(7, 'KeyEventResult', 'handled / ignored / skipRemainingHandlers'),
    resultShowcase,
    _sectionHeader(8, 'Code Snippets', 'Six idiomatic usage cards'),
    codeBlocksSection,
    _sectionHeader(9, 'KeyboardLockMode', 'numLock / capsLock / scrollLock'),
    lockModeGallery,
    _sectionHeader(10, 'Pitfalls', 'Six classic keyboard-handling mistakes'),
    pitfalls,
    _sectionHeader(11, 'Cheat Sheet', 'Constants and constructors at a glance'),
    cheatSheet,
  ];
  print('  section widget count: ${sectionWidgets.length}');

  final Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _kAccent,
      scaffoldBackgroundColor: _kCanvas,
      colorScheme: ColorScheme.fromSeed(seedColor: _kAccent),
    ),
    home: Scaffold(
      backgroundColor: _kCanvas,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0.0,
        foregroundColor: _kInk,
        title: const Text(
          'Flutter Keyboard - services',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: _kInk,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sectionWidgets,
        ),
      ),
    ),
  );

  print('Services keyboard deep visual demo built successfully');
  return app;
}
