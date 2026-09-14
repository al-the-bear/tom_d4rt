// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// Visual deep demo: TextSelectionGestureDetectorBuilder
// Subject: the abstract scaffolding that wires a text editing widget to
// platform gesture handlers (single-tap, double-tap, long-press,
// force-press, drag-select). Hand-drawn diagrams and panels.

import 'package:flutter/material.dart';

// ============================================================================
// PALETTE
// ============================================================================

const Color _kInk = Color(0xFF161A24);
const Color _kInkSoft = Color(0xFF374050);
const Color _kPaper = Color(0xFFF6F1E6);
const Color _kPaperWarm = Color(0xFFEEE4D2);
const Color _kAccent = Color(0xFFCB4B26);
const Color _kAccent2 = Color(0xFF2C7A7B);
const Color _kAccent3 = Color(0xFF8C5BBE);
const Color _kAccent4 = Color(0xFFD4A017);
const Color _kCursor = Color(0xFF1F6FEB);
const Color _kSelection = Color(0xFF93C5FD);
const Color _kStroke = Color(0xFF1F2433);

// ============================================================================
// PRIMITIVES
// ============================================================================

Widget _privatechip(String label, Color bg, {Color fg = _kInk}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      border: Border.all(color: _kInk, width: 1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: fg,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _privatesectionBanner(String index, String title, String subtitle, Color color) {
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 24, 0, 12),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      border: Border.all(color: _kInk, width: 2),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: _kInk, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            index,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: _kInk.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _privatecard({required Widget child, Color? bg, EdgeInsets? padding}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: padding ?? const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: bg ?? _kPaper,
      border: Border.all(color: _kInk, width: 1.4),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: _kInk.withValues(alpha: 0.10),
          offset: const Offset(3, 3),
          blurRadius: 0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _privatemonoLine(String text, {Color color = _kInk, double size = 12, FontWeight weight = FontWeight.w500}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: size,
        color: color,
        fontWeight: weight,
        height: 1.35,
      ),
    ),
  );
}

Widget _privatelabel(String text, {Color color = _kInk, double size = 13, FontWeight w = FontWeight.w800}) {
  return Text(
    text,
    style: TextStyle(fontSize: size, fontWeight: w, color: color),
  );
}

Widget _privatebody(String text, {Color? color, double size = 12.5}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color ?? _kInkSoft,
      height: 1.45,
    ),
  );
}

// ============================================================================
// HERO
// ============================================================================

class _PrivateHeroPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paper = Paint()..color = _kPaperWarm;
    canvas.drawRect(Offset.zero & size, paper);

    // grid
    final grid = Paint()
      ..color = _kInk.withValues(alpha: 0.05)
      ..strokeWidth = 0.6;
    for (double x = 0; x < size.width; x += 18) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 18) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // text field rectangle (the EditableText surface)
    final fieldRect = Rect.fromLTWH(60, 90, size.width - 120, 70);
    final field = Paint()..color = Colors.white;
    final fieldStroke = Paint()
      ..color = _kInk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final rrect = RRect.fromRectAndRadius(fieldRect, const Radius.circular(8));
    canvas.drawRRect(rrect, field);
    canvas.drawRRect(rrect, fieldStroke);

    // text glyphs in field
    final glyph = Paint()
      ..color = _kInk
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    double tx = fieldRect.left + 14;
    final ty = fieldRect.top + 38;
    for (int i = 0; i < 18; i++) {
      final w = 8.0 + (i % 4) * 2.0;
      canvas.drawLine(Offset(tx, ty), Offset(tx + w, ty), glyph);
      tx += w + 6;
    }

    // cursor at character 7
    final cursorX = fieldRect.left + 110;
    final cursor = Paint()
      ..color = _kCursor
      ..strokeWidth = 2.4;
    canvas.drawLine(
      Offset(cursorX, fieldRect.top + 18),
      Offset(cursorX, fieldRect.bottom - 18),
      cursor,
    );

    // finger / hand approaching
    final fingerCx = cursorX + 6;
    final fingerCy = fieldRect.bottom + 90;
    final skin = Paint()..color = const Color(0xFFF5C6A0);
    final skinStroke = Paint()
      ..color = _kInk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // hand palm
    final palm = RRect.fromRectAndRadius(
      Rect.fromLTWH(fingerCx - 28, fingerCy + 10, 70, 60),
      const Radius.circular(18),
    );
    canvas.drawRRect(palm, skin);
    canvas.drawRRect(palm, skinStroke);

    // index finger pointing up at cursor
    final finger = RRect.fromRectAndRadius(
      Rect.fromLTWH(fingerCx - 9, fieldRect.bottom + 5, 18, 90),
      const Radius.circular(9),
    );
    canvas.drawRRect(finger, skin);
    canvas.drawRRect(finger, skinStroke);

    // finger tip touching field bottom
    final tipPaint = Paint()..color = _kAccent.withValues(alpha: 0.4);
    canvas.drawCircle(Offset(fingerCx, fieldRect.bottom + 4), 14, tipPaint);
    canvas.drawCircle(
      Offset(fingerCx, fieldRect.bottom + 4),
      14,
      Paint()
        ..color = _kAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    // ripple
    for (int r = 1; r <= 3; r++) {
      canvas.drawCircle(
        Offset(fingerCx, fieldRect.bottom + 4),
        14.0 + r * 9,
        Paint()
          ..color = _kAccent.withValues(alpha: 0.4 - r * 0.1)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
    }

    // arrow from tap to cursor
    final arrow = Paint()
      ..color = _kAccent2
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(fingerCx, fieldRect.bottom + 4)
      ..quadraticBezierTo(
        fingerCx + 30,
        fieldRect.bottom - 10,
        cursorX,
        fieldRect.bottom - 6,
      );
    canvas.drawPath(path, arrow);

    // arrowhead
    canvas.drawLine(
      Offset(cursorX, fieldRect.bottom - 6),
      Offset(cursorX - 6, fieldRect.bottom - 12),
      arrow,
    );
    canvas.drawLine(
      Offset(cursorX, fieldRect.bottom - 6),
      Offset(cursorX + 4, fieldRect.bottom - 14),
      arrow,
    );

    // title text marker
    final titlePaint = TextPainter(
      text: TextSpan(
        text: 'tap → cursor positioning',
        style: TextStyle(
          fontFamily: 'monospace',
          color: _kInk,
          fontSize: 13,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    titlePaint.paint(canvas, Offset(60, 30));

    final subPaint = TextPainter(
      text: TextSpan(
        text: 'TextSelectionGestureDetectorBuilder routes the touch event',
        style: TextStyle(
          color: _kInkSoft,
          fontSize: 11,
          fontStyle: FontStyle.italic,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    subPaint.paint(canvas, Offset(60, 52));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _privatehero() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _kPaperWarm,
      border: Border.all(color: _kInk, width: 2.4),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: _kInk.withValues(alpha: 0.18),
          offset: const Offset(5, 5),
          blurRadius: 0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: _kAccent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'TextSelectionGestureDetectorBuilder',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
              _privatechip('flutter/widgets', _kAccent),
            ],
          ),
        ),
        SizedBox(
          height: 320,
          child: CustomPaint(
            painter: _PrivateHeroPainter(),
            size: Size.infinite,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(14),
          color: _kPaper,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'A toolkit that turns finger touches into text-editing semantics.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 6),
              _privatebody(
                'TextSelectionGestureDetectorBuilder is the abstract bridge sitting between '
                'a raw TextSelectionGestureDetector and a concrete editing widget. It owns '
                'the policy: which platform behaviour fires for which gesture, when the '
                'cursor moves, when the toolbar pops up, when a magnifier is shown.',
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _privatechip('abstract', _kAccent2, fg: Colors.white),
                  _privatechip('subclassable', _kAccent3, fg: Colors.white),
                  _privatechip('delegate-driven', _kAccent4),
                  _privatechip('platform-aware', _kAccent),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 — ANATOMY
// ============================================================================

Widget _privateanatomy() {
  return _privatecard(
    bg: _kPaper,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privatelabel('Anatomy of a builder', size: 16),
        const SizedBox(height: 4),
        _privatebody(
          'A subclass owns a delegate. The delegate exposes the editable text key, '
          'plus two boolean policies. The builder calls into the delegate to access '
          'the live EditableTextState and the underlying RenderEditable.',
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF2),
            border: Border.all(color: _kInk, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _privatemonoLine('class _MyBuilder extends', color: _kAccent3, weight: FontWeight.w800),
              _privatemonoLine('    TextSelectionGestureDetectorBuilder {', color: _kAccent3, weight: FontWeight.w800),
              _privatemonoLine('  _MyBuilder({required super.delegate});', color: _kInk),
              _privatemonoLine('  @override'),
              _privatemonoLine('  void onSingleTapUp(TapDragUpDetails d) {', color: _kAccent2),
              _privatemonoLine('    super.onSingleTapUp(d);'),
              _privatemonoLine('    editableText.requestKeyboard();'),
              _privatemonoLine('  }'),
              _privatemonoLine('}'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _privatemonoLine('delegate          → context provider', color: _kAccent2, weight: FontWeight.w700)),
            Expanded(child: _privatemonoLine('editableText      → live state', color: _kAccent2, weight: FontWeight.w700)),
          ],
        ),
        Row(
          children: [
            Expanded(child: _privatemonoLine('renderEditable    → layout/hit-test', color: _kAccent2, weight: FontWeight.w700)),
            Expanded(child: _privatemonoLine('shouldShowToolbar → bool getter', color: _kAccent2, weight: FontWeight.w700)),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 — METHOD GALLERY (12 cards)
// ============================================================================

class _PrivateOverride {
  final String name;
  final String signature;
  final String describe;
  final Color tint;
  final IconData icon;
  const _PrivateOverride(this.name, this.signature, this.describe, this.tint, this.icon);
}

const List<_PrivateOverride> _kOverrides = [
  _PrivateOverride(
    'onTapDown',
    'void onTapDown(TapDragDownDetails details)',
    'Pre-flight callback. Used to remember the press position before classifying the gesture.',
    _kAccent2,
    Icons.touch_app,
  ),
  _PrivateOverride(
    'onSingleTapUp',
    'void onSingleTapUp(TapDragUpDetails details)',
    'Fires on a definite single tap. Default: place the caret at the tap point and request keyboard.',
    _kAccent,
    Icons.adjust,
  ),
  _PrivateOverride(
    'onSingleTapCancel',
    'void onSingleTapCancel()',
    'A tap was identified but dismissed (drag started, etc.). Last chance to roll back optimistic UI.',
    _kAccent3,
    Icons.cancel,
  ),
  _PrivateOverride(
    'onSingleLongTapStart',
    'void onSingleLongTapStart(LongPressStartDetails details)',
    'iOS: shows a magnifier. Android: starts word selection. Use to enable contextual UI.',
    _kAccent4,
    Icons.search,
  ),
  _PrivateOverride(
    'onSingleLongTapMoveUpdate',
    'void onSingleLongTapMoveUpdate(LongPressMoveUpdateDetails details)',
    'Finger drags during long-press. Default: extend selection with hapticless precision.',
    _kAccent2,
    Icons.swap_horiz,
  ),
  _PrivateOverride(
    'onSingleLongTapEnd',
    'void onSingleLongTapEnd(LongPressEndDetails details)',
    'Finger lifted after long-press. Default: hide magnifier, show selection toolbar.',
    _kAccent,
    Icons.stop_circle_outlined,
  ),
  _PrivateOverride(
    'onDoubleTapDown',
    'void onDoubleTapDown(TapDragDownDetails details)',
    'Two taps within the kDoubleTapTimeout. Default: select the word at the tap.',
    _kAccent3,
    Icons.exposure_plus_2,
  ),
  _PrivateOverride(
    'onForcePressStart',
    'void onForcePressStart(ForcePressDetails details)',
    'iOS only — pressure exceeds threshold. Default: show magnifier and start word selection.',
    _kAccent4,
    Icons.compress,
  ),
  _PrivateOverride(
    'onForcePressEnd',
    'void onForcePressEnd(ForcePressDetails details)',
    'Pressure released. Default: dismiss magnifier and reveal toolbar.',
    _kAccent4,
    Icons.expand,
  ),
  _PrivateOverride(
    'onDragSelectionStart',
    'void onDragSelectionStart(DragStartDetails details)',
    'Mouse drag begins. Default: collapse caret to the drag origin and prepare to extend.',
    _kAccent2,
    Icons.mouse,
  ),
  _PrivateOverride(
    'onDragSelectionUpdate',
    'void onDragSelectionUpdate(DragStartDetails s, DragUpdateDetails u)',
    'Drag continues. Default: extend the selection from origin to current pointer.',
    _kAccent,
    Icons.timeline,
  ),
  _PrivateOverride(
    'onDragSelectionEnd',
    'void onDragSelectionEnd(DragEndDetails details)',
    'Mouse drag ends. Default: finalize selection and show toolbar if non-empty.',
    _kAccent3,
    Icons.flag,
  ),
];

Widget _privateoverrideCard(_PrivateOverride o, int index) {
  return Container(
    width: 290,
    margin: const EdgeInsets.only(right: 12, bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: o.tint.withValues(alpha: 0.10),
      border: Border.all(color: _kInk, width: 1.4),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: _kInk.withValues(alpha: 0.10),
          offset: const Offset(2, 2),
          blurRadius: 0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: o.tint,
                border: Border.all(color: _kInk, width: 1.4),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Icon(o.icon, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    o.name,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: _kInk,
                    ),
                  ),
                  Text(
                    '#${(index + 1).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 10,
                      color: _kInk.withValues(alpha: 0.55),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _kInk, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            o.signature,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: _kInk,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          o.describe,
          style: TextStyle(
            fontSize: 12,
            color: _kInkSoft,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _privateoverrideGallery() {
  final cards = <Widget>[];
  for (int i = 0; i < _kOverrides.length; i++) {
    cards.add(_privateoverrideCard(_kOverrides[i], i));
  }
  return _privatecard(
    bg: _kPaperWarm,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privatelabel('Method-override gallery — twelve hooks you can reach for', size: 16),
        const SizedBox(height: 4),
        _privatebody(
          'These are the building blocks of any custom selection policy. '
          'Each card shows the signature on the platform-correct details type '
          'and what calling super gives you for free.',
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 0,
          runSpacing: 0,
          children: cards,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4 — DELEGATE INTERFACE
// ============================================================================

Widget _privatedelegatePanel() {
  return _privatecard(
    bg: const Color(0xFFEAF1FB),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _kCursor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _kInk, width: 1.4),
              ),
              child: const Icon(Icons.handshake, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'TextSelectionGestureDetectorBuilderDelegate',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: _kInk,
                ),
              ),
            ),
            _privatechip('abstract', _kAccent3, fg: Colors.white),
          ],
        ),
        const SizedBox(height: 10),
        _privatebody(
          'The delegate is the glue between the builder and the live editing '
          'widget. It exposes a key, then the policy flags the builder needs '
          'to short-circuit gestures it should never handle.',
        ),
        const SizedBox(height: 12),
        _privatedelegateRow(
          'editableTextKey',
          'GlobalKey<EditableTextState>',
          'Lets the builder reach into the running EditableText: cursor, '
          'selection, hideToolbar, showAutocorrect, requestKeyboard.',
          _kAccent2,
        ),
        _privatedelegateRow(
          'forcePressEnabled',
          'bool',
          'Gates onForcePressStart / onForcePressEnd. Set false on Android '
          'and on platforms without pressure-sensitive input.',
          _kAccent4,
        ),
        _privatedelegateRow(
          'selectionEnabled',
          'bool',
          'Master switch. When false, the builder collapses gestures to '
          'caret-positioning only — long-press never selects words.',
          _kAccent,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFCF2),
            border: Border.all(color: _kInk, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _privatemonoLine('// Default delegate body', color: _kInkSoft),
              _privatemonoLine('GlobalKey<EditableTextState> get editableTextKey;'),
              _privatemonoLine('bool get forcePressEnabled;'),
              _privatemonoLine('bool get selectionEnabled;'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _privatedelegateRow(String name, String type, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _kInk, width: 1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      color: _kInk,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    type,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 12,
                  color: _kInkSoft,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5 — TIMELINE
// ============================================================================

class _PrivateTimelinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFFFFCF2),
    );

    final axis = Paint()
      ..color = _kInk
      ..strokeWidth = 1.6;
    final yMid = size.height / 2;
    canvas.drawLine(Offset(20, yMid), Offset(size.width - 20, yMid), axis);
    // ticks
    for (int i = 0; i <= 6; i++) {
      final x = 20 + (size.width - 40) * i / 6;
      canvas.drawLine(Offset(x, yMid - 5), Offset(x, yMid + 5), axis);
    }

    void label(double x, double y, String s, Color c, {bool below = false}) {
      final tp = TextPainter(
        text: TextSpan(
          text: s,
          style: TextStyle(
            fontSize: 11,
            color: c,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, below ? y + 8 : y - tp.height - 8));
    }

    void event(double x, Color c, IconData _) {
      canvas.drawCircle(Offset(x, yMid), 8, Paint()..color = c);
      canvas.drawCircle(
        Offset(x, yMid),
        8,
        Paint()
          ..color = _kInk
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
    }

    // single tap
    final x1 = 20 + (size.width - 40) * 1 / 6;
    event(x1, _kAccent, Icons.touch_app);
    label(x1, yMid, 'tapDown', _kAccent);
    label(x1, yMid, 'caret moves', _kInkSoft, below: true);

    // single tap up
    final x2 = 20 + (size.width - 40) * 2 / 6;
    event(x2, _kAccent2, Icons.adjust);
    label(x2, yMid, 'singleTapUp', _kAccent2);
    label(x2, yMid, 'keyboard request', _kInkSoft, below: true);

    // double tap
    final x3 = 20 + (size.width - 40) * 3 / 6;
    event(x3, _kAccent3, Icons.exposure_plus_2);
    label(x3, yMid, 'doubleTapDown', _kAccent3);
    label(x3, yMid, 'word selected', _kInkSoft, below: true);

    // long-press start
    final x4 = 20 + (size.width - 40) * 4 / 6;
    event(x4, _kAccent4, Icons.search);
    label(x4, yMid, 'longTapStart', _kAccent4);
    label(x4, yMid, 'magnifier on', _kInkSoft, below: true);

    // long-press end
    final x5 = 20 + (size.width - 40) * 5 / 6;
    event(x5, _kAccent, Icons.stop_circle_outlined);
    label(x5, yMid, 'longTapEnd', _kAccent);
    label(x5, yMid, 'toolbar shown', _kInkSoft, below: true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _privatetimeline() {
  return _privatecard(
    bg: _kPaper,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privatelabel('Gesture timeline — what fires, in order, on a typical session', size: 16),
        const SizedBox(height: 6),
        SizedBox(
          height: 130,
          child: CustomPaint(
            painter: _PrivateTimelinePainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 8),
        _privatebody(
          'The same builder routes all five events. Each handler may call super '
          'or replace the default. The ordering is enforced by the underlying '
          'TextSelectionGestureDetector, not by your subclass.',
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 6 — SIDE-BY-SIDE FROZEN FRAMES (six gestures)
// ============================================================================

class _PrivateFramePainter extends CustomPainter {
  final String label;
  final int caretIndex;
  final int? selectStart;
  final int? selectEnd;
  final Color caretColor;
  final bool magnifier;
  final bool toolbar;

  _PrivateFramePainter({
    required this.label,
    required this.caretIndex,
    this.selectStart,
    this.selectEnd,
    this.caretColor = _kCursor,
    this.magnifier = false,
    this.toolbar = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.white);
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..color = _kInk
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4,
    );

    // sample text "Hello, World!" mock
    final glyphs = 'Hello, World!'.length;
    const gw = 14.0;
    final ty = size.height / 2;
    final startX = 18.0;

    // selection background
    if (selectStart != null && selectEnd != null) {
      final sx = startX + selectStart! * gw;
      final ex = startX + selectEnd! * gw;
      canvas.drawRect(
        Rect.fromLTRB(sx, ty - 12, ex, ty + 12),
        Paint()..color = _kSelection.withValues(alpha: 0.6),
      );
    }

    // glyph strokes
    final glyphPaint = Paint()
      ..color = _kInk
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < glyphs; i++) {
      final x = startX + i * gw;
      canvas.drawLine(Offset(x + 2, ty + 4), Offset(x + 8, ty + 4), glyphPaint);
      canvas.drawLine(Offset(x + 5, ty + 4), Offset(x + 5, ty - 6), glyphPaint);
    }

    // caret
    final cx = startX + caretIndex * gw;
    canvas.drawLine(
      Offset(cx, ty - 14),
      Offset(cx, ty + 14),
      Paint()
        ..color = caretColor
        ..strokeWidth = 2.4,
    );

    // toolbar
    if (toolbar) {
      final toolbar = RRect.fromRectAndRadius(
        Rect.fromLTWH(startX + 10, 6, 110, 22),
        const Radius.circular(4),
      );
      canvas.drawRRect(toolbar, Paint()..color = _kInk);
      final tp = TextPainter(
        text: const TextSpan(
          text: 'Cut  Copy  Paste',
          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(startX + 18, 10));
    }

    // magnifier
    if (magnifier) {
      final mx = cx;
      final my = ty - 38;
      canvas.drawCircle(Offset(mx, my), 16, Paint()..color = const Color(0xFFFFFCF2));
      canvas.drawCircle(
        Offset(mx, my),
        16,
        Paint()
          ..color = _kInk
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6,
      );
      // reflected glyphs
      final smallGlyph = Paint()
        ..color = _kInk
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      for (int i = -2; i <= 2; i++) {
        canvas.drawLine(
          Offset(mx + i * 4 - 2, my + 2),
          Offset(mx + i * 4 + 2, my + 2),
          smallGlyph,
        );
      }
      // tail
      final path = Path()
        ..moveTo(mx - 6, my + 12)
        ..lineTo(mx, my + 24)
        ..lineTo(mx + 6, my + 12);
      canvas.drawPath(path, Paint()..color = const Color(0xFFFFFCF2));
      canvas.drawPath(
        path,
        Paint()
          ..color = _kInk
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
    }

    // label
    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: _kInk,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(8, size.height - 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _privateframe({
  required String title,
  required String before,
  required String after,
  required _PrivateFramePainter beforePainter,
  required _PrivateFramePainter afterPainter,
  required Color tint,
  required IconData icon,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.08),
      border: Border.all(color: _kInk, width: 1.4),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: tint, size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: _kInk,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _privatechip('before', _kInk.withValues(alpha: 0.1)),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 90,
                    child: CustomPaint(painter: beforePainter, size: Size.infinite),
                  ),
                  const SizedBox(height: 6),
                  _privatebody(before, size: 11.5),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 22,
              height: 90,
              alignment: Alignment.center,
              child: Icon(Icons.arrow_forward, color: tint, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _privatechip('after', tint.withValues(alpha: 0.3)),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 90,
                    child: CustomPaint(painter: afterPainter, size: Size.infinite),
                  ),
                  const SizedBox(height: 6),
                  _privatebody(after, size: 11.5),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _privateframes() {
  return _privatecard(
    bg: _kPaperWarm,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privatelabel('Six gestures — frozen frames (before / after)', size: 16),
        const SizedBox(height: 4),
        _privatebody(
          'Each pair shows the editable surface immediately before the touch '
          'lands and the resulting state once the matching builder hook returns.',
        ),
        const SizedBox(height: 12),
        _privateframe(
          title: 'Single tap up — caret positioning',
          before: 'Caret rests at column 0. The user is about to tap between H and e.',
          after: 'Caret jumps to column 1. Keyboard requested. Default super behaviour.',
          beforePainter: _PrivateFramePainter(label: 'caret @ 0', caretIndex: 0),
          afterPainter: _PrivateFramePainter(label: 'caret @ 1', caretIndex: 1, caretColor: _kAccent2),
          tint: _kAccent2,
          icon: Icons.adjust,
        ),
        _privateframe(
          title: 'Double tap down — word selection',
          before: 'Caret is loose. The user double-taps within the word "World".',
          after: 'The word "World" is selected. Toolbar offered to copy/cut.',
          beforePainter: _PrivateFramePainter(label: 'no selection', caretIndex: 7),
          afterPainter: _PrivateFramePainter(
            label: 'word selected',
            caretIndex: 12,
            selectStart: 7,
            selectEnd: 12,
            toolbar: true,
            caretColor: _kAccent3,
          ),
          tint: _kAccent3,
          icon: Icons.exposure_plus_2,
        ),
        _privateframe(
          title: 'Single long-tap start — magnifier',
          before: 'Finger is pressed and held at column 5.',
          after: 'Magnifier appears, caret follows precise pixel position.',
          beforePainter: _PrivateFramePainter(label: 'pressed', caretIndex: 5),
          afterPainter: _PrivateFramePainter(
            label: 'magnified',
            caretIndex: 5,
            magnifier: true,
            caretColor: _kAccent4,
          ),
          tint: _kAccent4,
          icon: Icons.search,
        ),
        _privateframe(
          title: 'Single long-tap end — toolbar',
          before: 'Magnifier still visible. Finger about to lift.',
          after: 'Magnifier dismissed. Toolbar appears at the selection.',
          beforePainter: _PrivateFramePainter(label: 'lifting', caretIndex: 5, magnifier: true),
          afterPainter: _PrivateFramePainter(
            label: 'toolbar',
            caretIndex: 5,
            toolbar: true,
            caretColor: _kAccent,
          ),
          tint: _kAccent,
          icon: Icons.stop_circle_outlined,
        ),
        _privateframe(
          title: 'Force press start (iOS) — pressure threshold',
          before: 'Light press: nothing fires.',
          after: 'Pressure exceeds threshold: magnifier opens at the press point.',
          beforePainter: _PrivateFramePainter(label: 'soft press', caretIndex: 9),
          afterPainter: _PrivateFramePainter(
            label: 'force press',
            caretIndex: 9,
            magnifier: true,
            caretColor: _kAccent2,
          ),
          tint: _kAccent2,
          icon: Icons.compress,
        ),
        _privateframe(
          title: 'Drag selection update — mouse drag',
          before: 'Mouse pressed at column 0, no selection yet.',
          after: 'Selection extended to column 5 as the cursor drags.',
          beforePainter: _PrivateFramePainter(label: 'drag start', caretIndex: 0),
          afterPainter: _PrivateFramePainter(
            label: 'drag updated',
            caretIndex: 5,
            selectStart: 0,
            selectEnd: 5,
            caretColor: _kAccent3,
          ),
          tint: _kAccent3,
          icon: Icons.timeline,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7 — PLATFORM TABLE
// ============================================================================

Widget _privateplatformRow(String gesture, String ios, String android, String macos, String linux, Color tint) {
  return Container(
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.08),
      border: Border(
        bottom: BorderSide(color: _kInk.withValues(alpha: 0.2), width: 1),
      ),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            gesture,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: _kInk,
            ),
          ),
        ),
        _privateplatformCell(ios),
        _privateplatformCell(android),
        _privateplatformCell(macos),
        _privateplatformCell(linux),
      ],
    ),
  );
}

Widget _privateplatformCell(String text) {
  return Expanded(
    flex: 2,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 10.5,
        color: _kInkSoft,
        height: 1.35,
      ),
      textAlign: TextAlign.left,
    ),
  );
}

Widget _privateplatformTable() {
  return _privatecard(
    bg: _kPaper,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privatelabel('Platform comparison — what each gesture means by OS', size: 16),
        const SizedBox(height: 4),
        _privatebody(
          'Each platform routes raw input differently through the builder. '
          'Force-press is iOS-only; long-press dominates Android; mouse-drag '
          'is the native desktop primitive.',
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: _kInk,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: const [
              Expanded(
                flex: 3,
                child: Text(
                  'gesture',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11),
                ),
              ),
              Expanded(flex: 2, child: Text('iOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11))),
              Expanded(flex: 2, child: Text('Android', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11))),
              Expanded(flex: 2, child: Text('macOS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11))),
              Expanded(flex: 2, child: Text('Linux', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11))),
            ],
          ),
        ),
        _privateplatformRow(
          'single tap',
          'caret jumps + keyboard',
          'caret jumps + keyboard',
          'caret jumps',
          'caret jumps',
          _kAccent2,
        ),
        _privateplatformRow(
          'double tap',
          'select word',
          'select word',
          'select word',
          'select word',
          _kAccent3,
        ),
        _privateplatformRow(
          'long press',
          'magnifier + collapse',
          'select word + toolbar',
          'no-op',
          'no-op',
          _kAccent4,
        ),
        _privateplatformRow(
          'force press',
          'magnifier + select',
          'unsupported',
          'unsupported',
          'unsupported',
          _kAccent,
        ),
        _privateplatformRow(
          'mouse drag',
          'n/a',
          'n/a',
          'extend selection',
          'extend selection',
          _kCursor,
        ),
        _privateplatformRow(
          'triple tap',
          'select line',
          'select paragraph',
          'select line',
          'select line',
          _kAccent3,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 8 — CODE LISTING (subclass)
// ============================================================================

Widget _privatecodeListing() {
  return _privatecard(
    bg: _kInk,
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.code, color: Colors.white, size: 22),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                '// _PrivateMyGestureBuilder.dart',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
            _privatechip('subclass', _kAccent),
          ],
        ),
        const SizedBox(height: 12),
        const _PrivateCodeLine('// A custom builder that auto-selects the word', _kInkSoft),
        const _PrivateCodeLine('// on every single tap (instead of just placing the caret).', _kInkSoft),
        SizedBox(height: 8),
        const _PrivateCodeLine('class _PrivateMyGestureBuilder extends', Color(0xFFFFB454)),
        const _PrivateCodeLine('    TextSelectionGestureDetectorBuilder {', Color(0xFFFFB454)),
        const _PrivateCodeLine('  _PrivateMyGestureBuilder({', Colors.white),
        const _PrivateCodeLine('    required _PrivateState state,', Colors.white),
        const _PrivateCodeLine('  })  : _state = state,', Colors.white),
        const _PrivateCodeLine('        super(delegate: state);', Colors.white),
        SizedBox(height: 4),
        const _PrivateCodeLine('  final _PrivateState _state;', Color(0xFFC4F1D5)),
        SizedBox(height: 8),
        const _PrivateCodeLine('  @override', Color(0xFF93C5FD)),
        const _PrivateCodeLine('  void onSingleTapUp(TapDragUpDetails details) {', Colors.white),
        const _PrivateCodeLine('    // 1. let the parent place the caret', _kInkSoft),
        const _PrivateCodeLine('    super.onSingleTapUp(details);', Colors.white),
        SizedBox(height: 4),
        const _PrivateCodeLine('    // 2. then auto-select the surrounding word', _kInkSoft),
        const _PrivateCodeLine('    if (delegate.selectionEnabled) {', Colors.white),
        const _PrivateCodeLine('      renderEditable.selectWord(cause: SelectionChangedCause.tap);', Colors.white),
        const _PrivateCodeLine('    }', Colors.white),
        SizedBox(height: 4),
        const _PrivateCodeLine('    // 3. force the toolbar', _kInkSoft),
        const _PrivateCodeLine('    if (shouldShowSelectionToolbar) {', Colors.white),
        const _PrivateCodeLine('      editableText.showToolbar();', Colors.white),
        const _PrivateCodeLine('    }', Colors.white),
        const _PrivateCodeLine('  }', Colors.white),
        SizedBox(height: 8),
        const _PrivateCodeLine('  @override', Color(0xFF93C5FD)),
        const _PrivateCodeLine('  void onDoubleTapDown(TapDragDownDetails details) {', Colors.white),
        const _PrivateCodeLine('    // already selected on single tap, so collapse here', _kInkSoft),
        const _PrivateCodeLine('    renderEditable.handleTapDown(details: details);', Colors.white),
        const _PrivateCodeLine('  }', Colors.white),
        SizedBox(height: 8),
        const _PrivateCodeLine('  @override', Color(0xFF93C5FD)),
        const _PrivateCodeLine('  void onSingleLongTapStart(LongPressStartDetails details) {', Colors.white),
        const _PrivateCodeLine('    // disable the magnifier — show toolbar straight away', _kInkSoft),
        const _PrivateCodeLine('    super.onSingleLongTapStart(details);', Colors.white),
        const _PrivateCodeLine('    editableText.hideMagnifier();', Colors.white),
        const _PrivateCodeLine('    editableText.showToolbar();', Colors.white),
        const _PrivateCodeLine('  }', Colors.white),
        SizedBox(height: 4),
        const _PrivateCodeLine('}', Color(0xFFFFB454)),
        SizedBox(height: 12),
        const _PrivateCodeLine('// Wire it into your widget tree:', _kInkSoft),
        const _PrivateCodeLine('Widget build(BuildContext context) {', Colors.white),
        const _PrivateCodeLine('  return _builder.buildGestureDetector(', Colors.white),
        const _PrivateCodeLine('    behavior: HitTestBehavior.translucent,', Colors.white),
        const _PrivateCodeLine('    child: EditableText(', Colors.white),
        const _PrivateCodeLine('      key: _state.editableTextKey,', Colors.white),
        const _PrivateCodeLine('      controller: _state.controller,', Colors.white),
        const _PrivateCodeLine('      // ...', _kInkSoft),
        const _PrivateCodeLine('    ),', Colors.white),
        const _PrivateCodeLine('  );', Colors.white),
        const _PrivateCodeLine('}', Colors.white),
      ],
    ),
  );
}

class _PrivateCodeLine extends StatelessWidget {
  final String text;
  final Color color;
  const _PrivateCodeLine(this.text, this.color);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: color,
          height: 1.4,
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 9 — RELATIONSHIP MAP
// ============================================================================

class _PrivateRelationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFFFFFCF2));

    void node(Rect r, Color color, String title, String sub) {
      canvas.drawRect(r, Paint()..color = color.withValues(alpha: 0.16));
      canvas.drawRect(
        r,
        Paint()
          ..color = _kInk
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
      final t1 = TextPainter(
        text: TextSpan(
          text: title,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.5,
            fontWeight: FontWeight.w900,
            color: _kInk,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: r.width - 8);
      t1.paint(canvas, Offset(r.left + 6, r.top + 6));
      final t2 = TextPainter(
        text: TextSpan(
          text: sub,
          style: const TextStyle(fontSize: 10, color: _kInkSoft),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: r.width - 8);
      t2.paint(canvas, Offset(r.left + 6, r.top + 22));
    }

    void arrow(Offset a, Offset b, Color color, {String? mid}) {
      final p = Paint()
        ..color = color
        ..strokeWidth = 1.6
        ..style = PaintingStyle.stroke;
      canvas.drawLine(a, b, p);
      // arrowhead
      final dir = (b - a);
      final len = dir.distance;
      if (len > 0) {
        final ux = dir.dx / len;
        final uy = dir.dy / len;
        canvas.drawLine(
          b,
          Offset(b.dx - ux * 8 - uy * 4, b.dy - uy * 8 + ux * 4),
          p,
        );
        canvas.drawLine(
          b,
          Offset(b.dx - ux * 8 + uy * 4, b.dy - uy * 8 - ux * 4),
          p,
        );
      }
      if (mid != null) {
        final mp = Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2);
        final tp = TextPainter(
          text: TextSpan(
            text: mid,
            style: TextStyle(
              fontSize: 9.5,
              color: color,
              fontWeight: FontWeight.w800,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        canvas.drawRect(
          Rect.fromCenter(center: mp, width: tp.width + 8, height: tp.height + 4),
          Paint()..color = const Color(0xFFFFFCF2),
        );
        tp.paint(canvas, Offset(mp.dx - tp.width / 2, mp.dy - tp.height / 2));
      }
    }

    final tf = Rect.fromLTWH(20, 30, 150, 50);
    final st = Rect.fromLTWH(20, 130, 150, 50);
    final builder = Rect.fromLTWH(220, 80, 200, 60);
    final delegate = Rect.fromLTWH(470, 30, 180, 50);
    final detector = Rect.fromLTWH(470, 130, 180, 50);

    node(tf, _kAccent2, 'TextField', 'composes builder');
    node(st, _kAccent3, 'SelectableText', 'also composes');
    node(builder, _kAccent, 'GestureDetectorBuilder', 'this widget');
    node(delegate, _kAccent4, 'Delegate', 'editableTextKey + flags');
    node(detector, _kCursor, 'GestureDetector', 'low-level wrapper');

    arrow(
      Offset(tf.right, tf.center.dy),
      Offset(builder.left, builder.center.dy - 6),
      _kAccent2,
      mid: 'uses',
    );
    arrow(
      Offset(st.right, st.center.dy),
      Offset(builder.left, builder.center.dy + 8),
      _kAccent3,
      mid: 'uses',
    );
    arrow(
      Offset(builder.right, builder.center.dy - 6),
      Offset(delegate.left, delegate.center.dy),
      _kAccent4,
      mid: 'reads',
    );
    arrow(
      Offset(builder.right, builder.center.dy + 8),
      Offset(detector.left, detector.center.dy),
      _kCursor,
      mid: 'builds',
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _privaterelationships() {
  return _privatecard(
    bg: _kPaper,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privatelabel('Where it sits in the framework', size: 16),
        const SizedBox(height: 4),
        _privatebody(
          'TextField and SelectableText each construct an internal subclass of '
          'TextSelectionGestureDetectorBuilder, populate the delegate, and call '
          'buildGestureDetector to wrap their EditableText.',
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _PrivateRelationPainter(),
            size: Size.infinite,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 10 — PITFALLS
// ============================================================================

Widget _privatepitfall(String title, String body, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      border: Border.all(color: _kInk, width: 1.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _kInk, width: 1.4),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12,
                  color: _kInkSoft,
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

Widget _privatepitfalls() {
  return _privatecard(
    bg: _kPaperWarm,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _privatelabel('Pitfalls and gotchas', size: 16),
        const SizedBox(height: 8),
        _privatepitfall(
          'Delegate must back the editableTextKey with a live state',
          'editableText is a getter that throws when editableTextKey.currentState is null. '
          'Always assign the GlobalKey to the EditableText that lives inside the gesture detector.',
          Icons.warning_amber,
          _kAccent,
        ),
        _privatepitfall(
          'Some hooks fire only on certain platforms',
          'onForcePressStart and onForcePressEnd never fire on Android, web, '
          'or desktop. Guard custom side-effects with delegate.forcePressEnabled.',
          Icons.devices,
          _kAccent4,
        ),
        _privatepitfall(
          'shouldShowSelectionToolbar is a getter, not a setter',
          'Override the getter in your subclass; do not try to assign to it. '
          'It cooperates with the EditableText’s last interaction cause.',
          Icons.toggle_off,
          _kAccent2,
        ),
        _privatepitfall(
          'Never call setState from a handler if the field is in a stateless host',
          'These callbacks are routed through the framework’s gesture phase. '
          'Use the EditableTextState’s methods directly — they already trigger rebuilds.',
          Icons.refresh,
          _kAccent3,
        ),
        _privatepitfall(
          'super calls matter',
          'Most defaults handle keyboard requests, magnifier, and toolbar. '
          'Calling super first and then customising is almost always the right order.',
          Icons.layers,
          _kCursor,
        ),
        _privatepitfall(
          'Triple-tap is platform-defined, not a separate hook',
          'Triple-tap is detected inside the underlying detector and routed back '
          'through onSingleTapUp with a different cause. Inspect the details.',
          Icons.replay,
          _kAccent,
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 11 — FOOTER
// ============================================================================

Widget _privatefooter() {
  return Container(
    margin: const EdgeInsets.only(top: 18, bottom: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kInk,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.gesture, color: Colors.white, size: 26),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'TextSelectionGestureDetectorBuilder — visual deep demo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'A subclass-by-design API: tell the framework which gestures matter, '
          'wrap your EditableText, and inherit a coherent platform-shaped UX.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _privatechip('flutter/widgets', _kAccent),
            _privatechip('text editing', _kAccent2, fg: Colors.white),
            _privatechip('platform-aware', _kAccent3, fg: Colors.white),
            _privatechip('subclass-friendly', _kAccent4),
            _privatechip('frozen-frame demo', Colors.white),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextSelectionGestureDetectorBuilder',
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFFFAF6EC),
      textTheme: const TextTheme(),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAF6EC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _privatehero(),
              _privatesectionBanner(
                '01',
                'Anatomy',
                'class shape, constructor, default member surface',
                _kAccent2,
              ),
              _privateanatomy(),
              _privatesectionBanner(
                '02',
                'Override gallery',
                'twelve overridable callbacks, one card each',
                _kAccent,
              ),
              _privateoverrideGallery(),
              _privatesectionBanner(
                '03',
                'Delegate interface',
                'TextSelectionGestureDetectorBuilderDelegate fields',
                _kAccent3,
              ),
              _privatedelegatePanel(),
              _privatesectionBanner(
                '04',
                'Gesture timeline',
                'event-by-event ordering of a typical session',
                _kAccent4,
              ),
              _privatetimeline(),
              _privatesectionBanner(
                '05',
                'Frozen frames',
                'before / after for the six dominant gestures',
                _kAccent,
              ),
              _privateframes(),
              _privatesectionBanner(
                '06',
                'Platforms',
                'how each OS interprets each gesture',
                _kCursor,
              ),
              _privateplatformTable(),
              _privatesectionBanner(
                '07',
                'Code listing',
                'a real subclass overriding three callbacks',
                _kAccent3,
              ),
              _privatecodeListing(),
              _privatesectionBanner(
                '08',
                'Relationships',
                'how TextField and SelectableText use this builder',
                _kAccent2,
              ),
              _privaterelationships(),
              _privatesectionBanner(
                '09',
                'Pitfalls',
                'sharp edges to avoid when subclassing',
                _kAccent4,
              ),
              _privatepitfalls(),
              _privatefooter(),
            ],
          ),
        ),
      ),
    ),
  );
}
