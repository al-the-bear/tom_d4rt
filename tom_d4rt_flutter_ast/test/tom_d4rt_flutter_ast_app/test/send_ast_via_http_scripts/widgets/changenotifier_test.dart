// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the ChangeNotifier / Listenable family
// from `package:flutter/foundation.dart`.
//
// This file is part of the D4rt flutter-test corpus. It is intended to be
// executed by an analyzer-free, sandboxed Dart interpreter. The script
// exports exactly one top-level entry point - `dynamic build(BuildContext)` -
// which is invoked a single time, and which returns a Widget tree.
//
// The rendered output is a long static gallery that walks through Flutter's
// reactivity story:
//
//   * Listenable (the abstract root) and the subtypes ChangeNotifier,
//     ValueNotifier<T> and Animation<T>.
//   * ChangeNotifier lifecycle: addListener -> notifyListeners -> callback
//     -> removeListener -> dispose.
//   * ValueNotifier gallery (six different value types).
//   * Listenable.merge composition.
//   * Idiomatic CounterModel implementation with a state-management
//     discussion card.
//   * Comparison of ListenableBuilder vs AnimatedBuilder vs
//     ValueListenableBuilder.
//   * Reactive widget tree CustomPainter.
//   * Pitfalls panel with six callouts.
//   * Six idiomatic code blocks.
//   * Cheat-sheet footer.
//
// Because the script runs in a static, no-interaction environment, every
// callback is either `null` or a no-op. The script never calls
// `notifyListeners()` after the widget tree is constructed, so the demo
// renders a single, deterministic snapshot. No `setState`, `Timer`, `Future`
// or `AnimationController` are used anywhere in this file.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// The demo deliberately uses literal ARGB colours instead of resolving from
// the active Theme, because some helper widgets are constructed without a
// live MaterialApp. The palette is tuned for a calm, IDE-like aesthetic.
const Color _kCanvas = Color(0xFFF6F7FB);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF1B1F27);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1B1F27);
const Color _kInkSecondary = Color(0xFF445064);
const Color _kInkTertiary = Color(0xFF8390A6);
const Color _kInkOnDark = Color(0xFFEDEFF5);
const Color _kInkOnDarkSecondary = Color(0xFFA1A8BA);
const Color _kAccent = Color(0xFF5E5CE6); // foundation indigo
const Color _kAccentBlue = Color(0xFF2F80ED);
const Color _kAccentGreen = Color(0xFF27AE60);
const Color _kAccentAmber = Color(0xFFF2994A);
const Color _kAccentRed = Color(0xFFEB5757);
const Color _kAccentTeal = Color(0xFF1ABC9C);
const Color _kAccentPink = Color(0xFFE91E63);
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
const TextStyle _kCodeStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kCodeText,
  height: 1.45,
  fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18.0);

// ---------------------------------------------------------------------------
// PRIVATE HELPERS
// ---------------------------------------------------------------------------
// All helpers are top-level `_camelCase` functions returning `Widget`s.
// They are intentionally kept as functions (not StatelessWidget subclasses)
// to keep the file readable top-to-bottom.
Widget _sectionHeader(int index, String title, String tagline) {
  return Padding(
    padding:
        const EdgeInsets.only(top: 28.0, bottom: 12.0, left: 18.0, right: 18.0),
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
  EdgeInsets margin =
      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
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

Widget _chipGroup(String title, List<String> labels, Color colour) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: const Color(0xFF2C2F3A),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairlineDark),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            color: colour,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: labels.map((String s) => _pill(s, colour: colour)).toList(),
        ),
      ],
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

Widget _bullet(String label, {Color colour = _kAccent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6.0, right: 8.0),
          width: 6.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
        Expanded(child: Text(label, style: _kBodyStyle)),
      ],
    ),
  );
}

Widget _calloutRow({
  required IconData icon,
  required Color colour,
  required String title,
  required String body,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: colour.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: colour, size: 20.0),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: colour,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(body, style: _kBodyStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// CUSTOM PAINTERS
// ---------------------------------------------------------------------------
// The two painters below render fully static diagrams. They both implement
// `shouldRepaint` as `false` because their input never changes during the
// single build pass.

/// Paints the Listenable class hierarchy:
///
///   * The abstract root `Listenable` sits at the top.
///   * Below it: `ChangeNotifier`, `ValueNotifier<T>`, `Animation<T>` as
///     leaves connected with arrows.
class _HierarchyPainter extends CustomPainter {
  const _HierarchyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint boxFill = Paint()..color = const Color(0xFFEDEEFB);
    final Paint boxStroke = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Paint leafFill = Paint()..color = const Color(0xFFE6F3EC);
    final Paint leafStroke = Paint()
      ..color = _kAccentGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Paint linePaint = Paint()
      ..color = _kInkTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    // Root: Listenable (centred at the top).
    final double rootW = 170.0;
    final double rootH = 38.0;
    final Rect rootRect = Rect.fromLTWH(
      (size.width - rootW) / 2.0,
      8.0,
      rootW,
      rootH,
    );
    final RRect rootRRect =
        RRect.fromRectAndRadius(rootRect, const Radius.circular(8.0));
    canvas.drawRRect(rootRRect, boxFill);
    canvas.drawRRect(rootRRect, boxStroke);
    _label(canvas, 'Listenable (abstract)', rootRect, _kAccent, bold: true);

    // Three leaves arranged across the bottom.
    final double leafW = 150.0;
    final double leafH = 42.0;
    final double bottomY = size.height - leafH - 8.0;
    final List<String> labels = <String>[
      'ChangeNotifier',
      'ValueNotifier<T>',
      'Animation<T>',
    ];
    final double gap = (size.width - 3 * leafW) / 4.0;
    for (int i = 0; i < 3; i++) {
      final double x = gap + i * (leafW + gap);
      final Rect leafRect = Rect.fromLTWH(x, bottomY, leafW, leafH);
      final RRect leafRRect =
          RRect.fromRectAndRadius(leafRect, const Radius.circular(8.0));
      canvas.drawRRect(leafRRect, leafFill);
      canvas.drawRRect(leafRRect, leafStroke);
      _label(canvas, labels[i], leafRect, _kAccentGreen, bold: true);

      // Connector line from the root to this leaf.
      final Offset topAnchor =
          Offset(rootRect.center.dx, rootRect.bottom + 0.0);
      final Offset leafTop = Offset(leafRect.center.dx, leafRect.top);
      _drawArrow(canvas, topAnchor, leafTop, linePaint);
    }

    // Side note: mixin/extends annotations.
    final TextSpan note = const TextSpan(
      text: 'mixin or extends -> notifyListeners()',
      style: TextStyle(
        color: _kInkTertiary,
        fontSize: 10.0,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w500,
      ),
    );
    final TextPainter tp = TextPainter(
      text: note,
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(12.0, rootRect.bottom + 8.0));
  }

  void _drawArrow(Canvas canvas, Offset a, Offset b, Paint paint) {
    canvas.drawLine(a, b, paint);
    // Arrow head pointing at b.
    final double dx = b.dx - a.dx;
    final double dy = b.dy - a.dy;
    final double len = math.sqrt(dx * dx + dy * dy);
    if (len < 0.0001) return;
    final double ux = dx / len;
    final double uy = dy / len;
    final double headSize = 6.0;
    final Offset left =
        Offset(b.dx - ux * headSize + -uy * (headSize * 0.6),
            b.dy - uy * headSize + ux * (headSize * 0.6));
    final Offset right =
        Offset(b.dx - ux * headSize + uy * (headSize * 0.6),
            b.dy - uy * headSize + -ux * (headSize * 0.6));
    final Path head = Path()
      ..moveTo(b.dx, b.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    final Paint fill = Paint()..color = paint.color;
    canvas.drawPath(head, fill);
  }

  void _label(
    Canvas canvas,
    String text,
    Rect rect,
    Color colour, {
    bool bold = false,
  }) {
    final TextSpan span = TextSpan(
      text: text,
      style: TextStyle(
        color: colour,
        fontSize: 12.5,
        fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        letterSpacing: -0.1,
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: rect.width);
    final Offset offset = Offset(
      rect.center.dx - tp.width / 2.0,
      rect.center.dy - tp.height / 2.0,
    );
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _HierarchyPainter oldDelegate) => false;
}

/// Paints the ChangeNotifier lifecycle as a horizontal flow chart:
///
///   addListener -> notifyListeners -> callback -> removeListener -> dispose
class _LifecyclePainter extends CustomPainter {
  const _LifecyclePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<_LifecycleStep> steps = <_LifecycleStep>[
      _LifecycleStep('addListener', _kAccentBlue),
      _LifecycleStep('notifyListeners', _kAccent),
      _LifecycleStep('callback', _kAccentTeal),
      _LifecycleStep('removeListener', _kAccentAmber),
      _LifecycleStep('dispose', _kAccentRed),
    ];

    final double pad = 10.0;
    final double slotW = (size.width - pad * 2) / steps.length;
    final double boxH = 40.0;
    final double y = (size.height - boxH) / 2.0;

    final Paint linePaint = Paint()
      ..color = _kInkTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    for (int i = 0; i < steps.length; i++) {
      final _LifecycleStep step = steps[i];
      final double cx = pad + slotW * i + slotW / 2.0;
      final Rect rect = Rect.fromCenter(
        center: Offset(cx, y + boxH / 2.0),
        width: slotW - 12.0,
        height: boxH,
      );
      final RRect rrect =
          RRect.fromRectAndRadius(rect, const Radius.circular(8.0));
      final Paint fill = Paint()..color = step.colour.withOpacity(0.12);
      final Paint stroke = Paint()
        ..color = step.colour
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      canvas.drawRRect(rrect, fill);
      canvas.drawRRect(rrect, stroke);

      final TextSpan span = TextSpan(
        text: step.label,
        style: TextStyle(
          color: step.colour,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
        ),
      );
      final TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: rect.width);
      tp.paint(
        canvas,
        Offset(
          rect.center.dx - tp.width / 2.0,
          rect.center.dy - tp.height / 2.0,
        ),
      );

      // Arrow connecting to the next box.
      if (i < steps.length - 1) {
        final Offset a = Offset(rect.right, rect.center.dy);
        final Offset b =
            Offset(rect.right + 12.0, rect.center.dy);
        canvas.drawLine(a, b, linePaint);
        // Arrow head.
        final Path head = Path()
          ..moveTo(b.dx, b.dy)
          ..lineTo(b.dx - 6.0, b.dy - 4.0)
          ..lineTo(b.dx - 6.0, b.dy + 4.0)
          ..close();
        canvas.drawPath(head, Paint()..color = linePaint.color);
      }
    }

    // Caption underneath
    final TextSpan caption = const TextSpan(
      text: 'Listener callbacks run synchronously from notifyListeners().',
      style: TextStyle(
        color: _kInkTertiary,
        fontSize: 10.5,
        fontStyle: FontStyle.italic,
      ),
    );
    final TextPainter cp = TextPainter(
      text: caption,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 24.0);
    cp.paint(canvas, Offset(12.0, size.height - cp.height - 4.0));
  }

  @override
  bool shouldRepaint(covariant _LifecyclePainter oldDelegate) => false;
}

class _LifecycleStep {
  const _LifecycleStep(this.label, this.colour);
  final String label;
  final Color colour;
}

/// Paints a "reactive widget tree":
///
///   * A `Listenable` source node on the left.
///   * Branches to four child nodes, two of which are subscribed via
///     *Builder and rebuild on change, two of which are not.
class _ReactiveTreePainter extends CustomPainter {
  const _ReactiveTreePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint sourceFill = Paint()..color = const Color(0xFFEDEEFB);
    final Paint sourceStroke = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final Paint subscriberFill = Paint()..color = const Color(0xFFE6F3EC);
    final Paint subscriberStroke = Paint()
      ..color = _kAccentGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Paint inertFill = Paint()..color = const Color(0xFFF1F1F4);
    final Paint inertStroke = Paint()
      ..color = _kInkTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Paint solidLine = Paint()
      ..color = _kAccentGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Paint dashedLine = Paint()
      ..color = _kInkTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    // Source on the left.
    final Rect source =
        Rect.fromLTWH(12.0, size.height / 2.0 - 22.0, 150.0, 44.0);
    final RRect sourceR =
        RRect.fromRectAndRadius(source, const Radius.circular(10.0));
    canvas.drawRRect(sourceR, sourceFill);
    canvas.drawRRect(sourceR, sourceStroke);
    _drawText(canvas, 'Listenable\n(notifier)', source, _kAccent, bold: true);

    // Four child boxes on the right column.
    final List<_TreeChild> children = <_TreeChild>[
      _TreeChild('ValueListenableBuilder', true),
      _TreeChild('AnimatedBuilder', true),
      _TreeChild('StatelessWidget (inert)', false),
      _TreeChild('Padding (inert)', false),
    ];
    final double childW = 180.0;
    final double childH = 36.0;
    final double startX = size.width - childW - 12.0;
    final double totalH = childH * children.length + 8.0 * (children.length - 1);
    final double startY = (size.height - totalH) / 2.0;
    for (int i = 0; i < children.length; i++) {
      final _TreeChild c = children[i];
      final Rect rect =
          Rect.fromLTWH(startX, startY + i * (childH + 8.0), childW, childH);
      final RRect rrect =
          RRect.fromRectAndRadius(rect, const Radius.circular(8.0));
      canvas.drawRRect(rrect, c.reactive ? subscriberFill : inertFill);
      canvas.drawRRect(rrect, c.reactive ? subscriberStroke : inertStroke);
      _drawText(canvas, c.label, rect,
          c.reactive ? _kAccentGreen : _kInkSecondary,
          bold: c.reactive);

      // Connecting line: solid for reactive, dashed for inert.
      final Offset a = Offset(source.right, source.center.dy);
      final Offset b = Offset(rect.left, rect.center.dy);
      if (c.reactive) {
        canvas.drawLine(a, b, solidLine);
      } else {
        _drawDashed(canvas, a, b, dashedLine);
      }
    }

    // Legend.
    final TextSpan legend = const TextSpan(
      text:
          'solid = subscribes via *Builder (rebuilds)   dashed = not subscribed (does not rebuild)',
      style: TextStyle(
        color: _kInkTertiary,
        fontSize: 10.5,
        fontStyle: FontStyle.italic,
      ),
    );
    final TextPainter lp = TextPainter(
      text: legend,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 24.0);
    lp.paint(canvas, Offset(12.0, size.height - lp.height - 4.0));
  }

  void _drawDashed(Canvas canvas, Offset a, Offset b, Paint paint) {
    const double dash = 5.0;
    const double gap = 4.0;
    final double dx = b.dx - a.dx;
    final double dy = b.dy - a.dy;
    final double len = math.sqrt(dx * dx + dy * dy);
    if (len < 0.001) return;
    final double ux = dx / len;
    final double uy = dy / len;
    double travelled = 0.0;
    while (travelled < len) {
      final double segEnd =
          (travelled + dash) < len ? (travelled + dash) : len;
      final Offset p1 = Offset(a.dx + ux * travelled, a.dy + uy * travelled);
      final Offset p2 = Offset(a.dx + ux * segEnd, a.dy + uy * segEnd);
      canvas.drawLine(p1, p2, paint);
      travelled = segEnd + gap;
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Rect rect,
    Color colour, {
    bool bold = false,
  }) {
    final TextSpan span = TextSpan(
      text: text,
      style: TextStyle(
        color: colour,
        fontSize: 11.5,
        fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
        height: 1.2,
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: rect.width - 8.0);
    final Offset offset = Offset(
      rect.center.dx - tp.width / 2.0,
      rect.center.dy - tp.height / 2.0,
    );
    tp.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _ReactiveTreePainter oldDelegate) => false;
}

class _TreeChild {
  const _TreeChild(this.label, this.reactive);
  final String label;
  final bool reactive;
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. All notifiers are
// constructed here, used to build the widget tree, and then left as-is.
// `notifyListeners()` is NEVER invoked after the tree is constructed so
// there are no rebuild loops.
// ===========================================================================
dynamic build(BuildContext context) {
  print('ChangeNotifier deep visual demo executing');
  final math.Random rng = math.Random(11);
  final int dummyEntropy = rng.nextInt(100);
  print('  rng warm-up: $dummyEntropy');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // The hero card explains what ChangeNotifier is and why Flutter ships a
  // family of Listenable types in the foundation library. The intro is a
  // gradient card with two columns: a title block and a list of bullets.
  // -------------------------------------------------------------------------
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF5E5CE6),
          Color(0xFF2F80ED),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x335E5CE6),
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
            Icon(Icons.podcasts, color: Color(0xFFFFFFFF), size: 32.0),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'ChangeNotifier & Listenable',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: -0.8,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Flutter\'s lightweight observable primitives',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'ChangeNotifier is the workhorse observable in Flutter. It exposes '
          'three things: addListener / removeListener (subscription) and '
          'notifyListeners (broadcast). Listenable is the abstract supertype '
          'shared with Animation<T>, so the same set of *Builder widgets - '
          'ListenableBuilder, AnimatedBuilder and ValueListenableBuilder - '
          'can react to controllers, value notifiers and custom models with '
          'no extra glue.',
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
          children: const <Widget>[
            _HeroChip('Foundation'),
            _HeroChip('Reactive'),
            _HeroChip('No Streams'),
            _HeroChip('Listenable'),
            _HeroChip('Provider-friendly'),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: const <Widget>[
            Icon(Icons.check_circle, color: Color(0xFFFFFFFF), size: 18.0),
            SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'Reach for ChangeNotifier when you want simple state with '
                'cheap diffing, no streams, no controllers, no scheduler.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xE6FFFFFF),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 - LISTENABLE HIERARCHY CUSTOMPAINTER
  // -------------------------------------------------------------------------
  // A static CustomPaint diagram shows the abstract Listenable root and the
  // three concrete leaves (ChangeNotifier, ValueNotifier<T>, Animation<T>).
  // Mixins/extends relationships are illustrated with arrows.
  // -------------------------------------------------------------------------
  final Widget hierarchyDiagram = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.account_tree, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Listenable hierarchy',
              subtitle:
                  'One abstract root, three concrete leaves that all expose addListener / removeListener',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 180.0,
          child: CustomPaint(
            size: Size.infinite,
            painter: const _HierarchyPainter(),
          ),
        ),
        const SizedBox(height: 8.0),
        _bullet(
          'Listenable defines just two methods: addListener(VoidCallback) and removeListener(VoidCallback).',
          colour: _kAccent,
        ),
        _bullet(
          'ChangeNotifier is the default implementation: stores listeners in a list, exposes notifyListeners().',
          colour: _kAccentGreen,
        ),
        _bullet(
          'ValueNotifier<T> extends ChangeNotifier and adds a single typed `value` field.',
          colour: _kAccentGreen,
        ),
        _bullet(
          'Animation<T> is a separate subclass; controllers (AnimationController) implement it directly.',
          colour: _kAccentGreen,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - CHANGENOTIFIER LIFECYCLE DIAGRAM
  // -------------------------------------------------------------------------
  // A horizontal flow:
  //
  //   addListener -> notifyListeners -> callback -> removeListener -> dispose
  //
  // The CustomPainter draws coloured pills with arrows between them.
  // -------------------------------------------------------------------------
  final Widget lifecycleDiagram = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.timeline, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'ChangeNotifier lifecycle',
              subtitle:
                  'addListener -> notifyListeners -> callback -> removeListener -> dispose',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 110.0,
          child: CustomPaint(
            size: Size.infinite,
            painter: const _LifecyclePainter(),
          ),
        ),
        const SizedBox(height: 6.0),
        _bullet(
          'addListener: hook a VoidCallback into the notifier. Cheap. Listeners are appended.',
          colour: _kAccentBlue,
        ),
        _bullet(
          'notifyListeners: synchronously calls every listener in registration order. Safe to add/remove during.',
          colour: _kAccent,
        ),
        _bullet(
          'callback: your code runs. Read the notifier, update local state, dispatch follow-up work.',
          colour: _kAccentTeal,
        ),
        _bullet(
          'removeListener: detach a previously-added callback. Idempotent if the listener is unknown.',
          colour: _kAccentAmber,
        ),
        _bullet(
          'dispose: drops every listener, marks the notifier as disposed; calling it twice throws.',
          colour: _kAccentRed,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - VALUENOTIFIER GALLERY
  // -------------------------------------------------------------------------
  // Six cards, one per generic type. Each card constructs a notifier with a
  // representative initial value and shows:
  //   * the declared generic parameter,
  //   * the current `.value`,
  //   * a ValueListenableBuilder that renders the value into the cell.
  //
  // The notifiers are constructed once during build. Because we never call
  // `value = ...` after the tree is constructed, no rebuild loops occur.
  // -------------------------------------------------------------------------
  final ValueNotifier<int> intNotifier = ValueNotifier<int>(42);
  final ValueNotifier<String> stringNotifier = ValueNotifier<String>('hi');
  final ValueNotifier<Color> colourNotifier = ValueNotifier<Color>(Colors.blue);
  final ValueNotifier<List<int>> listNotifier =
      ValueNotifier<List<int>>(<int>[]);
  final ValueNotifier<Map<String, int>> mapNotifier =
      ValueNotifier<Map<String, int>>(<String, int>{});
  final ValueNotifier<Object?> nullNotifier = ValueNotifier<Object?>(null);

  Widget _valueCard({
    required String typeLabel,
    required String currentDisplay,
    required Widget body,
    required Color colour,
  }) {
    return Container(
      width: 240.0,
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
          Row(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: colour.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  typeLabel,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: colour,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            'value:',
            style: _kCaptionStyle,
          ),
          Text(
            currentDisplay,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              color: _kInk,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6FA),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _kHairline),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.bolt, color: colour, size: 16.0),
                const SizedBox(width: 6.0),
                Expanded(child: body),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget valueCardInt = _valueCard(
    typeLabel: 'ValueNotifier<int>',
    currentDisplay: '${intNotifier.value}',
    colour: _kAccentBlue,
    body: ValueListenableBuilder<int>(
      valueListenable: intNotifier,
      builder: (BuildContext context, int value, Widget? child) {
        return Text(
          'rendered: $value',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: _kInk,
          ),
        );
      },
    ),
  );

  final Widget valueCardString = _valueCard(
    typeLabel: 'ValueNotifier<String>',
    currentDisplay: '"${stringNotifier.value}"',
    colour: _kAccentGreen,
    body: ValueListenableBuilder<String>(
      valueListenable: stringNotifier,
      builder: (BuildContext context, String value, Widget? child) {
        return Text(
          'rendered: "$value"',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: _kInk,
          ),
        );
      },
    ),
  );

  final Widget valueCardColour = _valueCard(
    typeLabel: 'ValueNotifier<Color>',
    currentDisplay:
        '#${colourNotifier.value.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
    colour: _kAccentTeal,
    body: ValueListenableBuilder<Color>(
      valueListenable: colourNotifier,
      builder: (BuildContext context, Color value, Widget? child) {
        return Row(
          children: <Widget>[
            Container(
              width: 18.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: value,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: _kHairline),
              ),
            ),
            const SizedBox(width: 6.0),
            const Text(
              'rendered swatch',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: _kInk,
              ),
            ),
          ],
        );
      },
    ),
  );

  final Widget valueCardList = _valueCard(
    typeLabel: 'ValueNotifier<List<int>>',
    currentDisplay: '${listNotifier.value}',
    colour: _kAccentAmber,
    body: ValueListenableBuilder<List<int>>(
      valueListenable: listNotifier,
      builder: (BuildContext context, List<int> value, Widget? child) {
        return Text(
          'len: ${value.length}',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: _kInk,
          ),
        );
      },
    ),
  );

  final Widget valueCardMap = _valueCard(
    typeLabel: 'ValueNotifier<Map<String,int>>',
    currentDisplay: '${mapNotifier.value}',
    colour: _kAccentPink,
    body: ValueListenableBuilder<Map<String, int>>(
      valueListenable: mapNotifier,
      builder:
          (BuildContext context, Map<String, int> value, Widget? child) {
        return Text(
          'keys: ${value.keys.length}',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: _kInk,
          ),
        );
      },
    ),
  );

  final Widget valueCardNull = _valueCard(
    typeLabel: 'ValueNotifier<Object?>',
    currentDisplay: '${nullNotifier.value}',
    colour: _kAccentRed,
    body: ValueListenableBuilder<Object?>(
      valueListenable: nullNotifier,
      builder: (BuildContext context, Object? value, Widget? child) {
        return Text(
          'rendered: ${value ?? "<null>"}',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: _kInk,
          ),
        );
      },
    ),
  );

  final Widget valueGallery = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.grid_view, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'ValueNotifier<T> gallery',
              subtitle:
                  'Six common generic parameters wired through ValueListenableBuilder',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            valueCardInt,
            valueCardString,
            valueCardColour,
            valueCardList,
            valueCardMap,
            valueCardNull,
          ],
        ),
        const SizedBox(height: 8.0),
        _bullet(
          'Each builder runs once during this build because no `.value = ...` is invoked afterwards.',
          colour: _kAccent,
        ),
        _bullet(
          'For collection types, prefer immutable replacement: notifier.value = [...old, x] (do not mutate in place).',
          colour: _kAccentAmber,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - LISTENABLE.MERGE DEMO
  // -------------------------------------------------------------------------
  // Three notifiers - one int, one string, one bool - are combined with
  // `Listenable.merge`. The merged listenable is the perfect input for an
  // AnimatedBuilder (which doesn't require an Animation, only a Listenable).
  // -------------------------------------------------------------------------
  final ValueNotifier<int> mergeCount = ValueNotifier<int>(7);
  final ValueNotifier<String> mergeLabel = ValueNotifier<String>('idle');
  final ValueNotifier<bool> mergeFlag = ValueNotifier<bool>(true);
  final Listenable merged =
      Listenable.merge(<Listenable>[mergeCount, mergeLabel, mergeFlag]);

  final Widget mergeDemo = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.merge_type, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Listenable.merge',
              subtitle:
                  'Forward notifications from N independent sources into a single Listenable',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6FA),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Inputs', style: _kCaptionStyle),
                    const SizedBox(height: 4.0),
                    Text(
                      'count = ${mergeCount.value}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                        color: _kInk,
                      ),
                    ),
                    Text(
                      'label = "${mergeLabel.value}"',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                        color: _kInk,
                      ),
                    ),
                    Text(
                      'flag  = ${mergeFlag.value}',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.5,
                        color: _kInk,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              Container(
                width: 1.0,
                height: 60.0,
                color: _kHairline,
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('AnimatedBuilder(listenable: merged)',
                        style: _kCaptionStyle),
                    const SizedBox(height: 4.0),
                    AnimatedBuilder(
                      animation: merged,
                      builder: (BuildContext context, Widget? child) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: _kAccent.withOpacity(0.10),
                            borderRadius: BorderRadius.circular(8.0),
                            border:
                                Border.all(color: _kAccent.withOpacity(0.3)),
                          ),
                          child: Text(
                            'snapshot: count=${mergeCount.value} '
                            'label="${mergeLabel.value}" '
                            'flag=${mergeFlag.value}',
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11.5,
                              color: _kInk,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _bullet(
          'Listenable.merge accepts any Iterable<Listenable?>; nulls are ignored.',
          colour: _kAccent,
        ),
        _bullet(
          'The merged Listenable does not own its inputs - dispose them yourself.',
          colour: _kAccentAmber,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - CUSTOM CHANGENOTIFIER CODE BLOCK
  // -------------------------------------------------------------------------
  // Shows the canonical CounterModel and a state-management discussion card.
  // -------------------------------------------------------------------------
  const String _counterModelCode =
      'class CounterModel extends ChangeNotifier {\n'
      '  int _v = 0;\n'
      '  int get v => _v;\n'
      '\n'
      '  void inc() {\n'
      '    _v++;\n'
      '    notifyListeners();\n'
      '  }\n'
      '\n'
      '  void reset() {\n'
      '    _v = 0;\n'
      '    notifyListeners();\n'
      '  }\n'
      '}\n';

  final Widget counterModelSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _codeBlock(_counterModelCode, title: 'counter_model.dart'),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.architecture, color: _kAccent, size: 20.0),
                const SizedBox(width: 6.0),
                _cardTitle(
                  'State management with ChangeNotifier',
                  subtitle:
                      'Why this 8-line class is the most common state pattern in Flutter',
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            _bullet(
              'Encapsulation: private `_v`, public getter `v` - the only mutation path is `inc()` / `reset()`.',
            ),
            _bullet(
              'Broadcast: a single notifyListeners() inside the mutator notifies all subscribers in O(N) time.',
            ),
            _bullet(
              'Composability: combine many models with Listenable.merge, MultiProvider or proxy providers.',
            ),
            _bullet(
              'Testability: pump a fresh CounterModel in a unit test, assert on `.v` after `.inc()`.',
            ),
            _bullet(
              'Dispose: when the owning widget is disposed, call `model.dispose()` to release listener refs.',
            ),
          ],
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - LISTENABLEBUILDER VS ANIMATEDBUILDER VS VALUELISTENABLEBUILDER
  // -------------------------------------------------------------------------
  // Comparison table and three side-by-side snippet cards.
  // -------------------------------------------------------------------------
  Widget _comparisonRow(
      String name, String input, String typed, String use) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                color: _kAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              input,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: _kInk,
              ),
            ),
          ),
          Expanded(
            child: Text(
              typed,
              style: const TextStyle(
                fontSize: 12.0,
                color: _kInkSecondary,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              use,
              style: _kBodyStyle,
            ),
          ),
        ],
      ),
    );
  }

  final Widget comparisonTable = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.compare_arrows, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Builders compared',
              subtitle:
                  'Pick the right *Builder for the listenable you have in hand',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: const BoxDecoration(
            color: Color(0xFFF5F6FA),
            border: Border(bottom: BorderSide(color: _kHairline)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text('Widget', style: _kCaptionStyle),
              ),
              Expanded(
                flex: 2,
                child: Text('Input', style: _kCaptionStyle),
              ),
              Expanded(
                child: Text('Typed?', style: _kCaptionStyle),
              ),
              Expanded(
                flex: 3,
                child: Text('When to use', style: _kCaptionStyle),
              ),
            ],
          ),
        ),
        _comparisonRow(
          'ListenableBuilder',
          'Listenable',
          'No',
          'Any Listenable - notifiers, controllers, merged. Use when you only need a "something changed" signal.',
        ),
        _comparisonRow(
          'AnimatedBuilder',
          'Listenable',
          'No',
          'Functionally identical to ListenableBuilder; idiomatic with Animation<T>. Older code uses it broadly.',
        ),
        _comparisonRow(
          'ValueListenableBuilder<T>',
          'ValueListenable<T>',
          'Yes',
          'When the source exposes a typed `.value` and you want it passed into your builder.',
        ),
      ],
    ),
  );

  const String _listenableBuilderSnippet =
      'ListenableBuilder(\n'
      '  listenable: controller,\n'
      '  builder: (context, child) {\n'
      '    return Text(controller.text);\n'
      '  },\n'
      ');\n';
  const String _animatedBuilderSnippet =
      'AnimatedBuilder(\n'
      '  animation: anim,\n'
      '  builder: (context, child) => Opacity(\n'
      '    opacity: anim.value,\n'
      '    child: child,\n'
      '  ),\n'
      '  child: const HeavyChild(),\n'
      ');\n';
  const String _valueListenableBuilderSnippet =
      'ValueListenableBuilder<int>(\n'
      '  valueListenable: counter,\n'
      '  builder: (context, value, child) {\n'
      '    return Text("Count: \$value");\n'
      '  },\n'
      ');\n';

  final Widget builderSnippets = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.code, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Side-by-side',
              subtitle:
                  'The minimal call sites for each builder, lined up for diffing',
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _codeBlock(_listenableBuilderSnippet, title: 'ListenableBuilder'),
        _codeBlock(_animatedBuilderSnippet, title: 'AnimatedBuilder'),
        _codeBlock(_valueListenableBuilderSnippet,
            title: 'ValueListenableBuilder<int>'),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - REACTIVE WIDGET TREE CUSTOMPAINTER
  // -------------------------------------------------------------------------
  // A diagram shows a Listenable on the left broadcasting to four widgets on
  // the right. Two of them subscribe (solid line, green) and rebuild; two
  // do not (dashed line, grey) and remain static.
  // -------------------------------------------------------------------------
  final Widget reactiveTree = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.hub, color: _kAccent, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Reactive widget tree',
              subtitle:
                  'Only widgets subscribed via *Builder rebuild when the source notifies',
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        SizedBox(
          height: 240.0,
          child: CustomPaint(
            size: Size.infinite,
            painter: const _ReactiveTreePainter(),
          ),
        ),
        const SizedBox(height: 6.0),
        _bullet(
          'Wrap the smallest possible subtree in a *Builder to minimise rebuild surface area.',
          colour: _kAccentGreen,
        ),
        _bullet(
          'Pass heavy static children through the `child` parameter so they are built once and reused.',
          colour: _kAccentGreen,
        ),
        _bullet(
          'Unsubscribed widgets ignore notifyListeners entirely; their `build` method does not run.',
          colour: _kInkSecondary,
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - PITFALLS
  // -------------------------------------------------------------------------
  // Six callouts. Use the warning palette to make them visually distinct from
  // the rest of the gallery.
  // -------------------------------------------------------------------------
  final Widget pitfalls = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.warning_amber, color: _kAccentAmber, size: 20.0),
            const SizedBox(width: 6.0),
            _cardTitle(
              'Pitfalls',
              subtitle: 'Six mistakes you will eventually make - and how to avoid them',
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _calloutRow(
          icon: Icons.delete_sweep,
          colour: _kAccentRed,
          title: 'Missing dispose leaks memory',
          body:
              'Every ChangeNotifier you own should be disposed in `State.dispose()`. Otherwise the framework keeps the listener list alive forever.',
        ),
        _calloutRow(
          icon: Icons.bug_report,
          colour: _kAccentRed,
          title: 'notifyListeners during build',
          body:
              'Calling `notifyListeners()` from within a synchronous build call schedules rebuilds while a build is in flight. Defer to `scheduleMicrotask` or trigger from event handlers only.',
        ),
        _calloutRow(
          icon: Icons.edit_off,
          colour: _kAccentAmber,
          title: 'Mutating a list/map in place',
          body:
              'ValueNotifier compares with `==`. Mutating `list.add(x)` does not change the reference, so no notification fires. Replace the value: `n.value = [...n.value, x]`.',
        ),
        _calloutRow(
          icon: Icons.link_off,
          colour: _kAccentAmber,
          title: 'removeListener after dispose',
          body:
              'After `dispose()` the listener list is cleared and further mutations throw. Always remove listeners in `dispose()` of the owning State before disposing the notifier.',
        ),
        _calloutRow(
          icon: Icons.layers,
          colour: _kAccentAmber,
          title: 'AnimatedBuilder rebuild too broad',
          body:
              'Wrap only the leaf that depends on the value. Heavy ancestors should sit outside the builder or come in via the `child` parameter to avoid pointless rebuilds.',
        ),
        _calloutRow(
          icon: Icons.lock_outline,
          colour: _kAccentRed,
          title: 'Capturing a notifier in a const constructor',
          body:
              'ChangeNotifier instances are mutable and identity-based; storing one in a const field defeats const canonicalisation and leaks across hot reloads. Pass it via a regular constructor parameter.',
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 10 - SIX IDIOMATIC CODE BLOCKS
  // -------------------------------------------------------------------------
  // Each block illustrates one canonical idiom. The strings are kept short
  // and self-contained so the screen-shot tells the whole story.
  // -------------------------------------------------------------------------
  const String _modelClassCode =
      'class TodoList extends ChangeNotifier {\n'
      '  final List<Todo> _items = <Todo>[];\n'
      '\n'
      '  List<Todo> get items => List<Todo>.unmodifiable(_items);\n'
      '\n'
      '  void add(Todo t) {\n'
      '    _items.add(t);\n'
      '    notifyListeners();\n'
      '  }\n'
      '\n'
      '  void toggle(int i) {\n'
      '    _items[i] = _items[i].copyWith(done: !_items[i].done);\n'
      '    notifyListeners();\n'
      '  }\n'
      '}\n';

  const String _proxyProviderCode =
      '// ProxyProvider: a derived model that depends on another notifier.\n'
      'ProxyProvider<AuthModel, ProfileModel>(\n'
      '  create: (_) => ProfileModel(),\n'
      '  update: (_, auth, prev) => prev!..bind(auth.user),\n'
      ');\n';

  const String _changeNotifierProviderCode =
      '// provider package - the standard ChangeNotifier wiring.\n'
      'ChangeNotifierProvider<CounterModel>(\n'
      '  create: (_) => CounterModel(),\n'
      '  child: const CounterScreen(),\n'
      ');\n'
      '\n'
      '// In the child:\n'
      'final c = context.watch<CounterModel>();\n'
      'Text("count: \${c.v}");\n';

  const String _animatedBuilderSelectorCode =
      '// AnimatedBuilder with a hand-rolled selector pattern.\n'
      'AnimatedBuilder(\n'
      '  animation: model,\n'
      '  builder: (context, child) {\n'
      '    final colour = model.theme.accent; // derived\n'
      '    return DecoratedBox(\n'
      '      decoration: BoxDecoration(color: colour),\n'
      '      child: child,\n'
      '    );\n'
      '  },\n'
      '  child: const HeavyContent(),\n'
      ');\n';

  const String _valueListenableOneLinerCode =
      '// A one-liner: render a single value with no boilerplate.\n'
      'ValueListenableBuilder<bool>(\n'
      '  valueListenable: model.isLoading,\n'
      '  builder: (_, busy, __) => busy\n'
      '      ? const CircularProgressIndicator()\n'
      '      : const Icon(Icons.check),\n'
      ');\n';

  const String _mergeCompositionCode =
      '// Compose multiple notifiers into a single Listenable.\n'
      'final composite = Listenable.merge(<Listenable>[\n'
      '  auth,\n'
      '  cart,\n'
      '  network,\n'
      ']);\n'
      '\n'
      'ListenableBuilder(\n'
      '  listenable: composite,\n'
      '  builder: (_, __) => StatusBar(\n'
      '    user: auth.user,\n'
      '    badge: cart.items.length,\n'
      '    online: network.online,\n'
      '  ),\n'
      ');\n';

  final Widget idiomCodeBlocks = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _codeBlock(_modelClassCode, title: 'a — model class with private state'),
      _codeBlock(_proxyProviderCode, title: 'b — ProxyProvider pattern'),
      _codeBlock(_changeNotifierProviderCode,
          title: 'c — ChangeNotifierProvider (provider package)'),
      _codeBlock(_animatedBuilderSelectorCode,
          title: 'd — AnimatedBuilder with a selector'),
      _codeBlock(_valueListenableOneLinerCode,
          title: 'e — ValueListenableBuilder one-liner'),
      _codeBlock(_mergeCompositionCode,
          title: 'f — Listenable.merge composition'),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 11 - FOOTER CHEAT-SHEET
  // -------------------------------------------------------------------------
  // Chip groups by category, with a tagline at the bottom.
  // -------------------------------------------------------------------------
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
            Icon(Icons.bookmarks, color: Color(0xFFFFD60A), size: 22.0),
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
          'The ChangeNotifier toolbox in four chip groups.',
          style: TextStyle(fontSize: 12.0, color: _kInkOnDarkSecondary),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _chipGroup(
              'FOUNDATION',
              const <String>[
                'Listenable',
                'ChangeNotifier',
                'ValueListenable<T>',
                'ValueNotifier<T>',
                'Animation<T>',
              ],
              _kAccent,
            ),
            _chipGroup(
              'WIDGETS',
              const <String>[
                'StatefulWidget',
                'State.dispose',
                'InheritedNotifier',
              ],
              _kAccentBlue,
            ),
            _chipGroup(
              'BUILDERS',
              const <String>[
                'ListenableBuilder',
                'AnimatedBuilder',
                'ValueListenableBuilder<T>',
              ],
              _kAccentGreen,
            ),
            _chipGroup(
              'SELECTORS',
              const <String>[
                'Selector<T,S>',
                'Consumer<T>',
                'context.watch<T>()',
                'context.select<T,S>()',
              ],
              _kAccentAmber,
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2F3A),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairlineDark),
          ),
          child: Row(
            children: <Widget>[
              const Icon(Icons.bolt, color: Color(0xFFFFD60A), size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Tagline: ChangeNotifier is the smallest reactive primitive '
                  'that scales from a single counter to a full app, as long '
                  'as you remember to dispose what you own and notify what '
                  'you mutate.',
                  style: const TextStyle(
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
  // Each section is preceded by a numbered header. The whole tree lives
  // inside a Material/Scaffold so the demo can render standalone.
  // -------------------------------------------------------------------------
  print('  building widget tree with 11 sections');
  final List<Widget> sectionWidgets = <Widget>[
    heroIntro,
    _sectionHeader(2, 'Hierarchy',
        'Listenable, ChangeNotifier, ValueNotifier<T>, Animation<T>'),
    hierarchyDiagram,
    _sectionHeader(3, 'Lifecycle',
        'addListener -> notifyListeners -> callback -> removeListener -> dispose'),
    lifecycleDiagram,
    _sectionHeader(4, 'ValueNotifier gallery',
        'Six typed notifiers piped through ValueListenableBuilder'),
    valueGallery,
    _sectionHeader(5, 'Listenable.merge',
        'Compose many notifiers into one Listenable'),
    mergeDemo,
    _sectionHeader(6, 'Custom ChangeNotifier',
        'CounterModel - the canonical 8-liner'),
    counterModelSection,
    _sectionHeader(7, 'Builders compared',
        'ListenableBuilder vs AnimatedBuilder vs ValueListenableBuilder'),
    comparisonTable,
    builderSnippets,
    _sectionHeader(8, 'Reactive tree',
        'Only *Builder subscribers rebuild on notify'),
    reactiveTree,
    _sectionDivider(),
    _sectionHeader(9, 'Pitfalls',
        'Six common ChangeNotifier mistakes'),
    pitfalls,
    _sectionHeader(10, 'Idioms',
        'Six idiomatic code blocks for everyday work'),
    idiomCodeBlocks,
    _sectionHeader(11, 'Cheat Sheet',
        'Chips, categories and a closing tagline'),
    cheatSheet,
  ];
  print('  section widget count: ${sectionWidgets.length}');

  final Widget app = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _kAccent,
      scaffoldBackgroundColor: _kCanvas,
      useMaterial3: false,
    ),
    home: Scaffold(
      backgroundColor: _kCanvas,
      appBar: AppBar(
        backgroundColor: _kCardBg,
        foregroundColor: _kInk,
        elevation: 0.5,
        title: const Text(
          'ChangeNotifier & Listenable',
          style: TextStyle(
            color: _kInk,
            fontWeight: FontWeight.w700,
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

  print('ChangeNotifier deep visual demo built successfully');
  return app;
}

// ---------------------------------------------------------------------------
// HERO CHIP
// ---------------------------------------------------------------------------
// Small const stateless widget used in the hero card. Kept private to the
// file. It uses translucent white over a gradient background so it reads
// well in both light and dark renders.
class _HeroChip extends StatelessWidget {
  const _HeroChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: const Color(0x66FFFFFF)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
