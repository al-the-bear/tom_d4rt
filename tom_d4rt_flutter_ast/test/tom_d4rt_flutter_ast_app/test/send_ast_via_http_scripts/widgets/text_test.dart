// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: Text from package:flutter/widgets.dart
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Text deep visual demo executing');

  // ---------------------------------------------------------------------------
  // Palette: "Inkwell Manuscript" — parchment, ink, vermilion, lapis, verdigris.
  // Chosen to evoke a typographic specimen book; unique to this demo file.
  // ---------------------------------------------------------------------------
  const Color cParchment = Color(0xFFF6EFE0);
  const Color cParchmentDeep = Color(0xFFE8DEC6);
  const Color cInk = Color(0xFF1B1A17);
  const Color cInkSoft = Color(0xFF3E3A33);
  const Color cVermilion = Color(0xFFB23A2A);
  const Color cLapis = Color(0xFF1F4E8C);
  const Color cVerdigris = Color(0xFF2F8F7E);
  const Color cGold = Color(0xFFB58B36);
  const Color cMargin = Color(0xFFD9CDB1);

  // Section header — used many times. Hand-built to keep the file linear.
  Widget sectionHeader(String number, String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 14.0),
      decoration: BoxDecoration(
        color: cInk,
        border: Border(
          left: BorderSide(color: cVermilion, width: 6.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                number,
                style: const TextStyle(
                  color: cGold,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: cParchment,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            subtitle,
            style: TextStyle(
              color: cParchment.withValues(alpha: 0.72),
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget specimenBox({required String label, required Widget child, Color? bg}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
      decoration: BoxDecoration(
        color: bg ?? cParchment,
        border: Border.all(color: cMargin, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 10.0,
              color: cInkSoft,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6.0),
          child,
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 0: Hero header.
  // ---------------------------------------------------------------------------
  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28.0, 36.0, 28.0, 36.0),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[cInk, cLapis],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'A SPECIMEN BOOK',
          style: TextStyle(
            color: cGold,
            fontSize: 12.0,
            letterSpacing: 8.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Text',
          style: TextStyle(
            color: cParchment,
            fontSize: 64.0,
            fontWeight: FontWeight.w900,
            height: 0.95,
            letterSpacing: -2.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'package:flutter/widgets.dart',
          style: TextStyle(
            color: cParchment.withValues(alpha: 0.78),
            fontSize: 14.0,
            fontFamily: 'monospace',
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: cParchment.withValues(alpha: 0.08),
            border: Border.all(color: cParchment.withValues(alpha: 0.25)),
          ),
          child: Text(
            'A run of text with a single style. The canonical text-rendering '
            'widget of Flutter — and the one widget every UI file you will '
            'ever write almost certainly contains.',
            style: TextStyle(
              color: cParchment.withValues(alpha: 0.92),
              fontSize: 14.5,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 1: Basic Text gallery (size, weight, style, color, spacing).
  // ---------------------------------------------------------------------------
  final List<Widget> basicSamples = <Widget>[];
  basicSamples.add(specimenBox(
    label: 'fontSize: 12',
    child: const Text(
      'The quick brown fox jumps over the lazy dog.',
      style: TextStyle(fontSize: 12.0, color: cInk),
    ),
  ));
  basicSamples.add(specimenBox(
    label: 'fontSize: 18',
    child: const Text(
      'The quick brown fox jumps over the lazy dog.',
      style: TextStyle(fontSize: 18.0, color: cInk),
    ),
  ));
  basicSamples.add(specimenBox(
    label: 'fontSize: 28 / weight: w300',
    child: const Text(
      'Glyphs at large sizes',
      style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w300, color: cInk),
    ),
  ));
  basicSamples.add(specimenBox(
    label: 'fontWeight: w900',
    child: const Text(
      'BLACK WEIGHT',
      style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w900, color: cInk),
    ),
  ));
  basicSamples.add(specimenBox(
    label: 'fontStyle: italic',
    child: const Text(
      'A passage rendered in italic for emphasis.',
      style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic, color: cVermilion),
    ),
  ));
  basicSamples.add(specimenBox(
    label: 'color: lapis',
    child: const Text(
      'Lapis lazuli pigment',
      style: TextStyle(fontSize: 20.0, color: cLapis, fontWeight: FontWeight.w600),
    ),
  ));
  basicSamples.add(specimenBox(
    label: 'letterSpacing: 6',
    child: const Text(
      'WIDE TRACKING',
      style: TextStyle(fontSize: 16.0, letterSpacing: 6.0, color: cInk),
    ),
  ));
  basicSamples.add(specimenBox(
    label: 'letterSpacing: -1',
    child: const Text(
      'Tight tracking pulls letters together',
      style: TextStyle(fontSize: 18.0, letterSpacing: -1.0, color: cInk),
    ),
  ));
  basicSamples.add(specimenBox(
    label: 'wordSpacing: 12',
    child: const Text(
      'Open word spacing for airy paragraphs',
      style: TextStyle(fontSize: 16.0, wordSpacing: 12.0, color: cInk),
    ),
  ));
  basicSamples.add(specimenBox(
    label: 'height: 1.8',
    child: const Text(
      'When the line height multiplier is increased, lines breathe further '
      'apart and a paragraph becomes easier to scan in dim light.',
      style: TextStyle(fontSize: 14.0, height: 1.8, color: cInkSoft),
    ),
  ));
  basicSamples.add(specimenBox(
    label: 'color + shadows',
    child: Text(
      'Embossed glyphs',
      style: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.w800,
        color: cParchment,
        shadows: <Shadow>[
          Shadow(
            color: cInk.withValues(alpha: 0.55),
            offset: const Offset(2.0, 2.0),
            blurRadius: 3.0,
          ),
        ],
      ),
    ),
  ));

  final Widget basicSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: basicSamples,
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 2: TextAlign gallery — all six values in fixed-width frames.
  // ---------------------------------------------------------------------------
  final List<TextAlign> aligns = <TextAlign>[
    TextAlign.left,
    TextAlign.right,
    TextAlign.center,
    TextAlign.justify,
    TextAlign.start,
    TextAlign.end,
  ];
  final List<String> alignNames = <String>[
    'TextAlign.left',
    'TextAlign.right',
    'TextAlign.center',
    'TextAlign.justify',
    'TextAlign.start',
    'TextAlign.end',
  ];
  final List<Widget> alignSamples = <Widget>[];
  for (int i = 0; i < aligns.length; i = i + 1) {
    alignSamples.add(Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cParchment,
        border: Border.all(color: cMargin),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            alignNames[i],
            style: const TextStyle(
              fontSize: 11.0,
              color: cVermilion,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Per accidens hoc — a passage long enough to fill multiple lines '
            'and reveal how alignment behaves with variable line widths.',
            textAlign: aligns[i],
            style: const TextStyle(fontSize: 13.5, color: cInk, height: 1.45),
          ),
        ],
      ),
    ));
  }

  final Widget alignSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: alignSamples,
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 3: TextOverflow gallery — clip / fade / ellipsis / visible.
  // ---------------------------------------------------------------------------
  const String longSample =
      'Pellentesque habitant morbi tristique senectus et netus et malesuada '
      'fames ac turpis egestas, with text long enough to overflow the box.';

  Widget overflowFrame(String label, TextOverflow overflow) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: cParchment,
        border: Border.all(color: cMargin),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.0,
              color: cVerdigris,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6.0),
          Container(
            width: 220.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: cParchmentDeep.withValues(alpha: 0.6),
              border: Border.all(color: cInk.withValues(alpha: 0.15)),
            ),
            padding: const EdgeInsets.all(6.0),
            child: Text(
              longSample,
              maxLines: 1,
              softWrap: false,
              overflow: overflow,
              style: const TextStyle(fontSize: 13.0, color: cInk),
            ),
          ),
        ],
      ),
    );
  }

  final Widget overflowSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        overflowFrame('TextOverflow.clip', TextOverflow.clip),
        overflowFrame('TextOverflow.fade', TextOverflow.fade),
        overflowFrame('TextOverflow.ellipsis', TextOverflow.ellipsis),
        overflowFrame('TextOverflow.visible', TextOverflow.visible),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 4: maxLines + ellipsis combos.
  // ---------------------------------------------------------------------------
  final List<int> maxLineValues = <int>[1, 2, 3, 4];
  final List<Widget> maxLineSamples = <Widget>[];
  for (int i = 0; i < maxLineValues.length; i = i + 1) {
    final int n = maxLineValues[i];
    maxLineSamples.add(Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cParchment,
        border: Border(left: BorderSide(color: cLapis, width: 4.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'maxLines: $n + ellipsis',
            style: const TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: cLapis,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'A truly extended passage. The first line of every novel matters. '
            'The second carries the reader. The third orients them in space. '
            'The fourth establishes time. The fifth introduces conflict. '
            'And the sixth is where the writer sets the hook for the chapter.',
            maxLines: n,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13.5, color: cInk, height: 1.4),
          ),
        ],
      ),
    ));
  }
  final Widget maxLineSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: maxLineSamples,
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 5: Text.rich showcase — inline styling via TextSpan tree.
  // ---------------------------------------------------------------------------
  Widget richBox;
  try {
    richBox = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      color: cParchment,
      child: Text.rich(
        TextSpan(
          style: const TextStyle(fontSize: 15.5, color: cInk, height: 1.55),
          children: <InlineSpan>[
            const TextSpan(text: 'In the beginning was the '),
            const TextSpan(
              text: 'Word',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: cVermilion,
              ),
            ),
            const TextSpan(text: ', and the Word was rendered by a '),
            const TextSpan(
              text: 'Text',
              style: TextStyle(
                fontFamily: 'monospace',
                color: cLapis,
                fontWeight: FontWeight.w700,
              ),
            ),
            const TextSpan(text: ' widget — itself wrapping a '),
            const TextSpan(
              text: 'TextSpan',
              style: TextStyle(
                fontFamily: 'monospace',
                color: cVerdigris,
                fontWeight: FontWeight.w700,
              ),
            ),
            const TextSpan(text: ' tree. Inline you can mix '),
            const TextSpan(
              text: 'italics',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const TextSpan(text: ', '),
            const TextSpan(
              text: 'underlines',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            const TextSpan(text: ', '),
            TextSpan(
              text: 'highlights',
              style: TextStyle(
                backgroundColor: cGold.withValues(alpha: 0.45),
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(text: ', and even '),
            const TextSpan(
              text: 'tracked caps',
              style: TextStyle(
                letterSpacing: 3.0,
                fontWeight: FontWeight.w800,
                color: cInk,
              ),
            ),
            const TextSpan(text: ' — all in a single paragraph.'),
          ],
        ),
      ),
    );
  } catch (e) {
    richBox = Text('Text.rich unavailable: $e');
  }

  // ---------------------------------------------------------------------------
  // SECTION 6: TextDecoration gallery — line variants & decoration styles.
  // ---------------------------------------------------------------------------
  final List<TextDecorationStyle> decoStyles = <TextDecorationStyle>[
    TextDecorationStyle.solid,
    TextDecorationStyle.double,
    TextDecorationStyle.dotted,
    TextDecorationStyle.dashed,
    TextDecorationStyle.wavy,
  ];
  final List<String> decoStyleNames = <String>[
    'solid',
    'double',
    'dotted',
    'dashed',
    'wavy',
  ];
  final List<Widget> decoSamples = <Widget>[];
  decoSamples.add(specimenBox(
    label: 'TextDecoration.underline',
    child: const Text(
      'Galley proof — underlined',
      style: TextStyle(
        fontSize: 18.0,
        color: cInk,
        decoration: TextDecoration.underline,
        decorationColor: cVermilion,
        decorationThickness: 2.0,
      ),
    ),
  ));
  decoSamples.add(specimenBox(
    label: 'TextDecoration.overline',
    child: const Text(
      'Marginalia — overlined',
      style: TextStyle(
        fontSize: 18.0,
        color: cInk,
        decoration: TextDecoration.overline,
        decorationColor: cLapis,
      ),
    ),
  ));
  decoSamples.add(specimenBox(
    label: 'TextDecoration.lineThrough',
    child: const Text(
      'Struck — withdrawn from the manuscript',
      style: TextStyle(
        fontSize: 18.0,
        color: cInkSoft,
        decoration: TextDecoration.lineThrough,
        decorationColor: cVermilion,
        decorationThickness: 2.0,
      ),
    ),
  ));
  for (int i = 0; i < decoStyles.length; i = i + 1) {
    decoSamples.add(specimenBox(
      label: 'decorationStyle: ${decoStyleNames[i]}',
      child: Text(
        'Underlined with style ${decoStyleNames[i]}',
        style: TextStyle(
          fontSize: 16.0,
          color: cInk,
          decoration: TextDecoration.underline,
          decorationStyle: decoStyles[i],
          decorationColor: cVerdigris,
          decorationThickness: 2.0,
        ),
      ),
    ));
  }
  final Widget decoSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: decoSamples,
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 7: FontFeature gallery — wrapped in try/catch (font dependent).
  // ---------------------------------------------------------------------------
  Widget featureSection;
  try {
    final List<Widget> featureSamples = <Widget>[];
    featureSamples.add(specimenBox(
      label: 'FontFeature.oldstyleFigures()',
      child: Text(
        '0 1 2 3 4 5 6 7 8 9',
        style: TextStyle(
          fontSize: 22.0,
          color: cInk,
          fontFeatures: <ui.FontFeature>[
            const ui.FontFeature.oldstyleFigures(),
          ],
        ),
      ),
    ));
    featureSamples.add(specimenBox(
      label: 'FontFeature.tabularFigures()',
      child: Text(
        '11 22 33 44 55',
        style: TextStyle(
          fontSize: 22.0,
          color: cInk,
          fontFeatures: <ui.FontFeature>[
            const ui.FontFeature.tabularFigures(),
          ],
        ),
      ),
    ));
    featureSamples.add(specimenBox(
      label: 'FontFeature.enable("smcp") — small caps',
      child: Text(
        'small caps petite text',
        style: TextStyle(
          fontSize: 20.0,
          color: cInk,
          fontFeatures: <ui.FontFeature>[
            const ui.FontFeature.enable('smcp'),
          ],
        ),
      ),
    ));
    featureSamples.add(specimenBox(
      label: 'FontFeature disable liga (ligatures off)',
      child: Text(
        'office finally affluent',
        style: TextStyle(
          fontSize: 20.0,
          color: cInk,
          fontFeatures: <ui.FontFeature>[
            const ui.FontFeature.disable('liga'),
          ],
        ),
      ),
    ));
    featureSamples.add(specimenBox(
      label: 'FontVariation wght: 700',
      child: Text(
        'Variable axis weight',
        style: TextStyle(
          fontSize: 20.0,
          color: cInk,
          fontVariations: <ui.FontVariation>[
            const ui.FontVariation('wght', 700.0),
          ],
        ),
      ),
    ));
    featureSection = Container(
      color: cParchmentDeep,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: featureSamples,
      ),
    );
  } catch (e) {
    featureSection = Container(
      color: cParchmentDeep,
      padding: const EdgeInsets.all(16.0),
      child: Text('FontFeature/FontVariation unavailable: $e'),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 8: TextScaler explainer — linear vs noScaling.
  // ---------------------------------------------------------------------------
  final List<double> scales = <double>[0.85, 1.0, 1.25, 1.6, 2.0];
  final List<Widget> scalerSamples = <Widget>[];
  for (int i = 0; i < scales.length; i = i + 1) {
    final double s = scales[i];
    scalerSamples.add(Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: cParchment,
        border: Border.all(color: cMargin),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              'TextScaler.linear($s)',
              style: const TextStyle(
                fontSize: 11.0,
                color: cVermilion,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              'Accessibility text scaling',
              textScaler: TextScaler.linear(s),
              style: const TextStyle(fontSize: 14.0, color: cInk),
            ),
          ),
        ],
      ),
    ));
  }
  scalerSamples.add(Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: cParchment,
      border: Border.all(color: cMargin),
    ),
    child: Row(
      children: <Widget>[
        const SizedBox(
          width: 130.0,
          child: Text(
            'TextScaler.noScaling',
            style: TextStyle(
              fontSize: 11.0,
              color: cVermilion,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        const Expanded(
          child: Text(
            'No scaling, fixed at 14',
            textScaler: TextScaler.noScaling,
            style: TextStyle(fontSize: 14.0, color: cInk),
          ),
        ),
      ],
    ),
  ));
  final Widget scalerSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: scalerSamples,
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 9: StrutStyle visual — forces a baseline regardless of run height.
  // ---------------------------------------------------------------------------
  Widget strutSection;
  try {
    strutSection = Container(
      color: cParchmentDeep,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          specimenBox(
            label: 'no strutStyle (default)',
            child: const Text(
              'Tall glyphs Áb̃g̃ shift the line height\nsecond line follows ascender extents',
              style: TextStyle(fontSize: 14.0, color: cInk),
            ),
          ),
          specimenBox(
            label: 'strutStyle: forceStrutHeight',
            child: const Text(
              'Tall glyphs Áb̃g̃ pinned by strut\nsecond line keeps fixed metrics',
              style: TextStyle(fontSize: 14.0, color: cInk),
              strutStyle: StrutStyle(
                fontSize: 14.0,
                height: 1.5,
                forceStrutHeight: true,
              ),
            ),
          ),
        ],
      ),
    );
  } catch (e) {
    strutSection = Container(
      color: cParchmentDeep,
      padding: const EdgeInsets.all(16.0),
      child: Text('StrutStyle unavailable: $e'),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 10: TextDirection — RTL mock paragraph.
  // ---------------------------------------------------------------------------
  final Widget directionSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        specimenBox(
          label: 'TextDirection.ltr',
          child: const Text(
            'In English, the line begins at the left margin and runs rightward.',
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 14.0, color: cInk),
          ),
        ),
        specimenBox(
          label: 'TextDirection.rtl (mock — Latin glyphs reversed flow)',
          child: const Text(
            '. margin right the at begins line the languages, RTL In',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 14.0, color: cInk),
          ),
        ),
        specimenBox(
          label: 'mixed scripts (Latin + Greek + Cyrillic + CJK)',
          child: const Text(
            'Latin / Ελληνικά / Кириллица / 漢字 — mixed scripts in one run.',
            style: TextStyle(fontSize: 15.0, color: cInk, height: 1.4),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 11: Comparison — Text vs RichText vs SelectableText.
  // ---------------------------------------------------------------------------
  Widget cell(String s, {Color color = cInk, FontWeight w = FontWeight.w400}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Text(
        s,
        style: TextStyle(fontSize: 13.0, color: color, fontWeight: w, height: 1.35),
      ),
    );
  }

  TableRow row(String a, String b, String c, String d) {
    return TableRow(children: <Widget>[cell(a), cell(b), cell(c), cell(d)]);
  }

  TableRow headRow() {
    return TableRow(
      decoration: const BoxDecoration(color: cInk),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Property',
              style: TextStyle(color: cParchment, fontWeight: FontWeight.w800, fontSize: 12.0, letterSpacing: 1.0)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Text',
              style: TextStyle(color: cParchment, fontWeight: FontWeight.w800, fontSize: 12.0, letterSpacing: 1.0)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('RichText',
              style: TextStyle(color: cParchment, fontWeight: FontWeight.w800, fontSize: 12.0, letterSpacing: 1.0)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('SelectableText',
              style: TextStyle(color: cParchment, fontWeight: FontWeight.w800, fontSize: 12.0, letterSpacing: 1.0)),
        ),
      ],
    );
  }

  final Widget compareSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        color: cParchment,
        border: Border.all(color: cMargin),
      ),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(color: cMargin.withValues(alpha: 0.7)),
        ),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1.4),
          1: FlexColumnWidth(1.0),
          2: FlexColumnWidth(1.0),
          3: FlexColumnWidth(1.4),
        },
        children: <TableRow>[
          headRow(),
          row('layer', 'widget', 'render-object', 'widget'),
          row('default style', 'inherits DefaultTextStyle', 'no inherit', 'inherits'),
          row('inline spans', 'via .rich', 'native (TextSpan)', 'via .rich'),
          row('selection', 'no', 'no', 'yes'),
          row('semantics label', 'yes', 'no', 'yes'),
          row('cost', 'low', 'lowest', 'higher'),
          row('typical use', 'most labels', 'low-level layout', 'copy-paste UI'),
        ],
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 12: Edge cases — empty / very long word / mixed scripts / long maxLines.
  // ---------------------------------------------------------------------------
  final Widget edgeSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        specimenBox(
          label: 'empty string',
          child: Container(
            height: 22.0,
            color: cParchmentDeep.withValues(alpha: 0.7),
            child: const Text('', style: TextStyle(fontSize: 14.0, color: cInk)),
          ),
        ),
        specimenBox(
          label: 'unbreakable long word, softWrap: true',
          child: const SizedBox(
            width: 180.0,
            child: Text(
              'Pneumonoultramicroscopicsilicovolcanoconiosisextended',
              style: TextStyle(fontSize: 14.0, color: cInk),
            ),
          ),
        ),
        specimenBox(
          label: 'softWrap: false + overflow.fade',
          child: const SizedBox(
            width: 180.0,
            child: Text(
              'A line that should not wrap and fades at the trailing edge of its frame.',
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 14.0, color: cInk),
            ),
          ),
        ),
        specimenBox(
          label: 'semanticsLabel override (visible: 1.2K, semantics: "1200 items")',
          child: const Text(
            '1.2K',
            semanticsLabel: '1200 items',
            style: TextStyle(fontSize: 18.0, color: cInk, fontWeight: FontWeight.w700),
          ),
        ),
        specimenBox(
          label: 'textWidthBasis.parent vs longestLine',
          child: Container(
            color: cParchmentDeep.withValues(alpha: 0.7),
            padding: const EdgeInsets.all(6.0),
            child: const Text(
              'Short\nLonger middle line\nMid',
              textAlign: TextAlign.center,
              textWidthBasis: TextWidthBasis.longestLine,
              style: TextStyle(fontSize: 14.0, color: cInk),
            ),
          ),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 13: TextStyle property reference — quick scan.
  // ---------------------------------------------------------------------------
  final List<List<String>> styleProps = <List<String>>[
    <String>['fontSize', 'logical pixels for em-square'],
    <String>['fontWeight', 'FontWeight.w100..w900'],
    <String>['fontStyle', 'normal | italic'],
    <String>['color', 'glyph fill color'],
    <String>['backgroundColor', 'paint behind glyphs'],
    <String>['letterSpacing', 'extra space per glyph (px)'],
    <String>['wordSpacing', 'extra space at word breaks (px)'],
    <String>['height', 'line-height multiplier of fontSize'],
    <String>['decoration', 'underline | overline | lineThrough | none'],
    <String>['decorationColor', 'color of decoration line'],
    <String>['decorationStyle', 'solid | double | dotted | dashed | wavy'],
    <String>['decorationThickness', 'multiplier of font-defined thickness'],
    <String>['fontFamily', 'primary family'],
    <String>['fontFamilyFallback', 'ordered fallback families'],
    <String>['fontFeatures', 'OpenType feature toggles'],
    <String>['fontVariations', 'variable-font axis values'],
    <String>['shadows', 'list of paint shadows'],
    <String>['locale', 'affects script-specific glyph selection'],
    <String>['textBaseline', 'alphabetic | ideographic'],
    <String>['leadingDistribution', 'half-leading distribution'],
  ];
  final List<TableRow> propRows = <TableRow>[
    TableRow(
      decoration: const BoxDecoration(color: cInk),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Property',
              style: TextStyle(color: cGold, fontSize: 12.0, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Description',
              style: TextStyle(color: cGold, fontSize: 12.0, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
        ),
      ],
    ),
  ];
  for (int i = 0; i < styleProps.length; i = i + 1) {
    propRows.add(TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Text(
            styleProps[i][0],
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: cLapis,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Text(
            styleProps[i][1],
            style: const TextStyle(fontSize: 12.5, color: cInk),
          ),
        ),
      ],
    ));
  }

  final Widget propSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Container(
      decoration: BoxDecoration(
        color: cParchment,
        border: Border.all(color: cMargin),
      ),
      child: Table(
        border: TableBorder.symmetric(
          inside: BorderSide(color: cMargin.withValues(alpha: 0.7)),
        ),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(1.0),
          1: FlexColumnWidth(2.0),
        },
        children: propRows,
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 13b: TextHeightBehavior — applyHeightToFirst/LastDescent.
  // ---------------------------------------------------------------------------
  Widget heightBehaviorSection;
  try {
    Widget heightCard(String title, TextHeightBehavior behavior) {
      return Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: cParchment,
          border: Border.all(color: cMargin),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 11.0,
                color: cVerdigris,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6.0),
            Container(
              color: cParchmentDeep.withValues(alpha: 0.7),
              padding: const EdgeInsets.all(6.0),
              child: Text(
                'First-line and last-line\nascent/descent metrics\nare modulated.',
                textHeightBehavior: behavior,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 2.0,
                  color: cInk,
                ),
              ),
            ),
          ],
        ),
      );
    }

    heightBehaviorSection = Container(
      color: cParchmentDeep,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heightCard(
            'default (apply both)',
            const TextHeightBehavior(),
          ),
          heightCard(
            'first: false / last: true',
            const TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: true,
            ),
          ),
          heightCard(
            'first: true / last: false',
            const TextHeightBehavior(
              applyHeightToFirstAscent: true,
              applyHeightToLastDescent: false,
            ),
          ),
          heightCard(
            'leadingDistribution.even',
            const TextHeightBehavior(
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ],
      ),
    );
  } catch (e) {
    heightBehaviorSection = Container(
      color: cParchmentDeep,
      padding: const EdgeInsets.all(16.0),
      child: Text('TextHeightBehavior unavailable: $e'),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 13c: Selection color — visual hint of selectionColor parameter.
  // ---------------------------------------------------------------------------
  final List<Color> selectionTints = <Color>[
    cVermilion.withValues(alpha: 0.35),
    cLapis.withValues(alpha: 0.35),
    cVerdigris.withValues(alpha: 0.35),
    cGold.withValues(alpha: 0.45),
  ];
  final List<String> selectionNames = <String>[
    'vermilion 35%',
    'lapis 35%',
    'verdigris 35%',
    'gold 45%',
  ];
  final List<Widget> selectionRows = <Widget>[];
  for (int i = 0; i < selectionTints.length; i = i + 1) {
    selectionRows.add(Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: cParchment,
        border: Border.all(color: cMargin),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              selectionNames[i],
              style: const TextStyle(
                fontSize: 11.0,
                color: cInkSoft,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(color: selectionTints[i]),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    'A passage that simulates a current selection range.',
                    style: const TextStyle(fontSize: 14.0, color: cInk),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
  final Widget selectionSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: selectionRows,
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 13d: Color spectrum sweep — single Text repeated across hues.
  // ---------------------------------------------------------------------------
  final List<Color> spectrum = <Color>[
    const Color(0xFF8C1F1F),
    const Color(0xFFB23A2A),
    const Color(0xFFC76A2C),
    const Color(0xFFB58B36),
    const Color(0xFF7E8C2C),
    const Color(0xFF2F8F7E),
    const Color(0xFF1F4E8C),
    const Color(0xFF553A8C),
    const Color(0xFF7C2A6E),
    const Color(0xFF1B1A17),
  ];
  final List<Widget> spectrumRows = <Widget>[];
  for (int i = 0; i < spectrum.length; i = i + 1) {
    spectrumRows.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 24.0,
            height: 24.0,
            color: spectrum[i],
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'The same string sweeps the palette',
              style: TextStyle(
                fontSize: 16.0,
                color: spectrum[i],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ));
  }
  final Widget spectrumSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cParchment,
        border: Border.all(color: cMargin),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: spectrumRows,
      ),
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 13e: Type scale — Material-style display/headline/title/body/label.
  // ---------------------------------------------------------------------------
  final List<List<Object>> typeScale = <List<Object>>[
    <Object>['displayLarge', 57.0, FontWeight.w400, -0.25],
    <Object>['displayMedium', 45.0, FontWeight.w400, 0.0],
    <Object>['displaySmall', 36.0, FontWeight.w400, 0.0],
    <Object>['headlineLarge', 32.0, FontWeight.w400, 0.0],
    <Object>['headlineMedium', 28.0, FontWeight.w400, 0.0],
    <Object>['headlineSmall', 24.0, FontWeight.w400, 0.0],
    <Object>['titleLarge', 22.0, FontWeight.w500, 0.0],
    <Object>['titleMedium', 16.0, FontWeight.w500, 0.15],
    <Object>['titleSmall', 14.0, FontWeight.w500, 0.1],
    <Object>['bodyLarge', 16.0, FontWeight.w400, 0.5],
    <Object>['bodyMedium', 14.0, FontWeight.w400, 0.25],
    <Object>['bodySmall', 12.0, FontWeight.w400, 0.4],
    <Object>['labelLarge', 14.0, FontWeight.w500, 0.1],
    <Object>['labelMedium', 12.0, FontWeight.w500, 0.5],
    <Object>['labelSmall', 11.0, FontWeight.w500, 0.5],
  ];
  final List<Widget> typeScaleRows = <Widget>[];
  for (int i = 0; i < typeScale.length; i = i + 1) {
    final String name = typeScale[i][0] as String;
    final double size = typeScale[i][1] as double;
    final FontWeight w = typeScale[i][2] as FontWeight;
    final double tracking = typeScale[i][3] as double;
    typeScaleRows.add(Container(
      margin: const EdgeInsets.only(bottom: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: cParchment,
        border: Border(left: BorderSide(color: cVerdigris, width: 3.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 11.0,
                color: cInkSoft,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'Specimen — Aa Bb Cc',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: size,
                fontWeight: w,
                letterSpacing: tracking,
                color: cInk,
                height: 1.0,
              ),
            ),
          ),
        ],
      ),
    ));
  }
  final Widget typeScaleSection = Container(
    color: cParchmentDeep,
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: typeScaleRows,
    ),
  );

  // ---------------------------------------------------------------------------
  // SECTION 13f: Mixed inline Text.rich — pricing card simulation.
  // ---------------------------------------------------------------------------
  Widget pricingRich;
  try {
    pricingRich = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: cParchment,
        border: Border.all(color: cMargin),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'PRO PLAN',
            style: TextStyle(
              color: cVermilion,
              fontSize: 12.0,
              letterSpacing: 4.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10.0),
          Text.rich(
            TextSpan(
              style: const TextStyle(color: cInk, height: 1.0),
              children: const <InlineSpan>[
                TextSpan(
                  text: '€',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: '49',
                  style: TextStyle(
                    fontSize: 56.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextSpan(
                  text: '.99',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' / mo',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: cInkSoft,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Text.rich(
            TextSpan(
              style: const TextStyle(fontSize: 13.0, color: cInkSoft, height: 1.5),
              children: <InlineSpan>[
                const TextSpan(text: 'Includes '),
                const TextSpan(
                  text: 'unlimited renders',
                  style: TextStyle(fontWeight: FontWeight.w700, color: cInk),
                ),
                const TextSpan(text: ', '),
                const TextSpan(
                  text: 'priority support',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                const TextSpan(text: ', and '),
                TextSpan(
                  text: 'early access',
                  style: TextStyle(
                    backgroundColor: cGold.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(text: ' to new typography features.'),
              ],
            ),
          ),
        ],
      ),
    );
  } catch (e) {
    pricingRich = Text('pricing rich unavailable: $e');
  }

  // ---------------------------------------------------------------------------
  // SECTION 14: Footer — colophon-style.
  // ---------------------------------------------------------------------------
  final Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 32.0),
    color: cInk,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'COLOPHON',
          style: TextStyle(
            color: cGold,
            fontSize: 11.0,
            letterSpacing: 5.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'This specimen was set in Flutter\'s default sans-serif and rendered '
          'entirely through the Text widget. Each section above is a single '
          'screenshot-friendly slice of the API surface — from the most '
          'common (size, weight, color) to the most obscure (FontFeature, '
          'FontVariation, strutStyle, textWidthBasis).',
          style: TextStyle(
            color: cParchment.withValues(alpha: 0.85),
            fontSize: 13.0,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14.0),
        Text(
          '— end of specimen —',
          style: TextStyle(
            color: cParchment.withValues(alpha: 0.55),
            fontSize: 11.0,
            letterSpacing: 3.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  print('Text deep visual demo build complete');

  return Scaffold(
    backgroundColor: cParchment,
    body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          hero,
          sectionHeader('I', 'Basic Text gallery',
              'Size, weight, italic, color, letter- and word-spacing, line height, shadows.'),
          basicSection,
          sectionHeader('II', 'TextAlign',
              'All six alignment values applied to the same multi-line passage.'),
          alignSection,
          sectionHeader('III', 'TextOverflow',
              'clip / fade / ellipsis / visible — each in a 220-px constrained frame.'),
          overflowSection,
          sectionHeader('IV', 'maxLines + ellipsis',
              'Same paragraph, capped at 1, 2, 3, then 4 lines.'),
          maxLineSection,
          sectionHeader('V', 'Text.rich',
              'A single paragraph composed from a TextSpan tree — inline styling per fragment.'),
          richBox,
          sectionHeader('VI', 'TextDecoration',
              'Underline, overline, lineThrough, plus the five decoration styles.'),
          decoSection,
          sectionHeader('VII', 'FontFeature & FontVariation',
              'OpenType toggles: oldstyle, tabular, smcp, liga; plus a variable wght axis.'),
          featureSection,
          sectionHeader('VIII', 'TextScaler',
              'TextScaler.linear at five scales versus TextScaler.noScaling.'),
          scalerSection,
          sectionHeader('IX', 'StrutStyle',
              'Pinning line metrics with forceStrutHeight.'),
          strutSection,
          sectionHeader('X', 'TextDirection',
              'LTR vs RTL flow plus mixed-script runs.'),
          directionSection,
          sectionHeader('XI', 'Text vs RichText vs SelectableText',
              'A property-by-property comparison of the three principal text widgets.'),
          compareSection,
          sectionHeader('XII', 'Edge cases',
              'Empty, unbreakable, soft-wrap off, semantic override, textWidthBasis.'),
          edgeSection,
          sectionHeader('XIII', 'TextStyle reference',
              'A scan-friendly index of the most useful TextStyle properties.'),
          propSection,
          sectionHeader('XIV', 'TextHeightBehavior',
              'applyHeightToFirstAscent / applyHeightToLastDescent / leadingDistribution.'),
          heightBehaviorSection,
          sectionHeader('XV', 'Selection color (mock)',
              'Visualizing how selectionColor tints a selected range across hues.'),
          selectionSection,
          sectionHeader('XVI', 'Color spectrum sweep',
              'A single string repeated across a curated palette of foreground colors.'),
          spectrumSection,
          sectionHeader('XVII', 'Material type scale',
              'Display, headline, title, body, and label sizes laid out side-by-side.'),
          typeScaleSection,
          sectionHeader('XVIII', 'Pricing card via Text.rich',
              'A realistic UI fragment composed entirely of inline TextSpan styling.'),
          pricingRich,
          footer,
        ],
      ),
    ),
  );
}
