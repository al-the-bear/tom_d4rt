// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: Spell-check support in `package:flutter/services.dart`.
//
// This file is a hand-authored corpus entry that exercises the spell-check
// surface area: `SuggestionSpan`, `SpellCheckResults`, `SpellCheckService`,
// `DefaultSpellCheckService`, and `SpellCheckConfiguration`. It renders a
// fully styled, scrollable poster — section cards with gradients, multi-layer
// shadows, anatomy diagrams via a `CustomPainter` (squiggly underlines over
// real text), tables, palette wraps and code-snippet cards.
//
// The script does NOT call platform APIs. Every `SpellCheckResults` instance
// is constructed manually with the values an Android or iOS bridge would
// realistically produce. Interaction is scoped to chips inside a
// `StatefulBuilder`, which lets a reader pick a suggestion and watch the
// preview update without using a top-level `setState`.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────
// Painter: draws a wavy / squiggly underline beneath spans of text.
// ─────────────────────────────────────────────────────────────────────────
class _SquigglyTextPainter extends CustomPainter {
  _SquigglyTextPainter({
    required this.text,
    required this.spans,
    required this.style,
    required this.underlineColor,
    this.highlightedIndex = -1,
    this.highlightColor = const Color(0xFF7C2D12),
  });

  final String text;
  final List<SuggestionSpan> spans;
  final TextStyle style;
  final Color underlineColor;
  static const double amplitude = 1.6;
  static const double wavelength = 4.0;
  final int highlightedIndex;
  final Color highlightColor;

  @override
  void paint(Canvas canvas, Size size) {
    final TextPainter tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    tp.layout(maxWidth: size.width);
    tp.paint(canvas, const Offset(0, 0));

    for (int i = 0; i < spans.length; i++) {
      final SuggestionSpan span = spans[i];
      final TextRange range = span.range;
      if (range.start < 0 || range.end > text.length) {
        continue;
      }
      final List<TextBox> boxes = tp.getBoxesForSelection(
        TextSelection(baseOffset: range.start, extentOffset: range.end),
      );
      final Paint paint = Paint()
        ..color = (i == highlightedIndex) ? highlightColor : underlineColor
        ..strokeWidth = (i == highlightedIndex) ? 2.0 : 1.4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..isAntiAlias = true;
      for (final TextBox box in boxes) {
        final double baseY = box.bottom + 1.5;
        final Path path = Path();
        path.moveTo(box.left, baseY);
        double x = box.left;
        bool up = true;
        while (x < box.right) {
          final double nextX = (x + wavelength).clamp(box.left, box.right);
          final double midX = (x + nextX) / 2.0;
          final double controlY = baseY + (up ? -amplitude : amplitude);
          path.quadraticBezierTo(midX, controlY, nextX, baseY);
          up = !up;
          x = nextX;
        }
        canvas.drawPath(path, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SquigglyTextPainter old) {
    return old.text != text ||
        old.spans != spans ||
        old.highlightedIndex != highlightedIndex ||
        old.underlineColor != underlineColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Painter: draws the platform delivery flow as a static diagram.
// ─────────────────────────────────────────────────────────────────────────
class _PlatformFlowPainter extends CustomPainter {
  _PlatformFlowPainter({
    required this.nodeColor,
    required this.edgeColor,
    required this.labelColor,
  });

  final Color nodeColor;
  final Color edgeColor;
  final Color labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    final List<String> labels = <String>[
      'EditableText',
      'SpellCheckConfiguration',
      'DefaultSpellCheckService',
      'Platform Channel',
      'OS Spell Engine',
    ];
    final double rowHeight = size.height / labels.length;
    final Paint nodePaint = Paint()..color = nodeColor;
    final Paint edgePaint = Paint()
      ..color = edgeColor
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < labels.length; i++) {
      final double cy = rowHeight * i + rowHeight / 2;
      final RRect node = RRect.fromRectAndRadius(
        Rect.fromLTWH(8, cy - 12, size.width - 16, 24),
        const Radius.circular(6),
      );
      canvas.drawRRect(node, nodePaint);

      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: labelColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: size.width - 24);
      tp.paint(canvas, Offset(16, cy - tp.height / 2));

      if (i < labels.length - 1) {
        canvas.drawLine(
          Offset(size.width / 2, cy + 12),
          Offset(size.width / 2, cy + rowHeight - 12),
          edgePaint,
        );
        final Path arrow = Path()
          ..moveTo(size.width / 2 - 4, cy + rowHeight - 16)
          ..lineTo(size.width / 2, cy + rowHeight - 10)
          ..lineTo(size.width / 2 + 4, cy + rowHeight - 16);
        canvas.drawPath(arrow, edgePaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PlatformFlowPainter old) {
    return old.nodeColor != nodeColor ||
        old.edgeColor != edgeColor ||
        old.labelColor != labelColor;
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Top-level harness: MaterialApp → Scaffold → SafeArea → Scroll → Column.
// ─────────────────────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  // ─── Palette: amber / rose / slate ───
  const Color amber = Color(0xFFD97706);
  const Color amberDeep = Color(0xFF92400E);
  const Color amberLight = Color(0xFFFEF3C7);
  const Color rose = Color(0xFFE11D48);
  const Color roseLight = Color(0xFFFFE4E6);
  const Color roseDeep = Color(0xFF881337);
  const Color slate = Color(0xFF334155);
  const Color slateDeep = Color(0xFF0F172A);
  const Color slateLight = Color(0xFFE2E8F0);
  const Color paper = Color(0xFFFFFBEB);
  const Color sand = Color(0xFFFDE68A);
  const Color sky = Color(0xFF0EA5E9);

  print('===== SPELL CHECK DEEP VISUAL DEMO =====');

  // ─── Worked example: misspelled paragraph + spans ───
  const String paragraph =
      'Ths is a sentance with severl misspellings to be flaged.';
  // Index map for the words we will mark as misspelled:
  //   "Ths"     → 0..3
  //   "sentance"→ 10..18
  //   "severl"  → 19..25
  //   "flaged"  → 49..55
  final List<SuggestionSpan> paragraphSpans = <SuggestionSpan>[
    SuggestionSpan(const TextRange(start: 0, end: 3),
        const <String>['This', 'Thus', 'The']),
    SuggestionSpan(const TextRange(start: 10, end: 18),
        const <String>['sentence', 'sentience', 'instance']),
    SuggestionSpan(const TextRange(start: 19, end: 25),
        const <String>['several', 'severe', 'sever']),
    SuggestionSpan(const TextRange(start: 49, end: 55),
        const <String>['flagged', 'flagger', 'fledged']),
  ];
  final SpellCheckResults paragraphResults =
      SpellCheckResults(paragraph, paragraphSpans);

  // ─── Sample card data: three suggestion spans ───
  final SuggestionSpan sampleSpanA = SuggestionSpan(
    const TextRange(start: 0, end: 5),
    const <String>['hello', 'hallo', 'hullo'],
  );
  final SuggestionSpan sampleSpanB = SuggestionSpan(
    const TextRange(start: 6, end: 11),
    const <String>['world', 'would', 'word'],
  );
  final SuggestionSpan sampleSpanC = SuggestionSpan(
    const TextRange(start: 12, end: 17),
    const <String>['today', 'todays', 'toyota'],
  );
  final SpellCheckResults sampleResults = SpellCheckResults(
    'helo wrold today',
    <SuggestionSpan>[sampleSpanA, sampleSpanB, sampleSpanC],
  );

  // ─── Configuration constructors ───
  final SpellCheckConfiguration defaultConfig = SpellCheckConfiguration(
    spellCheckService: DefaultSpellCheckService(),
    misspelledTextStyle: const TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: rose,
      decorationStyle: TextDecorationStyle.wavy,
    ),
  );
  const SpellCheckConfiguration disabledConfig =
      SpellCheckConfiguration.disabled();
  final SpellCheckConfiguration customServiceConfig = SpellCheckConfiguration(
    spellCheckService: DefaultSpellCheckService(),
    misspelledTextStyle: const TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: amber,
      decorationStyle: TextDecorationStyle.dashed,
    ),
  );
  final SpellCheckConfiguration toolbarConfig = SpellCheckConfiguration(
    spellCheckService: DefaultSpellCheckService(),
    misspelledTextStyle: const TextStyle(
      decoration: TextDecoration.underline,
      decorationColor: sky,
      decorationStyle: TextDecorationStyle.wavy,
    ),
    spellCheckSuggestionsToolbarBuilder: (BuildContext ctx, dynamic state) {
      return const SizedBox.shrink();
    },
  );

  print('paragraph spans: ${paragraphResults.suggestionSpans.length}');
  print('sample spans: ${sampleResults.suggestionSpans.length}');
  print('default enabled: ${defaultConfig.spellCheckEnabled}');
  print('disabled flag: ${disabledConfig.spellCheckEnabled}');
  print('custom service flag: ${customServiceConfig.spellCheckEnabled}');
  print('toolbar builder set: ${toolbarConfig.spellCheckSuggestionsToolbarBuilder != null}');

  // ─── Local widget helpers ───────────────────────────────────────────────

  Widget sectionBanner(String number, String title, List<Color> gradient) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 28, bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.45),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.18),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(19),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.55),
                width: 1.4,
              ),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget proseBox(String text, {Color? bg, Color? border}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg ?? paper,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border ?? sand),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: amber.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          height: 1.55,
          color: slateDeep.withValues(alpha: 0.92),
        ),
      ),
    );
  }

  Widget infoCard(String heading, Widget content,
      {List<Color>? headerGradient, Color? bodyColor}) {
    final List<Color> gradient =
        headerGradient ?? <Color>[amberDeep, amber];
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: bodyColor ?? Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: slateLight),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.07),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
          BoxShadow(
            color: gradient.first.withValues(alpha: 0.10),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Text(
              heading,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(14), child: content),
        ],
      ),
    );
  }

  Widget dataRow(String label, String value, {Color? labelColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: labelColor ?? slateDeep,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 12, color: slate),
            ),
          ),
        ],
      ),
    );
  }

  Widget chipTag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: bg.withValues(alpha: 0.30),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }

  Widget codeSnippetCard(String title, String code, {Color? accent}) {
    final Color a = accent ?? sky;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: slateDeep,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: slateDeep.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: a.withValues(alpha: 0.18),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
              color: a.withValues(alpha: 0.20),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(9)),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFB7185),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFCD34D),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34D399),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              code,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 12,
                height: 1.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget squigglyParagraph({
    required String text,
    required List<SuggestionSpan> spans,
    int highlightedIndex = -1,
    Color background = paper,
    Color border = sand,
    Color underline = rose,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: border),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: roseDeep.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        height: 36,
        width: double.infinity,
        child: CustomPaint(
          painter: _SquigglyTextPainter(
            text: text,
            spans: spans,
            style: const TextStyle(
              fontSize: 15,
              color: slateDeep,
              fontWeight: FontWeight.w500,
              fontFamily: 'monospace',
            ),
            underlineColor: underline,
            highlightedIndex: highlightedIndex,
            highlightColor: amberDeep,
          ),
        ),
      ),
    );
  }

  Widget suggestionWrap(List<String> suggestions, {Color? bg, Color? fg}) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: <Widget>[
        for (final String s in suggestions)
          chipTag(s, bg ?? amberLight, fg ?? amberDeep),
      ],
    );
  }

  // ───────────────────────────────────────────────────────────────────────
  // Section 1 — Overview
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 1] Overview');

  final Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '01',
        'Spell-Check in package:flutter/services',
        <Color>[amberDeep, rose],
      ),
      proseBox(
        'Flutter exposes spell-checking through four cooperating types in '
        '`package:flutter/services.dart`. `SuggestionSpan` is the smallest '
        'unit: it pairs a `TextRange` over the source text with a list of '
        'replacement strings. `SpellCheckResults` bundles the original text '
        'with every span the engine produced. `SpellCheckService` is the '
        'abstract contract callers implement (or accept the default of). '
        '`SpellCheckConfiguration` is the lightweight value object editable '
        'widgets accept to opt into or out of the entire pipeline. Together '
        'they make spell-check fully testable without ever calling into the '
        'native platform.',
      ),
      infoCard(
        'Core Types',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('SuggestionSpan', 'TextRange + List<String> suggestions'),
            dataRow('SpellCheckResults', 'spellCheckedText + spans list'),
            dataRow('SpellCheckService', 'abstract; fetchSpellCheckSuggestions'),
            dataRow('DefaultSpellCheckService',
                'Platform-channel-backed concrete impl'),
            dataRow('SpellCheckConfiguration', 'Wires it into EditableText'),
          ],
        ),
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 2 — Misspelled paragraph with squiggly underlines
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 2] Worked example');

  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '02',
        'Worked Example — Misspelled Paragraph',
        <Color>[rose, amberDeep],
      ),
      proseBox(
        'The card below renders a deliberately misspelled paragraph with '
        'wavy red underlines drawn by `_SquigglyTextPainter`. Each underline '
        'corresponds to one `SuggestionSpan` in `paragraphResults`. Tap a '
        'chip below the paragraph to highlight which span that chip belongs '
        'to: the highlighted span flips to an amber bolder squiggle. No '
        'platform call is made — the spans were authored in code and would '
        'in production come from `DefaultSpellCheckService` after a round '
        'trip through `SystemChannels.spellCheck`.',
      ),
      StatefulBuilder(
        builder: (BuildContext ctx, StateSetter localSet) {
          int highlighted = -1;
          int? pickedSpan;
          int? pickedSuggestion;

          return StatefulBuilder(
            builder: (BuildContext ctx2, StateSetter set2) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  squigglyParagraph(
                    text: paragraphResults.spellCheckedText,
                    spans: paragraphResults.suggestionSpans,
                    highlightedIndex: highlighted,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Misspelled words (tap to highlight):',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: slateDeep,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: <Widget>[
                      for (int i = 0;
                          i < paragraphResults.suggestionSpans.length;
                          i++)
                        GestureDetector(
                          onTap: () {
                            set2(() {
                              highlighted = (highlighted == i) ? -1 : i;
                              pickedSpan = highlighted >= 0 ? i : null;
                              pickedSuggestion = null;
                            });
                          },
                          child: chipTag(
                            paragraph.substring(
                              paragraphResults
                                  .suggestionSpans[i].range.start,
                              paragraphResults.suggestionSpans[i].range.end,
                            ),
                            highlighted == i ? roseDeep : roseLight,
                            highlighted == i ? Colors.white : roseDeep,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (pickedSpan != null)
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: amberLight,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sand),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Suggestions for "${paragraph.substring(paragraphResults.suggestionSpans[pickedSpan!].range.start, paragraphResults.suggestionSpans[pickedSpan!].range.end)}":',
                            style: TextStyle(
                              fontSize: 12,
                              color: amberDeep,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: <Widget>[
                              for (int j = 0;
                                  j <
                                      paragraphResults
                                          .suggestionSpans[pickedSpan!]
                                          .suggestions
                                          .length;
                                  j++)
                                GestureDetector(
                                  onTap: () => set2(() {
                                    pickedSuggestion = j;
                                  }),
                                  child: chipTag(
                                    paragraphResults
                                        .suggestionSpans[pickedSpan!]
                                        .suggestions[j],
                                    pickedSuggestion == j
                                        ? amberDeep
                                        : Colors.white,
                                    pickedSuggestion == j
                                        ? Colors.white
                                        : amberDeep,
                                  ),
                                ),
                            ],
                          ),
                          if (pickedSuggestion != null) ...<Widget>[
                            const SizedBox(height: 8),
                            Text(
                              'Replace: "${paragraph.substring(paragraphResults.suggestionSpans[pickedSpan!].range.start, paragraphResults.suggestionSpans[pickedSpan!].range.end)}" '
                              '→ "${paragraphResults.suggestionSpans[pickedSpan!].suggestions[pickedSuggestion!]}"',
                              style: TextStyle(
                                fontSize: 12,
                                color: roseDeep,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 3 — Sample SpellCheckResults rendered as a card
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 3] Sample SpellCheckResults card');

  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '03',
        'Sample SpellCheckResults Card',
        <Color>[sky, slateDeep],
      ),
      proseBox(
        'A `SpellCheckResults` instance carries the exact text the spell '
        'engine examined plus a list of `SuggestionSpan`s. Below, the sample '
        'string `"helo wrold today"` has three spans. Each row shows the '
        'span\'s `TextRange`, the substring it covers, and the candidate '
        'replacements. In production the order of suggestions matters: '
        'engines typically return them ranked by confidence, and a toolbar '
        'will preserve that order when offering choices to the user.',
      ),
      infoCard(
        'SpellCheckResults snapshot',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('spellCheckedText', '"${sampleResults.spellCheckedText}"'),
            dataRow('suggestionSpans.length',
                '${sampleResults.suggestionSpans.length}'),
            dataRow('runtimeType', '${sampleResults.runtimeType}'),
          ],
        ),
        headerGradient: <Color>[sky, slate],
      ),
      for (int i = 0; i < sampleResults.suggestionSpans.length; i++)
        infoCard(
          'Span #$i — '
          '${sampleResults.spellCheckedText.substring(sampleResults.suggestionSpans[i].range.start, sampleResults.suggestionSpans[i].range.end)}',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              dataRow(
                'range.start',
                '${sampleResults.suggestionSpans[i].range.start}',
              ),
              dataRow(
                'range.end',
                '${sampleResults.suggestionSpans[i].range.end}',
              ),
              dataRow(
                'covers',
                '"${sampleResults.spellCheckedText.substring(sampleResults.suggestionSpans[i].range.start, sampleResults.suggestionSpans[i].range.end)}"',
              ),
              dataRow(
                'suggestions.length',
                '${sampleResults.suggestionSpans[i].suggestions.length}',
              ),
              const SizedBox(height: 8),
              suggestionWrap(sampleResults.suggestionSpans[i].suggestions),
            ],
          ),
          headerGradient: <Color>[amber, rose],
          bodyColor: paper,
        ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 4 — TextRange ↔ SuggestionSpan anatomy
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 4] TextRange / SuggestionSpan anatomy');

  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '04',
        'TextRange ↔ SuggestionSpan Anatomy',
        <Color>[slate, sky],
      ),
      proseBox(
        '`SuggestionSpan` is essentially a `TextRange` plus suggestions. The '
        '`TextRange` uses UTF-16 code-unit offsets matching `String.substring` '
        'and `TextEditingValue.text`. Below, the diagram renders the sample '
        'text with the painter and shows the same offsets in a side table. '
        'The painter calls `TextPainter.getBoxesForSelection` to convert the '
        'range to pixel rectangles, which is exactly what Flutter\'s '
        '`EditableText` does to position its wavy decoration.',
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[paper, amberLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: sand),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: amber.withValues(alpha: 0.10),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Anatomy diagram',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: amberDeep,
                ),
              ),
              const SizedBox(height: 10),
              squigglyParagraph(
                text: sampleResults.spellCheckedText,
                spans: sampleResults.suggestionSpans,
                underline: rose,
                background: Colors.white,
                border: slateLight,
              ),
              const SizedBox(height: 14),
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: IntrinsicColumnWidth(),
                  2: FlexColumnWidth(),
                },
                border: TableBorder.all(color: slateLight),
                children: <TableRow>[
                  TableRow(
                    decoration: BoxDecoration(color: sand),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text('start',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: amberDeep)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text('end',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: amberDeep)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text('substring',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: amberDeep)),
                      ),
                    ],
                  ),
                  for (final SuggestionSpan s in sampleResults.suggestionSpans)
                    TableRow(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text('${s.range.start}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'monospace')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text('${s.range.end}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'monospace')),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            '"${sampleResults.spellCheckedText.substring(s.range.start, s.range.end)}"',
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: roseDeep),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 5 — SpellCheckConfiguration constructors
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 5] SpellCheckConfiguration constructors');

  final Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '05',
        'SpellCheckConfiguration Constructors',
        <Color>[amber, rose],
      ),
      proseBox(
        '`SpellCheckConfiguration` is the value object that `EditableText`, '
        '`TextField`, and `CupertinoTextField` consume. The default constructor '
        'accepts a service, a misspelled text style, and an optional toolbar '
        'builder; passing `null` for `spellCheckService` falls back to the '
        'platform default. The `SpellCheckConfiguration.disabled()` constant '
        'constructor turns the whole pipeline off explicitly — useful when '
        'you want to be unambiguous in tests. The cards below show the four '
        'configurations constructed at the top of this file.',
      ),
      infoCard(
        'defaultConfig — DefaultSpellCheckService, wavy red',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('spellCheckEnabled',
                '${defaultConfig.spellCheckEnabled}'),
            dataRow('service',
                '${defaultConfig.spellCheckService.runtimeType}'),
            dataRow('decoration',
                '${defaultConfig.misspelledTextStyle?.decoration}'),
            dataRow('decorationStyle',
                '${defaultConfig.misspelledTextStyle?.decorationStyle}'),
            dataRow('toolbar', defaultConfig
                        .spellCheckSuggestionsToolbarBuilder ==
                    null
                ? 'platform default'
                : 'custom'),
          ],
        ),
        headerGradient: <Color>[amberDeep, rose],
      ),
      infoCard(
        'disabledConfig — SpellCheckConfiguration.disabled()',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('spellCheckEnabled',
                '${disabledConfig.spellCheckEnabled}'),
            dataRow('service', '${disabledConfig.spellCheckService}'),
            dataRow('toolbar', disabledConfig
                        .spellCheckSuggestionsToolbarBuilder ==
                    null
                ? 'n/a (disabled)'
                : 'set'),
            dataRow('use case',
                'Tests, kiosks, locked-down UI, secure entry'),
          ],
        ),
        headerGradient: <Color>[slate, slateDeep],
      ),
      infoCard(
        'customServiceConfig — dashed amber underline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('spellCheckEnabled',
                '${customServiceConfig.spellCheckEnabled}'),
            dataRow('service',
                '${customServiceConfig.spellCheckService.runtimeType}'),
            dataRow('decoration',
                '${customServiceConfig.misspelledTextStyle?.decoration}'),
            dataRow('decorationStyle',
                '${customServiceConfig.misspelledTextStyle?.decorationStyle}'),
            dataRow(
                'note', 'In real code substitute your own SpellCheckService'),
          ],
        ),
        headerGradient: <Color>[amber, amberDeep],
      ),
      infoCard(
        'toolbarConfig — custom toolbarBuilder',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('spellCheckEnabled',
                '${toolbarConfig.spellCheckEnabled}'),
            dataRow('decoration',
                '${toolbarConfig.misspelledTextStyle?.decoration}'),
            dataRow('decorationColor',
                '${toolbarConfig.misspelledTextStyle?.decorationColor}'),
            dataRow(
                'toolbar',
                toolbarConfig.spellCheckSuggestionsToolbarBuilder != null
                    ? 'present'
                    : 'absent'),
            dataRow(
                'returns', 'A no-op SizedBox.shrink() for demo purposes'),
          ],
        ),
        headerGradient: <Color>[sky, slate],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 6 — Platform delivery flow (static visualisation)
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 6] Platform delivery flow');

  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '06',
        'Platform Delivery — DefaultSpellCheckService',
        <Color>[slateDeep, sky],
      ),
      proseBox(
        'On a real device, `DefaultSpellCheckService.fetchSpellCheckSuggestions` '
        'hops the request from Dart to the host platform across a method '
        'channel. The diagram below sketches that flow. No platform call is '
        'made here: the diagram is a static `CustomPainter` rendering. In '
        'production the data on the return trip is exactly a '
        '`SpellCheckResults` with `spellCheckedText` and a list of '
        '`SuggestionSpan`s — the same shape used in Sections 2 and 3.',
      ),
      Container(
        height: 260,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[paper, sand],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: sand),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: amber.withValues(alpha: 0.10),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: CustomPaint(
          painter: _PlatformFlowPainter(
            nodeColor: Colors.white,
            edgeColor: amberDeep,
            labelColor: slateDeep,
          ),
        ),
      ),
      infoCard(
        'Channel facts',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('channel', 'SystemChannels.spellCheck'),
            dataRow('method', 'SpellCheck.initiateSpellCheck'),
            dataRow('payload', '[localeTag, text]'),
            dataRow('return', 'List of {startIndex, endIndex, suggestions}'),
            dataRow('coverage',
                'Android & iOS today; web/desktop are no-ops'),
          ],
        ),
        headerGradient: <Color>[sky, slateDeep],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 7 — Decision matrix
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 7] Decision matrix');

  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '07',
        'Decision Matrix — Which Configuration?',
        <Color>[amberDeep, slateDeep],
      ),
      proseBox(
        'When you build a text-entry surface, pick the configuration whose '
        'trade-offs match your context. The table below summarises the '
        'common axes: whether suggestions appear, whether a misspelled style '
        'is applied, whether a custom toolbar overrides the platform one, '
        'and whether tests can rely on the output being deterministic. The '
        'last column lists when each option is the right call. Use this as '
        'a quick checklist while wiring up `TextField` widgets.',
      ),
      infoCard(
        'Configurations side-by-side',
        DataTable(
          headingRowColor:
              WidgetStateProperty.all(amberLight),
          columnSpacing: 18,
          headingTextStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: amberDeep,
          ),
          dataTextStyle: const TextStyle(fontSize: 11, color: slateDeep),
          columns: const <DataColumn>[
            DataColumn(label: Text('config')),
            DataColumn(label: Text('underline')),
            DataColumn(label: Text('toolbar')),
            DataColumn(label: Text('use when')),
          ],
          rows: const <DataRow>[
            DataRow(cells: <DataCell>[
              DataCell(Text('default')),
              DataCell(Text('wavy red')),
              DataCell(Text('platform')),
              DataCell(Text('most apps')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('disabled')),
              DataCell(Text('none')),
              DataCell(Text('none')),
              DataCell(Text('tests, secure entry')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('customService')),
              DataCell(Text('dashed amber')),
              DataCell(Text('platform')),
              DataCell(Text('custom dictionaries')),
            ]),
            DataRow(cells: <DataCell>[
              DataCell(Text('toolbarBuilder')),
              DataCell(Text('wavy sky')),
              DataCell(Text('custom')),
              DataCell(Text('branded UI')),
            ]),
          ],
        ),
        headerGradient: <Color>[amber, rose],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 8 — Code snippet
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 8] Code snippet');

  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '08',
        'Code Snippet — Wiring Spell-Check Into a TextField',
        <Color>[sky, amber],
      ),
      proseBox(
        'Plumbing spell-check into a `TextField` is one constructor argument: '
        'pass a `SpellCheckConfiguration`. The snippet below shows the same '
        'four configurations declared at the top of this script (default, '
        'disabled, custom service, custom toolbar) and a `TextField` that '
        'consumes one of them. Note that `EditableText` reads '
        '`misspelledTextStyle` to decorate misspellings — there is no need '
        'for a separate `TextStyle` field on `TextField` itself.',
      ),
      codeSnippetCard(
        'spell_check_setup.dart',
        '// Default — platform service, wavy red underline.\n'
        'final defaultConfig = SpellCheckConfiguration(\n'
        '  spellCheckService: DefaultSpellCheckService(),\n'
        '  misspelledTextStyle: TextStyle(\n'
        '    decoration: TextDecoration.underline,\n'
        '    decorationColor: Colors.red,\n'
        '    decorationStyle: TextDecorationStyle.wavy,\n'
        '  ),\n'
        ');\n'
        '\n'
        '// Disabled — no spell-check at all.\n'
        'const disabledConfig = SpellCheckConfiguration.disabled();\n'
        '\n'
        '// Custom toolbar builder — branded suggestion UI.\n'
        'final toolbarConfig = SpellCheckConfiguration(\n'
        '  spellCheckService: DefaultSpellCheckService(),\n'
        '  spellCheckSuggestionsToolbarBuilder: (ctx, state) =>\n'
        '      MyBrandedToolbar(state: state),\n'
        ');\n'
        '\n'
        'TextField(\n'
        '  spellCheckConfiguration: defaultConfig,\n'
        ');\n',
        accent: sky,
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 9 — Suggestion palette wrap
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 9] Suggestion palette');

  final List<String> aggregatedSuggestions = <String>[
    for (final SuggestionSpan s in paragraphResults.suggestionSpans)
      ...s.suggestions,
    for (final SuggestionSpan s in sampleResults.suggestionSpans)
      ...s.suggestions,
  ];

  final Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '09',
        'Suggestion Palette — All Candidates',
        <Color>[rose, sky],
      ),
      proseBox(
        'The wrap below dumps every suggestion this script produced — both '
        'from the paragraph and the small sample. A real toolbar would not '
        'show duplicates across spans, but for the corpus we render them all '
        'so the test runner can verify chip-based layout, wrapping behaviour, '
        'and colour selection under mixed content. The palette doubles as a '
        'quick visual sanity-check that the `SuggestionSpan` data made it '
        'all the way from constructor arguments to a styled widget tree.',
      ),
      infoCard(
        'Wrap of ${aggregatedSuggestions.length} suggestions',
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: <Widget>[
            for (int i = 0; i < aggregatedSuggestions.length; i++)
              chipTag(
                aggregatedSuggestions[i],
                i.isEven ? amberLight : roseLight,
                i.isEven ? amberDeep : roseDeep,
              ),
          ],
        ),
        headerGradient: <Color>[rose, amberDeep],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 10 — Edge cases
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 10] Edge cases');

  final SpellCheckResults emptyResults =
      const SpellCheckResults('correct text', <SuggestionSpan>[]);
  final SuggestionSpan emptySuggestionsSpan =
      const SuggestionSpan(TextRange(start: 0, end: 4), <String>[]);
  final SuggestionSpan singleSuggestionSpan =
      const SuggestionSpan(TextRange(start: 5, end: 9), <String>['ok']);

  final Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '10',
        'Edge Cases & Degenerate Spans',
        <Color>[slate, rose],
      ),
      proseBox(
        'Spell-check data has several edge cases worth representing in the '
        'corpus. An empty `SpellCheckResults` (no spans) means the engine '
        'examined the text and found nothing wrong. A `SuggestionSpan` with '
        'an empty suggestions list means the engine flagged the word but had '
        'no candidate replacement. A single-suggestion span is the common '
        '"obvious typo" case. The painter handles all three cleanly: zero '
        'spans paints just the text, and zero-suggestion spans still get '
        'their squiggle.',
      ),
      infoCard(
        'emptyResults',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('spellCheckedText', '"${emptyResults.spellCheckedText}"'),
            dataRow('spans', '${emptyResults.suggestionSpans.length}'),
            dataRow('meaning', 'Engine ran and found no misspellings'),
          ],
        ),
        headerGradient: <Color>[slate, slateDeep],
      ),
      infoCard(
        'emptySuggestionsSpan',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('range', '${emptySuggestionsSpan.range}'),
            dataRow('suggestions',
                '${emptySuggestionsSpan.suggestions.length}'),
            dataRow('meaning', 'Misspelling without proposed correction'),
          ],
        ),
        headerGradient: <Color>[rose, roseDeep],
      ),
      infoCard(
        'singleSuggestionSpan',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('range', '${singleSuggestionSpan.range}'),
            dataRow('suggestions',
                singleSuggestionSpan.suggestions.join(', ')),
            dataRow('meaning', 'High-confidence single replacement'),
          ],
        ),
        headerGradient: <Color>[amber, amberDeep],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────────
  // Section 11 — Glossary
  // ───────────────────────────────────────────────────────────────────────
  print('[Section 11] Glossary');

  final Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      sectionBanner(
        '11',
        'Glossary — Quick Reference',
        <Color>[amberDeep, slate],
      ),
      proseBox(
        'A glossary keyed off of the types this file exercises. Use these '
        'definitions when reading other tests in this corpus that touch '
        'editable text: every term that appears in widget docs also appears '
        'here. Glossary entries deliberately mirror the official dartdoc '
        'wording so that a reader switching between the corpus and the SDK '
        'will not see contradictory definitions. Definitions stay terse and '
        'lean on the longer prose elsewhere in the file.',
      ),
      infoCard(
        'Definitions',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            dataRow('SuggestionSpan',
                'TextRange + ranked list of replacements'),
            dataRow('TextRange', 'UTF-16 [start, end) over the text'),
            dataRow('SpellCheckResults',
                'Original text plus suggestion spans'),
            dataRow('SpellCheckService',
                'fetchSpellCheckSuggestions(locale, text)'),
            dataRow('DefaultSpellCheckService',
                'Platform-channel implementation'),
            dataRow('SpellCheckConfiguration',
                'Plug-in value object on EditableText'),
          ],
        ),
        headerGradient: <Color>[amberDeep, rose],
      ),
    ],
  );

  print('===== END SPELL CHECK DEEP VISUAL DEMO =====');

  // ─── Assemble the harness ───
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: amberDeep,
      colorScheme: ColorScheme.fromSeed(seedColor: amberDeep),
      scaffoldBackgroundColor: paper,
    ),
    home: Scaffold(
      backgroundColor: paper,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[amberDeep, rose, sky],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: amberDeep.withValues(alpha: 0.40),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: rose.withValues(alpha: 0.20),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Spell-Check — Deep Visual Demo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'package:flutter/services.dart — SuggestionSpan, '
                      'SpellCheckResults, SpellCheckService, '
                      'SpellCheckConfiguration.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              section1,
              section2,
              section3,
              section4,
              section5,
              section6,
              section7,
              section8,
              section9,
              section10,
              section11,
            ],
          ),
        ),
      ),
    ),
  );
}
