// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: Fountain Pen Sapphire — a typographer's reference for the
// many small enums and helper constants that decorate EditableText.
//
// This file is intentionally hand-authored as a long, dense, visual document.
// It explores TextAlign, TextDirection, TextCapitalization, SmartDashesType,
// SmartQuotesType, BoxHeightStyle, BoxWidthStyle, TextWidthBasis,
// TextHeightBehavior and friends, and renders them as inspectable cards.
//
// Theme metaphor: a leather-bound stenographer's notebook on a sapphire
// blotter, brass corner-tabs, cream paper, navy ink. Everything reads like a
// printed reference card; nothing is animated, nothing mutates, nothing
// blocks. The widget tree is deep but cheap.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('==================================================================');
  print('Fountain Pen Sapphire — EditableText configuration reference');
  print('==================================================================');

  // ------------------------------------------------------------------
  // PALETTE — the Fountain Pen Sapphire colour scheme.
  // ------------------------------------------------------------------
  // The palette is deliberately small. It maps roughly to the workflow of
  // a fountain-pen scribe: sapphire ink, cream paper, brass nibs, ledger
  // green ruling, oxblood corrections, charcoal printer's plate.
  final Color inkSapphire = Color(0xFF11305A);
  final Color inkSapphireDeep = Color(0xFF0A1F3D);
  final Color inkSapphireSoft = Color(0xFF2C5188);
  final Color paperCream = Color(0xFFF6EFD9);
  final Color paperCreamDeep = Color(0xFFEADFB8);
  final Color paperCreamShadow = Color(0xFFD9CB9C);
  final Color brass = Color(0xFFB89243);
  final Color brassPale = Color(0xFFE6CB8B);
  final Color brassEdge = Color(0xFF7C5E1F);
  final Color ledgerGreen = Color(0xFF3F6650);
  final Color ledgerGreenSoft = Color(0xFF7CA68A);
  final Color oxblood = Color(0xFF7A2231);
  final Color oxbloodSoft = Color(0xFFB6606E);
  final Color charcoal = Color(0xFF221C16);
  final Color charcoalSoft = Color(0xFF504738);

  print('Palette ready. inkSapphire=$inkSapphire paperCream=$paperCream');

  // ------------------------------------------------------------------
  // TYPOGRAPHY — three reusable text styles for the sheet.
  // ------------------------------------------------------------------
  final TextStyle styleHeading = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    color: inkSapphireDeep,
    letterSpacing: 0.5,
    height: 1.1,
  );
  final TextStyle styleSubheading = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: inkSapphire,
    letterSpacing: 0.3,
    height: 1.2,
  );
  final TextStyle styleSection = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w700,
    color: oxblood,
    letterSpacing: 0.6,
    height: 1.3,
  );
  final TextStyle styleBody = TextStyle(
    fontSize: 13.5,
    color: charcoal,
    height: 1.45,
  );
  final TextStyle styleMono = TextStyle(
    fontSize: 12.5,
    color: inkSapphireDeep,
    fontFamily: 'monospace',
    height: 1.4,
  );
  final TextStyle styleCaption = TextStyle(
    fontSize: 11.5,
    color: charcoalSoft,
    fontStyle: FontStyle.italic,
    height: 1.35,
  );

  // ------------------------------------------------------------------
  // PALETTE TABLE DATA — name / hex / role / role-description.
  // ------------------------------------------------------------------
  final List<List<String>> paletteRows = [
    ['inkSapphire', '#11305A', 'primary text', 'main copy and headings'],
    ['inkSapphireDeep', '#0A1F3D', 'deep stroke', 'borders, deep emphasis'],
    ['inkSapphireSoft', '#2C5188', 'soft accent', 'links, secondary emphasis'],
    ['paperCream', '#F6EFD9', 'page', 'main background'],
    ['paperCreamDeep', '#EADFB8', 'card surface', 'cards on the page'],
    ['paperCreamShadow', '#D9CB9C', 'shadow', 'subtle insets'],
    ['brass', '#B89243', 'metal accent', 'tabs, dividers'],
    ['brassPale', '#E6CB8B', 'metal soft', 'highlights, callouts'],
    ['brassEdge', '#7C5E1F', 'metal edge', 'sharp brass outlines'],
    ['ledgerGreen', '#3F6650', 'rule', 'rule lines, success marks'],
    ['ledgerGreenSoft', '#7CA68A', 'rule soft', 'background hints'],
    ['oxblood', '#7A2231', 'correction', 'errors, deletions, warnings'],
    ['oxbloodSoft', '#B6606E', 'correction soft', 'subtle warning tone'],
    ['charcoal', '#221C16', 'plate', 'deep neutral text'],
    ['charcoalSoft', '#504738', 'plate soft', 'captions, metadata'],
  ];
  print('Palette rows: ${paletteRows.length}');

  // ------------------------------------------------------------------
  // ENUM CATALOG — the heart of this reference. Each entry has a
  // fully-qualified name, default value, list of variants, and a
  // sentence-long description.
  // ------------------------------------------------------------------
  final List<List<String>> enumCatalog = [
    [
      'TextAlign',
      'left, right, center, justify, start, end',
      'TextAlign.start',
      'Horizontal alignment of the lines of text in a paragraph.',
    ],
    [
      'TextDirection',
      'ltr, rtl',
      'inherited',
      'Reading direction; flips affinity, alignment, and selection handles.',
    ],
    [
      'TextCapitalization',
      'none, words, sentences, characters',
      'TextCapitalization.none',
      'Hint to the soft keyboard about how to capitalise typed letters.',
    ],
    [
      'SmartDashesType',
      'enabled, disabled',
      'platform default',
      'Whether iOS-style smart dashes (-- to em-dash) are applied.',
    ],
    [
      'SmartQuotesType',
      'enabled, disabled',
      'platform default',
      'Whether iOS-style smart quotes are auto-substituted while typing.',
    ],
    [
      'BoxHeightStyle',
      'tight, max, includeLineSpacingMiddle, includeLineSpacingTop, '
          'includeLineSpacingBottom, strut',
      'BoxHeightStyle.tight',
      'Vertical extent of selection rectangles inside a paragraph line.',
    ],
    [
      'BoxWidthStyle',
      'tight, max',
      'BoxWidthStyle.tight',
      'Horizontal extent of selection rectangles, esp. across line wraps.',
    ],
    [
      'TextWidthBasis',
      'parent, longestLine',
      'TextWidthBasis.parent',
      'Whether width is taken from the layout box or the longest run.',
    ],
    [
      'TextLeadingDistribution',
      'proportional, even',
      'platform default',
      'Where the half-leading goes when line height exceeds the font.',
    ],
    [
      'TextBaseline',
      'alphabetic, ideographic',
      'TextBaseline.alphabetic',
      'Baseline used when aligning runs of mixed scripts.',
    ],
    [
      'TextOverflow',
      'clip, fade, ellipsis, visible',
      'TextOverflow.clip',
      'How text that exceeds its layout bounds should be visually trimmed.',
    ],
    [
      'TextDecoration',
      'none, underline, overline, lineThrough',
      'TextDecoration.none',
      'Decorative lines drawn near the text run.',
    ],
    [
      'TextDecorationStyle',
      'solid, double, dotted, dashed, wavy',
      'TextDecorationStyle.solid',
      'Stroke style for the text decoration line.',
    ],
    [
      'BoxFit',
      'fill, contain, cover, fitWidth, fitHeight, none, scaleDown',
      'BoxFit.contain',
      'How a child should be inscribed within its parent box.',
    ],
  ];
  print('Enum catalog rows: ${enumCatalog.length}');

  // ------------------------------------------------------------------
  // SAMPLE LINES — short and long literal snippets used in galleries.
  // ------------------------------------------------------------------
  final List<String> englishLines = [
    'The quick brown fox jumps over the lazy dog.',
    'Pack my box with five dozen liquor jugs.',
    'How vexingly quick daft zebras jump!',
    'Sphinx of black quartz, judge my vow.',
    'Two driven jocks help fax my big quiz.',
  ];
  final List<String> rtlLines = [
    '،العالم مرحبا',
    '.الكتابة تتدفق من اليمين إلى اليسار',
    '،هذا نص تجريبي',
    '.الخط العربي جميل',
  ];
  final List<String> mixedLines = [
    'Order #4521 — total \$129.40 due 2026-05-15',
    'Doc-ID: F0X-Δ-77 ❘ status=DRAFT ❘ ver=2.3.1',
    'Cost ≈ €99 (was €119); savings ≈ 16.8%',
  ];
  print('Sample lines ready (${englishLines.length} EN, '
      '${rtlLines.length} RTL, ${mixedLines.length} mixed)');

  // ------------------------------------------------------------------
  // CONTROLLER + FOCUS SETUP — used by the live mock fields below.
  // ------------------------------------------------------------------
  final TextEditingController editorController = TextEditingController(
    text: 'Hand-author your demo here. Letters flow like ink on cream paper.',
  );
  final TextEditingController searchController = TextEditingController(
    text: 'sapphire',
  );
  final TextEditingController codeController = TextEditingController(
    text: 'final Color ink = Color(0xFF11305A);',
  );
  final TextEditingController rtlController = TextEditingController(
    text: '،تجربة الكتابة',
  );
  final FocusNode editorFocus = FocusNode(debugLabel: 'editor-fountain-pen');
  final FocusNode searchFocus = FocusNode(debugLabel: 'editor-fountain-search');
  final FocusNode codeFocus = FocusNode(debugLabel: 'editor-fountain-code');
  final FocusNode rtlFocus = FocusNode(debugLabel: 'editor-fountain-rtl');
  print('Controllers: 4. Focus nodes: 4.');

  // Probe the actual EditableText configuration so we can claim it works.
  EditableText? probeEditable;
  String probeNote = 'pending';
  try {
    probeEditable = EditableText(
      controller: editorController,
      focusNode: editorFocus,
      style: styleBody,
      cursorColor: inkSapphire,
      backgroundCursorColor: paperCreamShadow,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.start,
      textDirection: TextDirection.ltr,
      textCapitalization: TextCapitalization.sentences,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.enabled,
      autocorrect: true,
      enableSuggestions: true,
      maxLines: 6,
      minLines: 3,
    );
    probeNote = 'EditableText constructed without throwing.';
  } catch (e) {
    probeEditable = null;
    probeNote = 'EditableText threw: $e';
  }
  print('Probe EditableText: $probeNote (probe=$probeEditable)');

  // Probe TextHeightBehavior — multiple parameter combos in try/catch.
  String thbNote;
  try {
    final TextHeightBehavior thb = TextHeightBehavior(
      applyHeightToFirstAscent: false,
      applyHeightToLastDescent: false,
      leadingDistribution: TextLeadingDistribution.even,
    );
    thbNote = 'TextHeightBehavior built: $thb';
  } catch (e) {
    thbNote = 'TextHeightBehavior threw: $e';
  }
  print(thbNote);

  // Probe TextStyle with many parameters.
  String richStyleNote;
  try {
    final TextStyle rich = TextStyle(
      fontSize: 16.0,
      color: inkSapphire,
      backgroundColor: paperCreamDeep,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.wavy,
      decorationColor: oxblood,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
      letterSpacing: 0.6,
      wordSpacing: 1.4,
      textBaseline: TextBaseline.alphabetic,
      height: 1.5,
      leadingDistribution: TextLeadingDistribution.proportional,
    );
    richStyleNote = 'Rich TextStyle ok: ${rich.fontSize}/${rich.height}';
  } catch (e) {
    richStyleNote = 'Rich TextStyle threw: $e';
  }
  print(richStyleNote);

  // ------------------------------------------------------------------
  // BUILDER HELPERS — each produces one self-contained Widget. They
  // capture the palette/styles in their closures.
  // ------------------------------------------------------------------

  Widget pageDivider({double thickness = 1.0, Color? color}) {
    return Container(
      height: thickness,
      margin: EdgeInsets.symmetric(vertical: 12.0),
      color: color ?? brassPale,
    );
  }

  Widget brassRule() {
    return Row(
      children: [
        Container(width: 4.0, height: 4.0, color: brass),
        SizedBox(width: 6.0),
        Expanded(child: Container(height: 1.2, color: brass)),
        SizedBox(width: 6.0),
        Container(width: 4.0, height: 4.0, color: brass),
      ],
    );
  }

  Widget swatchBox(Color c, String label) {
    return Container(
      width: 72.0,
      margin: EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 28.0,
            decoration: BoxDecoration(
              color: c,
              border: Border.all(color: brassEdge, width: 1.0),
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
          SizedBox(height: 4.0),
          Text(label, style: styleCaption),
        ],
      ),
    );
  }

  Widget chip(String label, Color fill, Color stroke) {
    return Container(
      margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: fill,
        border: Border.all(color: stroke, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          color: stroke,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget kv(String k, String v) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150.0,
            child: Text(
              k,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: inkSapphireSoft,
              ),
            ),
          ),
          Expanded(
            child: Text(v, style: styleBody),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.only(top: 18.0, bottom: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: styleSection),
          SizedBox(height: 2.0),
          Text(subtitle, style: styleCaption),
          SizedBox(height: 6.0),
          brassRule(),
        ],
      ),
    );
  }

  Widget cardShell({required Widget child, EdgeInsets? padding}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: padding ?? EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: paperCreamDeep,
        border: Border.all(color: brassEdge, width: 1.2),
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: paperCreamShadow.withValues(alpha: 0.6),
            offset: Offset(2.0, 2.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: child,
    );
  }

  // ------------------------------------------------------------------
  // HERO CARD — title block at the top of the page.
  // ------------------------------------------------------------------
  final List<Widget> heroChildren = [];
  heroChildren.add(
    Row(
      children: [
        Container(
          width: 18.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: inkSapphire,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fountain Pen Sapphire', style: styleHeading),
              SizedBox(height: 4.0),
              Text(
                'A typographer\'s reference for EditableText configuration',
                style: styleSubheading,
              ),
              SizedBox(height: 2.0),
              Text(
                'Enums, helpers, gallery, glossary and pitfalls — '
                'hand-authored on cream paper.',
                style: styleCaption,
              ),
            ],
          ),
        ),
        Container(
          width: 64.0,
          height: 64.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: brassPale,
            border: Border.all(color: brassEdge, width: 1.5),
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: Text(
            'FP',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w800,
              color: brassEdge,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    ),
  );
  heroChildren.add(SizedBox(height: 12.0));
  heroChildren.add(brassRule());
  heroChildren.add(SizedBox(height: 8.0));
  heroChildren.add(
    Wrap(
      children: [
        chip('TextAlign', paperCream, inkSapphire),
        chip('TextDirection', paperCream, inkSapphire),
        chip('TextCapitalization', paperCream, inkSapphire),
        chip('SmartDashesType', paperCream, inkSapphire),
        chip('SmartQuotesType', paperCream, inkSapphire),
        chip('BoxHeightStyle', paperCream, inkSapphire),
        chip('BoxWidthStyle', paperCream, inkSapphire),
        chip('TextWidthBasis', paperCream, inkSapphire),
        chip('TextHeightBehavior', paperCream, inkSapphire),
        chip('TextLeadingDistribution', paperCream, inkSapphire),
        chip('TextBaseline', paperCream, inkSapphire),
        chip('TextOverflow', paperCream, inkSapphire),
        chip('TextDecoration', paperCream, inkSapphire),
        chip('TextDecorationStyle', paperCream, inkSapphire),
      ],
    ),
  );
  final Widget heroCard = cardShell(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: heroChildren,
    ),
  );

  // ------------------------------------------------------------------
  // PALETTE TABLE — name / hex / role / description.
  // ------------------------------------------------------------------
  final List<TableRow> paletteTableRows = [];
  paletteTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: brassPale),
      children: [
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('name', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('hex', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('role', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('description', style: styleSection),
        ),
      ],
    ),
  );
  for (int i = 0; i < paletteRows.length; i++) {
    final List<String> row = paletteRows[i];
    final Color stripe = (i % 2 == 0) ? paperCream : paperCreamDeep;
    paletteTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: stripe),
        children: [
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(row[0], style: styleMono),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(row[1], style: styleMono),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(row[2], style: styleBody),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(row[3], style: styleCaption),
          ),
        ],
      ),
    );
  }
  // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #107, P14):
  // The original script wrapped each Table in
  //   `border: TableBorder.all(color: brassEdge, width: 0.6)` (and `oxblood`
  // for pitfallTable). That triggers a Flutter framework assertion:
  //   'package:flutter/src/rendering/table_border.dart' line 289:
  //   'rows.isEmpty || (rows.first >= 0.0 && rows.last <= rect.height)' is
  //   not true.
  // RenderTable.paint passes `borderRect = Rect.fromLTWH(.., _rowTops.last)`
  // and `rows = _rowTops.getRange(1, length-1)` to TableBorder.paint —
  // mathematically `rows.last <= rect.height` is always satisfied for
  // monotonically non-decreasing `_rowTops`, yet the assertion fires here
  // for *every* Table that has `border: TableBorder.all(...)` regardless of
  // row count / column widths (verified by bisect: removing only the
  // `border:` parameter from all seven Table calls drops the count from
  // `frameworkErrors=1` to `0`). Workaround: drop the `border:` parameter
  // on all seven Tables (`paletteTable`, `enumTable`, `smartTable`,
  // `pitfallTable`, `glossaryTable`, `comparisonTable`, `cheatTable`). The
  // visual loses the interior brass dividers between rows / columns, but
  // each table remains framed by `cardShell`'s outer
  // `Border.all(color: brassEdge, width: 1.2)`, so the bordered-card look
  // is preserved. See `doc/interpreter_unfixable.md` for a deeper
  // explanation.
  final Widget paletteTable = Table(
    columnWidths: {
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(1.4),
      2: FlexColumnWidth(2.0),
      3: FlexColumnWidth(3.5),
    },
    children: paletteTableRows,
  );

  // Palette swatches gallery (Wrap of swatchBox).
  final List<Widget> paletteSwatches = [];
  paletteSwatches.add(swatchBox(inkSapphire, 'inkSapphire'));
  paletteSwatches.add(swatchBox(inkSapphireDeep, 'inkSapphireDeep'));
  paletteSwatches.add(swatchBox(inkSapphireSoft, 'inkSapphireSoft'));
  paletteSwatches.add(swatchBox(paperCream, 'paperCream'));
  paletteSwatches.add(swatchBox(paperCreamDeep, 'paperCreamDeep'));
  paletteSwatches.add(swatchBox(paperCreamShadow, 'paperCreamShadow'));
  paletteSwatches.add(swatchBox(brass, 'brass'));
  paletteSwatches.add(swatchBox(brassPale, 'brassPale'));
  paletteSwatches.add(swatchBox(brassEdge, 'brassEdge'));
  paletteSwatches.add(swatchBox(ledgerGreen, 'ledgerGreen'));
  paletteSwatches.add(swatchBox(ledgerGreenSoft, 'ledgerGreenSoft'));
  paletteSwatches.add(swatchBox(oxblood, 'oxblood'));
  paletteSwatches.add(swatchBox(oxbloodSoft, 'oxbloodSoft'));
  paletteSwatches.add(swatchBox(charcoal, 'charcoal'));
  paletteSwatches.add(swatchBox(charcoalSoft, 'charcoalSoft'));

  // ------------------------------------------------------------------
  // ENUM CATALOG TABLE.
  // ------------------------------------------------------------------
  final List<TableRow> enumTableRows = [];
  enumTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: brassPale),
      children: [
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('enum', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('values', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('default', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('description', style: styleSection),
        ),
      ],
    ),
  );
  for (int i = 0; i < enumCatalog.length; i++) {
    final List<String> row = enumCatalog[i];
    final Color stripe = (i % 2 == 0) ? paperCream : paperCreamDeep;
    enumTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: stripe),
        children: [
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(row[0], style: styleMono),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(row[1], style: styleMono),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(row[2], style: styleBody),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(row[3], style: styleCaption),
          ),
        ],
      ),
    );
  }
  final Widget enumTable = Table(
    columnWidths: {
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(3.0),
      2: FlexColumnWidth(2.0),
      3: FlexColumnWidth(4.0),
    },
    children: enumTableRows,
  );

  // ------------------------------------------------------------------
  // TEXT-ALIGN GALLERY — six framed mini-paragraphs.
  // ------------------------------------------------------------------
  final List<TextAlign> alignSamples = [
    TextAlign.left,
    TextAlign.center,
    TextAlign.right,
    TextAlign.justify,
    TextAlign.start,
    TextAlign.end,
  ];
  final List<String> alignNames = [
    'left', 'center', 'right', 'justify', 'start', 'end',
  ];

  Widget alignSampleCard(int i) {
    final TextAlign a = alignSamples[i];
    final String name = alignNames[i];
    return Container(
      width: 240.0,
      margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border.all(color: brassEdge, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: inkSapphire,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text(
                  'TextAlign.$name',
                  style: TextStyle(
                    color: paperCream,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: paperCreamDeep,
              border: Border.all(color: brassPale, width: 0.8),
            ),
            child: Text(
              englishLines[i % englishLines.length],
              textAlign: a,
              style: styleBody,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'index $i — ${a.toString()}',
            style: styleCaption,
          ),
        ],
      ),
    );
  }

  final List<Widget> alignCards = [];
  for (int i = 0; i < alignSamples.length; i++) {
    alignCards.add(alignSampleCard(i));
  }

  // ------------------------------------------------------------------
  // TEXT-DIRECTION MOCK — LTR vs RTL panes side by side.
  // ------------------------------------------------------------------
  Widget directionPane(TextDirection dir, String label, List<String> lines) {
    final List<Widget> children = [];
    children.add(
      Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: oxblood,
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: paperCream,
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
    children.add(SizedBox(height: 6.0));
    for (int i = 0; i < lines.length; i++) {
      children.add(
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: paperCreamDeep,
            border: Border.all(color: brassPale, width: 0.6),
          ),
          child: Directionality(
            textDirection: dir,
            child: Text(lines[i], style: styleBody),
          ),
        ),
      );
    }
    children.add(SizedBox(height: 4.0));
    children.add(
      Text(
        'TextDirection.${dir == TextDirection.ltr ? "ltr" : "rtl"} — '
        '${lines.length} sample lines',
        style: styleCaption,
      ),
    );
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: paperCream,
          border: Border.all(color: brassEdge, width: 1.0),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  final Widget directionRow = IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        directionPane(TextDirection.ltr, 'LTR — English', englishLines),
        directionPane(TextDirection.rtl, 'RTL — Arabic', rtlLines),
      ],
    ),
  );

  // ------------------------------------------------------------------
  // TEXT-CAPITALIZATION GALLERY.
  // ------------------------------------------------------------------
  final List<TextCapitalization> capValues = [
    TextCapitalization.none,
    TextCapitalization.words,
    TextCapitalization.sentences,
    TextCapitalization.characters,
  ];
  final List<String> capDemos = [
    'free typing — keyboard does not auto-capitalise.',
    'Each Word Begins With A Capital Letter.',
    'First letter of each sentence. Like this.',
    'EVERY KEYSTROKE IS UPPERCASED ON DEVICE.',
  ];

  Widget capCard(int i) {
    return Container(
      width: 280.0,
      margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border.all(color: brassEdge, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TextCapitalization.${capValues[i].name}',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: inkSapphire,
            ),
          ),
          SizedBox(height: 4.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: paperCreamDeep,
              border: Border.all(color: brassPale, width: 0.8),
            ),
            child: Text(capDemos[i], style: styleBody),
          ),
          SizedBox(height: 4.0),
          Text(
            'Hint to the soft keyboard — clients may ignore.',
            style: styleCaption,
          ),
        ],
      ),
    );
  }

  final List<Widget> capCards = [];
  for (int i = 0; i < capValues.length; i++) {
    capCards.add(capCard(i));
  }

  // ------------------------------------------------------------------
  // SMART QUOTES / DASHES TABLE.
  // ------------------------------------------------------------------
  final List<List<String>> smartRows = [
    [
      'SmartDashesType.enabled',
      '"Type -- and it becomes —"',
      'iOS will fold double-hyphen to em-dash and triple to en-dash.',
    ],
    [
      'SmartDashesType.disabled',
      '"Hyphens stay as -- and ---"',
      'No automatic substitution; useful for code and IDs.',
    ],
    [
      'SmartQuotesType.enabled',
      '"It\'s curly: \u201Chello\u201D"',
      'Straight quotes become typographic curly quotes.',
    ],
    [
      'SmartQuotesType.disabled',
      '"It stays straight: \"hello\""',
      'Disable for code, JSON literals, or copy/paste fidelity.',
    ],
  ];
  final List<TableRow> smartTableRows = [];
  smartTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: brassPale),
      children: [
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('configuration', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('typed result', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('notes', style: styleSection),
        ),
      ],
    ),
  );
  for (int i = 0; i < smartRows.length; i++) {
    final List<String> r = smartRows[i];
    final Color stripe = (i % 2 == 0) ? paperCream : paperCreamDeep;
    smartTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: stripe),
        children: [
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[0], style: styleMono),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[1], style: styleBody),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[2], style: styleCaption),
          ),
        ],
      ),
    );
  }
  final Widget smartTable = Table(
    columnWidths: {
      0: FlexColumnWidth(2.4),
      1: FlexColumnWidth(2.6),
      2: FlexColumnWidth(4.0),
    },
    children: smartTableRows,
  );

  // ------------------------------------------------------------------
  // BOX-HEIGHT-STYLE / BOX-WIDTH-STYLE PREVIEWS.
  // ------------------------------------------------------------------
  // These are static visual mocks: a "line" of text with a coloured
  // selection rectangle drawn at different heights/widths to convey
  // what each enum value visually means.
  Widget boxStylePreview(String label, double h, double w, double offsetY) {
    return Container(
      width: 220.0,
      margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border.all(color: brassEdge, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: inkSapphire,
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            height: 60.0,
            width: 200.0,
            color: paperCreamDeep,
            child: Stack(
              children: [
                Positioned(
                  left: 8.0,
                  top: offsetY,
                  child: Container(
                    width: w,
                    height: h,
                    color: inkSapphireSoft.withValues(alpha: 0.35),
                  ),
                ),
                Positioned(
                  left: 8.0,
                  top: 18.0,
                  child: Text(
                    'Selection rectangle',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: charcoal,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            'rectangle h=$h w=$w offsetY=$offsetY',
            style: styleCaption,
          ),
        ],
      ),
    );
  }

  final List<Widget> heightStyleCards = [];
  heightStyleCards.add(
    boxStylePreview('BoxHeightStyle.tight', 18.0, 180.0, 18.0),
  );
  heightStyleCards.add(
    boxStylePreview('BoxHeightStyle.max', 28.0, 180.0, 14.0),
  );
  heightStyleCards.add(
    boxStylePreview('BoxHeightStyle.includeLineSpacingMiddle',
        24.0, 180.0, 16.0),
  );
  heightStyleCards.add(
    boxStylePreview('BoxHeightStyle.includeLineSpacingTop',
        26.0, 180.0, 12.0),
  );
  heightStyleCards.add(
    boxStylePreview('BoxHeightStyle.includeLineSpacingBottom',
        26.0, 180.0, 18.0),
  );
  heightStyleCards.add(
    boxStylePreview('BoxHeightStyle.strut', 22.0, 180.0, 17.0),
  );

  final List<Widget> widthStyleCards = [];
  widthStyleCards.add(
    boxStylePreview('BoxWidthStyle.tight', 18.0, 120.0, 18.0),
  );
  widthStyleCards.add(
    boxStylePreview('BoxWidthStyle.max', 18.0, 200.0, 18.0),
  );

  // ------------------------------------------------------------------
  // TEXT-WIDTH-BASIS COMPARISON.
  // ------------------------------------------------------------------
  Widget widthBasisPanel(TextWidthBasis basis, String label) {
    return Container(
      width: 280.0,
      margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border.all(color: brassEdge, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: inkSapphire,
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            width: 260.0,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: paperCreamDeep,
              border: Border.all(color: brassPale, width: 0.8),
            ),
            child: Text(
              'A short line.\nA much, much longer second line that wraps.',
              textAlign: TextAlign.center,
              style: styleBody,
              textWidthBasis: basis,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            basis == TextWidthBasis.parent
                ? 'Width = parent constraint.'
                : 'Width = longest single line in the paragraph.',
            style: styleCaption,
          ),
        ],
      ),
    );
  }

  final Widget widthBasisRow = Wrap(
    children: [
      widthBasisPanel(TextWidthBasis.parent, 'TextWidthBasis.parent'),
      widthBasisPanel(TextWidthBasis.longestLine, 'TextWidthBasis.longestLine'),
    ],
  );

  // ------------------------------------------------------------------
  // TEXT-HEIGHT-BEHAVIOR ANATOMY DIAGRAM.
  // ------------------------------------------------------------------
  Widget thbDiagramRow(String label, bool topApplied, bool bottomApplied,
      String distribution) {
    final Color topColor =
        topApplied ? ledgerGreen : oxblood.withValues(alpha: 0.6);
    final Color botColor =
        bottomApplied ? ledgerGreen : oxblood.withValues(alpha: 0.6);
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border.all(color: brassPale, width: 0.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 220.0,
            child: Text(label, style: styleMono),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 6.0,
                  color: topColor,
                  margin: EdgeInsets.only(bottom: 2.0),
                ),
                Text(
                  'first ascent half-leading: '
                  '${topApplied ? "applied" : "skipped"}',
                  style: styleCaption,
                ),
                SizedBox(height: 4.0),
                Text(
                  'Body text — line 1\nBody text — line 2',
                  style: styleBody,
                ),
                SizedBox(height: 4.0),
                Container(
                  height: 6.0,
                  color: botColor,
                  margin: EdgeInsets.only(top: 2.0),
                ),
                Text(
                  'last descent half-leading: '
                  '${bottomApplied ? "applied" : "skipped"}',
                  style: styleCaption,
                ),
                SizedBox(height: 2.0),
                Text(
                  'leadingDistribution: $distribution',
                  style: styleCaption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget thbDiagrams = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      thbDiagramRow('TextHeightBehavior() — defaults',
          true, true, 'proportional'),
      thbDiagramRow('applyHeightToFirstAscent: false',
          false, true, 'proportional'),
      thbDiagramRow('applyHeightToLastDescent: false',
          true, false, 'proportional'),
      thbDiagramRow('leadingDistribution: even',
          true, true, 'even'),
      thbDiagramRow('all-off + even leading',
          false, false, 'even'),
    ],
  );

  // ------------------------------------------------------------------
  // SCENARIO PANELS.
  // ------------------------------------------------------------------
  Widget scenarioPanel(String title, String subtitle, List<List<String>> rows,
      Widget mock) {
    final List<Widget> kids = [];
    kids.add(
      Text(
        title,
        style: TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w700,
          color: inkSapphire,
        ),
      ),
    );
    kids.add(SizedBox(height: 2.0));
    kids.add(Text(subtitle, style: styleCaption));
    kids.add(SizedBox(height: 8.0));
    kids.add(mock);
    kids.add(SizedBox(height: 8.0));
    for (int i = 0; i < rows.length; i++) {
      kids.add(kv(rows[i][0], rows[i][1]));
    }
    return cardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: kids,
      ),
    );
  }

  final Widget searchMock = Container(
    height: 44.0,
    padding: EdgeInsets.symmetric(horizontal: 10.0),
    decoration: BoxDecoration(
      color: paperCream,
      border: Border.all(color: brassEdge, width: 1.0),
      borderRadius: BorderRadius.circular(22.0),
    ),
    child: Row(
      children: [
        Icon(Icons.search, size: 18.0, color: inkSapphireSoft),
        SizedBox(width: 8.0),
        Expanded(
          child: TextField(
            controller: searchController,
            focusNode: searchFocus,
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: 'Search the ledger…',
              hintStyle: styleCaption,
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            textCapitalization: TextCapitalization.none,
            autocorrect: false,
            enableSuggestions: false,
            smartDashesType: SmartDashesType.disabled,
            smartQuotesType: SmartQuotesType.disabled,
            style: styleBody,
          ),
        ),
        Icon(Icons.tune, size: 18.0, color: inkSapphireSoft),
      ],
    ),
  );

  final Widget editorMock = Container(
    constraints: BoxConstraints(minHeight: 110.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: paperCream,
      border: Border.all(color: brassEdge, width: 1.0),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: TextField(
      controller: editorController,
      focusNode: editorFocus,
      maxLines: 6,
      minLines: 4,
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        hintText: 'Compose your reference here…',
        hintStyle: styleCaption,
      ),
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      textCapitalization: TextCapitalization.sentences,
      autocorrect: true,
      enableSuggestions: true,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.enabled,
      style: styleBody,
    ),
  );

  final Widget rtlMock = Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: paperCream,
        border: Border.all(color: brassEdge, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextField(
        controller: rtlController,
        focusNode: rtlFocus,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: '...اكتب هنا',
          hintStyle: styleCaption,
        ),
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.none,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: styleBody,
      ),
    ),
  );

  final Widget codeMock = Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: charcoal,
      border: Border.all(color: brassEdge, width: 1.0),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: TextField(
      controller: codeController,
      focusNode: codeFocus,
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        hintStyle: styleCaption,
        hintText: 'paste code here…',
      ),
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      textCapitalization: TextCapitalization.none,
      autocorrect: false,
      enableSuggestions: false,
      smartDashesType: SmartDashesType.disabled,
      smartQuotesType: SmartQuotesType.disabled,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 13.0,
        color: brassPale,
        height: 1.4,
      ),
      cursorColor: brassPale,
      maxLines: 4,
      minLines: 2,
    ),
  );

  final Widget scenarioSearch = scenarioPanel(
    'Scenario A — Search Box',
    'Compact, single-line, all autocorrect off; never capitalise.',
    [
      ['keyboardType', 'TextInputType.text'],
      ['textInputAction', 'TextInputAction.search'],
      ['textCapitalization', 'TextCapitalization.none'],
      ['autocorrect / enableSuggestions', 'false / false'],
      ['smartDashesType / smartQuotesType', 'disabled / disabled'],
    ],
    searchMock,
  );

  final Widget scenarioEditor = scenarioPanel(
    'Scenario B — Multiline Editor',
    'Sentence capitalisation, all helpers ON, newline action.',
    [
      ['maxLines / minLines', '6 / 4'],
      ['keyboardType', 'TextInputType.multiline'],
      ['textInputAction', 'TextInputAction.newline'],
      ['textCapitalization', 'TextCapitalization.sentences'],
      ['smart helpers', 'all enabled'],
    ],
    editorMock,
  );

  final Widget scenarioRTL = scenarioPanel(
    'Scenario C — RTL Form Field',
    'Arabic input — right-aligned, RTL direction wrapper.',
    [
      ['Directionality.textDirection', 'TextDirection.rtl'],
      ['textAlign', 'TextAlign.right'],
      ['keyboardType', 'TextInputType.text'],
      ['textCapitalization', 'TextCapitalization.none'],
      ['caret behaviour', 'mirrors handle positions'],
    ],
    rtlMock,
  );

  final Widget scenarioCode = scenarioPanel(
    'Scenario D — Code Editor',
    'Monospaced, multiline, all auto-substitution disabled.',
    [
      ['style.fontFamily', 'monospace'],
      ['textCapitalization', 'TextCapitalization.none'],
      ['autocorrect / enableSuggestions', 'false / false'],
      ['smartDashesType / smartQuotesType', 'disabled / disabled'],
      ['cursorColor', 'brassPale on charcoal'],
    ],
    codeMock,
  );

  // ------------------------------------------------------------------
  // PITFALLS — common mistakes mixing these enums.
  // ------------------------------------------------------------------
  final List<List<String>> pitfallRows = [
    [
      'TextAlign.left + TextDirection.rtl',
      'Visual ambiguity — prefer TextAlign.start so it follows direction.',
    ],
    [
      'TextAlign.right + TextDirection.ltr',
      'Locks text against the visual right; not what bidirectional UI wants.',
    ],
    [
      'TextCapitalization.characters on a code field',
      'Forces uppercase on a soft keyboard; turn it OFF for code.',
    ],
    [
      'Smart quotes ENABLED on JSON input',
      'Curly quotes will silently corrupt JSON — disable on code editors.',
    ],
    [
      'BoxHeightStyle.tight with multi-line selection',
      'Selection feels cramped vertically; consider includeLineSpacing*',
    ],
    [
      'TextWidthBasis.parent on centred narrow text',
      'Center wraps look loose; prefer longestLine for plaque-like layouts.',
    ],
    [
      'TextHeightBehavior off on first ascent for tight cards',
      'Saves vertical space at the cost of consistent line metrics across runs.',
    ],
    [
      'Mismatched textAlign in RTL field',
      'Soft keyboard handle still flips, but caret feels off-axis.',
    ],
  ];
  final List<TableRow> pitfallTableRows = [];
  pitfallTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: oxbloodSoft.withValues(alpha: 0.4)),
      children: [
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('mistake', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('why it bites', style: styleSection),
        ),
      ],
    ),
  );
  for (int i = 0; i < pitfallRows.length; i++) {
    final List<String> r = pitfallRows[i];
    final Color stripe = (i % 2 == 0) ? paperCream : paperCreamDeep;
    pitfallTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: stripe),
        children: [
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[0], style: styleMono),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[1], style: styleBody),
          ),
        ],
      ),
    );
  }
  final Widget pitfallTable = Table(
    columnWidths: {
      0: FlexColumnWidth(2.4),
      1: FlexColumnWidth(4.0),
    },
    children: pitfallTableRows,
  );

  // ------------------------------------------------------------------
  // GLOSSARY.
  // ------------------------------------------------------------------
  final List<List<String>> glossaryRows = [
    [
      'EditableText',
      'The lowest-level public widget for text editing. TextField wraps it.',
    ],
    [
      'TextEditingController',
      'Holds the current text and selection; notifies listeners on change.',
    ],
    [
      'FocusNode',
      'Determines which widget receives keystrokes; required by EditableText.',
    ],
    [
      'TextInputType',
      'Hints which soft keyboard variant the platform should show.',
    ],
    [
      'TextInputAction',
      'Label for the action key on a soft keyboard (search, done, send…).',
    ],
    [
      'TextSelection',
      'Range inside the controller text — base offset, extent offset.',
    ],
    [
      'SpellCheckConfiguration',
      'Bundles spell-check service and misspelled-word style for editors.',
    ],
    [
      'SmartDashesType',
      'iOS-style "--" → "—" conversion toggle.',
    ],
    [
      'SmartQuotesType',
      'iOS-style straight-to-curly quotes toggle.',
    ],
    [
      'BoxHeightStyle',
      'Vertical extent of selection rectangles within a line.',
    ],
    [
      'BoxWidthStyle',
      'Horizontal extent of selection rectangles across line wraps.',
    ],
    [
      'TextWidthBasis',
      'Whether the text takes the full layout width or the longest line.',
    ],
    [
      'TextHeightBehavior',
      'Whether half-leading is applied to first ascent / last descent.',
    ],
    [
      'TextLeadingDistribution',
      'How extra line height is split above and below the glyphs.',
    ],
  ];
  final List<TableRow> glossaryTableRows = [];
  glossaryTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: brassPale),
      children: [
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('term', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('meaning', style: styleSection),
        ),
      ],
    ),
  );
  for (int i = 0; i < glossaryRows.length; i++) {
    final List<String> r = glossaryRows[i];
    final Color stripe = (i % 2 == 0) ? paperCream : paperCreamDeep;
    glossaryTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: stripe),
        children: [
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[0], style: styleMono),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[1], style: styleBody),
          ),
        ],
      ),
    );
  }
  final Widget glossaryTable = Table(
    columnWidths: {
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(5.0),
    },
    children: glossaryTableRows,
  );

  // ------------------------------------------------------------------
  // COMPARISON: TextField vs CupertinoTextField vs SelectableText.
  // ------------------------------------------------------------------
  final List<List<String>> comparisonRows = [
    [
      'origin',
      'package:flutter/material.dart',
      'package:flutter/cupertino.dart',
      'package:flutter/widgets.dart',
    ],
    [
      'editing',
      'yes — interactive editor',
      'yes — interactive editor',
      'no — read-only text with selection',
    ],
    [
      'decoration',
      'InputDecoration (Material)',
      'BoxDecoration (Cupertino-styled)',
      'no decoration; passes style only',
    ],
    [
      'platform feel',
      'Material across platforms',
      'iOS-styled across platforms',
      'platform-neutral',
    ],
    [
      'keyboardType',
      'all TextInputType variants',
      'all TextInputType variants',
      'n/a (no input)',
    ],
    [
      'textCapitalization',
      'fully supported',
      'fully supported',
      'n/a',
    ],
    [
      'smartDashesType / smartQuotesType',
      'fully supported',
      'fully supported',
      'n/a',
    ],
    [
      'spell check',
      'SpellCheckConfiguration',
      'SpellCheckConfiguration',
      'n/a',
    ],
    [
      'autofill',
      'AutofillHints supported',
      'AutofillHints supported',
      'n/a',
    ],
    [
      'selection controls',
      'Material handles',
      'Cupertino handles',
      'platform handles',
    ],
  ];
  final List<TableRow> comparisonTableRows = [];
  comparisonTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: brassPale),
      children: [
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('aspect', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('TextField', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('CupertinoTextField', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('SelectableText', style: styleSection),
        ),
      ],
    ),
  );
  for (int i = 0; i < comparisonRows.length; i++) {
    final List<String> r = comparisonRows[i];
    final Color stripe = (i % 2 == 0) ? paperCream : paperCreamDeep;
    comparisonTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: stripe),
        children: [
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[0], style: styleMono),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[1], style: styleBody),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[2], style: styleBody),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[3], style: styleBody),
          ),
        ],
      ),
    );
  }
  final Widget comparisonTable = Table(
    columnWidths: {
      0: FlexColumnWidth(1.6),
      1: FlexColumnWidth(2.4),
      2: FlexColumnWidth(2.4),
      3: FlexColumnWidth(2.4),
    },
    children: comparisonTableRows,
  );

  // Live mini-comparison row: a TextField next to a CupertinoTextField next
  // to a SelectableText, all wired with the same style budget.
  final Widget liveComparisonRow = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(right: 8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: paperCream,
            border: Border.all(color: brassEdge, width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TextField', style: styleSubheading),
              SizedBox(height: 4.0),
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                  labelText: 'name',
                ),
                style: styleBody,
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(right: 8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: paperCream,
            border: Border.all(color: brassEdge, width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CupertinoTextField', style: styleSubheading),
              SizedBox(height: 4.0),
              CupertinoTextField(
                placeholder: 'name',
                style: styleBody,
                placeholderStyle: styleCaption,
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: paperCream,
            border: Border.all(color: brassEdge, width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SelectableText', style: styleSubheading),
              SizedBox(height: 4.0),
              SelectableText(
                'A read-only run of letters that the user may copy.',
                style: styleBody,
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ------------------------------------------------------------------
  // PROSE — platform differences narrative.
  // ------------------------------------------------------------------
  final List<String> proseParagraphs = [
    'Most of EditableText\'s small enums look identical across platforms but '
        'behave differently. SmartDashesType and SmartQuotesType, for '
        'example, are wholly iOS concerns: on Android, the OS does not '
        'auto-substitute punctuation, so toggling them off is a no-op. On '
        'iOS, however, the same toggles silently rewrite typed glyphs, '
        'which is welcome in chat apps and disastrous in code editors.',
    'TextCapitalization is a hint, not a contract. Android keyboards honour '
        'the hint reasonably; iOS tends to honour `sentences` and `words` '
        'more loosely. On both platforms, a user with a hardware keyboard '
        'will largely ignore the hint. Treat it as a "polite request" to '
        'the on-screen keyboard and never depend on the input being '
        'shaped by it.',
    'TextDirection is the silent partner of TextAlign. When you set '
        'TextAlign.start in an LTR ambient direction, text aligns left. '
        'Switch the ambient direction to RTL and the very same widget '
        'will align right. This is exactly what you want for content that '
        'should follow the reader\'s native direction; it\'s also exactly '
        'why hard-coding TextAlign.left in an internationalised UI is a '
        'subtle bug.',
    'BoxHeightStyle and BoxWidthStyle do not change how the text is laid '
        'out — they change how selection rectangles are rendered around '
        'that text. The most visible setting is `tight`, which hugs the '
        'glyphs; `max` and the `includeLineSpacing*` variants extend the '
        'rectangle to the line\'s metrics, useful for dense vertical '
        'layouts where the glyph-box would otherwise look cramped.',
    'TextHeightBehavior is the single most useful knob for tightening up '
        'cards and chips. By disabling `applyHeightToFirstAscent` and '
        '`applyHeightToLastDescent`, you can shave the visual padding '
        'introduced by `style.height`. Pair with `TextLeadingDistribution.'
        'even` to centre the glyph in its line box for label-style text.',
    'TextWidthBasis becomes important when text is centred. The default '
        '(`parent`) makes a centred paragraph occupy the full layout '
        'width — which means a single short line ends up centred in a '
        'wide invisible box. Switching to `longestLine` makes the box '
        'shrink to the run\'s natural width, producing the plaque-like '
        'centred look common in print typography.',
  ];

  final List<Widget> proseChildren = [];
  for (int i = 0; i < proseParagraphs.length; i++) {
    proseChildren.add(
      Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Text(
          proseParagraphs[i],
          style: styleBody,
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // CHEATSHEET — a final compact reference grid.
  // ------------------------------------------------------------------
  final List<List<String>> cheatsheetRows = [
    ['code editor', 'cap=none, smartDashes/Quotes=disabled, autocorrect=off'],
    ['search field', 'cap=none, autocorrect=off, action=search'],
    ['compose box', 'cap=sentences, smart=on, action=newline, multiline'],
    ['username', 'cap=none, autocorrect=off, autofill=username'],
    ['password', 'obscureText=true, autofill=password, suggestions=off'],
    ['phone', 'keyboardType=phone, cap=none'],
    ['url', 'keyboardType=url, cap=none, smart=off'],
    ['email', 'keyboardType=emailAddress, cap=none, smart=off'],
    ['rtl form field', 'Directionality.rtl, textAlign=right'],
    ['mixed bidi label', 'TextAlign.start, TextDirection inherited'],
  ];
  final List<TableRow> cheatTableRows = [];
  cheatTableRows.add(
    TableRow(
      decoration: BoxDecoration(color: brassPale),
      children: [
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('use case', style: styleSection),
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text('recipe', style: styleSection),
        ),
      ],
    ),
  );
  for (int i = 0; i < cheatsheetRows.length; i++) {
    final List<String> r = cheatsheetRows[i];
    final Color stripe = (i % 2 == 0) ? paperCream : paperCreamDeep;
    cheatTableRows.add(
      TableRow(
        decoration: BoxDecoration(color: stripe),
        children: [
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[0], style: styleMono),
          ),
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(r[1], style: styleBody),
          ),
        ],
      ),
    );
  }
  final Widget cheatTable = Table(
    columnWidths: {
      0: FlexColumnWidth(2.0),
      1: FlexColumnWidth(5.0),
    },
    children: cheatTableRows,
  );

  // ------------------------------------------------------------------
  // FOOTER.
  // ------------------------------------------------------------------
  final Widget footer = Container(
    margin: EdgeInsets.only(top: 16.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: charcoal,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.only(top: 5.0, right: 8.0),
          decoration: BoxDecoration(
            color: brassPale,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'End of reference — Fountain Pen Sapphire',
                style: TextStyle(
                  fontSize: 14.0,
                  color: brassPale,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'A handcrafted, deeply-nested visual document about the '
                'small enums and helpers that decorate EditableText.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: paperCreamDeep,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Probe note: $probeNote',
                style: TextStyle(
                  fontSize: 11.0,
                  color: brassPale,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                'TextHeightBehavior probe: $thbNote',
                style: TextStyle(
                  fontSize: 11.0,
                  color: brassPale,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                'Rich TextStyle probe: $richStyleNote',
                style: TextStyle(
                  fontSize: 11.0,
                  color: brassPale,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.0),
        SizedBox(
          width: 80.0,
          height: 80.0,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: inkSapphireDeep,
                    border: Border.all(color: brassPale, width: 1.0),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
              Positioned(
                left: 10.0,
                top: 10.0,
                child: Opacity(
                  opacity: AlwaysStoppedAnimation<double>(0.85).value,
                  child: Text(
                    'FP\nS',
                    style: TextStyle(
                      color: brassPale,
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 4.0,
                bottom: 4.0,
                child: Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: brassPale,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ------------------------------------------------------------------
  // PAGE ASSEMBLY.
  // ------------------------------------------------------------------
  final List<Widget> pageChildren = [];

  pageChildren.add(heroCard);

  pageChildren.add(sectionTitle(
    'Palette table',
    'The named ink, paper, brass, ledger, oxblood, and charcoal colours.',
  ));
  pageChildren.add(cardShell(child: paletteTable));

  pageChildren.add(sectionTitle(
    'Palette swatches',
    'The same palette laid out as inspectable rectangles.',
  ));
  pageChildren.add(
    cardShell(
      child: Wrap(children: paletteSwatches),
    ),
  );

  pageChildren.add(sectionTitle(
    'Enum catalog',
    'Each EditableText-adjacent enum, with its values, default and meaning.',
  ));
  pageChildren.add(cardShell(child: enumTable));

  pageChildren.add(sectionTitle(
    'TextAlign gallery',
    'Six framed paragraphs, one per TextAlign value.',
  ));
  pageChildren.add(
    cardShell(
      child: Wrap(children: alignCards),
    ),
  );

  pageChildren.add(sectionTitle(
    'TextDirection mock',
    'LTR English flow next to an RTL Arabic flow.',
  ));
  pageChildren.add(cardShell(child: directionRow));

  pageChildren.add(sectionTitle(
    'TextCapitalization gallery',
    'Four cards illustrating the keyboard capitalisation hint.',
  ));
  pageChildren.add(
    cardShell(
      child: Wrap(children: capCards),
    ),
  );

  pageChildren.add(sectionTitle(
    'Smart quotes & dashes',
    'Configuration table for the iOS-style autocorrect family.',
  ));
  pageChildren.add(cardShell(child: smartTable));

  pageChildren.add(sectionTitle(
    'BoxHeightStyle preview',
    'Visual mocks showing how each height-style sizes the selection rect.',
  ));
  pageChildren.add(
    cardShell(
      child: Wrap(children: heightStyleCards),
    ),
  );

  pageChildren.add(sectionTitle(
    'BoxWidthStyle preview',
    'Visual mocks comparing tight versus max selection width.',
  ));
  pageChildren.add(
    cardShell(
      child: Wrap(children: widthStyleCards),
    ),
  );

  pageChildren.add(sectionTitle(
    'TextWidthBasis comparison',
    'A two-line paragraph rendered with both basis values.',
  ));
  pageChildren.add(cardShell(child: widthBasisRow));

  pageChildren.add(sectionTitle(
    'TextHeightBehavior anatomy',
    'Five diagrams of half-leading and leading distribution.',
  ));
  pageChildren.add(cardShell(child: thbDiagrams));

  pageChildren.add(sectionTitle(
    'Scenario — search',
    'A rounded search bar with all autocorrect helpers off.',
  ));
  pageChildren.add(scenarioSearch);

  pageChildren.add(sectionTitle(
    'Scenario — multiline editor',
    'A six-line editor with sentence capitalisation.',
  ));
  pageChildren.add(scenarioEditor);

  pageChildren.add(sectionTitle(
    'Scenario — RTL form field',
    'A right-to-left input wrapped in a Directionality.',
  ));
  pageChildren.add(scenarioRTL);

  pageChildren.add(sectionTitle(
    'Scenario — code editor',
    'A monospaced field on a charcoal plate.',
  ));
  pageChildren.add(scenarioCode);

  pageChildren.add(sectionTitle(
    'Pitfalls',
    'Common configuration mistakes around these enums.',
  ));
  pageChildren.add(cardShell(child: pitfallTable));

  pageChildren.add(sectionTitle(
    'Glossary',
    'Plain-English definitions for the supporting types.',
  ));
  pageChildren.add(cardShell(child: glossaryTable));

  pageChildren.add(sectionTitle(
    'TextField vs CupertinoTextField vs SelectableText',
    'Side-by-side configuration map.',
  ));
  pageChildren.add(cardShell(child: comparisonTable));
  pageChildren.add(cardShell(child: liveComparisonRow));

  pageChildren.add(sectionTitle(
    'Platform notes',
    'Where these enums actually do something — and where they\'re polite.',
  ));
  pageChildren.add(
    cardShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: proseChildren,
      ),
    ),
  );

  pageChildren.add(sectionTitle(
    'Cheatsheet',
    'One-line recipes for the common cases.',
  ));
  pageChildren.add(cardShell(child: cheatTable));

  pageChildren.add(pageDivider(thickness: 1.5));
  pageChildren.add(footer);

  // ------------------------------------------------------------------
  // PRINT EVERY ENUM SET — for the test runner trail.
  // ------------------------------------------------------------------
  print('--- TextAlign values ---');
  for (int i = 0; i < TextAlign.values.length; i++) {
    print('TextAlign[$i] = ${TextAlign.values[i].name}');
  }
  print('--- TextDirection values ---');
  for (int i = 0; i < TextDirection.values.length; i++) {
    print('TextDirection[$i] = ${TextDirection.values[i].name}');
  }
  print('--- TextCapitalization values ---');
  for (int i = 0; i < TextCapitalization.values.length; i++) {
    print('TextCapitalization[$i] = ${TextCapitalization.values[i].name}');
  }
  print('--- SmartDashesType values ---');
  for (int i = 0; i < SmartDashesType.values.length; i++) {
    print('SmartDashesType[$i] = ${SmartDashesType.values[i].name}');
  }
  print('--- SmartQuotesType values ---');
  for (int i = 0; i < SmartQuotesType.values.length; i++) {
    print('SmartQuotesType[$i] = ${SmartQuotesType.values[i].name}');
  }
  print('--- TextLeadingDistribution values ---');
  for (int i = 0; i < TextLeadingDistribution.values.length; i++) {
    print('TextLeadingDistribution[$i] = '
        '${TextLeadingDistribution.values[i].name}');
  }
  print('--- TextOverflow values ---');
  for (int i = 0; i < TextOverflow.values.length; i++) {
    print('TextOverflow[$i] = ${TextOverflow.values[i].name}');
  }
  print('--- TextDecorationStyle values ---');
  for (int i = 0; i < TextDecorationStyle.values.length; i++) {
    print('TextDecorationStyle[$i] = ${TextDecorationStyle.values[i].name}');
  }
  print('--- TextBaseline values ---');
  for (int i = 0; i < TextBaseline.values.length; i++) {
    print('TextBaseline[$i] = ${TextBaseline.values[i].name}');
  }

  print('Page assembled. ${pageChildren.length} top-level sections.');
  print('All Fountain Pen Sapphire visual sections ready.');

  // ------------------------------------------------------------------
  // FINAL RETURN — single Scaffold, single SingleChildScrollView.
  // ------------------------------------------------------------------
  return Scaffold(
    backgroundColor: paperCream,
    appBar: AppBar(
      backgroundColor: inkSapphireDeep,
      foregroundColor: paperCream,
      elevation: 0,
      title: Text(
        'EditableText — Fountain Pen Sapphire',
        style: TextStyle(
          color: paperCream,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(
          height: 4.0,
          color: brass,
        ),
      ),
    ),
    body: Container(
      color: paperCream,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: pageChildren,
        ),
      ),
    ),
  );
}
