// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
//  QUILL TANGERINE  --  A Proofreader's Almanac of SuggestionSpan
// ----------------------------------------------------------------------------
//  Theme           : Quill Tangerine. Imagine a proofreader's desk at dusk:
//                    a slab of ivory parchment, a small jar of tangerine ink,
//                    a fine-tip marker resting against a leather blotter, and
//                    a stack of printed manuscript pages whose misspellings
//                    have been ringed in orange. The palette evokes that
//                    desk: ivory, parchment, tangerine, marigold rind, soft
//                    cocoa lettering, and a few accent inks for callouts.
//  Subject         : `SuggestionSpan` from `package:flutter/services.dart`.
//                    A small, immutable, value-typed record that ties a
//                    `TextRange` (the misspelled region inside an editable
//                    string) to a `List<String>` of candidate corrections.
//                    SuggestionSpan instances are produced by the platform
//                    `SpellCheckService` and consumed by `EditableText` so
//                    the user sees red squiggles plus a popover of choices.
//  Surface         : `const SuggestionSpan(TextRange range, List<String>
//                    suggestions)`. Two final fields, value-based equality,
//                    no extra methods to memorise. The simplicity is the
//                    point: SuggestionSpan is a pure data carrier between
//                    the platform spell-check engine and the framework.
//  Audience        : Flutter engineers wiring custom editors, QA folk
//                    writing snapshot tests for spell-check overlays, and
//                    curious readers of the Tom AI D4rt flutter ast smoke
//                    harness who want to see a SuggestionSpan rendered as
//                    a printed manuscript page rather than a JSON dump.
//  D4rt notes      : `build()` is invoked exactly once. The returned widget
//                    tree is a static snapshot. No StatefulWidget, no
//                    setState, no controllers, no timers, no streams. We do
//                    NOT iterate BridgedInstance values with for-in, and we
//                    do NOT touch `.value` on a Tween.animate. Alpha colours
//                    use `.withValues(alpha: ...)` instead of withOpacity.
//  Style           : Tangerine, marigold rind, ivory parchment, parchment
//                    deep, cocoa ink, sepia ink, sage proof-mark, plum
//                    margin-note, terracotta correction, soft mist, slate,
//                    and a charcoal monospace background for code.
//  Length goal     : 1800+ lines so the harness can exercise its rendering
//                    pipeline against a substantial AST and the reader can
//                    treat the file as a small standalone reference work.
//  Print policy    : Narrative print(...) calls scattered through build()
//                    to log the journey. Each section opens with a print so
//                    that running this script in dcli tells a story.
// ----------------------------------------------------------------------------
//  Diagram (rendered later as a series of cards):
//
//      User types into TextField
//          \
//           v
//      EditableText asks SpellCheckService.fetchSpellCheckSuggestions(...)
//          \
//           v
//      Platform engine returns SpellCheckResults:
//          .text: "Ths is a tset"
//          .suggestionSpans: [
//              SuggestionSpan(TextRange(0,3),  ['This','Thus','Th']),
//              SuggestionSpan(TextRange(8,12), ['test','text','tests']),
//          ]
//          \
//           v
//      EditableText paints squiggles under each .range
//          \
//           v
//      User taps a squiggle => popover shows .suggestions list
//          \
//           v
//      Tap a suggestion => replace .range with chosen string
//
//  Anatomy (rendered as a labelled "card" later):
//
//      class SuggestionSpan {
//        final TextRange range;
//        final List<String> suggestions;
//        const SuggestionSpan(this.range, this.suggestions);
//        // value-based equality: same range AND same suggestions list
//        // hashCode mirrors equality
//      }
//
//  TextRange anatomy (also rendered later):
//
//      class TextRange {
//        final int start; // UTF-16 offset, inclusive
//        final int end;   // UTF-16 offset, exclusive
//        bool get isCollapsed => start == end;
//        bool get isNormalized => start <= end;
//        bool get isValid => start >= 0 && end >= 0;
//        String textBefore(String s) => s.substring(0, start);
//        String textInside(String s) => s.substring(start, end);
//        String textAfter(String s)  => s.substring(end);
//      }
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Quill Tangerine palette. These constants are reused across every section
// so the demo feels like a single bound book rather than a scrapbook.
// ---------------------------------------------------------------------------

const Color cParchment = Color(0xFFFBF3DF);
const Color cParchmentDeep = Color(0xFFEFE2BF);
const Color cIvory = Color(0xFFFFF8E7);
const Color cTangerine = Color(0xFFEC7C2D);
const Color cTangerineDeep = Color(0xFFB95612);
const Color cTangerineSoft = Color(0xFFF5A86A);
const Color cMarigoldRind = Color(0xFFD89A2C);
const Color cCocoaInk = Color(0xFF3E2A1A);
const Color cSepiaInk = Color(0xFF6B4628);
const Color cSageProof = Color(0xFF8AA66F);
const Color cPlumMargin = Color(0xFF6E3A6E);
const Color cTerracotta = Color(0xFFB44A2B);
const Color cMist = Color(0xFFE6DCC4);
const Color cSlate = Color(0xFF2A2018);
const Color cCharcoal = Color(0xFF1B1611);

// Derived washes for soft backgrounds.
final Color cTangerineWash = cTangerine.withValues(alpha: 0.18);
final Color cMarigoldWash = cMarigoldRind.withValues(alpha: 0.20);
final Color cSageWash = cSageProof.withValues(alpha: 0.20);
final Color cPlumWash = cPlumMargin.withValues(alpha: 0.16);
final Color cTerracottaWash = cTerracotta.withValues(alpha: 0.18);

// ---------------------------------------------------------------------------
// Reusable text-style helpers. Plain functions so call-sites stay short.
// ---------------------------------------------------------------------------

TextStyle _titleStyle({Color color = cCocoaInk, double size = 22}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.4,
  );
}

TextStyle _subtitleStyle({Color color = cSepiaInk, double size = 15}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );
}

TextStyle _bodyStyle({Color color = cCocoaInk, double size = 13.5}) {
  return TextStyle(color: color, fontSize: size, height: 1.45);
}

TextStyle _marginStyle({Color color = cPlumMargin, double size = 12.5}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontStyle: FontStyle.italic,
    height: 1.4,
  );
}

TextStyle _codeStyle({Color color = cParchment, double size = 12.5}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontFamily: 'monospace',
    height: 1.4,
  );
}

TextStyle _captionStyle({Color color = cSepiaInk, double size = 11}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontStyle: FontStyle.italic,
  );
}

// ---------------------------------------------------------------------------
// Visual helper widgets. Each returns a widget so the body of build() can
// stay declarative. We avoid any control-flow over BridgedInstance values.
// ---------------------------------------------------------------------------

Widget _swatch(Color c, String label) {
  return Container(
    width: 88,
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: cCocoaInk.withValues(alpha: 0.25)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: _captionStyle(color: cCocoaInk, size: 10)),
      ],
    ),
  );
}

Widget _sectionHeader(String index, String title, {Color? accent}) {
  final Color c = accent ?? cTangerine;
  return Container(
    margin: const EdgeInsets.only(top: 28, bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: c, width: 6)),
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            index,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(title, style: _titleStyle(size: 18)),
        ),
      ],
    ),
  );
}

Widget _proseBlock(String text, {Color? color}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: (color ?? cIvory),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cMist),
    ),
    child: Text(text, style: _bodyStyle()),
  );
}

Widget _marginNote(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
    decoration: BoxDecoration(
      color: cPlumWash,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: cPlumMargin, width: 3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.format_quote, color: cPlumMargin, size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: _marginStyle())),
      ],
    ),
  );
}

Widget _bulletList(List<String> bullets, {Color dot = cTangerine}) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < bullets.length; i++) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 6, right: 8),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dot,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(bullets[i], style: _bodyStyle()),
            ),
          ],
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: rows,
  );
}

Widget _kvRow(String key, String value, {Color? keyColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 170,
          child: Text(
            key,
            style: _subtitleStyle(
              color: keyColor ?? cTangerineDeep,
              size: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(value, style: _bodyStyle(size: 13)),
        ),
      ],
    ),
  );
}

Widget _codeCard(String title, String code, {Color? accent}) {
  final Color c = accent ?? cTangerine;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cCharcoal,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.7), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: cTangerine,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: cMarigoldRind,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: cSageProof,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(code, style: _codeStyle()),
      ],
    ),
  );
}

Widget _doAvoid(String label, String text, {required bool isDo}) {
  final Color border = isDo ? cSageProof : cTerracotta;
  final String prefix = isDo ? 'DO' : 'AVOID';
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: border.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: border, width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: border,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            prefix,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: _subtitleStyle(size: 13)),
              const SizedBox(height: 4),
              Text(text, style: _bodyStyle(size: 12.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _glossaryItem(String term, String definition) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: cIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cMarigoldRind.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(term, style: _subtitleStyle(color: cTangerineDeep, size: 13)),
        const SizedBox(height: 3),
        Text(definition, style: _bodyStyle(size: 12.5)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// _manuscriptPage: the centerpiece of the demo. Given a sentence, a
// SuggestionSpan, and a colour, render a "manuscript page" card that shows:
//
//   * The sentence with the misspelled region highlighted in tangerine.
//   * A label for the misspelling itself.
//   * A popover-styled list of the .suggestions, each suggestion clickable
//     in spirit (we render them as buttons but no callback fires).
//
// This helper is the visual heart of the SuggestionSpan story: it puts the
// abstract SuggestionSpan onto a printed page so the reader sees how a
// real editor would surface the data.
// ---------------------------------------------------------------------------

Widget _manuscriptPage({
  required String label,
  required String sentence,
  required SuggestionSpan span,
  required Color accent,
  required String marginNote,
}) {
  // Decompose the sentence around the misspelling region using the
  // TextRange helper methods. We reach into TextRange.start/.end directly
  // since that is the most idiomatic way to slice a String around a span.
  final int start = span.range.start;
  final int end = span.range.end;
  final String before = sentence.substring(0, start);
  final String inside = sentence.substring(start, end);
  final String after = sentence.substring(end);

  // Render the sentence as a RichText with three TextSpans. The middle
  // span carries a subtle tangerine underline to mimic the squiggle a
  // real spell-check overlay would draw, plus a tangerine wash behind it
  // so the misspelling is visible from across the room.
  final TextSpan rich = TextSpan(
    style: _bodyStyle(size: 15),
    children: <TextSpan>[
      TextSpan(text: before),
      TextSpan(
        text: inside,
        style: TextStyle(
          color: cTangerineDeep,
          fontWeight: FontWeight.w800,
          fontSize: 15,
          backgroundColor: accent.withValues(alpha: 0.30),
          decoration: TextDecoration.underline,
          decorationColor: cTerracotta,
          decorationStyle: TextDecorationStyle.wavy,
          decorationThickness: 2.5,
        ),
      ),
      TextSpan(text: after),
    ],
  );

  // Build the suggestion popover list using indexed for-loops. Each
  // suggestion is rendered as a small pill: the first suggestion is
  // emphasised since spell-check engines list candidates in confidence
  // order.
  final List<Widget> pills = <Widget>[];
  for (int i = 0; i < span.suggestions.length; i++) {
    final String s = span.suggestions[i];
    final bool isTop = i == 0;
    pills.add(
      Container(
        margin: const EdgeInsets.only(right: 6, bottom: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isTop ? cTangerine : cIvory,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isTop ? cTangerineDeep : cMarigoldRind,
            width: isTop ? 1.6 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (isTop)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.check_circle,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            Text(
              s,
              style: TextStyle(
                color: isTop ? Colors.white : cCocoaInk,
                fontWeight: isTop ? FontWeight.w700 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cIvory,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cCocoaInk.withValues(alpha: 0.10),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Header row: a small accent dot, the page label, the range.
        Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(label, style: _subtitleStyle(size: 14)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: cMarigoldWash,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: cMarigoldRind),
              ),
              child: Text(
                'TextRange($start, $end)',
                style: TextStyle(
                  color: cTangerineDeep,
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // The sentence as a RichText with the misspelling marked.
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cParchment,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: cMist,
            ),
          ),
          child: RichText(text: rich),
        ),
        const SizedBox(height: 10),
        // Suggestion popover row.
        Row(
          children: <Widget>[
            Icon(Icons.lightbulb, size: 16, color: cTangerine),
            const SizedBox(width: 6),
            Text(
              'Suggestions (${span.suggestions.length})',
              style: _subtitleStyle(color: cTangerineDeep, size: 12.5),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: cTangerineWash,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'tap a chip to replace',
                style: _captionStyle(color: cTangerineDeep, size: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(children: pills),
        const SizedBox(height: 8),
        // Margin note styled like a proofreader's pencil annotation.
        Container(
          padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
          decoration: BoxDecoration(
            color: cPlumWash,
            borderRadius: BorderRadius.circular(6),
            border: Border(
              left: BorderSide(color: cPlumMargin, width: 2.5),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.edit_note, color: cPlumMargin, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(marginNote, style: _marginStyle()),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// _suggestionTable: a tiny table that prints each suggestion in confidence
// order with a placeholder confidence value derived from index. This is
// purely illustrative since SuggestionSpan does not actually carry per-
// suggestion confidence; the platform engines do, but the framework
// flattens that into a simple list.
Widget _suggestionTable(SuggestionSpan span, {Color accent = cTangerine}) {
  final List<Widget> rows = <Widget>[];
  rows.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.18),
        border: Border(
          bottom: BorderSide(color: accent),
        ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 36,
            child: Text('#', style: _subtitleStyle(size: 12)),
          ),
          Expanded(
            child: Text('suggestion', style: _subtitleStyle(size: 12)),
          ),
          SizedBox(
            width: 110,
            child: Text('illustrative score',
                style: _subtitleStyle(size: 12)),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < span.suggestions.length; i++) {
    final String s = span.suggestions[i];
    // Pretend confidence: top suggestion is 0.95, then linearly down.
    final double pretendScore =
        0.95 - (i * (0.65 / (span.suggestions.length + 1)));
    final String scoreText = pretendScore.toStringAsFixed(2);
    rows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: i.isEven ? cIvory : cParchment,
          border: Border(
            bottom: BorderSide(color: cMist),
          ),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 36,
              child: Text('${i + 1}', style: _bodyStyle(size: 12)),
            ),
            Expanded(
              child: Text(
                s,
                style: TextStyle(
                  color: cCocoaInk,
                  fontWeight: i == 0 ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(
              width: 110,
              child: Text(
                scoreText,
                style: _codeStyle(color: cSepiaInk, size: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: cIvory,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cMarigoldRind),
    ),
    child: Column(children: rows),
  );
}

// _rangeAnatomyCard: visualise a TextRange as a labelled ruler so the
// reader can see start, end, length, and the half-open interval. Renders
// a horizontal bar with tick marks and the inside-substring underneath.
Widget _rangeAnatomyCard({
  required String sentence,
  required TextRange range,
  Color accent = cTangerine,
}) {
  final int start = range.start;
  final int end = range.end;
  final int length = end - start;
  final bool collapsed = start == end;
  final bool normalized = start <= end;
  final bool valid = start >= 0 && end >= 0;

  // Build a row of small "tick" boxes, one per code-unit position.
  // For brevity we only render up to the first 24 positions; longer
  // strings get a trailing ellipsis tick.
  final int cap = sentence.length < 24 ? sentence.length : 24;
  final List<Widget> ticks = <Widget>[];
  for (int i = 0; i < cap; i++) {
    final bool inside = i >= start && i < end;
    ticks.add(
      Container(
        margin: const EdgeInsets.only(right: 2),
        width: 18,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: inside ? accent : cParchment,
          border: Border.all(
            color: inside ? cTangerineDeep : cMist,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          sentence[i],
          style: TextStyle(
            color: inside ? Colors.white : cCocoaInk,
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: inside ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
  if (sentence.length > cap) {
    ticks.add(
      Container(
        margin: const EdgeInsets.only(right: 2),
        width: 24,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: cMist,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text('...', style: _codeStyle(color: cSepiaInk, size: 11)),
      ),
    );
  }

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cParchment,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('"$sentence"', style: _bodyStyle(size: 14)),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: ticks),
        ),
        const SizedBox(height: 10),
        _kvRow('start', '$start (UTF-16, inclusive)'),
        _kvRow('end', '$end (UTF-16, exclusive)'),
        _kvRow('length', '$length code units'),
        _kvRow('isCollapsed', '$collapsed'),
        _kvRow('isNormalized', '$normalized'),
        _kvRow('isValid', '$valid'),
        _kvRow('inside', '"${sentence.substring(start, end)}"'),
      ],
    ),
  );
}

// ===========================================================================
//                                  build()
// ===========================================================================
dynamic build(BuildContext context) {
  print('=== Quill Tangerine almanac for SuggestionSpan ===');
  print('Step 1: minting palette and helper widgets.');
  print('Step 2: constructing eight illustrative SuggestionSpan instances.');

  // ------------------------------------------------------------------------
  // Eight illustrative SuggestionSpans, each pointing at a typo inside a
  // sample sentence. The sentences are intentionally short so that the
  // ranges line up with what the reader can verify by counting characters.
  //
  // For each span we keep the sample sentence as a sibling local variable
  // so the manuscript-page renderer can slice the sentence using the span's
  // TextRange. In a real spell-check pipeline the sentence comes from the
  // editing controller and the spans come from the platform service; we
  // simulate that pairing inline.
  // ------------------------------------------------------------------------

  // Sample 1: classic "their/there/they're" homophone confusion.
  final String s1Text = "their going to the proofreader";
  final SuggestionSpan s1Span = SuggestionSpan(
    const TextRange(start: 0, end: 5),
    const <String>['they\'re', 'there', 'they are', 'their'],
  );

  // Sample 2: missing vowel in "separate".
  final String s2Text = "Please seperate the receipts.";
  final SuggestionSpan s2Span = SuggestionSpan(
    const TextRange(start: 7, end: 15),
    const <String>['separate', 'desperate', 'seperated'],
  );

  // Sample 3: transposition typo in "the".
  final String s3Text = "Hand teh manuscript over.";
  final SuggestionSpan s3Span = SuggestionSpan(
    const TextRange(start: 5, end: 8),
    const <String>['the', 'ten', 'tea'],
  );

  // Sample 4: the famously hard "definitely".
  final String s4Text = "We will definately ship Friday.";
  final SuggestionSpan s4Span = SuggestionSpan(
    const TextRange(start: 8, end: 18),
    const <String>['definitely', 'definitively', 'defiantly'],
  );

  // Sample 5: doubled letter in "occurrence".
  final String s5Text = "An odd occurence happened.";
  final SuggestionSpan s5Span = SuggestionSpan(
    const TextRange(start: 7, end: 16),
    const <String>['occurrence', 'occurrences', 'occurance'],
  );

  // Sample 6: noun/verb confusion "advice/advise".
  final String s6Text = "Please advice the editor.";
  final SuggestionSpan s6Span = SuggestionSpan(
    const TextRange(start: 7, end: 13),
    const <String>['advise', 'advice', 'advices'],
  );

  // Sample 7: foreign-loan word with empty suggestions (a span the engine
  // produced but could not refine; the editor still draws a squiggle and
  // lets the user dismiss the prompt).
  final String s7Text = "The recieved package is heavy.";
  final SuggestionSpan s7Span = SuggestionSpan(
    const TextRange(start: 4, end: 12),
    const <String>['received'],
  );

  // Sample 8: a span at the very end of the sentence to exercise the
  // boundary case where range.end == sentence.length.
  final String s8Text = "Wrap it in a warm tortila";
  final SuggestionSpan s8Span = SuggestionSpan(
    const TextRange(start: 18, end: 25),
    const <String>['tortilla', 'tortillas', 'tortolla'],
  );

  // A ninth span with no suggestions at all, demonstrating the "the
  // engine flagged it but cannot help" case.
  final String s9Text = "Foofquibble is not a word.";
  final SuggestionSpan s9Span = SuggestionSpan(
    const TextRange(start: 0, end: 11),
    const <String>[],
  );

  print('Step 3: minted ${9} sample sentences and SuggestionSpans.');
  print('Step 4: building title banner with palette and proofreader strap.');

  // ------------------------------------------------------------------------
  // SECTION 1 -- Title banner with palette swatches.
  // ------------------------------------------------------------------------
  final Widget section1 = Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[cTangerineDeep, cTangerine, cMarigoldRind],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'QUILL TANGERINE',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'SuggestionSpan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 26,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A proofreader\'s almanac of misspellings and corrections.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: cIvory,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.spellcheck, size: 16, color: cTangerineDeep),
              const SizedBox(width: 6),
              Text(
                'package:flutter/services.dart  ::  SuggestionSpan',
                style: TextStyle(
                  color: cTangerineDeep,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          children: <Widget>[
            _swatch(cTangerine, 'tangerine'),
            _swatch(cTangerineDeep, 'tangerine deep'),
            _swatch(cTangerineSoft, 'tangerine soft'),
            _swatch(cMarigoldRind, 'marigold rind'),
            _swatch(cParchment, 'parchment'),
            _swatch(cParchmentDeep, 'parchment deep'),
            _swatch(cIvory, 'ivory'),
            _swatch(cCocoaInk, 'cocoa ink'),
            _swatch(cSepiaInk, 'sepia ink'),
            _swatch(cSageProof, 'sage proof'),
            _swatch(cPlumMargin, 'plum margin'),
            _swatch(cTerracotta, 'terracotta'),
            _swatch(cMist, 'mist'),
            _swatch(cSlate, 'slate'),
            _swatch(cCharcoal, 'charcoal'),
          ],
        ),
      ],
    ),
  );

  print('Step 5: building section 2 (anatomy of a SuggestionSpan).');

  // ------------------------------------------------------------------------
  // SECTION 2 -- Anatomy of a SuggestionSpan.
  // ------------------------------------------------------------------------
  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('02', 'Anatomy of a SuggestionSpan',
          accent: cTangerine),
      _proseBlock(
        'A SuggestionSpan is one of the smallest types in the Flutter '
        'services layer. Its job is to bind together two pieces of data: '
        'where in an editable string the spell-check engine found a '
        'problem, and what alternative spellings it would propose. The '
        'first lives in a TextRange; the second lives in a List<String>. '
        'The class itself adds value-based equality, a const constructor, '
        'and nothing else. There are no methods to call, no streams to '
        'listen to, no flags to set.',
      ),
      _proseBlock(
        'In the wider spell-check pipeline, SuggestionSpan instances are '
        'produced by an implementation of SpellCheckService. On iOS that '
        'is DefaultSpellCheckService, which talks to UITextChecker. On '
        'Android it is also DefaultSpellCheckService, which talks to the '
        'platform spell-checker session. On desktop and web the service '
        'is typically a no-op or a custom implementation. Each of those '
        'platforms produces a list of SuggestionSpan objects whenever an '
        'editable text widget asks for a fresh check.',
        color: cTangerineWash,
      ),
      _proseBlock(
        'The consumer side is EditableText, the workhorse behind '
        'TextField, TextFormField, and CupertinoTextField. EditableText '
        'reads the SuggestionSpan list out of SpellCheckResults, draws '
        'the squiggle decoration under each .range, and surfaces the '
        '.suggestions in a popover when the user taps a misspelled word. '
        'The framework does not store SuggestionSpan instances anywhere '
        'permanent: they are recomputed on every edit.',
        color: cMarigoldWash,
      ),
      _marginNote(
        'Margin note: SuggestionSpan is a "transport" type, not a "state" '
        'type. Hold one only as long as you need it for rendering.',
      ),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cIvory,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cMist),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kvRow('Type', 'SuggestionSpan'),
            _kvRow('Library', 'package:flutter/services.dart'),
            _kvRow('Constructor', 'const SuggestionSpan(TextRange, List<String>)'),
            _kvRow('Field 1', 'final TextRange range'),
            _kvRow('Field 2', 'final List<String> suggestions'),
            _kvRow('Equality', 'value-based: same range AND same suggestions'),
            _kvRow('hashCode', 'mirrors equality (Object.hash of fields)'),
            _kvRow('Mutability', 'immutable; both fields are final'),
            _kvRow('Producer', 'SpellCheckService.fetchSpellCheckSuggestions'),
            _kvRow('Consumer', 'EditableText / SpellCheckSuggestionsToolbar'),
            _kvRow('Carrier', 'SpellCheckResults.suggestionSpans'),
            _kvRow('Lifetime', 'rebuilt per edit; not retained by widgets'),
          ],
        ),
      ),
    ],
  );

  print('Step 6: building section 3 (TextRange geometry).');

  // ------------------------------------------------------------------------
  // SECTION 3 -- TextRange geometry.
  // ------------------------------------------------------------------------
  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('03', 'TextRange geometry',
          accent: cMarigoldRind),
      _proseBlock(
        'Every SuggestionSpan carries a TextRange, and a TextRange is one '
        'of those types whose semantics are subtle enough to deserve a '
        'whole section. A TextRange has two ints: start and end. Both are '
        'UTF-16 code-unit offsets into the underlying String. start is '
        'inclusive, end is exclusive: the half-open interval [start, end). '
        'When start equals end, the range is "collapsed" - it represents '
        'a caret position rather than a selection.',
      ),
      _proseBlock(
        'The TextRange API gives you a handful of derived getters: '
        'isCollapsed, isNormalized (true when start <= end), and isValid '
        '(true when both offsets are non-negative). It also gives you '
        'three substring helpers: textBefore(s), textInside(s), and '
        'textAfter(s). Together they let you slice the underlying string '
        'into the three pieces that surround a misspelling.',
        color: cTangerineWash,
      ),
      _rangeAnatomyCard(
        sentence: s1Text,
        range: s1Span.range,
        accent: cTangerine,
      ),
      _rangeAnatomyCard(
        sentence: s2Text,
        range: s2Span.range,
        accent: cMarigoldRind,
      ),
      _rangeAnatomyCard(
        sentence: s3Text,
        range: s3Span.range,
        accent: cSageProof,
      ),
      _rangeAnatomyCard(
        sentence: s8Text,
        range: s8Span.range,
        accent: cPlumMargin,
      ),
      _marginNote(
        'Surrogate pairs (emoji and certain CJK ideographs) take TWO '
        'UTF-16 code units. Always derive ranges from the same String '
        'you intend to slice; never copy raw integers across encodings.',
      ),
    ],
  );

  print('Step 7: building section 4 (constructor patterns).');

  // ------------------------------------------------------------------------
  // SECTION 4 -- Constructor patterns.
  // ------------------------------------------------------------------------
  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('04', 'Constructor patterns', accent: cSageProof),
      _proseBlock(
        'The constructor signature is short: `const SuggestionSpan('
        'TextRange range, List<String> suggestions)`. Both arguments are '
        'positional; both are required. There are no named parameters, '
        'no factories, no copyWith, no fromJson. The recipe cards below '
        'cover the patterns you will actually write.',
      ),
      _codeCard(
        'Recipe 1: a single misspelling with three alternatives',
        'const SuggestionSpan(\n'
        '  TextRange(start: 7, end: 15),\n'
        '  <String>[\'separate\', \'desperate\', \'seperated\'],\n'
        ');',
        accent: cTangerine,
      ),
      _codeCard(
        'Recipe 2: empty suggestions (engine flagged but no fix)',
        'const SuggestionSpan(\n'
        '  TextRange(start: 0, end: 11),\n'
        '  <String>[],\n'
        ');',
        accent: cMarigoldRind,
      ),
      _codeCard(
        'Recipe 3: a single best suggestion (high-confidence fix)',
        'const SuggestionSpan(\n'
        '  TextRange(start: 4, end: 12),\n'
        '  <String>[\'received\'],\n'
        ');',
        accent: cSageProof,
      ),
      _codeCard(
        'Recipe 4: collapsed range (rare, but legal)',
        '// A collapsed range marks a caret position; not what spell-check\n'
        '// services normally emit, but useful for custom tooling.\n'
        'const SuggestionSpan(\n'
        '  TextRange.collapsed(12),\n'
        '  <String>[\'note\'],\n'
        ');',
        accent: cPlumMargin,
      ),
      _codeCard(
        'Recipe 5: building from a substring search',
        'final int idx = text.indexOf(typo);\n'
        'final SuggestionSpan span = SuggestionSpan(\n'
        '  TextRange(start: idx, end: idx + typo.length),\n'
        '  candidates,\n'
        ');',
        accent: cTerracotta,
      ),
      _codeCard(
        'Recipe 6: building a list of spans',
        'final List<SuggestionSpan> spans = <SuggestionSpan>[\n'
        '  SuggestionSpan(TextRange(start:  0, end:  3), [\'This\']),\n'
        '  SuggestionSpan(TextRange(start:  8, end: 12), [\'test\']),\n'
        '];\n'
        '// Then carry them in SpellCheckResults.suggestionSpans.',
        accent: cMarigoldRind,
      ),
      _marginNote(
        'The constructor is `const`. If you call it with const arguments, '
        'you get a canonicalised value-typed instance for free.',
      ),
    ],
  );

  print('Step 8: building section 5 (equality semantics).');

  // ------------------------------------------------------------------------
  // SECTION 5 -- Equality semantics.
  // ------------------------------------------------------------------------
  final SuggestionSpan eqA = const SuggestionSpan(
    TextRange(start: 0, end: 4),
    <String>['this', 'thus', 'thumb'],
  );
  final SuggestionSpan eqB = const SuggestionSpan(
    TextRange(start: 0, end: 4),
    <String>['this', 'thus', 'thumb'],
  );
  final SuggestionSpan eqC = const SuggestionSpan(
    TextRange(start: 0, end: 4),
    <String>['this', 'thus'],
  );
  final SuggestionSpan eqD = const SuggestionSpan(
    TextRange(start: 0, end: 5),
    <String>['this', 'thus', 'thumb'],
  );

  final Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('05', 'Equality semantics', accent: cPlumMargin),
      _proseBlock(
        'SuggestionSpan overrides == and hashCode so that two instances '
        'are equal when they have the same range and the same suggestions '
        'in the same order. The list comparison is structural: the '
        'lengths must match and each element must be equal. This means '
        'you can deduplicate a List<SuggestionSpan> with Set, and you can '
        'compare a freshly-fetched span list against a cached one to '
        'decide whether the editor needs to repaint.',
      ),
      _proseBlock(
        'Note that equality is sensitive to suggestion order. The '
        'platform spell-check engines list suggestions in confidence '
        'order, and that order is itself meaningful to the user. Two '
        'spans that contain the same words in different orders are '
        'considered different - and rightly so, since the top suggestion '
        'is what the popover highlights as the recommended fix.',
        color: cTangerineWash,
      ),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cIvory,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cMist),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Comparison ledger', style: _subtitleStyle()),
            const SizedBox(height: 8),
            _kvRow('eqA == eqB', '${eqA == eqB}  // identical fields'),
            _kvRow('eqA == eqC',
                '${eqA == eqC}  // suggestions list differs'),
            _kvRow('eqA == eqD',
                '${eqA == eqD}  // range differs'),
            _kvRow('eqA.hashCode == eqB.hashCode',
                '${eqA.hashCode == eqB.hashCode}'),
            _kvRow('identical(eqA, eqB)',
                '${identical(eqA, eqB)}  // const canonicalisation'),
            _kvRow('identical(eqA, eqC)',
                '${identical(eqA, eqC)}'),
          ],
        ),
      ),
      _marginNote(
        'Equality plus const canonicalisation means two equal const '
        'SuggestionSpans can share the same heap object. This is a quiet '
        'but real performance win for editors that emit thousands of '
        'spans per session.',
      ),
    ],
  );

  print('Step 9: building section 6 (SpellCheckResults integration).');

  // ------------------------------------------------------------------------
  // SECTION 6 -- SpellCheckResults integration.
  // ------------------------------------------------------------------------
  final SpellCheckResults sampleResults = SpellCheckResults(
    s1Text + ' / ' + s2Text + ' / ' + s4Text,
    <SuggestionSpan>[s1Span, s2Span, s4Span],
  );

  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('06', 'SpellCheckResults integration',
          accent: cTerracotta),
      _proseBlock(
        'SuggestionSpan does not travel alone. It rides inside a '
        'SpellCheckResults envelope alongside the original String the '
        'engine examined. The envelope is what crosses the platform '
        'channel from native code to the Dart isolate, and what '
        'EditableText receives as the payload of an asynchronous spell '
        'check.',
      ),
      _proseBlock(
        'The envelope has two final fields: spellCheckedText (the String '
        'the engine examined) and suggestionSpans (the list of '
        'SuggestionSpan objects). Holding the original String alongside '
        'the spans matters: by the time the result reaches the Dart side, '
        'the user may already have typed more characters. EditableText '
        'discards stale results by comparing spellCheckedText against the '
        'current controller value.',
        color: cTerracottaWash,
      ),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cIvory,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cMist),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Envelope dump', style: _subtitleStyle()),
            const SizedBox(height: 8),
            _kvRow('runtimeType', '${sampleResults.runtimeType}'),
            _kvRow('spellCheckedText',
                '"${sampleResults.spellCheckedText}"'),
            _kvRow('suggestionSpans length',
                '${sampleResults.suggestionSpans.length}'),
            _kvRow('first span range',
                '${sampleResults.suggestionSpans[0].range}'),
            _kvRow('first span suggestions',
                '${sampleResults.suggestionSpans[0].suggestions}'),
            _kvRow('second span range',
                '${sampleResults.suggestionSpans[1].range}'),
            _kvRow('third span range',
                '${sampleResults.suggestionSpans[2].range}'),
          ],
        ),
      ),
      _codeCard(
        'How EditableText pulls SuggestionSpan out of the envelope',
        'final SpellCheckResults? results = state.spellCheckResults;\n'
        'if (results == null) return;\n'
        'if (results.spellCheckedText != controller.text) {\n'
        '  // stale; ignore.\n'
        '  return;\n'
        '}\n'
        'for (int i = 0; i < results.suggestionSpans.length; i++) {\n'
        '  final SuggestionSpan span = results.suggestionSpans[i];\n'
        '  paintSquiggleAt(span.range);\n'
        '}',
        accent: cTangerineDeep,
      ),
      _marginNote(
        'Stale-result handling is the reason SpellCheckResults carries '
        'the original String. SuggestionSpan offsets are only valid '
        'against the exact String that was examined.',
      ),
    ],
  );

  print('Step 10: building section 7 (the manuscript pages).');

  // ------------------------------------------------------------------------
  // SECTION 7 -- The manuscript pages. The visual centerpiece.
  // ------------------------------------------------------------------------
  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('07', 'Manuscript pages (eight illustrative samples)',
          accent: cTangerineDeep),
      _proseBlock(
        'Each card below shows a sentence with one misspelling marked in '
        'tangerine, followed by the popover-styled list of corrections '
        'the spell-check engine offered. The first chip in each list is '
        'the engine\'s top suggestion; the rest are runners-up. A real '
        'editor would highlight the same chip and pre-select it for the '
        'enter key.',
      ),
      _manuscriptPage(
        label: 'Page 1: homophone confusion',
        sentence: s1Text,
        span: s1Span,
        accent: cTangerine,
        marginNote:
            'Homophones are the hardest class for spell-checkers because '
            'every candidate is also a real word. The engine ranks them '
            'using a language model rather than a dictionary lookup.',
      ),
      _manuscriptPage(
        label: 'Page 2: missing vowel',
        sentence: s2Text,
        span: s2Span,
        accent: cMarigoldRind,
        marginNote:
            '"separate" is a perennial loser of the spelling bee. The '
            'first suggestion is the right one; everything after is '
            'noise.',
      ),
      _manuscriptPage(
        label: 'Page 3: transposition typo',
        sentence: s3Text,
        span: s3Span,
        accent: cSageProof,
        marginNote:
            'Transpositions are easy: the engine simply tries swapping '
            'adjacent letters and looks the result up in the dictionary.',
      ),
      _manuscriptPage(
        label: 'Page 4: vowel-cluster typo',
        sentence: s4Text,
        span: s4Span,
        accent: cPlumMargin,
        marginNote:
            'Note "defiantly" in the runner-up slot - same letters, very '
            'different meaning. Always read the top suggestion before '
            'clicking.',
      ),
      _manuscriptPage(
        label: 'Page 5: doubled-letter rule',
        sentence: s5Text,
        span: s5Span,
        accent: cTerracotta,
        marginNote:
            '"occurrence" doubles both the c and the r. Engine '
            'dictionaries store the canonical spelling and reach it via '
            'edit-distance lookup.',
      ),
      _manuscriptPage(
        label: 'Page 6: noun/verb confusion',
        sentence: s6Text,
        span: s6Span,
        accent: cTangerineSoft,
        marginNote:
            '"advice" is a noun; "advise" is a verb. Grammar engines '
            'sometimes catch this by inspecting the surrounding clause.',
      ),
      _manuscriptPage(
        label: 'Page 7: classical rule violation',
        sentence: s7Text,
        span: s7Span,
        accent: cTangerine,
        marginNote:
            '"i before e except after c" yields "received". One '
            'high-confidence suggestion is enough.',
      ),
      _manuscriptPage(
        label: 'Page 8: end-of-string range',
        sentence: s8Text,
        span: s8Span,
        accent: cMarigoldRind,
        marginNote:
            'Spans that touch the end of the string are common - users '
            'often misspell the last word. Verify range.end <= text.length.',
      ),
      _manuscriptPage(
        label: 'Page 9: empty suggestions (engine has no fix)',
        sentence: s9Text,
        span: s9Span,
        accent: cTerracotta,
        marginNote:
            'Empty suggestion lists are legal. The squiggle still warns '
            'the user; the popover should offer "ignore" instead of an '
            'empty list of fixes.',
      ),
    ],
  );

  print('Step 11: building section 8 (custom-paragraph rendering).');

  // ------------------------------------------------------------------------
  // SECTION 8 -- Custom-paragraph rendering: showing how a custom editor
  // would consume a SuggestionSpan list to draw underlined misspellings
  // with a popover of suggestions. This section is mostly tables and
  // code, since the visual "real thing" already lives in section 7.
  // ------------------------------------------------------------------------
  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('08', 'Custom-paragraph rendering',
          accent: cMarigoldRind),
      _proseBlock(
        'Most apps never need to render SuggestionSpans by hand: '
        'EditableText, which sits underneath TextField, does it for '
        'you. But if you are building a custom rich-text editor, a code '
        'editor, or a markdown writer, you may want to wire spell-check '
        'into your own paint pipeline. The pattern is straightforward: '
        'split the underlying String at each span boundary, render each '
        'piece as its own TextSpan, and decorate the misspelled pieces '
        'with a wavy underline.',
      ),
      _suggestionTable(s1Span, accent: cTangerine),
      _suggestionTable(s4Span, accent: cPlumMargin),
      _suggestionTable(s8Span, accent: cMarigoldRind),
      _codeCard(
        'Recipe: split a String around a list of SuggestionSpans',
        'List<TextSpan> splitForSpellCheck(\n'
        '  String text,\n'
        '  List<SuggestionSpan> spans,\n'
        ') {\n'
        '  final List<TextSpan> out = <TextSpan>[];\n'
        '  int cursor = 0;\n'
        '  for (int i = 0; i < spans.length; i++) {\n'
        '    final SuggestionSpan span = spans[i];\n'
        '    if (span.range.start > cursor) {\n'
        '      out.add(TextSpan(\n'
        '        text: text.substring(cursor, span.range.start),\n'
        '      ));\n'
        '    }\n'
        '    out.add(TextSpan(\n'
        '      text: text.substring(span.range.start, span.range.end),\n'
        '      style: TextStyle(\n'
        '        decoration: TextDecoration.underline,\n'
        '        decorationStyle: TextDecorationStyle.wavy,\n'
        '        decorationColor: Colors.red,\n'
        '      ),\n'
        '    ));\n'
        '    cursor = span.range.end;\n'
        '  }\n'
        '  if (cursor < text.length) {\n'
        '    out.add(TextSpan(text: text.substring(cursor)));\n'
        '  }\n'
        '  return out;\n'
        '}',
        accent: cTangerineDeep,
      ),
      _codeCard(
        'Recipe: tap-to-correct using SuggestionSpan.suggestions',
        'void onTapMisspelling(\n'
        '  SuggestionSpan span,\n'
        '  TextEditingController controller,\n'
        ') {\n'
        '  showMenu<String>(\n'
        '    context: context,\n'
        '    position: anchorRect,\n'
        '    items: <PopupMenuEntry<String>>[\n'
        '      for (int i = 0; i < span.suggestions.length; i++)\n'
        '        PopupMenuItem<String>(\n'
        '          value: span.suggestions[i],\n'
        '          child: Text(span.suggestions[i]),\n'
        '        ),\n'
        '    ],\n'
        '  ).then((String? choice) {\n'
        '    if (choice == null) return;\n'
        '    final String t = controller.text;\n'
        '    controller.text = t.replaceRange(\n'
        '      span.range.start,\n'
        '      span.range.end,\n'
        '      choice,\n'
        '    );\n'
        '  });\n'
        '}',
        accent: cSageProof,
      ),
      _marginNote(
        'Always replace the misspelling using the same TextRange you '
        'received with the SuggestionSpan. Recomputing offsets later '
        'invites off-by-one bugs when the user has typed in between '
        'fetch and tap.',
      ),
    ],
  );

  print('Step 12: building section 9 (DO and AVOID).');

  // ------------------------------------------------------------------------
  // SECTION 9 -- DO and AVOID callouts.
  // ------------------------------------------------------------------------
  final Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('09', 'DO and AVOID', accent: cTangerine),
      _doAvoid(
        'DO treat SuggestionSpan as immutable',
        'Both fields are final. Build a new SuggestionSpan when the data '
        'changes; never reach into the existing one.',
        isDo: true,
      ),
      _doAvoid(
        'DO render the first suggestion as the recommended fix',
        'Spell-check engines list candidates in confidence order. The '
        'first chip is what should pre-select on Enter / tab.',
        isDo: true,
      ),
      _doAvoid(
        'DO compare incoming spans against the current text',
        'The platform service is asynchronous. Always validate that '
        'spellCheckedText still matches the controller value before '
        'painting squiggles based on stale ranges.',
        isDo: true,
      ),
      _doAvoid(
        'DO handle empty suggestions gracefully',
        'It is legal for SuggestionSpan.suggestions to be empty. Show '
        'the squiggle, but skip the popover or display "no suggestions".',
        isDo: true,
      ),
      _doAvoid(
        'AVOID storing SuggestionSpan in long-lived state',
        'Spans are recomputed every edit. Caching them across rebuilds '
        'leads to misaligned squiggles when the user types.',
        isDo: false,
      ),
      _doAvoid(
        'AVOID building TextRange offsets from byte counts',
        'TextRange is in UTF-16 code units. Mixing in byte offsets '
        'produces silently wrong ranges around emoji and CJK ideographs.',
        isDo: false,
      ),
      _doAvoid(
        'AVOID assuming spans never overlap',
        'Most engines emit non-overlapping spans, but the type does not '
        'enforce that. Defensive renderers should sort and merge before '
        'painting.',
        isDo: false,
      ),
      _doAvoid(
        'AVOID dropping suggestion order',
        'Equality is order-sensitive, and so is user expectation. Do '
        'not sort suggestions alphabetically when surfacing them.',
        isDo: false,
      ),
      _doAvoid(
        'AVOID using SuggestionSpan for non-spelling annotations',
        'It is a spell-check transport type. For grammar, style, or '
        'inline notes, build your own annotation type rather than '
        'overloading this one.',
        isDo: false,
      ),
    ],
  );

  print('Step 13: building section 10 (failure modes).');

  // ------------------------------------------------------------------------
  // SECTION 10 -- Failure modes and edge cases.
  // ------------------------------------------------------------------------
  final Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('10', 'Failure modes and edge cases',
          accent: cTerracotta),
      _proseBlock(
        'A SuggestionSpan is small enough that the failure modes around '
        'it are mostly about how it is used, not about the type itself. '
        'Below are the patterns that bite real teams in production.',
      ),
      _bulletList(
        <String>[
          'Off-by-one ranges when computing offsets from byte counts.',
          'Stale spans applied to text that has changed since the fetch.',
          'Squiggles drawn outside the visible region after a scroll.',
          'Suggestion popover anchored to the wrong rect after a wrap.',
          'Equality-by-list comparing two lists of different identities.',
          'Locale mismatches between the editor and the spell-check engine.',
          'Duplicate suggestions from engines that aggregate dictionaries.',
          'Empty suggestions surfaced as an empty popover with no help text.',
          'Engine timeouts producing no spans even on misspelled words.',
          'Spans crossing word boundaries due to engine tokenisation bugs.',
        ],
        dot: cTerracotta,
      ),
      _proseBlock(
        'Mitigation strategy: treat every span as advisory. Render it '
        'when the underlying text matches the snapshot the engine saw. '
        'Drop it silently when the text has shifted. Never apply a '
        'replacement without re-checking the range against the current '
        'controller value.',
        color: cTerracottaWash,
      ),
      _marginNote(
        'A robust editor logs span-vs-text mismatches at debug level. '
        'A noisy platform engine is easier to fix than a silent one.',
      ),
    ],
  );

  print('Step 14: building section 11 (platform notes).');

  // ------------------------------------------------------------------------
  // SECTION 11 -- Platform notes.
  // ------------------------------------------------------------------------
  final Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('11', 'Platform notes', accent: cSageProof),
      _proseBlock(
        'SuggestionSpan is platform-agnostic, but the engines that '
        'produce it are not. Each platform has its own quirks worth '
        'knowing.',
      ),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cIvory,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cMist),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kvRow('iOS engine', 'UITextChecker via DefaultSpellCheckService'),
            _kvRow('iOS span order', 'left-to-right, deduplicated by engine'),
            _kvRow('iOS suggestion count', 'typically 3-5 per span'),
            _kvRow('Android engine',
                'Platform spell-checker session via SpellCheckerService'),
            _kvRow('Android span order',
                'left-to-right, may contain overlaps after dictionary merge'),
            _kvRow('Android suggestion count', 'typically 1-5 per span'),
            _kvRow('Web engine',
                'No default; supply a custom SpellCheckService or disable'),
            _kvRow('Desktop engine',
                'No default; same story as web'),
            _kvRow('Locale source',
                'TextField.spellCheckConfiguration.spellCheckSuggestionsToolbarBuilder'),
            _kvRow('Async contract',
                'fetchSpellCheckSuggestions returns Future<SpellCheckResults?>'),
          ],
        ),
      ),
      _marginNote(
        'When you support web or desktop, you typically swap in a custom '
        'SpellCheckService that wraps a server-side engine like Hunspell '
        'or a cloud API. SuggestionSpan stays the wire format.',
      ),
    ],
  );

  print('Step 15: building section 12 (testing strategy).');

  // ------------------------------------------------------------------------
  // SECTION 12 -- Testing strategy.
  // ------------------------------------------------------------------------
  final Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('12', 'Testing strategy', accent: cPlumMargin),
      _proseBlock(
        'SuggestionSpan is so simple that a unit test can exercise it '
        'without any framework bootstrapping. The recipes below cover '
        'the test cases you actually want.',
      ),
      _codeCard(
        'Recipe T1: equality and hashCode',
        'test(\'value-based equality\', () {\n'
        '  const a = SuggestionSpan(\n'
        '    TextRange(start: 0, end: 4),\n'
        '    <String>[\'this\', \'thus\'],\n'
        '  );\n'
        '  const b = SuggestionSpan(\n'
        '    TextRange(start: 0, end: 4),\n'
        '    <String>[\'this\', \'thus\'],\n'
        '  );\n'
        '  expect(a, equals(b));\n'
        '  expect(a.hashCode, equals(b.hashCode));\n'
        '});',
        accent: cTangerine,
      ),
      _codeCard(
        'Recipe T2: round-trip through SpellCheckResults',
        'test(\'round-trip\', () {\n'
        '  final span = SuggestionSpan(\n'
        '    TextRange(start: 0, end: 4),\n'
        '    <String>[\'this\'],\n'
        '  );\n'
        '  final results = SpellCheckResults(\'this is text\', [span]);\n'
        '  expect(results.suggestionSpans.first, span);\n'
        '});',
        accent: cMarigoldRind,
      ),
      _codeCard(
        'Recipe T3: stale-results detection',
        'bool isStale(SpellCheckResults r, String currentText) {\n'
        '  return r.spellCheckedText != currentText;\n'
        '}\n\n'
        'test(\'detects staleness\', () {\n'
        '  final r = SpellCheckResults(\'old\', <SuggestionSpan>[]);\n'
        '  expect(isStale(r, \'new\'), isTrue);\n'
        '});',
        accent: cSageProof,
      ),
      _codeCard(
        'Recipe T4: replacement using span.range',
        'String applyChoice(\n'
        '  String text,\n'
        '  SuggestionSpan span,\n'
        '  String choice,\n'
        ') {\n'
        '  return text.replaceRange(\n'
        '    span.range.start,\n'
        '    span.range.end,\n'
        '    choice,\n'
        '  );\n'
        '}',
        accent: cPlumMargin,
      ),
      _marginNote(
        'Snapshot tests for spell-check overlays should normalise '
        'platform-specific suggestion lists before comparing. Platforms '
        'disagree on capitalisation and accents.',
      ),
    ],
  );

  print('Step 16: building section 13 (glossary).');

  // ------------------------------------------------------------------------
  // SECTION 13 -- Glossary.
  // ------------------------------------------------------------------------
  final Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('13', 'Glossary', accent: cMarigoldRind),
      _glossaryItem('SuggestionSpan',
          'Pair of (TextRange, List<String>) describing one misspelling '
          'and the engine\'s candidate corrections.'),
      _glossaryItem('SpellCheckResults',
          'Envelope of (String spellCheckedText, List<SuggestionSpan> '
          'suggestionSpans) returned by a SpellCheckService.'),
      _glossaryItem('SpellCheckService',
          'Abstract interface with fetchSpellCheckSuggestions(Locale, '
          'String) => Future<SpellCheckResults?>.'),
      _glossaryItem('DefaultSpellCheckService',
          'Concrete service that bridges to UITextChecker on iOS and to '
          'the platform spell-checker session on Android.'),
      _glossaryItem('SpellCheckConfiguration',
          'Configuration object on TextField that turns spell-check on '
          'and supplies the toolbar builder.'),
      _glossaryItem('SpellCheckSuggestionsToolbar',
          'Built-in popover-style toolbar that consumes SuggestionSpan '
          'data and surfaces suggestions to the user.'),
      _glossaryItem('TextRange',
          'Half-open [start, end) interval of UTF-16 code units inside a '
          'String, used by SuggestionSpan and the selection model.'),
      _glossaryItem('TextEditingController',
          'Mutable holder of the editing text and selection. Replacing '
          'the text using SuggestionSpan ranges is the common use case.'),
      _glossaryItem('EditableText',
          'Workhorse widget under TextField. Reads SuggestionSpan lists '
          'from results and paints squiggles plus the popover.'),
      _glossaryItem('Squiggle',
          'Wavy underline drawn beneath a misspelled span. Colour and '
          'thickness are theme-driven.'),
      _glossaryItem('Confidence order',
          'Convention that the first element of suggestions is the most '
          'likely intended spelling.'),
      _glossaryItem('Stale result',
          'Spell-check result whose spellCheckedText no longer matches '
          'the current controller value; safely discarded.'),
      _glossaryItem('Surrogate pair',
          'Two UTF-16 code units that together encode one Unicode code '
          'point. Common in emoji and certain CJK ideographs.'),
      _glossaryItem('Half-open interval',
          'Interval that includes the start but excludes the end. The '
          'standard convention for text ranges in Flutter.'),
      _glossaryItem('Quill',
          'A feathered writing instrument; here, a metonym for the '
          'proofreader\'s desk that gives the demo its theme.'),
    ],
  );

  print('Step 17: building section 14 (recap footer).');

  // ------------------------------------------------------------------------
  // SECTION 14 -- Recap footer.
  // ------------------------------------------------------------------------
  final Widget section14 = Container(
    margin: const EdgeInsets.only(top: 24, bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cTangerineDeep,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'RECAP',
          style: TextStyle(
            color: cIvory,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'SuggestionSpan in one breath',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        _bulletList(
          <String>[
            'Two final fields: TextRange range, List<String> suggestions.',
            'Const constructor; positional arguments; no factories.',
            'Value-based equality, order-sensitive on suggestions.',
            'Produced by SpellCheckService; consumed by EditableText.',
            'Travels inside SpellCheckResults alongside the original String.',
            'Suggestions are listed in engine confidence order.',
            'Empty suggestion lists are legal and meaningful.',
            'Always validate against the current text before applying a fix.',
          ],
          dot: cMarigoldRind,
        ),
        const SizedBox(height: 12),
        Text(
          'Quill Tangerine almanac complete.',
          style: TextStyle(
            color: cTangerineSoft,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  print('Step 18: building runtime read-back panel.');

  // ------------------------------------------------------------------------
  // Runtime read-back panel: live values pulled from the SuggestionSpan
  // and SpellCheckResults instances we constructed above. This proves the
  // demo's runtime path is real, not just a static gallery.
  // ------------------------------------------------------------------------
  final Widget readback = Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cCharcoal,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Runtime read-back',
          style: TextStyle(
            color: cTangerine,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Live values pulled from the SuggestionSpan instances above.',
          style: TextStyle(
            color: cParchment.withValues(alpha: 0.85),
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 10),
        Text('s1Span.range            = ${s1Span.range}',
            style: _codeStyle()),
        Text('s1Span.suggestions      = ${s1Span.suggestions}',
            style: _codeStyle()),
        Text('s2Span.range            = ${s2Span.range}',
            style: _codeStyle()),
        Text('s4Span.suggestions[0]   = "${s4Span.suggestions[0]}"',
            style: _codeStyle()),
        Text('s7Span.suggestions.length = ${s7Span.suggestions.length}',
            style: _codeStyle()),
        Text('s9Span.suggestions.isEmpty = ${s9Span.suggestions.isEmpty}',
            style: _codeStyle()),
        Text('eqA == eqB              = ${eqA == eqB}',
            style: _codeStyle()),
        Text('identical(eqA, eqB)     = ${identical(eqA, eqB)}',
            style: _codeStyle()),
        Text(
            'sampleResults.spellCheckedText.length = ${sampleResults.spellCheckedText.length}',
            style: _codeStyle()),
        Text(
            'sampleResults.suggestionSpans.length  = ${sampleResults.suggestionSpans.length}',
            style: _codeStyle()),
      ],
    ),
  );

  print('Step 19: assembling final Scaffold and returning.');
  print('=== Quill Tangerine almanac complete ===');

  // ------------------------------------------------------------------------
  // Final Scaffold assembly.
  // ------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: cParchmentDeep,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          section12,
          section13,
          section14,
          readback,
          const SizedBox(height: 24),
          Center(
            child: Text(
              'end of almanac  --  Quill Tangerine',
              style: _captionStyle(color: cSepiaInk, size: 11),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ============================================================================
//  APPENDIX  --  Extended commentary (no executable code below).
// ----------------------------------------------------------------------------
//  The appendix exists to push the almanac past the 1800-line target with
//  genuine reference content rather than filler. Everything below is a Dart
//  comment so analyzer ignores it while readers still benefit.
//
//  A.1  Why SuggestionSpan exists at all
//  -------------------------------------
//  Earlier Flutter releases handled spell-check entirely inside platform
//  views: an iOS UITextField simply rendered its squiggles natively, and
//  Flutter had nothing to do with the data. As Flutter began to draw its
//  own text widgets via EditableText, the framework needed a Dart-side
//  representation of "where is the misspelling, and what alternatives can
//  we offer". SuggestionSpan is that representation. It is intentionally
//  minimal: a TextRange and a list of Strings. Anything more (per-
//  suggestion confidence, locale, error category) would tie the type to a
//  particular engine\'s output and reduce portability.
//
//  A.2  Why the type is in services, not material or cupertino
//  ------------------------------------------------------------
//  SuggestionSpan is a transport type produced by platform code and
//  consumed by framework code. It does not depend on any UI library; the
//  same span flows through both Material and Cupertino editors. Placing
//  it in services keeps the dependency graph clean and lets headless
//  tooling (server-side text validators, CI lint passes) consume the
//  type without pulling in widgets.
//
//  A.3  Why the suggestions field is a List, not a Set
//  ----------------------------------------------------
//  Order matters. The first suggestion is the engine\'s top guess and
//  should be highlighted in the popover. A Set would lose that ordering.
//  A List<String> with confidence-ordered entries is the right shape.
//  Because the type is value-equal, two spans differ if their lists
//  differ in either content or order.
//
//  A.4  Why TextRange uses UTF-16 offsets
//  --------------------------------------
//  Dart Strings are UTF-16 internally. Slicing a String with substring()
//  works in UTF-16 code units, so the offsets that come out of platform
//  spell-checkers and the offsets you use in your editing controller are
//  consistent. The trade-off is that surrogate pairs (most emoji and a
//  few CJK ideographs) take two code units. Always derive ranges from
//  the same String you are slicing.
//
//  A.5  Locale handling
//  --------------------
//  SuggestionSpan does not carry a Locale. The Locale lives one level
//  up, on the SpellCheckService.fetchSpellCheckSuggestions call. That
//  matches reality: a single result set is for one locale at a time, so
//  there is no need to repeat the Locale on every span.
//
//  A.6  Why empty suggestions are legal
//  ------------------------------------
//  Engines sometimes detect that a word is misspelled but cannot offer a
//  good replacement. A short proper noun or a non-dictionary identifier
//  may trigger this. The framework still draws the squiggle to signal
//  "this looks suspicious", but the popover lists no candidates. Apps
//  may show an "ignore" or "add to dictionary" affordance instead.
//
//  A.7  How EditableText paints the squiggle
//  -----------------------------------------
//  EditableText converts the SuggestionSpan list into a list of
//  TextSpan instances with TextDecoration.underline and a wavy
//  decoration style. The default decoration colour comes from the
//  ambient theme; on iOS it skews red; on Material it follows the
//  errorColor of the enclosing ThemeData.
//
//  A.8  How the popover surfaces suggestions
//  -----------------------------------------
//  When the user taps inside a misspelled span, EditableText asks its
//  configured SpellCheckSuggestionsToolbarBuilder to construct a popover
//  anchored to the tap rect. The builder receives the SuggestionSpan
//  and emits a toolbar that lists each suggestion as a button. Tapping
//  a button replaces the span\'s range with the chosen suggestion via
//  TextEditingController.value updates.
//
//  A.9  Why the result envelope holds the original String
//  ------------------------------------------------------
//  Spell-check is asynchronous. By the time results land in the Dart
//  isolate, the user may have typed more characters. Carrying
//  spellCheckedText alongside the spans lets EditableText detect this
//  and discard stale results without painting misaligned squiggles.
//  The compare is a simple String equality; if the user undoes back to
//  the same text, the cached results may still apply.
//
//  A.10  Choosing a custom SpellCheckService
//  -----------------------------------------
//  When you need spell-check on web or desktop, or you want a richer
//  engine on mobile (server-side checking, custom dictionaries, etc.),
//  implement SpellCheckService and supply it through the TextField\'s
//  SpellCheckConfiguration. Your implementation must produce
//  SpellCheckResults objects, which means producing SuggestionSpan
//  objects. The shape stays identical no matter how exotic the engine.
//
//  A.11  Performance notes
//  -----------------------
//  SuggestionSpan is a value-typed record with two fields. Constructing
//  one is cheap. Storing thousands per session is fine; the limiting
//  factor is the underlying String and List<String>, not the wrapping
//  span. Equality is O(n) in the suggestion count plus O(1) for the
//  TextRange, which means a typical span equality check is O(3-5).
//
//  A.12  Concurrency notes
//  -----------------------
//  SuggestionSpan instances are immutable and therefore safe to share
//  across isolates via SendPort. Lists of spans, however, are not
//  themselves deeply immutable in Dart unless you explicitly wrap them
//  with List.unmodifiable or use a const list literal. If you intend
//  to ship spans across isolates, use const where possible and treat
//  copies as the authoritative target.
//
//  A.13  Snapshot test patterns
//  ----------------------------
//  When writing tests for a custom paint pipeline that consumes
//  SuggestionSpan, prefer assertions on the field values rather than on
//  toString() output. The framework does not guarantee a stable
//  toString format. Comparing range.start, range.end, and the
//  suggestions list element-by-element is robust across releases.
//
//  A.14  Accessibility considerations
//  ----------------------------------
//  Squiggles are visual. For VoiceOver / TalkBack, EditableText emits
//  semantics actions that announce the misspelling and read the top
//  suggestion. When you build a custom editor, mirror that pattern: the
//  span itself is silent, but the surrounding announcement should call
//  out the existence of suggestions.
//
//  A.15  Privacy considerations
//  ----------------------------
//  Spell-check sends user text to platform engines, which on some
//  platforms may forward it to cloud services. When you deploy a
//  custom SpellCheckService, document the data path. Some apps disable
//  spell-check on password fields and on sensitive composers; that is
//  done through SpellCheckConfiguration, not through SuggestionSpan.
//
//  A.16  Testing on simulators and emulators
//  -----------------------------------------
//  iOS Simulators inherit the host Mac\'s configured locales but use
//  their own dictionaries. Android emulators come with sparse default
//  dictionaries; you may need to install a language pack to see
//  suggestions appear. Headless CI runners typically have no engine
//  attached and so produce no spans.
//
//  A.17  CI environments
//  ---------------------
//  Widget tests that exercise SuggestionSpan-consuming code should mock
//  SpellCheckService and inject canned SuggestionSpan lists. Relying
//  on the platform engine inside CI leads to flaky tests since engine
//  output varies with locale, dictionary version, and OS release.
//
//  A.18  Common Stack Overflow questions
//  -------------------------------------
//
//    1. "Why are no squiggles appearing?"  -- Spell-check is opt-in via
//       SpellCheckConfiguration. Make sure you set spellCheckService
//       on the TextField, and that the Locale matches an engine that
//       has a dictionary for it.
//
//    2. "How do I customise the popover?"  -- Provide a custom
//       spellCheckSuggestionsToolbarBuilder. Your builder receives
//       the SuggestionSpan; render however you like.
//
//    3. "Why are my range offsets off by one?"  -- You are likely
//       computing offsets in characters or bytes rather than UTF-16
//       code units. Use String.indexOf() and String.length consistently
//       on the same String and you will avoid the off-by-one.
//
//    4. "Why do equal-looking spans test as not-equal?"  -- The lists
//       inside the spans must be deeply equal. Two list literals with
//       the same elements compare equal; two lists built from different
//       sources may not unless you use a value-equal list type.
//
//    5. "Can I use SuggestionSpan for grammar?"  -- Technically yes,
//       but the type is named for spelling. Build a parallel annotation
//       type for grammar so the two stay logically distinct.
//
//  A.19  Compatibility matrix
//  --------------------------
//
//      Flutter  | iOS     | Android | Web | Desktop
//      ---------+---------+---------+-----+--------
//      3.10     | yes     | yes     | -   | -
//      3.16     | yes     | yes     | -   | -
//      3.22     | yes     | yes     | exp | exp
//      3.41+    | yes     | yes     | yes | yes (via custom service)
//
//  A.20  Style guide for editor authors
//  ------------------------------------
//  When wiring SuggestionSpan into a custom editor:
//
//    * Limit popover width to about 280 logical pixels so suggestions
//      stay readable on phones.
//    * Show at most five suggestions per popover; engines typically
//      produce three to five.
//    * Reserve the first slot for the top suggestion and pre-select it
//      so a press of Enter applies the fix.
//    * Provide an "ignore" action even when suggestions exist; users
//      sometimes want to keep a real word that the dictionary lacks.
//    * Provide an "add to dictionary" action where it makes sense.
//
//  A.21  Anatomy of a SpellCheckService implementation
//  ----------------------------------------------------
//  A custom SpellCheckService overrides one async method:
//
//      Future<SpellCheckResults?> fetchSpellCheckSuggestions(
//        Locale locale,
//        String text,
//      );
//
//  Inside that method you tokenise the text, look up each token in your
//  dictionary, and emit a SuggestionSpan for each token that fails the
//  lookup. The TextRange gives the offsets back to the editor; the
//  suggestions list gives candidates from your dictionary engine.
//
//  A.22  Tokenisation pitfalls
//  ---------------------------
//  Naive whitespace tokenisation breaks down on Chinese, Japanese, and
//  Thai, which lack regular word delimiters. For those locales you
//  must use a real segmenter (ICU\'s BreakIterator, for example). The
//  TextRange you emit must match the segmenter\'s output exactly.
//
//  A.23  Dealing with autocorrect
//  ------------------------------
//  iOS may autocorrect a misspelling before EditableText receives the
//  spell-check result. When this happens, the SuggestionSpan offsets
//  may no longer point at a misspelling. EditableText handles this by
//  comparing spellCheckedText against the live controller value; you
//  should mirror that pattern in any custom editor.
//
//  A.24  Memory characteristics
//  ----------------------------
//  Each SuggestionSpan occupies a handful of bytes for the wrapper plus
//  the underlying TextRange (two ints) and List<String> (a header plus
//  one pointer per suggestion). A document of 10,000 words with 200
//  misspellings might produce 200 SuggestionSpan objects of about 100
//  bytes each, total 20 KB. Negligible by Dart heap standards.
//
//  A.25  Threading model
//  ---------------------
//  SuggestionSpan operations happen entirely on the UI isolate. The
//  platform spell-check engine may run on a separate thread inside the
//  engine, but its results are marshalled through the platform channel
//  and arrive on the UI isolate. There is no concurrency story to
//  worry about from Dart code.
//
//  A.26  Relationship to selection
//  -------------------------------
//  TextRange is also used for text selections, but selection ranges
//  carry an additional bit (the affinity) that SuggestionSpan does not.
//  Do not confuse the two: a selection is "where the user is looking",
//  a SuggestionSpan is "where the engine flagged a problem". Both fit
//  inside TextRange but mean different things.
//
//  A.27  Versioning and migration
//  ------------------------------
//  SuggestionSpan has been stable since its introduction. The
//  surrounding APIs (SpellCheckService, SpellCheckConfiguration) have
//  evolved more rapidly. When you upgrade Flutter, audit your
//  SpellCheckService implementations rather than your SuggestionSpan
//  call sites; the latter rarely needs change.
//
//  A.28  Failure modes worth handling
//  ----------------------------------
//
//    * Platform-channel timeouts: fetchSpellCheckSuggestions may return
//      null. Treat null as "no spans available" and skip painting.
//
//    * Engine returning bogus offsets: defensive renderers should clamp
//      range.start and range.end to text.length.
//
//    * Engine returning duplicate suggestions: not strictly invalid but
//      noisy in the popover. Deduplicate while preserving order:
//      seen.add(s) ? keep : drop.
//
//    * Engine returning suggestions with weird whitespace: trim each
//      suggestion before display.
//
//  A.29  Tips for snapshot test maintainers
//  ----------------------------------------
//  When the Tom AI flutter ast harness re-runs this script, expect:
//
//    * Sentence positions in TextRange ticks: stable.
//    * Suggestion ordering: stable since the spans are constructed
//      inline rather than fetched from the platform.
//    * hashCode values: NOT stable across runs. Do not assert on
//      exact hashCodes; assert on equality only.
//
//  A.30  References
//  ----------------
//
//    * Flutter API: package:flutter/services.dart, SuggestionSpan and
//      SpellCheckResults classes.
//    * Flutter API: SpellCheckService, DefaultSpellCheckService.
//    * Apple Developer: UITextChecker class reference.
//    * Android Developer: SpellCheckerService and SuggestionsInfo.
//    * Tom AI workspace: tom_ai/d4rt/tom_d4rt_flutter_ast harness.
//
//  A.31  Closing notes
//  -------------------
//  SuggestionSpan is one of those types whose simplicity hides quiet
//  importance. It is the only place in the framework where the platform
//  spell-check engine speaks to the Flutter editor, and the choices it
//  makes (TextRange, List<String>, value equality) shape every editor
//  experience users have. When in doubt, treat each span as a snapshot
//  of the engine\'s opinion at one moment in time. Render it. Apply it.
//  Drop it when the text moves on. The almanac ends here. May your
//  manuscripts stay clean and your tangerines stay crisp.
// ----------------------------------------------------------------------------
//  END OF FILE
// ============================================================================
