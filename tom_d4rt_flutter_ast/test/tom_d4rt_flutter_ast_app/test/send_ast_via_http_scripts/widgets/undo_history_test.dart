// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep demo: UndoHistory<T> — the top-level stateful widget that wires a
// `ValueNotifier<T>` (typically a TextEditingController) to an
// `UndoHistoryController` and reacts to platform undo/redo intents.
//
// Flutter SDK reference:
//   packages/flutter/lib/src/widgets/undo_history.dart
//
//   class UndoHistory<T> extends StatefulWidget {
//     const UndoHistory({
//       super.key,
//       this.shouldChangeUndoStack,
//       required this.value,                 // ValueNotifier<T>
//       required this.onTriggered,           // void Function(T)
//       this.controller,                     // UndoHistoryController?
//       this.undoStackModifier,
//       this.focusNode,
//       required this.child,
//     });
//     final ValueNotifier<T> value;
//     final void Function(T value) onTriggered;
//     final bool Function(T?, T)? shouldChangeUndoStack;
//     final T Function(T value)? undoStackModifier;
//     final UndoHistoryController? controller;
//     final FocusNode? focusNode;
//     final Widget child;
//   }
//
// The sibling demos cover:
//   • undo_history_value_test.dart — UndoHistoryValue (canUndo / canRedo)
//   • undo_history_controller_test.dart — imperative controller API
//   • undo_history_state_test.dart — UndoHistoryState<T> internals
//
// This file deliberately concentrates on the *top-level widget*: its
// constructor surface, the data-flow loop with a ValueNotifier source, the
// throttled / idle-triggered push policy that stops every keystroke from
// becoming its own undo entry, the way it cooperates with EditableText on
// focus changes, and the platform shortcut wiring that sends undo / redo
// intents into it.
//
// SendTestRunner constraints honoured:
//   • No StatefulWidget, no setState, no Timer, no Future, no animation.
//   • Top-level `build(BuildContext)` returns a SingleChildScrollView →
//     Column.  No MaterialApp, no Scaffold, no Theme.of, no Navigator.
//   • Container uses BoxDecoration only; never `color:` and `decoration:`
//     together.  Alphas always via `Color.withValues(alpha: ...)`.
//   • UndoHistory<T> is *not* instantiated — the runner gets no real keyboard
//     events, so the widget would be inert.  Instead, every behavioural claim
//     is shown via labelled diagrams and code-text panels.
//
// Theme: pressed-paper letterpress.  Sepia parchment, deep ink, ribbon-red
// typewriter accents, and ledger-blue rule lines.  Section banners read like
// printed plates; diagrams use rectangles + arrows hand-drawn with painters.

import 'dart:math' as math;

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
//  PALETTE — letterpress / typewriter
// ═══════════════════════════════════════════════════════════════════════════

class _UhPal {
  const _UhPal._();

  // Paper layers (light → dark grain).
  static const Color paper = Color(0xFFF1E6CC);
  static const Color paperWarm = Color(0xFFE8DAB4);
  static const Color paperDeep = Color(0xFFD8C794);
  static const Color paperInset = Color(0xFFEBDDB7);
  static const Color paperShadow = Color(0xFFB9A571);

  // Ink — text and strokes.
  static const Color ink = Color(0xFF1A1208);
  static const Color inkSoft = Color(0xFF2E2014);
  static const Color inkFaded = Color(0xFF55402E);
  static const Color inkGhost = Color(0xFF7E6850);

  // Ribbon red (typewriter).
  static const Color ribbon = Color(0xFFA8261C);
  static const Color ribbonDeep = Color(0xFF6F1612);
  static const Color ribbonBright = Color(0xFFD24A3F);
  static const Color ribbonTint = Color(0xFFE7B7B0);

  // Ledger blue (rule lines, footers).
  static const Color ledger = Color(0xFF24496E);
  static const Color ledgerSoft = Color(0xFF3E6A95);
  static const Color ledgerTint = Color(0xFFB8CCE0);

  // Punch tones.
  static const Color olive = Color(0xFF5C6B2D);
  static const Color oliveLight = Color(0xFFB4C28A);
  static const Color amber = Color(0xFFB37D1A);
  static const Color amberLight = Color(0xFFE8C780);
  static const Color teal = Color(0xFF2E6B68);

  // Status.
  static const Color ok = Color(0xFF305E33);
  static const Color okLight = Color(0xFFC8DEC3);
  static const Color stop = Color(0xFF7A2230);
}

// ═══════════════════════════════════════════════════════════════════════════
//  Reusable building blocks
// ═══════════════════════════════════════════════════════════════════════════

Widget _uhPaperPlate({required Widget child, EdgeInsets? padding}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: padding ?? const EdgeInsets.fromLTRB(18, 16, 18, 18),
    decoration: BoxDecoration(
      color: _UhPal.paper,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: _UhPal.paperShadow, width: 1),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(2, 2),
          blurRadius: 0,
        ),
      ],
    ),
    child: child,
  );
}

Widget _uhInkText(
  String text, {
  double size = 13,
  FontWeight weight = FontWeight.w500,
  Color color = _UhPal.ink,
  String family = 'monospace',
  double height = 1.35,
  double letterSpacing = 0.1,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      fontFamily: family,
      height: height,
      letterSpacing: letterSpacing,
    ),
  );
}

Widget _uhRule({Color color = _UhPal.ledgerTint}) {
  return Container(
    height: 1,
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(color: color),
  );
}

Widget _uhPill(
  String text, {
  Color background = _UhPal.ink,
  Color foreground = _UhPal.paper,
  double size = 11,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(2),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w800,
        color: foreground,
        fontFamily: 'monospace',
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _uhKeyCap(String label, {double width = 36, double height = 26}) {
  return Container(
    width: width,
    height: height,
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: 2),
    decoration: BoxDecoration(
      color: _UhPal.paperInset,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: _UhPal.inkFaded, width: 1),
      boxShadow: const [
        BoxShadow(
          color: Color(0x44000000),
          offset: Offset(0, 1.5),
          blurRadius: 0,
        ),
      ],
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: _UhPal.inkSoft,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  CustomPainter — letterpress masthead
// ═══════════════════════════════════════════════════════════════════════════

class _UhMastheadPainter extends CustomPainter {
  const _UhMastheadPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Deep ink plate.
    final Paint plate = Paint()..color = _UhPal.ink;
    canvas.drawRect(Offset.zero & size, plate);

    // Subtle paper grain over plate.
    final math.Random rng = math.Random(91);
    final Paint dot = Paint()
      ..color = _UhPal.paper.withValues(alpha: 0.04);
    for (int i = 0; i < 220; i++) {
      final double x = rng.nextDouble() * size.width;
      final double y = rng.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), rng.nextDouble() * 1.4, dot);
    }

    // Ribbon-red horizontal stripe.
    final double stripeY = size.height * 0.62;
    final Paint stripe = Paint()..color = _UhPal.ribbonDeep;
    canvas.drawRect(
      Rect.fromLTWH(0, stripeY, size.width, size.height * 0.06),
      stripe,
    );

    // Ledger-blue rule lines (printer registration).
    final Paint rule = Paint()
      ..color = _UhPal.ledgerSoft.withValues(alpha: 0.55)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, stripeY - 4),
      Offset(size.width, stripeY - 4),
      rule,
    );
    canvas.drawLine(
      Offset(0, stripeY + size.height * 0.06 + 4),
      Offset(size.width, stripeY + size.height * 0.06 + 4),
      rule,
    );

    // Decorative typewriter-key arcs on the right margin.
    final Paint keyOutline = Paint()
      ..color = _UhPal.ribbonBright.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    for (int i = 0; i < 3; i++) {
      final double cx = size.width - 48 - i * 18.0;
      final double cy = size.height * 0.28 + i * 10.0;
      canvas.drawCircle(Offset(cx, cy), 14 - i * 1.5, keyOutline);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Painter that draws a small "[N]→[N+1]" stack arrow used in timeline diagrams.
class _UhArrowPainter extends CustomPainter {
  _UhArrowPainter({required this.color});
  final Color color;
  static const double thickness = 1.6;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;
    final double midY = size.height / 2;
    canvas.drawLine(Offset(2, midY), Offset(size.width - 8, midY), paint);
    final Path head = Path()
      ..moveTo(size.width - 2, midY)
      ..lineTo(size.width - 10, midY - 5)
      ..lineTo(size.width - 10, midY + 5)
      ..close();
    final Paint headFill = Paint()..color = color;
    canvas.drawPath(head, headFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Painter that draws the cursor caret pointing at a history slot.
class _UhCursorCaretPainter extends CustomPainter {
  const _UhCursorCaretPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fill = Paint()..color = _UhPal.ribbon;
    final Path triangle = Path()
      ..moveTo(size.width / 2, size.height)
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(triangle, fill);

    final Paint outline = Paint()
      ..color = _UhPal.ribbonDeep
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawPath(triangle, outline);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════
//  Section banner — printed plate look
// ═══════════════════════════════════════════════════════════════════════════

Widget _uhSectionBanner({
  required String ordinal,
  required String title,
  required String subtitle,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 26, bottom: 12),
    height: 96,
    width: double.infinity,
    child: Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(painter: const _UhMastheadPainter()),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _UhPal.ribbon,
                  shape: BoxShape.circle,
                  border: Border.all(color: _UhPal.paper, width: 2),
                ),
                child: Text(
                  ordinal,
                  style: const TextStyle(
                    color: _UhPal.paper,
                    fontFamily: 'monospace',
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _UhPal.paper,
                        fontFamily: 'monospace',
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.7,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: _UhPal.paper.withValues(alpha: 0.78),
                        fontFamily: 'monospace',
                        fontSize: 12,
                        letterSpacing: 0.3,
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
  );
}

Widget _uhSubheading(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4, bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 6,
          height: 16,
          decoration: const BoxDecoration(color: _UhPal.ribbon),
        ),
        const SizedBox(width: 8),
        _uhInkText(
          text,
          size: 14,
          weight: FontWeight.w800,
          color: _UhPal.inkSoft,
          letterSpacing: 0.4,
        ),
      ],
    ),
  );
}

Widget _uhAnnotation(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 11.5,
        fontStyle: FontStyle.italic,
        color: _UhPal.inkFaded,
        fontFamily: 'monospace',
        height: 1.4,
      ),
    ),
  );
}

Widget _uhBullet(String text, {Color dotColor = _UhPal.ribbon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6, right: 8),
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Expanded(child: _uhInkText(text, size: 12.5, height: 1.4)),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  Code-text panel — looks like a tear sheet from a printer's proof
// ═══════════════════════════════════════════════════════════════════════════

Widget _uhCodeBlock({
  required String label,
  required List<String> lines,
  Color frame = _UhPal.ink,
  Color body = _UhPal.inkSoft,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: body,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: frame, width: 1.2),
      boxShadow: const [
        BoxShadow(
          color: Color(0x55000000),
          offset: Offset(2, 2),
          blurRadius: 0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: const BoxDecoration(
            color: _UhPal.ink,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: _UhPal.ribbonBright,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: _UhPal.amberLight,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: _UhPal.oliveLight,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: _UhPal.paper,
                    fontFamily: 'monospace',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              _uhPill(
                'PROOF',
                background: _UhPal.ribbon,
                foreground: _UhPal.paper,
                size: 10,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (int i = 0; i < lines.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 28,
                        child: Text(
                          (i + 1).toString().padLeft(2, '0'),
                          style: TextStyle(
                            color: _UhPal.inkGhost.withValues(alpha: 0.85),
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          lines[i],
                          style: const TextStyle(
                            color: _UhPal.paperInset,
                            fontSize: 12,
                            fontFamily: 'monospace',
                            height: 1.45,
                          ),
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
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  Cursor-and-list visualisation primitives
// ═══════════════════════════════════════════════════════════════════════════

Widget _uhHistoryCell({
  required String label,
  required bool isCurrent,
  required bool isPast,
  required bool isFuture,
}) {
  Color bg;
  Color border;
  Color textColor;
  if (isCurrent) {
    bg = _UhPal.ribbonTint;
    border = _UhPal.ribbon;
    textColor = _UhPal.ribbonDeep;
  } else if (isPast) {
    bg = _UhPal.paperWarm;
    border = _UhPal.inkFaded;
    textColor = _UhPal.inkSoft;
  } else if (isFuture) {
    bg = _UhPal.ledgerTint;
    border = _UhPal.ledgerSoft;
    textColor = _UhPal.ledger;
  } else {
    bg = _UhPal.paperInset;
    border = _UhPal.paperShadow;
    textColor = _UhPal.inkFaded;
  }
  return Container(
    width: 64,
    height: 56,
    margin: const EdgeInsets.symmetric(horizontal: 3),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: border, width: isCurrent ? 2 : 1),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: textColor,
        fontFamily: 'monospace',
        height: 1.2,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _uhHistoryStrip({
  required List<String> entries,
  required int cursorIndex,
}) {
  // Build a horizontal strip with the cursor caret above the current entry.
  // [past][past][CURRENT][future][future]
  return Column(
    children: [
      // Caret row aligning with the cursor cell.
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < entries.length; i++)
            SizedBox(
              width: 70,
              height: 14,
              child: i == cursorIndex
                  ? Center(
                      child: SizedBox(
                        width: 16,
                        height: 12,
                        child: CustomPaint(
                          painter: const _UhCursorCaretPainter(),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < entries.length; i++)
            _uhHistoryCell(
              label: entries[i],
              isCurrent: i == cursorIndex,
              isPast: i < cursorIndex,
              isFuture: i > cursorIndex,
            ),
        ],
      ),
      const SizedBox(height: 6),
      // Index ruler under the strip.
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < entries.length; i++)
            SizedBox(
              width: 70,
              child: Text(
                '#$i',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: i == cursorIndex
                      ? _UhPal.ribbonDeep
                      : _UhPal.inkGhost,
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: i == cursorIndex
                      ? FontWeight.w900
                      : FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  Build the entire scroll
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('UndoHistory deep-demo executing');
  print('  • This script never instantiates UndoHistory<T> directly.');
  print('  • All behaviour is illustrated via diagrams and code panels.');
  print('  • Sibling scripts cover Value / Controller / State separately.');

  // -- Section 1 ---------------------------------------------------------
  print('--- Section 1: Title banner ---');
  final Widget titleBanner = Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
    decoration: BoxDecoration(
      color: _UhPal.paperWarm,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: _UhPal.inkFaded, width: 1.4),
      boxShadow: const [
        BoxShadow(
          color: Color(0x55000000),
          offset: Offset(4, 4),
          blurRadius: 0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _UhPal.ink,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _UhPal.ribbon, width: 2),
              ),
              child: const Text(
                'UH',
                style: TextStyle(
                  color: _UhPal.paper,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _uhInkText(
                        'UndoHistory<T>',
                        size: 26,
                        weight: FontWeight.w900,
                        color: _UhPal.ink,
                        letterSpacing: 0.6,
                      ),
                      const SizedBox(width: 10),
                      _uhPill('widgets.dart',
                          background: _UhPal.ribbon,
                          foreground: _UhPal.paper),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _uhInkText(
                    'Stateful widget that watches a ValueNotifier<T> and '
                    'records throttled snapshots into an undo stack.',
                    size: 12.5,
                    color: _UhPal.inkSoft,
                    weight: FontWeight.w500,
                    height: 1.45,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: _UhPal.paperInset,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: _UhPal.ledgerSoft, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Icon(Icons.menu_book, color: _UhPal.ledger, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: _uhInkText(
                  'Letterpress edition.  Plates set in monospace, ribbon-red '
                  'cursors, ledger-blue rule lines.  Scroll for the full '
                  'eight-section anatomy of UndoHistory<T>.',
                  size: 12,
                  color: _UhPal.inkSoft,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: <Widget>[
            _uhPill('§1 Banner',
                background: _UhPal.ribbon, foreground: _UhPal.paper),
            _uhPill('§2 UndoHistoryValue',
                background: _UhPal.ledger, foreground: _UhPal.paper),
            _uhPill('§3 Timeline',
                background: _UhPal.amber, foreground: _UhPal.ink),
            _uhPill('§4 Controller API',
                background: _UhPal.teal, foreground: _UhPal.paper),
            _uhPill('§5 Push Conditions',
                background: _UhPal.olive, foreground: _UhPal.paper),
            _uhPill('§6 Code Pattern',
                background: _UhPal.ink, foreground: _UhPal.paper),
            _uhPill('§7 EditableText vs custom',
                background: _UhPal.stop, foreground: _UhPal.paper),
            _uhPill('§8 Recap',
                background: _UhPal.inkFaded, foreground: _UhPal.paper),
          ],
        ),
      ],
    ),
  );

  // -- Section 2 ---------------------------------------------------------
  print('--- Section 2: Anatomy of UndoHistoryValue ---');
  final Widget section2Banner = _uhSectionBanner(
    ordinal: '2',
    title: 'Anatomy of UndoHistoryValue',
    subtitle: 'value.canUndo • value.canRedo — what the controller exposes',
  );

  final Widget section2Body = _uhPaperPlate(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _uhSubheading('The immutable snapshot'),
        const SizedBox(height: 4),
        _uhInkText(
          'UndoHistoryValue is a tiny @immutable record with two booleans: '
          'canUndo and canRedo.  An UndoHistoryController exposes the '
          'current value via its `.value` getter and notifies listeners '
          'whenever the underlying stack position changes.',
          size: 12.5,
          color: _UhPal.inkSoft,
        ),
        _uhRule(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                decoration: BoxDecoration(
                  color: _UhPal.paperInset,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: _UhPal.inkFaded),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _uhPill('STRUCT',
                            background: _UhPal.ribbon,
                            foreground: _UhPal.paper),
                        const SizedBox(width: 8),
                        _uhInkText('UndoHistoryValue',
                            size: 13, weight: FontWeight.w900),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _uhInkText('• final bool canUndo',
                        size: 12, color: _UhPal.inkSoft),
                    _uhInkText('• final bool canRedo',
                        size: 12, color: _UhPal.inkSoft),
                    _uhInkText('• static const empty = UndoHistoryValue();',
                        size: 11.5, color: _UhPal.inkFaded),
                    const SizedBox(height: 6),
                    _uhAnnotation(
                      'No fields beyond the two flags.  The actual stack of '
                      'snapshots lives privately inside UndoHistoryState, '
                      'not in the value class.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                decoration: BoxDecoration(
                  color: _UhPal.paperInset,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(color: _UhPal.ledgerSoft),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _uhPill('NOTIFIER',
                            background: _UhPal.ledger,
                            foreground: _UhPal.paper),
                        const SizedBox(width: 8),
                        _uhInkText('UndoHistoryController',
                            size: 13, weight: FontWeight.w900),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _uhInkText(
                      '• extends ValueNotifier<UndoHistoryValue>',
                      size: 12,
                      color: _UhPal.inkSoft,
                    ),
                    _uhInkText('• ChangeNotifier onUndo',
                        size: 12, color: _UhPal.inkSoft),
                    _uhInkText('• ChangeNotifier onRedo',
                        size: 12, color: _UhPal.inkSoft),
                    _uhInkText('• void undo() / void redo()',
                        size: 12, color: _UhPal.inkSoft),
                    const SizedBox(height: 6),
                    _uhAnnotation(
                      'Holds *only* the value; the actual stack is owned by '
                      'whichever UndoHistory<T> last attached to it.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        _uhRule(),
        _uhSubheading('Four flag combinations'),
        const SizedBox(height: 4),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _uhFlagCard(canUndo: false, canRedo: false, label: 'fresh stack'),
            _uhFlagCard(canUndo: true, canRedo: false, label: 'after typing'),
            _uhFlagCard(
                canUndo: true, canRedo: true, label: 'mid-history (after undo)'),
            _uhFlagCard(canUndo: false, canRedo: true, label: 'fully undone'),
          ],
        ),
        _uhRule(),
        _uhAnnotation(
          'See undo_history_value_test.dart for the deep-dive demo of '
          'UndoHistoryValue equality, hashCode, and the const empty sentinel.',
        ),
      ],
    ),
  );

  // -- Section 3 ---------------------------------------------------------
  print('--- Section 3: Undo / redo timeline diagrams ---');
  final Widget section3Banner = _uhSectionBanner(
    ordinal: '3',
    title: 'Undo / redo timeline diagrams',
    subtitle: 'Cursor walks left on undo, right on redo, truncates on edit',
  );

  final Widget section3Body = _uhPaperPlate(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _uhSubheading('Scenario A — typing extends the stack'),
        _uhInkText(
          'Each *finalised* keystroke burst becomes one entry.  The cursor '
          'always sits on the most recent entry.',
          size: 12.5,
          color: _UhPal.inkSoft,
        ),
        const SizedBox(height: 8),
        _uhHistoryStrip(
          entries: const <String>['""', '"He"', '"Hello"', '"Hello,"', '"Hello, world"'],
          cursorIndex: 4,
        ),
        const SizedBox(height: 6),
        _uhAnnotation(
          'value.canUndo == true   value.canRedo == false   (cursor at tail)',
        ),
        _uhRule(),
        _uhSubheading('Scenario B — undo() walks the cursor left'),
        _uhInkText(
          'Calling controller.undo() moves the cursor down the stack and '
          'invokes onTriggered with that previous snapshot.',
          size: 12.5,
          color: _UhPal.inkSoft,
        ),
        const SizedBox(height: 8),
        _uhHistoryStrip(
          entries: const <String>['""', '"He"', '"Hello"', '"Hello,"', '"Hello, world"'],
          cursorIndex: 2,
        ),
        const SizedBox(height: 6),
        _uhAnnotation(
          'value.canUndo == true   value.canRedo == true   '
          '(snapshots #3 and #4 are still recoverable via redo)',
        ),
        _uhRule(),
        _uhSubheading('Scenario C — editing while mid-stack truncates the future'),
        _uhInkText(
          'Once a new entry is pushed while the cursor is not at the tail, '
          'the entries to the right are dropped.  This is the "branching '
          'history is collapsed" rule shared by every editor.',
          size: 12.5,
          color: _UhPal.inkSoft,
        ),
        const SizedBox(height: 8),
        _uhHistoryStrip(
          entries: const <String>['""', '"He"', '"Hello"', '"Howdy"', '✗'],
          cursorIndex: 3,
        ),
        const SizedBox(height: 6),
        _uhAnnotation(
          'After pushing "Howdy" with cursor at #2, the strip becomes '
          '[""], ["He"], ["Hello"], ["Howdy"]; "Hello," and "Hello, world" '
          'are gone forever.  canRedo flips back to false.',
        ),
        _uhRule(),
        _uhSubheading('Scenario D — redo() walks the cursor right'),
        _uhInkText(
          'controller.redo() advances the cursor again and fires onTriggered '
          'with the snapshot ahead of the current one.',
          size: 12.5,
          color: _UhPal.inkSoft,
        ),
        const SizedBox(height: 8),
        _uhHistoryStrip(
          entries: const <String>['""', '"He"', '"Hello"', '"Hello,"', '"Hello, world"'],
          cursorIndex: 3,
        ),
        const SizedBox(height: 6),
        _uhAnnotation(
          'Stepping right from #2 → #3 emits onTriggered("Hello,") and the '
          'controller publishes the new value (canUndo true, canRedo true).',
        ),
        _uhRule(),
        // Legend.
        _uhSubheading('Legend'),
        Wrap(
          spacing: 10,
          runSpacing: 6,
          children: <Widget>[
            _uhLegendCell(_UhPal.paperWarm, _UhPal.inkFaded, 'past'),
            _uhLegendCell(_UhPal.ribbonTint, _UhPal.ribbon, 'current'),
            _uhLegendCell(_UhPal.ledgerTint, _UhPal.ledgerSoft, 'future'),
          ],
        ),
      ],
    ),
  );

  // -- Section 4 ---------------------------------------------------------
  print('--- Section 4: UndoHistoryController API panel ---');
  final Widget section4Banner = _uhSectionBanner(
    ordinal: '4',
    title: 'UndoHistoryController API surface',
    subtitle: 'A ValueNotifier with two ChangeNotifier side-channels',
  );

  final Widget section4Body = _uhPaperPlate(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _uhSubheading('Members at a glance'),
        const SizedBox(height: 4),
        _uhApiRow('value', 'UndoHistoryValue',
            'Current canUndo / canRedo.  Listenable.'),
        _uhApiRow('onUndo', 'ChangeNotifier',
            'Fires every time someone calls controller.undo().'),
        _uhApiRow('onRedo', 'ChangeNotifier',
            'Fires every time someone calls controller.redo().'),
        _uhApiRow('undo()', 'void',
            'Imperative request — equivalent to a UndoTextIntent.'),
        _uhApiRow('redo()', 'void',
            'Imperative request — equivalent to a RedoTextIntent.'),
        _uhApiRow('addListener(cb)', 'void',
            'Inherited from ValueNotifier — re-runs cb on value change.'),
        _uhApiRow('dispose()', 'void',
            'Always pair with the State that constructed the controller.'),
        _uhRule(),
        _uhSubheading('Listening flow'),
        _uhCodeBlock(
          label: 'controller_listener.dart',
          lines: const <String>[
            'final controller = UndoHistoryController();',
            'controller.addListener(() {',
            '  final v = controller.value;          // UndoHistoryValue',
            '  print(\'canUndo=\${v.canUndo}, canRedo=\${v.canRedo}\');',
            '});',
            'controller.onUndo.addListener(() {',
            '  print(\'an undo was just performed\');',
            '});',
            'controller.onRedo.addListener(() {',
            '  print(\'a redo was just performed\');',
            '});',
          ],
        ),
        _uhAnnotation(
          'In a custom toolbar these listeners drive the enabled/disabled '
          'state of "Undo" and "Redo" buttons.  Forgetting to listen leaves '
          'them stuck in the initial false/false state.',
        ),
        _uhRule(),
        _uhSubheading('Keyboard wiring (illustrative)'),
        _uhInkText(
          'WidgetsApp installs default Action / Shortcut entries that map '
          'platform-conventional keystrokes onto UndoTextIntent and '
          'RedoTextIntent.  UndoHistory<T> registers an Actions block that '
          'invokes controller.undo()/redo() in response.',
          size: 12.5,
          color: _UhPal.inkSoft,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _uhKeyCap('Ctrl'),
                const Text('+',
                    style: TextStyle(
                        color: _UhPal.inkFaded,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w800)),
                _uhKeyCap('Z'),
                const SizedBox(width: 8),
                _uhInkText('→ undo (Win/Linux)',
                    size: 12, color: _UhPal.inkSoft),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _uhKeyCap('Ctrl'),
                const Text('+',
                    style: TextStyle(
                        color: _UhPal.inkFaded,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w800)),
                _uhKeyCap('Y'),
                const SizedBox(width: 8),
                _uhInkText('→ redo (Win/Linux)',
                    size: 12, color: _UhPal.inkSoft),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _uhKeyCap('⌘', width: 30),
                const Text('+',
                    style: TextStyle(
                        color: _UhPal.inkFaded,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w800)),
                _uhKeyCap('Z'),
                const SizedBox(width: 8),
                _uhInkText('→ undo (macOS / iOS)',
                    size: 12, color: _UhPal.inkSoft),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _uhKeyCap('⌘', width: 30),
                const Text('+',
                    style: TextStyle(
                        color: _UhPal.inkFaded,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w800)),
                _uhKeyCap('⇧', width: 30),
                const Text('+',
                    style: TextStyle(
                        color: _UhPal.inkFaded,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w800)),
                _uhKeyCap('Z'),
                const SizedBox(width: 8),
                _uhInkText('→ redo (macOS / iOS)',
                    size: 12, color: _UhPal.inkSoft),
              ],
            ),
          ],
        ),
        const SizedBox(height: 6),
        _uhAnnotation(
          'These shortcuts are not bound here — the SendTestRunner gets no '
          'real keyboard events.  The cards above are reference glyphs only.',
        ),
      ],
    ),
  );

  // -- Section 5 ---------------------------------------------------------
  print('--- Section 5: Push conditions ---');
  final Widget section5Banner = _uhSectionBanner(
    ordinal: '5',
    title: 'When does UndoHistory push a new entry?',
    subtitle: 'Debounce, idle-trigger, and shouldChangeUndoStack',
  );

  final Widget section5Body = _uhPaperPlate(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _uhSubheading('The throttling problem'),
        _uhInkText(
          'If every keystroke pushed a snapshot, "Hello, world" would create '
          '12 history entries — undo would feel like a stuttering rewind '
          'instead of a real "step backwards in thought".',
          size: 12.5,
          color: _UhPal.inkSoft,
        ),
        _uhRule(),
        _uhSubheading('Three rules used by UndoHistory<T>'),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _uhRuleCard(
                ordinal: 'R1',
                title: 'Idle debounce',
                tone: _UhPal.amber,
                lines: const <String>[
                  'After the source ValueNotifier fires a change,',
                  'the state schedules a microtask.',
                  'If the value stops changing for ~_kThrottleDuration',
                  '(currently 500ms in the SDK, see undo_history.dart),',
                  'a new snapshot is pushed onto the stack.',
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _uhRuleCard(
                ordinal: 'R2',
                title: 'Focus loss',
                tone: _UhPal.teal,
                lines: const <String>[
                  'When the focusNode loses focus,',
                  'pending changes are flushed immediately.',
                  'Re-focusing later resumes the throttle clock.',
                  'This makes "Tab away" a natural commit point.',
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _uhRuleCard(
                ordinal: 'R3',
                title: 'shouldChangeUndoStack',
                tone: _UhPal.olive,
                lines: const <String>[
                  'A user-provided callback (oldT, newT) → bool.',
                  'Return false to *suppress* the snapshot.',
                  'Useful for ignoring caret-only changes',
                  'that happen to come through the same notifier.',
                ],
              ),
            ),
          ],
        ),
        _uhRule(),
        _uhSubheading('shouldChangeUndoStack — typical usage'),
        _uhCodeBlock(
          label: 'shouldChangeUndoStack.dart',
          lines: const <String>[
            'UndoHistory<TextEditingValue>(',
            '  value: textController,',
            '  controller: undoController,',
            '  shouldChangeUndoStack: (TextEditingValue? prev,',
            '                          TextEditingValue next) {',
            '    if (prev == null) return true;',
            '    // Only push when the actual text changes — ignore caret moves.',
            '    return prev.text != next.text;',
            '  },',
            '  onTriggered: (TextEditingValue value) {',
            '    textController.value = value;',
            '  },',
            '  child: editor,',
            ')',
          ],
        ),
        _uhAnnotation(
          'Without shouldChangeUndoStack, dragging the caret through a '
          'paragraph would generate dozens of useless undo entries.',
        ),
        _uhRule(),
        _uhSubheading('Push timeline (visual)'),
        _uhPushTimeline(),
      ],
    ),
  );

  // -- Section 6 ---------------------------------------------------------
  print('--- Section 6: Code-text panel — typical usage ---');
  final Widget section6Banner = _uhSectionBanner(
    ordinal: '6',
    title: 'Typical usage in a custom editor',
    subtitle: 'Wiring UndoHistory<TextEditingValue> over a TextField',
  );

  final Widget section6Body = _uhPaperPlate(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _uhSubheading('Imports & local fields'),
        _uhCodeBlock(
          label: 'imports.dart',
          lines: const <String>[
            'import \'package:flutter/material.dart\';',
            'import \'package:flutter/widgets.dart\';',
            '',
            'late final TextEditingController _text =',
            '    TextEditingController(text: \'Hello, world\');',
            'late final UndoHistoryController _undo =',
            '    UndoHistoryController();',
            'final FocusNode _focus = FocusNode();',
          ],
        ),
        _uhSubheading('Build method'),
        _uhCodeBlock(
          label: 'build_method.dart',
          lines: const <String>[
            '@override',
            'Widget build(BuildContext context) {',
            '  return UndoHistory<TextEditingValue>(',
            '    value: _text,                      // ValueNotifier source',
            '    controller: _undo,                 // exposed canUndo/canRedo',
            '    focusNode: _focus,                 // commits on focus loss',
            '    shouldChangeUndoStack: (prev, next) =>',
            '        prev?.text != next.text,',
            '    onTriggered: (TextEditingValue v) {',
            '      _text.value = v;                 // re-emit the snapshot',
            '    },',
            '    child: Column(',
            '      children: <Widget>[',
            '        TextField(controller: _text, focusNode: _focus),',
            '        ValueListenableBuilder<UndoHistoryValue>(',
            '          valueListenable: _undo,',
            '          builder: (context, v, _) => Row(',
            '            children: <Widget>[',
            '              IconButton(',
            '                onPressed: v.canUndo ? _undo.undo : null,',
            '                icon: const Icon(Icons.undo),',
            '              ),',
            '              IconButton(',
            '                onPressed: v.canRedo ? _undo.redo : null,',
            '                icon: const Icon(Icons.redo),',
            '              ),',
            '            ],',
            '          ),',
            '        ),',
            '      ],',
            '    ),',
            '  );',
            '}',
          ],
        ),
        _uhSubheading('Disposal'),
        _uhCodeBlock(
          label: 'dispose.dart',
          lines: const <String>[
            '@override',
            'void dispose() {',
            '  _text.dispose();',
            '  _undo.dispose();',
            '  _focus.dispose();',
            '  super.dispose();',
            '}',
          ],
        ),
        _uhAnnotation(
          'Always dispose the UndoHistoryController together with the source '
          'ValueNotifier — leaking either one means leaking the listeners '
          'that UndoHistoryState attached during initState.',
        ),
      ],
    ),
  );

  // -- Section 7 ---------------------------------------------------------
  print('--- Section 7: EditableText vs custom application-level history ---');
  final Widget section7Banner = _uhSectionBanner(
    ordinal: '7',
    title: 'EditableText vs custom application-level history',
    subtitle: 'Two undo stacks that should not be confused',
  );

  final Widget section7Body = _uhPaperPlate(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _uhSubheading('Where UndoHistory<T> lives in the framework'),
        _uhInkText(
          'EditableText.build(...) wraps its inner Editable in an '
          'UndoHistory<TextEditingValue>.  This means *every* TextField '
          'and TextFormField in your app already has per-field undo, '
          'driven by Cmd/Ctrl+Z keyboard shortcuts that the framework '
          'wires up via WidgetsApp\'s default actions map.',
          size: 12.5,
          color: _UhPal.inkSoft,
        ),
        _uhRule(),
        _uhSubheading('Comparison sheet'),
        _uhCompareTable(),
        _uhRule(),
        _uhSubheading('Wiring at the application level'),
        _uhInkText(
          'For document-level undo (drawing strokes, dragged shapes, '
          'colour-picker tweaks) you typically build your own observable '
          'model.  UndoHistory<T> can still be used — wrap a '
          'ValueNotifier<MyDocSnapshot> instead of a TextEditingController.',
          size: 12.5,
          color: _UhPal.inkSoft,
        ),
        const SizedBox(height: 6),
        _uhCodeBlock(
          label: 'application_undo.dart',
          lines: const <String>[
            'class _DocSnapshot { /* immutable payload */ }',
            '',
            'final docNotifier = ValueNotifier<_DocSnapshot>(',
            '  _DocSnapshot.initial(),',
            ');',
            'final undoCtrl = UndoHistoryController();',
            '',
            'UndoHistory<_DocSnapshot>(',
            '  value: docNotifier,',
            '  controller: undoCtrl,',
            '  shouldChangeUndoStack: (a, b) => a != b,',
            '  onTriggered: (snap) => docNotifier.value = snap,',
            '  child: const _Canvas(),',
            ');',
          ],
        ),
        _uhAnnotation(
          'Beware: if your editor *also* contains TextFields, both undo '
          'stacks coexist.  Document-level Cmd+Z usually fires when no '
          'TextField is focused; the keyboard system delivers the intent '
          'to the closest UndoHistory ancestor.',
        ),
      ],
    ),
  );

  // -- Section 8 ---------------------------------------------------------
  print('--- Section 8: Recap card ---');
  final Widget section8Banner = _uhSectionBanner(
    ordinal: '8',
    title: 'Recap',
    subtitle: 'One scroll, one widget, one cursor walking a stack',
  );

  final Widget section8Body = Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
    decoration: BoxDecoration(
      color: _UhPal.ink,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: _UhPal.ribbon, width: 1.6),
      boxShadow: const [
        BoxShadow(
          color: Color(0x66000000),
          offset: Offset(3, 3),
          blurRadius: 0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _uhPill('RECAP',
                background: _UhPal.ribbon, foreground: _UhPal.paper),
            const SizedBox(width: 10),
            Text(
              'UndoHistory<T> in seven lines',
              style: TextStyle(
                color: _UhPal.paper,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _uhRecapLine(
          '1.', 'Listens to a ValueNotifier<T> and pushes throttled '
          'snapshots onto an internal stack.',
        ),
        _uhRecapLine(
          '2.', 'Exposes the cursor state through an UndoHistoryController '
          'as an UndoHistoryValue (canUndo / canRedo).',
        ),
        _uhRecapLine(
          '3.', 'controller.undo() / controller.redo() walk the cursor '
          'and call onTriggered with the chosen snapshot.',
        ),
        _uhRecapLine(
          '4.', 'shouldChangeUndoStack(prev, next) lets you veto pushes — '
          'caret-only changes, programmatic swaps, etc.',
        ),
        _uhRecapLine(
          '5.', 'Focus loss flushes pending changes; the throttle resets '
          'when focus returns.',
        ),
        _uhRecapLine(
          '6.', 'Editing while the cursor is mid-stack truncates the '
          'future entries — branching history is collapsed.',
        ),
        _uhRecapLine(
          '7.', 'Every TextField already gets all of this for free via '
          'EditableText; reach for it manually only for application-level '
          'undo over your own observable model.',
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: _UhPal.paperWarm.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: _UhPal.paperWarm.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.bookmark, color: _UhPal.amberLight, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Pair this script with undo_history_value_test.dart, '
                  'undo_history_controller_test.dart and '
                  'undo_history_state_test.dart for the full picture.',
                  style: TextStyle(
                    color: _UhPal.paper.withValues(alpha: 0.92),
                    fontFamily: 'monospace',
                    fontSize: 12,
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

  print('UndoHistory deep-demo: assembling scroll …');

  return SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(18, 22, 18, 36),
    child: Container(
      decoration: const BoxDecoration(color: _UhPal.paperDeep),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleBanner,
          section2Banner,
          section2Body,
          section3Banner,
          section3Body,
          section4Banner,
          section4Body,
          section5Banner,
          section5Body,
          section6Banner,
          section6Body,
          section7Banner,
          section7Body,
          section8Banner,
          section8Body,
          const SizedBox(height: 18),
          Center(
            child: Text(
              '— end of letterpress proof —',
              style: TextStyle(
                color: _UhPal.inkFaded,
                fontFamily: 'monospace',
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  Section-2 helpers — flag-combination cards
// ═══════════════════════════════════════════════════════════════════════════

Widget _uhFlagCard({
  required bool canUndo,
  required bool canRedo,
  required String label,
}) {
  Color bg;
  if (canUndo && canRedo) {
    bg = _UhPal.amberLight;
  } else if (canUndo && !canRedo) {
    bg = _UhPal.okLight;
  } else if (!canUndo && canRedo) {
    bg = _UhPal.ledgerTint;
  } else {
    bg = _UhPal.paperInset;
  }
  return Container(
    width: 220,
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: _UhPal.inkFaded),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _uhFlagBadge('canUndo', canUndo),
            const SizedBox(width: 6),
            _uhFlagBadge('canRedo', canRedo),
          ],
        ),
        const SizedBox(height: 8),
        _uhInkText(
          label,
          size: 12.5,
          weight: FontWeight.w800,
          color: _UhPal.ink,
        ),
        const SizedBox(height: 2),
        _uhAnnotation(
          'UndoHistoryValue('
          'canUndo: $canUndo, canRedo: $canRedo)',
        ),
      ],
    ),
  );
}

Widget _uhFlagBadge(String name, bool on) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: on ? _UhPal.ok : _UhPal.stop,
      borderRadius: BorderRadius.circular(2),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          on ? Icons.check : Icons.close,
          color: _UhPal.paper,
          size: 12,
        ),
        const SizedBox(width: 4),
        Text(
          name,
          style: const TextStyle(
            color: _UhPal.paper,
            fontFamily: 'monospace',
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _uhLegendCell(Color bg, Color border, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 22,
        height: 16,
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: border, width: 1),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 6),
      _uhInkText(label, size: 11.5, color: _UhPal.inkSoft),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  Section-4 helpers — API table rows
// ═══════════════════════════════════════════════════════════════════════════

Widget _uhApiRow(String name, String type, String description) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
    decoration: BoxDecoration(
      color: _UhPal.paperInset,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: _UhPal.paperShadow, width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            name,
            style: const TextStyle(
              color: _UhPal.ribbonDeep,
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(
          width: 170,
          child: Text(
            type,
            style: const TextStyle(
              color: _UhPal.ledger,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: const TextStyle(
              color: _UhPal.inkSoft,
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  Section-5 helpers — push-rule cards and timeline
// ═══════════════════════════════════════════════════════════════════════════

Widget _uhRuleCard({
  required String ordinal,
  required String title,
  required Color tone,
  required List<String> lines,
}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
    decoration: BoxDecoration(
      color: _UhPal.paperInset,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: tone, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tone,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                ordinal,
                style: const TextStyle(
                  color: _UhPal.paper,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _uhInkText(
                title,
                size: 13,
                weight: FontWeight.w900,
                color: _UhPal.inkSoft,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final String line in lines) _uhBullet(line, dotColor: tone),
      ],
    ),
  );
}

Widget _uhPushTimeline() {
  // A horizontal "tape" showing keystroke events with throttle window markers.
  return Container(
    padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
    decoration: BoxDecoration(
      color: _UhPal.paperInset,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: _UhPal.paperShadow),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.timeline, color: _UhPal.ledger, size: 18),
            SizedBox(width: 8),
            Text(
              'Throttle window over 2.0 s of typing',
              style: TextStyle(
                color: _UhPal.ledger,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Tape with vertical ticks at each "keystroke" timestamp.
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: _UhPal.paperWarm,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(color: _UhPal.inkFaded, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (int i = 0; i < 12; i++)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: _UhPal.paperShadow,
                          width: i == 11 ? 0 : 1,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        // keystroke events at positions 0,1,2,3 (burst),
                        // gap, then 7,8,9 (burst), then 10 idle 500ms.
                        if (<int>[0, 1, 2, 3, 7, 8, 9].contains(i))
                          Positioned(
                            left: 4,
                            top: 8,
                            child: Container(
                              width: 8,
                              height: 16,
                              decoration: BoxDecoration(
                                color: _UhPal.ribbon,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                          ),
                        if (i == 4)
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 30,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: _UhPal.amber,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        if (i == 11)
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 30,
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: _UhPal.amber,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 2,
                          child: Center(
                            child: Text(
                              '${i * 200}',
                              style: const TextStyle(
                                color: _UhPal.inkGhost,
                                fontFamily: 'monospace',
                                fontSize: 9,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 14,
          runSpacing: 6,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 8,
                  height: 12,
                  decoration: const BoxDecoration(color: _UhPal.ribbon),
                ),
                const SizedBox(width: 6),
                _uhInkText('keystroke', size: 11.5, color: _UhPal.inkSoft),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 12,
                  height: 4,
                  decoration: const BoxDecoration(color: _UhPal.amber),
                ),
                const SizedBox(width: 6),
                _uhInkText(
                  'idle window expired → push snapshot',
                  size: 11.5,
                  color: _UhPal.inkSoft,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        _uhAnnotation(
          'Two snapshots are pushed in this 2-second tape: one at ~800ms '
          '(after the first burst stops), one at ~2200ms after focus is '
          'lost or a final idle window expires.  The 7 intermediate '
          'keystrokes are *not* individual undo entries.',
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  Section-7 helpers — comparison table
// ═══════════════════════════════════════════════════════════════════════════

Widget _uhCompareTable() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _UhPal.paperInset,
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: _UhPal.paperShadow),
    ),
    child: Column(
      children: <Widget>[
        // Header row.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: _UhPal.ink,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 160,
                child: Text(
                  'Aspect',
                  style: TextStyle(
                    color: _UhPal.paper,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'EditableText built-in',
                  style: TextStyle(
                    color: _UhPal.paper,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'Application-level (custom)',
                  style: TextStyle(
                    color: _UhPal.paper,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        _uhCompareRow(
          'Source',
          'TextEditingController',
          'Any ValueNotifier<MyT>',
        ),
        _uhCompareRow(
          'Stack contents',
          'TextEditingValue snapshots',
          'Application-defined immutable T',
        ),
        _uhCompareRow(
          'Activation',
          'Focused TextField + Cmd/Ctrl+Z',
          'Wherever you place the UndoHistory<T>',
        ),
        _uhCompareRow(
          'Throttle',
          'SDK default (~500 ms idle window)',
          'Same — driven by UndoHistoryState',
        ),
        _uhCompareRow(
          'Vetoing',
          'Equality on TextEditingValue',
          'Custom shouldChangeUndoStack callback',
        ),
        _uhCompareRow(
          'Undo target',
          'Restores text + selection + composing',
          'Whatever onTriggered restores',
        ),
        _uhCompareRow(
          'Per-field?',
          'Yes — every TextField has its own stack',
          'Up to you — usually one shared stack',
        ),
        _uhCompareRow(
          'Lifecycle',
          'Owned by EditableText\'s State',
          'Owned by your widget; remember to dispose',
        ),
        _uhCompareRow(
          'Keyboard wiring',
          'Default actions installed by WidgetsApp',
          'You may bind UndoTextIntent / RedoTextIntent',
        ),
      ],
    ),
  );
}

Widget _uhCompareRow(String aspect, String editable, String custom) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 2),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _UhPal.paperWarm.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(2),
      border: Border.all(color: _UhPal.paperShadow, width: 0.8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 160,
          child: Text(
            aspect,
            style: const TextStyle(
              color: _UhPal.ribbonDeep,
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              editable,
              style: const TextStyle(
                color: _UhPal.inkSoft,
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.4,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            custom,
            style: const TextStyle(
              color: _UhPal.inkSoft,
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  Section-8 helpers — recap line
// ═══════════════════════════════════════════════════════════════════════════

Widget _uhRecapLine(String ordinal, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 28,
          child: Text(
            ordinal,
            style: const TextStyle(
              color: _UhPal.ribbonBright,
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: _UhPal.paper.withValues(alpha: 0.92),
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
//  Diagram helper that uses _UhArrowPainter — exposed for legend purposes.
//  (Kept as a top-level so the painter type is genuinely used somewhere.)
// ═══════════════════════════════════════════════════════════════════════════

// ignore: unused_element
Widget _uhArrow({double width = 36, double height = 12, Color? color}) {
  return SizedBox(
    width: width,
    height: height,
    child: CustomPaint(
      painter: _UhArrowPainter(color: color ?? _UhPal.ledger),
    ),
  );
}
