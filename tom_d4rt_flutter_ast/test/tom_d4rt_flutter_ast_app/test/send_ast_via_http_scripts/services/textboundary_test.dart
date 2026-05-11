// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, lines_longer_than_80_chars
// D4rt test script: Deep visual demo of flutter `services` TextBoundary.
//
// This file is part of the D4rt flutter-test corpus. It is intended to be
// executed by an analyzer-free, sandboxed Dart interpreter. The script
// exports exactly one top-level entry point - `dynamic build(BuildContext)` -
// which is invoked a single time and which returns a Widget tree.
//
// The rendered output is a long static gallery that walks through Flutter's
// `services` TextBoundary family - the family of classes that power text
// selection extension, word-by-word caret movement, screen-reader granularity
// changes and most of the keyboard shortcuts that any "real" rich-text
// editor needs to honour:
//
//   * TextBoundary             - abstract root, defines the three-method API
//   * CharacterBoundary        - grapheme-cluster boundaries (Characters pkg)
//   * WordBoundary             - locale-aware word boundaries (TextPainter)
//   * LineBoundary             - visual line boundaries (TextLayoutMetrics)
//   * ParagraphBoundary        - paragraph boundaries (split on `\n` / `\r\n`)
//   * DocumentBoundary         - the whole document as a single range
//
// Note: Flutter does NOT publish a `LineBreakBoundary` class. The line
// boundary the framework ships is `LineBoundary`, which wraps a
// `TextLayoutMetrics`. The "line break" section of this demo therefore uses
// `LineBoundary` as the concrete API and explains the naming explicitly.
//
// Because the script runs in a static, no-interaction environment, this file
// never calls `setState`, never spawns a `Timer`, never returns a `Future`
// and never instantiates an `AnimationController`. All "live" data is
// computed up-front and rendered into widgets.
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
// The demo uses literal ARGB colours instead of resolving against a theme
// because some helper widgets are constructed without a live Theme. The
// palette is loosely inspired by a "material-you" dark/light hybrid; the
// boundary types are colour-coded so the reader can recognise them across
// sections.
const Color _kCanvas = Color(0xFFF6F7FB);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardDark = Color(0xFF111319);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF14161B);
const Color _kInkSecondary = Color(0xFF40454F);
const Color _kInkTertiary = Color(0xFF8C92A0);
const Color _kInkOnDark = Color(0xFFEEF0F4);
const Color _kInkOnDarkSecondary = Color(0xFFA8AEBA);

// Per-boundary accent colours.
const Color _kAccentBoundary = Color(0xFF6750A4); // root TextBoundary
const Color _kAccentChar = Color(0xFF2563EB); // CharacterBoundary
const Color _kAccentWord = Color(0xFF059669); // WordBoundary
const Color _kAccentLine = Color(0xFFD97706); // LineBoundary
const Color _kAccentParagraph = Color(0xFFDB2777); // ParagraphBoundary
const Color _kAccentDocument = Color(0xFF0EA5E9); // DocumentBoundary
const Color _kAccentRed = Color(0xFFDC2626);

// Code block colours - "dracula-ish".
const Color _kCodeBg = Color(0xFF1B1D24);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);

// Painter-canvas backgrounds.
const Color _kCanvasInk = Color(0xFF1F2430);
const Color _kCanvasInkLight = Color(0xFFEAECF2);

// ---------------------------------------------------------------------------
// TEXT STYLES
// ---------------------------------------------------------------------------
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
const TextStyle _kMonoStyle = TextStyle(
  fontSize: 12.5,
  fontFamily: 'monospace',
  color: _kInk,
  height: 1.35,
);
const EdgeInsets _kCardPadding = EdgeInsets.all(18.0);
const EdgeInsets _kSectionPadding = EdgeInsets.symmetric(horizontal: 18.0);

// ---------------------------------------------------------------------------
// PRIVATE STRUCTURAL HELPERS
// ---------------------------------------------------------------------------
// All helpers below are top-level `_camelCase` functions that return
// `Widget`s. They are intentionally not wrapped in StatelessWidget subclasses
// so the file reads top-to-bottom in narrative order.

Widget _sectionHeader(int index, String title, String tagline, {Color colour = _kAccentBoundary}) {
  return Padding(
    padding: const EdgeInsets.only(top: 28.0, bottom: 12.0, left: 18.0, right: 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colour,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: colour.withOpacity(0.35),
                offset: const Offset(0.0, 2.0),
                blurRadius: 6.0,
              ),
            ],
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
  Color border = _kHairline,
}) {
  return Container(
    margin: margin,
    padding: padding,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: border),
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

Widget _cardTitle(String title, {String? subtitle, Color titleColor = _kInk, Color subtitleColor = _kInkSecondary, Color? accent}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          if (accent != null) ...<Widget>[
            Container(
              width: 4.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            const SizedBox(width: 8.0),
          ],
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: titleColor,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
      if (subtitle != null) ...<Widget>[
        const SizedBox(height: 4.0),
        Padding(
          padding: EdgeInsets.only(left: accent != null ? 12.0 : 0.0),
          child: Text(subtitle, style: TextStyle(fontSize: 12.5, color: subtitleColor)),
        ),
      ],
    ],
  );
}

Widget _pill(String label, {Color colour = _kAccentBoundary, Color? textColour}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 3.0),
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
        color: textColour ?? colour,
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
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0.0, 2.0),
          blurRadius: 6.0,
        ),
      ],
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

Widget _kvRow(String key, String value, {Color valueColour = _kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 110.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12.0,
              color: _kInkTertiary,
              fontWeight: FontWeight.w500,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.5,
              color: valueColour,
              fontWeight: FontWeight.w500,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// CUSTOMPAINTER 1 - BOUNDARY CLASS HIERARCHY DIAGRAM
// ---------------------------------------------------------------------------
// Renders a simple tree: `TextBoundary` at the top with five concrete
// subclasses dangling underneath. The painter is deliberately rectangular
// (no smooth curves) so the SemanticsBoundary-aware Flutter screen-reader
// can read its visual structure if requested.
class _HierarchyPainter extends CustomPainter {
  const _HierarchyPainter();

  static const List<_HierarchyNode> _children = <_HierarchyNode>[
    _HierarchyNode('CharacterBoundary', 'grapheme', _kAccentChar),
    _HierarchyNode('WordBoundary', 'locale word', _kAccentWord),
    _HierarchyNode('LineBoundary', 'visual line', _kAccentLine),
    _HierarchyNode('ParagraphBoundary', 'hard break', _kAccentParagraph),
    _HierarchyNode('DocumentBoundary', 'whole doc', _kAccentDocument),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = const Color(0xFFB8BEC9)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    // Root node.
    const double rootW = 200.0;
    const double rootH = 40.0;
    final double rootX = (size.width - rootW) / 2.0;
    const double rootY = 8.0;
    final Rect rootRect = Rect.fromLTWH(rootX, rootY, rootW, rootH);
    final Paint rootFill = Paint()..color = _kAccentBoundary;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rootRect, const Radius.circular(8.0)),
      rootFill,
    );
    final TextPainter rootLabel = TextPainter(
      text: const TextSpan(
        text: 'TextBoundary (abstract)',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    rootLabel.paint(
      canvas,
      Offset(
        rootRect.center.dx - rootLabel.width / 2.0,
        rootRect.center.dy - rootLabel.height / 2.0,
      ),
    );

    // Children evenly distributed.
    final int count = _children.length;
    final double slot = size.width / count;
    const double childY = 92.0;
    const double childH = 46.0;
    const double childW = 116.0;
    for (int i = 0; i < count; i++) {
      final _HierarchyNode node = _children[i];
      final double cx = slot * (i + 0.5);
      final Rect childRect = Rect.fromCenter(
        center: Offset(cx, childY + childH / 2.0),
        width: childW,
        height: childH,
      );
      final Paint childFill = Paint()..color = node.colour.withOpacity(0.18);
      final Paint childStroke = Paint()
        ..color = node.colour
        ..strokeWidth = 1.4
        ..style = PaintingStyle.stroke;
      final RRect rr = RRect.fromRectAndRadius(childRect, const Radius.circular(8.0));
      canvas.drawRRect(rr, childFill);
      canvas.drawRRect(rr, childStroke);

      // Connector line.
      final Offset top = Offset(cx, childRect.top);
      final Offset rootBottom = Offset(rootRect.center.dx, rootRect.bottom);
      canvas.drawLine(rootBottom, Offset(rootBottom.dx, rootY + rootH + 12.0), linePaint);
      canvas.drawLine(Offset(rootBottom.dx, rootY + rootH + 12.0), Offset(cx, rootY + rootH + 12.0), linePaint);
      canvas.drawLine(Offset(cx, rootY + rootH + 12.0), top, linePaint);

      // Title.
      final TextPainter titlePainter = TextPainter(
        text: TextSpan(
          text: node.name,
          style: TextStyle(
            color: node.colour,
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: childW - 4.0);
      titlePainter.paint(
        canvas,
        Offset(cx - titlePainter.width / 2.0, childRect.top + 6.0),
      );
      // Subtitle.
      final TextPainter subPainter = TextPainter(
        text: TextSpan(
          text: node.tag,
          style: const TextStyle(
            color: _kInkSecondary,
            fontSize: 10.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: childW - 4.0);
      subPainter.paint(
        canvas,
        Offset(cx - subPainter.width / 2.0, childRect.top + 22.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _HierarchyPainter oldDelegate) => false;
}

@immutable
class _HierarchyNode {
  const _HierarchyNode(this.name, this.tag, this.colour);
  final String name;
  final String tag;
  final Color colour;
}

// ---------------------------------------------------------------------------
// CUSTOMPAINTER 2 - LINE-BREAK OVERLAY
// ---------------------------------------------------------------------------
// Draws a single long paragraph laid out into a fixed-width box, then walks
// every visible line break and draws a dashed-ish red marker between lines
// to make the line iteration cost visible at a glance.
class _LineBreakOverlayPainter extends CustomPainter {
  _LineBreakOverlayPainter({required this.text, required this.style, required this.maxWidth});

  final String text;
  final TextStyle style;
  final double maxWidth;

  @override
  void paint(Canvas canvas, Size size) {
    // Layout the paragraph.
    final TextPainter painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    // Paint the text first.
    painter.paint(canvas, Offset.zero);

    // Draw a single-line break ruler on the right edge for each visible line.
    final Paint breakPaint = Paint()
      ..color = const Color(0xFFDC2626)
      ..strokeWidth = 1.2;

    // Walk every code unit and look up the line at that offset. Whenever the
    // line range changes, we draw a horizontal stripe on the right margin.
    int previousStart = -1;
    int previousEnd = -1;
    final List<TextBox> _ = const <TextBox>[]; // placeholder for tooling
    for (int i = 0; i <= text.length; i++) {
      final TextRange range = painter.getLineBoundary(TextPosition(offset: i));
      if (range.start != previousStart || range.end != previousEnd) {
        previousStart = range.start;
        previousEnd = range.end;
        if (range.start >= 0 && range.end >= range.start && range.start < text.length) {
          // Get the rect for the *start* of this line via getBoxesForSelection.
          final List<TextBox> boxes = painter.getBoxesForSelection(
            TextSelection(baseOffset: range.start, extentOffset: math.min(range.end, text.length)),
          );
          if (boxes.isNotEmpty) {
            final TextBox box = boxes.first;
            final double y = box.top;
            canvas.drawLine(
              Offset(-6.0, y),
              Offset(maxWidth + 8.0, y),
              breakPaint..color = const Color(0x22DC2626),
            );
            // Marker tab on the left for clarity.
            canvas.drawRect(
              Rect.fromLTWH(-8.0, y - 0.5, 4.0, box.bottom - box.top),
              Paint()..color = const Color(0xFFDC2626),
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LineBreakOverlayPainter oldDelegate) =>
      oldDelegate.text != text || oldDelegate.style != style || oldDelegate.maxWidth != maxWidth;
}

// ---------------------------------------------------------------------------
// BOUNDARY ANALYSIS HELPERS
// ---------------------------------------------------------------------------
// These helpers walk every offset of a string, ask the boundary for the
// leading / trailing edge, and return a list of small annotation cards.
// All of the work happens up-front so the build is purely declarative.

@immutable
class _BoundaryProbe {
  const _BoundaryProbe({
    required this.offset,
    required this.charBefore,
    required this.charAfter,
    required this.leading,
    required this.trailing,
    required this.range,
  });
  final int offset;
  final String charBefore;
  final String charAfter;
  final int? leading;
  final int? trailing;
  final TextRange range;
}

List<_BoundaryProbe> _probeCharacterBoundary(String text) {
  final CharacterBoundary boundary = CharacterBoundary(text);
  final List<_BoundaryProbe> out = <_BoundaryProbe>[];
  for (int i = 0; i <= text.length; i++) {
    final int? lead = boundary.getLeadingTextBoundaryAt(i);
    final int? trail = boundary.getTrailingTextBoundaryAt(i);
    final TextRange range = boundary.getTextBoundaryAt(i);
    final String before = i == 0 ? '' : text.substring(math.max(0, i - 1), i);
    final String after = i >= text.length ? '' : text.substring(i, math.min(text.length, i + 1));
    out.add(_BoundaryProbe(
      offset: i,
      charBefore: before,
      charAfter: after,
      leading: lead,
      trailing: trail,
      range: range,
    ));
  }
  return out;
}

List<_BoundaryProbe> _probeParagraphBoundary(String text) {
  final ParagraphBoundary boundary = ParagraphBoundary(text);
  final List<_BoundaryProbe> out = <_BoundaryProbe>[];
  for (int i = 0; i <= text.length; i++) {
    final int? lead = boundary.getLeadingTextBoundaryAt(i);
    final int? trail = boundary.getTrailingTextBoundaryAt(i);
    final TextRange range = boundary.getTextBoundaryAt(i);
    final String before = i == 0 ? '' : text.substring(math.max(0, i - 1), i);
    final String after = i >= text.length ? '' : text.substring(i, math.min(text.length, i + 1));
    out.add(_BoundaryProbe(
      offset: i,
      charBefore: before,
      charAfter: after,
      leading: lead,
      trailing: trail,
      range: range,
    ));
  }
  return out;
}

List<_BoundaryProbe> _probeDocumentBoundary(String text) {
  final DocumentBoundary boundary = DocumentBoundary(text);
  final List<_BoundaryProbe> out = <_BoundaryProbe>[];
  // Only sample a few representative offsets - the answer never changes.
  final List<int> samples = <int>[
    0,
    text.length ~/ 4,
    text.length ~/ 2,
    (3 * text.length) ~/ 4,
    text.length - 1,
    text.length,
  ];
  for (final int i in samples) {
    final int safe = math.max(0, math.min(i, text.length));
    final int? lead = boundary.getLeadingTextBoundaryAt(safe);
    final int? trail = boundary.getTrailingTextBoundaryAt(safe);
    final TextRange range = boundary.getTextBoundaryAt(safe);
    final String before = safe == 0 ? '' : text.substring(math.max(0, safe - 1), safe);
    final String after = safe >= text.length ? '' : text.substring(safe, math.min(text.length, safe + 1));
    out.add(_BoundaryProbe(
      offset: safe,
      charBefore: before,
      charAfter: after,
      leading: lead,
      trailing: trail,
      range: range,
    ));
  }
  return out;
}

// For words we can't construct a WordBoundary directly (its constructor is
// private). We compute boundaries via a layouted `TextPainter`.
List<_BoundaryProbe> _probeWordBoundaryViaPainter(String text, TextStyle style, double maxWidth) {
  final TextPainter painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);
  final List<_BoundaryProbe> out = <_BoundaryProbe>[];
  for (int i = 0; i <= text.length; i++) {
    final TextRange range = painter.getWordBoundary(TextPosition(offset: math.min(i, text.length)));
    final String before = i == 0 ? '' : text.substring(math.max(0, i - 1), i);
    final String after = i >= text.length ? '' : text.substring(i, math.min(text.length, i + 1));
    out.add(_BoundaryProbe(
      offset: i,
      charBefore: before,
      charAfter: after,
      leading: range.start,
      trailing: range.end,
      range: range,
    ));
  }
  return out;
}

// Lines come from a layouted `TextPainter.getLineBoundary`.
List<_BoundaryProbe> _probeLineBoundaryViaPainter(String text, TextStyle style, double maxWidth) {
  final TextPainter painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )..layout(maxWidth: maxWidth);
  final List<_BoundaryProbe> out = <_BoundaryProbe>[];
  // Sample one offset per line - we walk every code unit and only emit a
  // probe when the line range changes. That keeps the visual list short.
  int previousStart = -2;
  int previousEnd = -2;
  for (int i = 0; i <= text.length; i++) {
    final TextRange range = painter.getLineBoundary(TextPosition(offset: math.min(i, text.length)));
    if (range.start != previousStart || range.end != previousEnd) {
      previousStart = range.start;
      previousEnd = range.end;
      final String before = i == 0 ? '' : text.substring(math.max(0, i - 1), i);
      final String after = i >= text.length ? '' : text.substring(i, math.min(text.length, i + 1));
      out.add(_BoundaryProbe(
        offset: i,
        charBefore: before,
        charAfter: after,
        leading: range.start,
        trailing: range.end,
        range: range,
      ));
    }
  }
  return out;
}

// Renders a single probe as an "annotation card" - a tiny chip showing
// `offset / leading / trailing` plus the surrounding characters.
Widget _probeCard(_BoundaryProbe probe, {required Color accent}) {
  final String beforeDisplay = probe.charBefore.isEmpty ? '◁' : probe.charBefore;
  final String afterDisplay = probe.charAfter.isEmpty ? '▷' : probe.charAfter;
  return Container(
    margin: const EdgeInsets.all(3.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: accent.withOpacity(0.07),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withOpacity(0.25)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '#${probe.offset}',
              style: TextStyle(
                fontSize: 10.5,
                color: accent,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(width: 6.0),
            Text(
              '$beforeDisplay|$afterDisplay',
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                color: _kInk,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 3.0),
        Text(
          'lead=${probe.leading ?? "null"}, trail=${probe.trailing ?? "null"}',
          style: const TextStyle(
            fontSize: 10.0,
            color: _kInkSecondary,
            fontFamily: 'monospace',
          ),
        ),
        Text(
          'range=[${probe.range.start},${probe.range.end})',
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

Widget _probeGrid(List<_BoundaryProbe> probes, {required Color accent}) {
  return Wrap(
    spacing: 0.0,
    runSpacing: 0.0,
    children: probes.map((_BoundaryProbe p) => _probeCard(p, accent: accent)).toList(),
  );
}

// Renders a small "string ruler" that places every code unit in a column with
// its index underneath. Each cell is colour-coded if it's a high or low
// surrogate to make grapheme clusters discoverable visually.
Widget _stringRuler(String text, {required Color accent}) {
  final List<Widget> cells = <Widget>[];
  for (int i = 0; i < text.length; i++) {
    final int unit = text.codeUnitAt(i);
    final bool isHighSurrogate = unit >= 0xD800 && unit <= 0xDBFF;
    final bool isLowSurrogate = unit >= 0xDC00 && unit <= 0xDFFF;
    final Color cellColor = isHighSurrogate
        ? const Color(0xFFFFEDD5)
        : isLowSurrogate
            ? const Color(0xFFFEF3C7)
            : _kCardBg;
    final String label = (isHighSurrogate || isLowSurrogate)
        ? '0x${unit.toRadixString(16).toUpperCase().padLeft(4, "0")}'
        : text.substring(i, i + 1);
    cells.add(Container(
      width: 28.0,
      margin: const EdgeInsets.symmetric(horizontal: 1.0),
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: cellColor,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: isHighSurrogate || isLowSurrogate ? 9.0 : 13.0,
              fontWeight: FontWeight.w600,
              color: _kInk,
              fontFamily: 'monospace',
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            '$i',
            style: TextStyle(
              fontSize: 9.0,
              color: accent,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ));
  }
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(children: cells),
  );
}

// ---------------------------------------------------------------------------
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls `build` exactly once. We compute all probe data
// up-front, log a short summary via `print`, and return a deep `ListView`-
// like widget tree wrapped in a SingleChildScrollView.
// ===========================================================================
dynamic build(BuildContext context) {
  print('Services TextBoundary deep visual demo executing');
  final math.Random rng = math.Random(11);
  final int warmUp = rng.nextInt(1000);
  print('  rng warm-up: $warmUp');

  // -------------------------------------------------------------------------
  // SAMPLE TEXTS
  // -------------------------------------------------------------------------
  // The character sample is deliberately mixed: ASCII letters, an em-dash,
  // ASCII space, a flag emoji (which is a country code: regional indicator
  // U+1F1FA + U+1F1F8 → 🇺🇸), and a trailing ASCII word. This exercises
  // grapheme clustering across surrogate pairs.
  const String charSample = 'Hello — Flutter 🇺🇸 family';
  const String wordSample = 'The quick brown fox jumps over the lazy dog.';
  const String paragraphSample =
      'TextBoundary describes how to walk\n'
      'text in editor-friendly units.\n'
      'It is locale and grapheme aware.\n'
      'Use it for caret motion and selection.';
  const String longParagraph =
      'TextBoundary is the abstract base class that every editor-aware text '
      'iterator in Flutter extends from. Selection extension, double-tap to '
      'select word, word-wise delete, screen-reader granularity, all rely on '
      'one of these boundaries under the hood. The class itself is tiny - '
      'three methods, all overridable, all default-implemented in terms of '
      'each other - but the concrete subclasses encapsulate non-trivial '
      'platform behaviour: locale-aware word breaking, grapheme clustering, '
      'visual line wrapping and paragraph splitting on hard line terminators.';
  const String docSample =
      'This is a tiny document.\n'
      'Two paragraphs, twenty-something tokens, four lines if it wraps.';

  print('  charSample length: ${charSample.length}');
  print('  wordSample length: ${wordSample.length}');
  print('  paragraphSample length: ${paragraphSample.length}');

  // -------------------------------------------------------------------------
  // PROBE COMPUTATIONS
  // -------------------------------------------------------------------------
  // Each boundary type is probed across its sample. WordBoundary and
  // LineBoundary need a layouted TextPainter; we construct one per probe
  // helper rather than sharing state.
  final List<_BoundaryProbe> charProbes = _probeCharacterBoundary(charSample);
  final List<_BoundaryProbe> wordProbes = _probeWordBoundaryViaPainter(
    wordSample,
    const TextStyle(fontSize: 14.0, color: _kInk, height: 1.4),
    320.0,
  );
  final List<_BoundaryProbe> lineProbes = _probeLineBoundaryViaPainter(
    longParagraph,
    const TextStyle(fontSize: 14.0, color: _kInk, height: 1.45),
    320.0,
  );
  final List<_BoundaryProbe> paragraphProbes = _probeParagraphBoundary(paragraphSample);
  final List<_BoundaryProbe> docProbes = _probeDocumentBoundary(docSample);

  print('  charProbes: ${charProbes.length}');
  print('  wordProbes: ${wordProbes.length}');
  print('  lineProbes: ${lineProbes.length}');
  print('  paragraphProbes: ${paragraphProbes.length}');
  print('  docProbes: ${docProbes.length}');

  // -------------------------------------------------------------------------
  // SECTION 1 - HERO INTRO
  // -------------------------------------------------------------------------
  // Big gradient card explaining what TextBoundary is, why it matters and
  // where it sits relative to text editing and accessibility.
  final Widget heroIntro = Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 8.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF6750A4),
          Color(0xFF2563EB),
        ],
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x336750A4),
          offset: Offset(0.0, 6.0),
          blurRadius: 18.0,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.text_fields, color: Color(0xFFFFFFFF), size: 30.0),
            SizedBox(width: 12.0),
            Text(
              'TextBoundary',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFFFFFFFF),
                letterSpacing: -0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Editor-aware iteration over a string of text',
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xCCFFFFFF),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'TextBoundary is the abstract base of every editor-aware text iterator in '
          'Flutter. Its concrete subclasses tell the framework where one grapheme '
          'cluster ends and the next begins, where one word ends and the next begins, '
          'where a visual line wraps, where a paragraph terminates and where the '
          'document begins and ends. Every selection-extension keyboard shortcut, '
          'every screen-reader granularity change, every double-tap-to-select-word '
          'and every triple-tap-to-select-line in EditableText eventually consults '
          'one of these boundaries.',
          style: TextStyle(
            fontSize: 14.0,
            height: 1.55,
            color: Color(0xFFFFFFFF),
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('Editor-aware', colour: const Color(0xFFFFFFFF), textColour: Colors.white),
            _pill('Grapheme-safe', colour: const Color(0xFFFFFFFF), textColour: Colors.white),
            _pill('Locale-aware', colour: const Color(0xFFFFFFFF), textColour: Colors.white),
            _pill('Accessibility', colour: const Color(0xFFFFFFFF), textColour: Colors.white),
            _pill('flutter/services', colour: const Color(0xFFFFFFFF), textColour: Colors.white),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          children: <Widget>[
            const Icon(Icons.bolt, color: Color(0xFFFFFFFF), size: 18.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'Three methods: getLeadingTextBoundaryAt, getTrailingTextBoundaryAt, '
                'getTextBoundaryAt. Two are default-implemented in terms of the third.',
                style: const TextStyle(
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
  // SECTION 2 - HIERARCHY DIAGRAM
  // -------------------------------------------------------------------------
  // CustomPainter that renders an abstract root with five concrete leaves.
  // The diagram clarifies which boundary type belongs to which "unit".
  final Widget hierarchyCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Boundary class hierarchy',
          subtitle: 'TextBoundary (abstract) and its five concrete subclasses',
          accent: _kAccentBoundary,
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 160.0,
          child: CustomPaint(
            painter: const _HierarchyPainter(),
            size: const Size(double.infinity, 160.0),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'Every concrete subclass overrides at least one of the three methods on '
          'TextBoundary. CharacterBoundary, ParagraphBoundary and DocumentBoundary '
          'live in flutter/services and only need a `String`. WordBoundary and '
          'LineBoundary live in flutter/painting and flutter/services respectively '
          'and require layout information (a `TextPainter` for WordBoundary, a '
          '`TextLayoutMetrics` for LineBoundary).',
          style: _kCaptionStyle.copyWith(height: 1.5),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 - CHARACTERBOUNDARY LIVE DEMO
  // -------------------------------------------------------------------------
  // Walk every offset of `charSample` and show what
  // `getLeadingTextBoundaryAt` / `getTrailingTextBoundaryAt` return. A ruler
  // visualises surrogate pairs so the reader can see why offsets aren't 1:1
  // with visible characters.
  final Widget charBoundaryCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'CharacterBoundary',
          subtitle: 'Grapheme clusters from the Characters package',
          accent: _kAccentChar,
        ),
        const SizedBox(height: 10.0),
        Text(
          'Sample: "$charSample"',
          style: _kBodyStyle.copyWith(fontFamily: 'monospace'),
        ),
        const SizedBox(height: 8.0),
        Text(
          'String length: ${charSample.length} code units, '
          '${charSample.characters.length} grapheme clusters. The flag 🇺🇸 is two '
          'regional indicator code points, each a surrogate pair, totalling four '
          'UTF-16 code units but rendering as one user-perceived character.',
          style: _kCaptionStyle.copyWith(height: 1.5),
        ),
        const SizedBox(height: 12.0),
        _stringRuler(charSample, accent: _kAccentChar),
        const SizedBox(height: 14.0),
        Text(
          'Probes - one per code-unit offset:',
          style: _kCaptionStyle.copyWith(color: _kAccentChar, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6.0),
        _probeGrid(charProbes, accent: _kAccentChar),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kAccentChar.withOpacity(0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentChar.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('length', '${charSample.length} code units'),
              _kvRow('graphemes', '${charSample.characters.length}'),
              _kvRow('runtimeType', '${CharacterBoundary(charSample).runtimeType}'),
              _kvRow('superclass', 'TextBoundary'),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 - WORDBOUNDARY LIVE DEMO
  // -------------------------------------------------------------------------
  // WordBoundary's constructor is library-private (`WordBoundary._`). The
  // public way to obtain one is via `TextPainter.wordBoundary`, but even
  // simpler is calling `TextPainter.getWordBoundary(TextPosition)` directly.
  // We do the latter and document the rationale.
  final Widget wordBoundaryCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'WordBoundary',
          subtitle: 'Locale-aware word boundaries via TextPainter.getWordBoundary',
          accent: _kAccentWord,
        ),
        const SizedBox(height: 10.0),
        Text(
          'Sample: "$wordSample"',
          style: _kBodyStyle.copyWith(fontFamily: 'monospace'),
        ),
        const SizedBox(height: 8.0),
        Text(
          'WordBoundary delegates to the underlying `ui.Paragraph.getWordBoundary`, '
          'which uses ICU/CFStringTokenizer/uax-29 (depending on platform) to '
          'compute word breaks. Because the boundary needs a layouted paragraph, '
          'its constructor is library-private; obtain a WordBoundary via '
          '`TextPainter.wordBoundary` or just call `TextPainter.getWordBoundary` '
          'directly.',
          style: _kCaptionStyle.copyWith(height: 1.5),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: _kAccentWord.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentWord.withOpacity(0.2)),
          ),
          child: Text(
            wordSample,
            style: const TextStyle(
              fontSize: 14.0,
              color: _kInk,
              height: 1.4,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          'Probes - one per code-unit offset:',
          style: _kCaptionStyle.copyWith(color: _kAccentWord, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6.0),
        _probeGrid(wordProbes, accent: _kAccentWord),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kAccentWord.withOpacity(0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentWord.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('words', '${wordSample.split(RegExp(r"\s+")).length}'),
              _kvRow('whitespace', 'reported as its own range'),
              _kvRow('locale', 'inherited from TextPainter.locale'),
              _kvRow('construct', 'TextPainter.wordBoundary'),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 - LINE BOUNDARY LIVE DEMO
  // -------------------------------------------------------------------------
  // Flutter's API surface uses `LineBoundary` for visual line wrapping.
  // (The spec in this file refers to it as "LineBreakBoundary" - that name
  // does not exist in flutter/services. `LineBoundary` is the actual class.)
  // We layout a long paragraph in a fixed-width box, ask for the line range
  // at every offset and visualise breaks with a CustomPainter overlay.
  final Widget lineBoundaryCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'LineBoundary',
          subtitle: 'Visual line breaks via TextLayoutMetrics / TextPainter',
          accent: _kAccentLine,
        ),
        const SizedBox(height: 10.0),
        Text(
          'Note: the spec for this demo asked for "LineBreakBoundary"; the actual '
          'class shipped in flutter/services is `LineBoundary`, which wraps a '
          '`TextLayoutMetrics` (most commonly a `TextPainter`). The naming below '
          'follows the real API.',
          style: _kCaptionStyle.copyWith(height: 1.5, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 12.0),
        Container(
          width: 320.0 + 16.0,
          padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0, bottom: 8.0),
          decoration: BoxDecoration(
            color: _kAccentLine.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentLine.withOpacity(0.2)),
          ),
          child: SizedBox(
            height: 230.0,
            width: 320.0,
            child: CustomPaint(
              painter: _LineBreakOverlayPainter(
                text: longParagraph,
                style: const TextStyle(fontSize: 14.0, color: _kInk, height: 1.45),
                maxWidth: 320.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          'One probe per visible line:',
          style: _kCaptionStyle.copyWith(color: _kAccentLine, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6.0),
        _probeGrid(lineProbes, accent: _kAccentLine),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kAccentLine.withOpacity(0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentLine.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('depends on', 'TextLayoutMetrics'),
              _kvRow('cost', 'O(n) iteration, layout-bound'),
              _kvRow('reflows', 'on TextPainter.layout(maxWidth)'),
              _kvRow('used by', 'caret motion, line-selection'),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 - DOCUMENTBOUNDARY CARD
  // -------------------------------------------------------------------------
  // Trivial: the boundary is always `[0, text.length)` for any position
  // inside the document.
  final Widget documentBoundaryCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'DocumentBoundary',
          subtitle: 'Whole document as one logical range',
          accent: _kAccentDocument,
        ),
        const SizedBox(height: 10.0),
        Text(
          'Sample: "$docSample"',
          style: _kBodyStyle.copyWith(fontFamily: 'monospace'),
        ),
        const SizedBox(height: 8.0),
        Text(
          'DocumentBoundary always returns 0 from getLeadingTextBoundaryAt and '
          'text.length from getTrailingTextBoundaryAt, regardless of the offset '
          'passed in (with bounds-checking nulls at the very edges). It is the '
          'boundary used for "select all", "go to start of document" and similar '
          'document-wise commands.',
          style: _kCaptionStyle.copyWith(height: 1.5),
        ),
        const SizedBox(height: 12.0),
        _probeGrid(docProbes, accent: _kAccentDocument),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kAccentDocument.withOpacity(0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentDocument.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('always', '[0, text.length)'),
              _kvRow('runtimeType', '${DocumentBoundary(docSample).runtimeType}'),
              _kvRow('null at', 'position < 0 (leading)'),
              _kvRow('null at', 'position >= length (trailing)'),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 - PARAGRAPHBOUNDARY DEMO
  // -------------------------------------------------------------------------
  // Paragraph splits happen on hard line terminators (`\n`, `\r\n`, U+2028
  // etc.) - distinct from visual line wrapping (LineBoundary).
  final Widget paragraphBoundaryCard = _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'ParagraphBoundary',
          subtitle: 'Hard line-terminator splits',
          accent: _kAccentParagraph,
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kAccentParagraph.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentParagraph.withOpacity(0.2)),
          ),
          child: Text(
            paragraphSample,
            style: const TextStyle(
              fontSize: 13.5,
              color: _kInk,
              height: 1.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          'Paragraphs are split on hard line terminators only - U+000A (LF), '
          'U+000D (CR), CRLF, U+0085 (NEL), U+2028 (LS), U+2029 (PS). Visual line '
          'wrapping at the right edge of a text box does NOT create new paragraphs. '
          'That is what distinguishes ParagraphBoundary from LineBoundary.',
          style: _kCaptionStyle.copyWith(height: 1.5),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Annotated probes:',
          style: _kCaptionStyle.copyWith(color: _kAccentParagraph, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6.0),
        _probeGrid(paragraphProbes, accent: _kAccentParagraph),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kAccentParagraph.withOpacity(0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kAccentParagraph.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('separator', 'LF / CR / CRLF / LS / PS'),
              _kvRow('runtimeType', '${ParagraphBoundary(paragraphSample).runtimeType}'),
              _kvRow('used by', 'block-level ops, paragraph nav'),
              _kvRow('layout-free', 'true - only needs the String'),
            ],
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 - COMPARISON TABLE
  // -------------------------------------------------------------------------
  // Five rows: Boundary type / unit size / surrogate-aware / locale-aware /
  // keyboard shortcut consumer.
  Widget _tableCell(String text, {Color colour = _kInk, FontWeight weight = FontWeight.w500, double fontSize = 12.5, TextAlign align = TextAlign.left}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: colour,
          fontWeight: weight,
          fontFamily: 'monospace',
          height: 1.4,
        ),
        textAlign: align,
      ),
    );
  }

  Widget _tableHeaderCell(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      color: _kInk,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11.5,
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  final Widget comparisonTableCard = _card(
    padding: const EdgeInsets.all(0.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: Table(
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2.2),
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(1.2),
          3: FlexColumnWidth(1.2),
          4: FlexColumnWidth(2.2),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.symmetric(
          inside: const BorderSide(color: _kHairline),
        ),
        children: <TableRow>[
          TableRow(
            children: <Widget>[
              _tableHeaderCell('Boundary type'),
              _tableHeaderCell('Unit size'),
              _tableHeaderCell('Surrogate-aware'),
              _tableHeaderCell('Locale-aware'),
              _tableHeaderCell('Keyboard shortcut'),
            ],
          ),
          TableRow(
            decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
            children: <Widget>[
              _tableCell('CharacterBoundary', colour: _kAccentChar, weight: FontWeight.w700),
              _tableCell('grapheme cluster'),
              _tableCell('YES'),
              _tableCell('—'),
              _tableCell('←/→ caret motion'),
            ],
          ),
          TableRow(
            children: <Widget>[
              _tableCell('WordBoundary', colour: _kAccentWord, weight: FontWeight.w700),
              _tableCell('locale word'),
              _tableCell('YES (via Paragraph)'),
              _tableCell('YES'),
              _tableCell('Ctrl/⌥ + ←/→'),
            ],
          ),
          TableRow(
            decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
            children: <Widget>[
              _tableCell('LineBoundary', colour: _kAccentLine, weight: FontWeight.w700),
              _tableCell('visual line'),
              _tableCell('YES (via Paragraph)'),
              _tableCell('partial (BiDi)'),
              _tableCell('Home / End'),
            ],
          ),
          TableRow(
            children: <Widget>[
              _tableCell('ParagraphBoundary', colour: _kAccentParagraph, weight: FontWeight.w700),
              _tableCell('hard-terminator block'),
              _tableCell('NO (UTF-16 scan)'),
              _tableCell('—'),
              _tableCell('Ctrl + ↑/↓'),
            ],
          ),
          TableRow(
            decoration: const BoxDecoration(color: Color(0xFFF8FAFC)),
            children: <Widget>[
              _tableCell('DocumentBoundary', colour: _kAccentDocument, weight: FontWeight.w700),
              _tableCell('whole document'),
              _tableCell('—'),
              _tableCell('—'),
              _tableCell('Ctrl/⌘ + Home/End'),
            ],
          ),
        ],
      ),
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 - SIX CODE-BLOCK CARDS (DARK)
  // -------------------------------------------------------------------------
  // Each block illustrates an idiomatic selection-handling pattern using one
  // of the boundary classes plus `TextSelection.expandToInclude`. The sixth
  // block sketches a custom-boundary skeleton.

  const String code1 = '// 1. Expand a collapsed caret to the surrounding grapheme.\n'
      'TextSelection _selectGrapheme(String text, TextSelection sel) {\n'
      '  final boundary = CharacterBoundary(text);\n'
      '  final range = boundary.getTextBoundaryAt(sel.baseOffset);\n'
      '  final unit = TextSelection(\n'
      '    baseOffset: range.start,\n'
      '    extentOffset: range.end,\n'
      '  );\n'
      '  return sel.expandToInclude(unit);\n'
      '}';

  const String code2 = '// 2. Word-wise expansion using TextPainter.getWordBoundary.\n'
      'TextSelection _selectWord(TextPainter painter, TextSelection sel) {\n'
      '  final range = painter.getWordBoundary(\n'
      '    TextPosition(offset: sel.baseOffset),\n'
      '  );\n'
      '  return sel.expandToInclude(\n'
      '    TextSelection(\n'
      '      baseOffset: range.start,\n'
      '      extentOffset: range.end,\n'
      '    ),\n'
      '  );\n'
      '}';

  const String code3 = '// 3. Line-wise expansion via LineBoundary.\n'
      'TextSelection _selectLine(TextLayoutMetrics metrics, int offset, TextSelection sel) {\n'
      '  const boundary = LineBoundary; // type-only reference\n'
      '  final lb = LineBoundary(metrics);\n'
      '  final range = lb.getTextBoundaryAt(offset);\n'
      '  return sel.expandToInclude(\n'
      '    TextSelection(\n'
      '      baseOffset: range.start,\n'
      '      extentOffset: range.end,\n'
      '    ),\n'
      '  );\n'
      '}';

  const String code4 = '// 4. Paragraph-wise expansion (hard-break units).\n'
      'TextSelection _selectParagraph(String text, TextSelection sel) {\n'
      '  final boundary = ParagraphBoundary(text);\n'
      '  final start = boundary.getLeadingTextBoundaryAt(sel.baseOffset) ?? 0;\n'
      '  final end = boundary.getTrailingTextBoundaryAt(sel.extentOffset) ?? text.length;\n'
      '  return sel.expandToInclude(\n'
      '    TextSelection(baseOffset: start, extentOffset: end),\n'
      '  );\n'
      '}';

  const String code5 = '// 5. Select-all via DocumentBoundary.\n'
      'TextSelection _selectAll(String text) {\n'
      '  final boundary = DocumentBoundary(text);\n'
      '  return TextSelection(\n'
      '    baseOffset: boundary.getLeadingTextBoundaryAt(0) ?? 0,\n'
      '    extentOffset: boundary.getTrailingTextBoundaryAt(0) ?? text.length,\n'
      '  );\n'
      '}';

  const String code6 = '// 6. Custom boundary skeleton (sentence-by-sentence, English).\n'
      'class _SentenceBoundary extends TextBoundary {\n'
      '  const _SentenceBoundary(this._text);\n'
      '  final String _text;\n'
      '\n'
      '  static const _terminators = <int>{0x2E, 0x21, 0x3F}; // . ! ?\n'
      '\n'
      '  @override\n'
      '  int? getLeadingTextBoundaryAt(int position) {\n'
      '    if (position < 0 || _text.isEmpty) return null;\n'
      '    var i = math.min(position, _text.length - 1);\n'
      '    while (i > 0) {\n'
      '      if (_terminators.contains(_text.codeUnitAt(i - 1))) return i;\n'
      '      i--;\n'
      '    }\n'
      '    return 0;\n'
      '  }\n'
      '\n'
      '  @override\n'
      '  int? getTrailingTextBoundaryAt(int position) {\n'
      '    if (position >= _text.length) return null;\n'
      '    var i = math.max(0, position);\n'
      '    while (i < _text.length) {\n'
      '      if (_terminators.contains(_text.codeUnitAt(i))) return i + 1;\n'
      '      i++;\n'
      '    }\n'
      '    return _text.length;\n'
      '  }\n'
      '}';

  // -------------------------------------------------------------------------
  // SECTION 10 - PITFALLS
  // -------------------------------------------------------------------------
  Widget _pitfall(String title, String body, {Color colour = _kAccentRed, IconData icon = Icons.warning_amber}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colour.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: colour, size: 22.0),
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
                const SizedBox(height: 4.0),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: _kInk,
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

  // -------------------------------------------------------------------------
  // SECTION 11 - FOOTER CHEAT-SHEET
  // -------------------------------------------------------------------------
  Widget _chipGroup(String title, List<String> chips, {Color colour = _kAccentBoundary}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: colour.withOpacity(0.2)),
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
            ),
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: chips.map<Widget>((String c) => _pill(c, colour: colour)).toList(),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // FINAL TREE ASSEMBLY
  // -------------------------------------------------------------------------
  // Build the gallery as a `Column` inside a `SingleChildScrollView`. Every
  // section is gated by a `_sectionHeader` and an explanatory blurb where
  // necessary.

  final List<Widget> tree = <Widget>[];

  // Hero.
  tree.add(heroIntro);

  // Section 2 - Hierarchy.
  tree.add(_sectionHeader(
    2,
    'Class hierarchy',
    'How the five concrete boundaries inherit from the abstract root',
    colour: _kAccentBoundary,
  ));
  tree.add(hierarchyCard);

  // Section 3 - CharacterBoundary.
  tree.add(_sectionHeader(
    3,
    'CharacterBoundary',
    'Grapheme clusters across surrogate pairs',
    colour: _kAccentChar,
  ));
  tree.add(charBoundaryCard);

  // Section 4 - WordBoundary.
  tree.add(_sectionHeader(
    4,
    'WordBoundary',
    'Locale-aware word breaking via a layouted TextPainter',
    colour: _kAccentWord,
  ));
  tree.add(wordBoundaryCard);

  // Section 5 - LineBoundary.
  tree.add(_sectionHeader(
    5,
    'LineBoundary',
    'Visual line breaks for caret motion and selection',
    colour: _kAccentLine,
  ));
  tree.add(lineBoundaryCard);

  // Section 6 - DocumentBoundary.
  tree.add(_sectionHeader(
    6,
    'DocumentBoundary',
    'The whole document as one logical range',
    colour: _kAccentDocument,
  ));
  tree.add(documentBoundaryCard);

  // Section 7 - ParagraphBoundary.
  tree.add(_sectionHeader(
    7,
    'ParagraphBoundary',
    'Hard line-terminator splits, layout-free',
    colour: _kAccentParagraph,
  ));
  tree.add(paragraphBoundaryCard);

  // Section 8 - Comparison.
  tree.add(_sectionHeader(
    8,
    'Comparison',
    'Side-by-side properties of each boundary type',
    colour: _kAccentBoundary,
  ));
  tree.add(comparisonTableCard);

  // Section 9 - Code blocks.
  tree.add(_sectionHeader(
    9,
    'Selection-handling idioms',
    'Six dark code blocks - one per boundary, plus a custom-boundary skeleton',
    colour: _kInk,
  ));
  tree.add(_codeBlock(code1, title: 'grapheme.dart'));
  tree.add(_codeBlock(code2, title: 'word.dart'));
  tree.add(_codeBlock(code3, title: 'line.dart'));
  tree.add(_codeBlock(code4, title: 'paragraph.dart'));
  tree.add(_codeBlock(code5, title: 'document.dart'));
  tree.add(_codeBlock(code6, title: 'custom_sentence_boundary.dart'));

  // Section 10 - Pitfalls.
  tree.add(_sectionHeader(
    10,
    'Pitfalls',
    'Common ways code that "works for ASCII" silently corrupts real text',
    colour: _kAccentRed,
  ));
  tree.add(_pitfall(
    'Surrogate-pair miscounting',
    'String.length returns UTF-16 code units, NOT grapheme clusters. The flag '
    '🇺🇸 is four code units but one user-perceived character. Always use '
    'CharacterBoundary (or the Characters package) before deleting or moving '
    'the caret - otherwise you will split a surrogate pair and produce an '
    'invalid string.',
  ));
  tree.add(_pitfall(
    'Locale-specific word boundaries',
    'WordBoundary depends on the platform\'s ICU word-break rules and the '
    'paragraph\'s Locale. "I.B.M." breaks into three words in en_US but stays '
    'as one in many CJK locales. Never hard-code regex `\\W` as a substitute '
    'for WordBoundary; always layout a real TextPainter with the correct '
    'locale.',
    colour: const Color(0xFFB45309),
    icon: Icons.translate,
  ));
  tree.add(_pitfall(
    'LineBoundary iteration cost',
    'Each LineBoundary call ultimately calls into the platform paragraph and '
    'is amortised over a single layout. Calling it in a tight loop across '
    'tens of thousands of code units AND re-laying out the paragraph between '
    'calls turns selection extension into a soft hang. Cache the TextPainter '
    'whenever you can.',
    colour: const Color(0xFFD97706),
    icon: Icons.speed,
  ));
  tree.add(_pitfall(
    'RTL edge cases',
    'In bidirectional text, "previous" and "next" do NOT always correspond to '
    'the leading and trailing offsets of a boundary. A WordBoundary range '
    'that crosses a BiDi run might map to two visually distinct rectangles '
    'when you ask for getBoxesForSelection. Test with mixed Hebrew/Arabic + '
    'Latin samples before shipping.',
    colour: const Color(0xFF7C3AED),
    icon: Icons.swap_horiz,
  ));
  tree.add(_pitfall(
    'Mixing boundary results across layouts',
    'WordBoundary and LineBoundary are tied to a specific layouted paragraph. '
    'If you reuse a range computed against an old TextPainter (different '
    'maxWidth, different textScaler, different fontSize) the offsets may '
    'still be valid as integers but the geometry will be wrong. Recompute '
    'on every relayout.',
    colour: const Color(0xFF0EA5E9),
    icon: Icons.layers,
  ));

  // Section 11 - Cheat-sheet footer.
  tree.add(_sectionHeader(
    11,
    'Cheat-sheet',
    'Boundary classes, TextSelection helpers, TextPainter integration',
    colour: _kAccentBoundary,
  ));
  tree.add(_chipGroup(
    'Boundary classes',
    const <String>[
      'TextBoundary',
      'CharacterBoundary',
      'WordBoundary',
      'LineBoundary',
      'ParagraphBoundary',
      'DocumentBoundary',
    ],
    colour: _kAccentBoundary,
  ));
  tree.add(_chipGroup(
    'TextSelection helpers',
    const <String>[
      'TextSelection',
      'TextSelection.collapsed',
      'TextSelection.fromPosition',
      'expandToInclude',
      'isCollapsed',
      'baseOffset / extentOffset',
      'TextRange',
      'TextPosition',
    ],
    colour: _kAccentChar,
  ));
  tree.add(_chipGroup(
    'TextPainter integration',
    const <String>[
      'TextPainter.layout(maxWidth:)',
      'TextPainter.getWordBoundary',
      'TextPainter.getLineBoundary',
      'TextPainter.getOffsetBefore',
      'TextPainter.getOffsetAfter',
      'TextPainter.getBoxesForSelection',
      'TextLayoutMetrics',
    ],
    colour: _kAccentWord,
  ));
  tree.add(_chipGroup(
    'Keyboard shortcuts they power',
    const <String>[
      '←/→ char',
      'Ctrl/⌥ + ←/→ word',
      'Home / End line',
      'Ctrl + ↑/↓ paragraph',
      'Ctrl/⌘ + Home/End doc',
      'Shift +  ↑/↓ extend',
      'Double-tap word',
      'Triple-tap line',
    ],
    colour: _kAccentLine,
  ));
  tree.add(Padding(
    padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 40.0),
    child: Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFF111319),
            Color(0xFF1F2430),
          ],
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.format_quote, color: Color(0xFFE6E6E6), size: 28.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'TextBoundary in one line',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: _kInkOnDarkSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '"Three methods. Five concrete subclasses. Every selection-aware '
                  'shortcut in Flutter lives or dies by these objects."',
                  style: TextStyle(
                    fontSize: 14.5,
                    color: _kInkOnDark,
                    height: 1.45,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ));

  print('Services TextBoundary deep visual demo completed (${tree.length} top-level widgets)');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: tree,
      ),
    ),
  );
}
