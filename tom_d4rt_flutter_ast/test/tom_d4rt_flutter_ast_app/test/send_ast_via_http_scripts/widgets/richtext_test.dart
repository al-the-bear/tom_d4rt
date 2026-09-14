// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// =====================================================================
// RICHTEXT FOUNDRY — RichText / Text.rich / TextSpan / WidgetSpan
// =====================================================================
//
// This demo is a single static Flutter scene that walks through the
// inline-text family in Flutter: the low-level RichText widget, the
// higher-level Text.rich constructor, the recursive InlineSpan tree
// (TextSpan), and the embedded-widget escape hatch (WidgetSpan).
//
// Where Text takes a flat String, RichText takes an InlineSpan: a tree
// of TextSpan and WidgetSpan nodes, each carrying its own TextStyle.
// Children inherit their parent's style by composition (not by widget
// inheritance — RichText does NOT consult DefaultTextStyle), and any
// child can override any field. This makes RichText the right tool for
// syntax-highlighted code, terminal output, mixed-font math, inline
// chips/icons, multi-locale prose, and anywhere the cost of one style
// per character would otherwise force you into a Row of Texts.
//
// Layout:
//   - A wordmark that spells "RichText" with a different style per glyph.
//   - An anatomy diagram of TextSpan's named arguments.
//   - A tree visualization showing the parent/child structure of a
//     deeply nested span built into a single sentence.
//   - Stylized prose with italic / bold / colored / underlined /
//     monospace runs.
//   - A code-listing simulation rendering a Dart snippet with token
//     colors (keyword / string / comment / number).
//   - A terminal-output simulation with INFO/WARN/ERR colored lines.
//   - Inline math expressions using superscript / subscript via small
//     font sizes and baseline offsets.
//   - A WidgetSpan gallery: Chip, Icon, and a custom badge embedded
//     mid-sentence.
//   - A textScaler / TextHeightBehavior / strutStyle showcase with the
//     same paragraph rendered three ways.
//   - A recognizer-hint section explaining how a TapGestureRecognizer
//     would be attached (shown as code listing only — this demo is
//     static and there is no disposal lifecycle).
//   - Pitfalls callouts.
// =====================================================================

dynamic build(BuildContext context) {
  print('RichTextFoundry: building demo...');

  // -----------------------------------------------------------------
  // PALETTE
  // -----------------------------------------------------------------
  final Color paperCream = const Color(0xFFFBF7EE);
  final Color paperDeep = const Color(0xFFEDE3CC);
  final Color inkBlack = const Color(0xFF1A1814);
  final Color inkSoft = const Color(0xFF3F3A30);
  final Color accentRed = const Color(0xFFC8341A);
  final Color accentBlue = const Color(0xFF1F3A93);
  final Color accentGold = const Color(0xFFC9A227);
  final Color accentTeal = const Color(0xFF137F7B);
  final Color accentMagenta = const Color(0xFFA0288D);
  final Color accentForest = const Color(0xFF2F6A2A);
  final Color editorBg = const Color(0xFF1E1E2E);
  final Color editorPanel = const Color(0xFF181825);
  final Color editorGutter = const Color(0xFF313244);
  final Color tokenKeyword = const Color(0xFF82AAFF);
  final Color tokenString = const Color(0xFFA6E22E);
  final Color tokenComment = const Color(0xFF7F848E);
  final Color tokenNumber = const Color(0xFFF78C6C);
  final Color tokenType = const Color(0xFFFFCB6B);
  final Color tokenIdent = const Color(0xFFE6E6E6);
  final Color terminalBg = const Color(0xFF0A0A0A);
  final Color termPrompt = const Color(0xFF7CFC00);
  final Color termInfo = const Color(0xFF87CEEB);
  final Color termWarn = const Color(0xFFFFD166);
  final Color termErr = const Color(0xFFFF5252);
  final Color termDim = const Color(0xFFA0A0A0);

  // -----------------------------------------------------------------
  // GRADIENTS (>= 6)
  // -----------------------------------------------------------------
  final LinearGradient gPaper = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[paperCream, paperDeep],
  );
  final LinearGradient gWordmark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      accentRed.withValues(alpha: 0.95),
      accentMagenta.withValues(alpha: 0.95),
      accentBlue.withValues(alpha: 0.95),
      accentTeal.withValues(alpha: 0.95),
    ],
  );
  final LinearGradient gEditor = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[editorPanel, editorBg],
  );
  final LinearGradient gTerminal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[const Color(0xFF050505), const Color(0xFF101010)],
  );
  final LinearGradient gAnatomy = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[accentBlue.withValues(alpha: 0.10), accentGold.withValues(alpha: 0.10)],
  );
  final LinearGradient gPitfall = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[accentRed.withValues(alpha: 0.10), accentRed.withValues(alpha: 0.04)],
  );
  final LinearGradient gMath = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[accentTeal.withValues(alpha: 0.08), accentBlue.withValues(alpha: 0.06)],
  );
  final LinearGradient gWidgetSpan = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[accentMagenta.withValues(alpha: 0.10), accentGold.withValues(alpha: 0.08)],
  );

  // -----------------------------------------------------------------
  // SHADOWS (>= 6)
  // -----------------------------------------------------------------
  final BoxShadow shadowCard = BoxShadow(
    color: inkBlack.withValues(alpha: 0.12),
    blurRadius: 14,
    offset: const Offset(0, 6),
  );
  final BoxShadow shadowCardHi = BoxShadow(
    color: inkBlack.withValues(alpha: 0.06),
    blurRadius: 4,
    offset: const Offset(0, 2),
  );
  final BoxShadow shadowEditor = BoxShadow(
    color: Colors.black.withValues(alpha: 0.55),
    blurRadius: 22,
    offset: const Offset(0, 10),
  );
  final BoxShadow shadowTerminal = BoxShadow(
    color: Colors.black.withValues(alpha: 0.65),
    blurRadius: 26,
    offset: const Offset(0, 12),
  );
  final BoxShadow shadowAnatomy = BoxShadow(
    color: accentBlue.withValues(alpha: 0.18),
    blurRadius: 12,
    offset: const Offset(0, 5),
  );
  final BoxShadow shadowPitfall = BoxShadow(
    color: accentRed.withValues(alpha: 0.18),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );
  final BoxShadow shadowChip = BoxShadow(
    color: inkBlack.withValues(alpha: 0.10),
    blurRadius: 6,
    offset: const Offset(0, 2),
  );
  final BoxShadow shadowBadge = BoxShadow(
    color: accentGold.withValues(alpha: 0.45),
    blurRadius: 8,
    offset: const Offset(0, 3),
  );

  // -----------------------------------------------------------------
  // BASE STYLES — RichText does NOT inherit DefaultTextStyle, so the
  // root span must always carry an explicit baseline TextStyle.
  // -----------------------------------------------------------------
  final TextStyle baseProse = TextStyle(
    fontFamily: 'Georgia',
    fontSize: 15,
    height: 1.55,
    color: inkBlack,
    leadingDistribution: TextLeadingDistribution.even,
  );
  final TextStyle baseMono = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13.5,
    height: 1.45,
    color: tokenIdent,
  );
  final TextStyle baseTerm = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    height: 1.5,
    color: termDim,
  );
  final TextStyle headingStyle = TextStyle(
    fontFamily: 'Georgia',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: inkBlack,
    letterSpacing: 0.2,
  );
  final TextStyle subheadingStyle = TextStyle(
    fontFamily: 'Georgia',
    fontSize: 16,
    fontStyle: FontStyle.italic,
    color: inkSoft,
    height: 1.4,
  );
  final TextStyle labelStyle = TextStyle(
    fontFamily: 'monospace',
    fontSize: 11,
    color: accentBlue,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
  );

  // =================================================================
  // HEADER
  // =================================================================
  final Widget header = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28, 28, 28, 22),
    decoration: BoxDecoration(
      gradient: gPaper,
      border: Border(bottom: BorderSide(color: paperDeep, width: 2)),
      boxShadow: <BoxShadow>[shadowCardHi],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('THE RICHTEXT FOUNDRY', style: labelStyle),
        const SizedBox(height: 6),
        Text(
          'A field guide to RichText, Text.rich, TextSpan, and WidgetSpan',
          style: headingStyle,
        ),
        const SizedBox(height: 6),
        Text(
          'One static scene · ten sections · all spans hand-authored.',
          style: subheadingStyle,
        ),
      ],
    ),
  );

  // =================================================================
  // SECTION 1 — HERO WORDMARK
  //
  // We spell "RichText" by composing the eight glyphs as eight separate
  // TextSpans, each with its own color, weight, fontStyle, fontSize, or
  // letter spacing. The whole word is hosted in a RichText whose root
  // span carries the shared font family. Below the wordmark we add a
  // small caption spelled with mixed cases and a colored period.
  // =================================================================
  final Widget heroWordmark = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28, 36, 28, 36),
    decoration: BoxDecoration(
      gradient: gPaper,
      boxShadow: <BoxShadow>[shadowCard],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('§ 1 — Hero wordmark', style: labelStyle),
        const SizedBox(height: 14),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 86,
              height: 1.0,
              color: inkBlack,
              letterSpacing: -1.5,
            ),
            children: <InlineSpan>[
              TextSpan(
                text: 'R',
                style: TextStyle(
                  color: accentRed,
                  fontWeight: FontWeight.w900,
                  fontSize: 96,
                ),
              ),
              TextSpan(
                text: 'i',
                style: TextStyle(
                  color: accentMagenta,
                  fontStyle: FontStyle.italic,
                  fontSize: 78,
                ),
              ),
              TextSpan(
                text: 'c',
                style: TextStyle(
                  color: accentBlue,
                  fontWeight: FontWeight.w400,
                  fontSize: 82,
                ),
              ),
              TextSpan(
                text: 'h',
                style: TextStyle(
                  color: accentTeal,
                  fontWeight: FontWeight.w800,
                  fontSize: 92,
                  letterSpacing: -2.0,
                ),
              ),
              const TextSpan(text: ' '),
              TextSpan(
                text: 'T',
                style: TextStyle(
                  color: accentGold,
                  fontWeight: FontWeight.w900,
                  fontSize: 100,
                ),
              ),
              TextSpan(
                text: 'e',
                style: TextStyle(
                  color: accentForest,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 80,
                ),
              ),
              TextSpan(
                text: 'x',
                style: TextStyle(
                  color: accentRed,
                  fontWeight: FontWeight.w300,
                  fontSize: 84,
                  letterSpacing: -1.0,
                ),
              ),
              TextSpan(
                text: 't',
                style: TextStyle(
                  color: accentBlue,
                  fontWeight: FontWeight.w900,
                  fontSize: 96,
                  decoration: TextDecoration.underline,
                  decorationColor: accentGold,
                  decorationThickness: 3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        ShaderMask(
          shaderCallback: (Rect bounds) => gWordmark.createShader(bounds),
          child: Text(
            'eight glyphs · eight spans · one InlineSpan tree',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  // =================================================================
  // SECTION 2 — TEXTSPAN ANATOMY
  //
  // A boxed "diagram" labelling the named parameters of TextSpan.
  // Each row is a labelled chip-like Container with the parameter name
  // on the left and a short description on the right.
  // =================================================================
  Widget anatomyRow(String name, String type, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 130,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: accentBlue.withValues(alpha: 0.10),
              border: Border.all(color: accentBlue.withValues(alpha: 0.35)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: accentBlue,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 110,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: accentGold.withValues(alpha: 0.10),
              border: Border.all(color: accentGold.withValues(alpha: 0.35)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              type,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: accentGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                description,
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 14,
                  color: inkBlack,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget anatomy = Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: gAnatomy,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentBlue.withValues(alpha: 0.30)),
      boxShadow: <BoxShadow>[shadowAnatomy],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('§ 2 — TextSpan anatomy', style: labelStyle),
        const SizedBox(height: 6),
        Text('The named arguments of the TextSpan constructor', style: subheadingStyle),
        const SizedBox(height: 16),
        anatomyRow(
          'text',
          'String?',
          'The literal characters this span contributes. May be null if the span is purely a styled container for children.',
        ),
        anatomyRow(
          'style',
          'TextStyle?',
          'Style applied to text and inherited (composed) by children. Children override field-by-field.',
        ),
        anatomyRow(
          'children',
          'List<InlineSpan>?',
          'Nested spans laid out inline. May contain TextSpan or WidgetSpan. Nesting depth is unlimited.',
        ),
        anatomyRow(
          'recognizer',
          'GestureRecognizer?',
          'Receives pointer events that hit this span (e.g. TapGestureRecognizer). MUST be disposed by the owner.',
        ),
        anatomyRow(
          'mouseCursor',
          'MouseCursor?',
          'Cursor while the pointer is over this span (web/desktop). Defaults to SystemMouseCursors.click when a recognizer is set.',
        ),
        anatomyRow(
          'semanticsLabel',
          'String?',
          'Override of the announced text for screen readers. Useful when the visual glyphs are decorative or abbreviated.',
        ),
        anatomyRow(
          'locale',
          'Locale?',
          'Locale used for font fallback and digit shaping inside this span.',
        ),
        anatomyRow(
          'spellOut',
          'bool?',
          'When true, screen readers spell each character individually (e.g. for codes).',
        ),
      ],
    ),
  );

  // =================================================================
  // SECTION 3 — TREE VISUALIZATION
  //
  // We build a single sentence as a deeply nested TextSpan tree, then
  // render an ASCII-style diagram of that tree side-by-side. The root
  // span has children, some of which have their own children — so the
  // composition shows up in both the rendered prose AND the diagram.
  // =================================================================
  final TextSpan deepRoot = TextSpan(
    style: baseProse.copyWith(fontSize: 16),
    children: <InlineSpan>[
      const TextSpan(text: 'The '),
      TextSpan(
        style: TextStyle(color: accentBlue, fontWeight: FontWeight.w700),
        children: <InlineSpan>[
          const TextSpan(text: 'quick '),
          TextSpan(
            style: TextStyle(fontStyle: FontStyle.italic, color: accentMagenta),
            text: 'brown ',
          ),
          const TextSpan(text: 'fox'),
        ],
      ),
      const TextSpan(text: ' jumps '),
      TextSpan(
        style: TextStyle(color: accentForest),
        children: <InlineSpan>[
          const TextSpan(text: 'over '),
          TextSpan(
            style: const TextStyle(decoration: TextDecoration.underline),
            children: <InlineSpan>[
              const TextSpan(text: 'the lazy '),
              TextSpan(
                style: TextStyle(color: accentRed, fontWeight: FontWeight.w900),
                text: 'dog',
              ),
            ],
          ),
        ],
      ),
      const TextSpan(text: '.'),
    ],
  );

  final String treeDiagram = '''
TextSpan (root, baseProse 16pt)
├── TextSpan "The "
├── TextSpan (blue, w700)
│   ├── TextSpan "quick "
│   ├── TextSpan "brown " (italic, magenta)
│   └── TextSpan "fox"
├── TextSpan " jumps "
├── TextSpan (forest)
│   ├── TextSpan "over "
│   └── TextSpan (underline)
│       ├── TextSpan "the lazy "
│       └── TextSpan "dog" (red, w900)
└── TextSpan "."
''';

  final Widget treeSection = Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: paperCream,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paperDeep, width: 1.5),
      boxShadow: <BoxShadow>[shadowCard],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('§ 3 — Tree visualization', style: labelStyle),
        const SizedBox(height: 6),
        Text('A single sentence rendered from a recursive TextSpan tree', style: subheadingStyle),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: paperDeep),
                ),
                child: RichText(text: deepRoot),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: editorPanel,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: editorGutter),
                ),
                child: Text(
                  treeDiagram,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    height: 1.4,
                    color: tokenIdent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // =================================================================
  // SECTION 4 — STYLIZED PROSE
  //
  // A short paragraph from a fictional novel where five phrases are
  // emphasised differently: italic, bold, colored, underlined, and
  // monospace. Built as a single Text.rich for compactness.
  // =================================================================
  final Widget prose = Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: paperCream,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paperDeep, width: 1.5),
      boxShadow: <BoxShadow>[shadowCard, shadowCardHi],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('§ 4 — Stylized prose', style: labelStyle),
        const SizedBox(height: 6),
        Text('Five emphases in one paragraph', style: subheadingStyle),
        const SizedBox(height: 14),
        Text.rich(
          TextSpan(
            style: baseProse,
            children: <InlineSpan>[
              const TextSpan(
                text:
                    'On the seventh evening Halvard climbed the dune and looked back at the city. ',
              ),
              TextSpan(
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: accentMagenta,
                ),
                text: 'It was smaller than memory had told him, ',
              ),
              const TextSpan(text: 'a thumbprint of yellow light pressed against the dark. '),
              TextSpan(
                style: const TextStyle(fontWeight: FontWeight.w800),
                text: 'He had not eaten in two days. ',
              ),
              const TextSpan(text: 'Above him the gulls described their slow, '),
              TextSpan(
                style: TextStyle(
                  color: accentBlue,
                  fontWeight: FontWeight.w600,
                ),
                text: 'cobalt circles ',
              ),
              const TextSpan(text: 'and from the sea below rose the steady, '),
              TextSpan(
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: accentRed,
                  decorationStyle: TextDecorationStyle.wavy,
                  decorationThickness: 1.5,
                ),
                text: 'metallic clang of the warning buoy.',
              ),
              const TextSpan(text: ' He sat in the sand and remembered the line carved above the door of the orphanage: '),
              TextSpan(
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: accentForest,
                  backgroundColor: accentForest.withValues(alpha: 0.08),
                  fontSize: 13,
                ),
                text: 'memento, ne obliviscaris',
              ),
              const TextSpan(text: '. He had forgotten almost all of it.'),
            ],
          ),
        ),
      ],
    ),
  );

  // =================================================================
  // SECTION 5 — CODE-LISTING SIMULATION
  //
  // A Container styled like a code editor (dark bg, gutter, frame),
  // containing a RichText that renders a Dart snippet with token
  // colors. Each line is a sequence of styled spans separated by '\n'.
  // =================================================================
  TextSpan codeLine({
    required int lineNo,
    required List<InlineSpan> tokens,
    required Color gutter,
  }) {
    return TextSpan(
      children: <InlineSpan>[
        TextSpan(
          text: '${lineNo.toString().padLeft(2, ' ')}  ',
          style: TextStyle(color: gutter, fontFamily: 'monospace', fontSize: 13.5),
        ),
        ...tokens,
        const TextSpan(text: '\n'),
      ],
    );
  }

  TextSpan kw(String t) => TextSpan(
        text: t,
        style: TextStyle(color: tokenKeyword, fontWeight: FontWeight.w700),
      );
  TextSpan str(String t) => TextSpan(text: t, style: TextStyle(color: tokenString));
  TextSpan cm(String t) => TextSpan(
        text: t,
        style: TextStyle(color: tokenComment, fontStyle: FontStyle.italic),
      );
  TextSpan nm(String t) => TextSpan(text: t, style: TextStyle(color: tokenNumber));
  TextSpan ty(String t) => TextSpan(text: t, style: TextStyle(color: tokenType));
  TextSpan id(String t) => TextSpan(text: t, style: TextStyle(color: tokenIdent));
  TextSpan op(String t) => TextSpan(
        text: t,
        style: TextStyle(color: tokenIdent.withValues(alpha: 0.85)),
      );

  final RichText codeListing = RichText(
    text: TextSpan(
      style: baseMono,
      children: <InlineSpan>[
        codeLine(
          lineNo: 1,
          gutter: tokenComment,
          tokens: <InlineSpan>[cm('// Greeting renderer — maps a name to a stylised greeting.')],
        ),
        codeLine(
          lineNo: 2,
          gutter: tokenComment,
          tokens: <InlineSpan>[ty('String'), id(' '), id('greet'), op('('), ty('String'), id(' '), id('name'), op(') {')],
        ),
        codeLine(
          lineNo: 3,
          gutter: tokenComment,
          tokens: <InlineSpan>[
            id('  '),
            kw('if'),
            id(' '),
            op('('),
            id('name'),
            op('.'),
            id('isEmpty'),
            op(') '),
            kw('return'),
            id(' '),
            str("'Hello, friend.'"),
            op(';'),
          ],
        ),
        codeLine(
          lineNo: 4,
          gutter: tokenComment,
          tokens: <InlineSpan>[
            id('  '),
            kw('final'),
            id(' '),
            ty('int'),
            id(' '),
            id('count'),
            op(' = '),
            nm('42'),
            op(';'),
            id('   '),
            cm('// always 42'),
          ],
        ),
        codeLine(
          lineNo: 5,
          gutter: tokenComment,
          tokens: <InlineSpan>[
            id('  '),
            kw('return'),
            id(' '),
            str("'Hello, '"),
            op(' + '),
            id('name'),
            op(' + '),
            str("' ('"),
            op(' + '),
            id('count'),
            op('.'),
            id('toString'),
            op('()'),
            op(' + '),
            str("')'"),
            op(';'),
          ],
        ),
        codeLine(
          lineNo: 6,
          gutter: tokenComment,
          tokens: <InlineSpan>[op('}')],
        ),
        codeLine(
          lineNo: 7,
          gutter: tokenComment,
          tokens: <InlineSpan>[],
        ),
        codeLine(
          lineNo: 8,
          gutter: tokenComment,
          tokens: <InlineSpan>[cm('// Driver')],
        ),
        codeLine(
          lineNo: 9,
          gutter: tokenComment,
          tokens: <InlineSpan>[
            kw('void'),
            id(' '),
            id('main'),
            op('() {'),
          ],
        ),
        codeLine(
          lineNo: 10,
          gutter: tokenComment,
          tokens: <InlineSpan>[
            id('  '),
            id('print'),
            op('('),
            id('greet'),
            op('('),
            str("'Halvard'"),
            op('));'),
          ],
        ),
        codeLine(
          lineNo: 11,
          gutter: tokenComment,
          tokens: <InlineSpan>[op('}')],
        ),
      ],
    ),
  );

  final Widget codeSection = Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    decoration: BoxDecoration(
      gradient: gEditor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[shadowEditor],
      border: Border.all(color: editorGutter, width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
          decoration: BoxDecoration(
            color: editorPanel,
            border: Border(bottom: BorderSide(color: editorGutter)),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Row(
            children: <Widget>[
              _circleDot(const Color(0xFFFF5F57)),
              const SizedBox(width: 6),
              _circleDot(const Color(0xFFFEBC2E)),
              const SizedBox(width: 6),
              _circleDot(const Color(0xFF28C840)),
              const SizedBox(width: 16),
              Text(
                'greet.dart  —  RichText syntax-highlight demo',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: tokenIdent.withValues(alpha: 0.85),
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '§ 5 — Code-listing simulation',
                style: labelStyle.copyWith(color: tokenKeyword),
              ),
              const SizedBox(height: 10),
              codeListing,
            ],
          ),
        ),
      ],
    ),
  );

  // =================================================================
  // SECTION 6 — TERMINAL OUTPUT SIMULATION
  //
  // A black terminal-like Container with a RichText that renders mixed
  // INFO/WARN/ERR lines, each prefixed with a colored tag. Demonstrates
  // line-level color switching inside a single InlineSpan tree.
  // =================================================================
  TextSpan termLine(String tag, Color tagColor, String body) {
    return TextSpan(
      children: <InlineSpan>[
        TextSpan(
          text: '[$tag]',
          style: TextStyle(color: tagColor, fontWeight: FontWeight.w700),
        ),
        TextSpan(
          text: '  $body\n',
          style: TextStyle(color: termDim),
        ),
      ],
    );
  }

  final RichText terminalText = RichText(
    text: TextSpan(
      style: baseTerm,
      children: <InlineSpan>[
        TextSpan(
          text: '\$ ',
          style: TextStyle(color: termPrompt, fontWeight: FontWeight.w700),
        ),
        TextSpan(
          text: 'tom build --release\n',
          style: TextStyle(color: const Color(0xFFE0E0E0)),
        ),
        termLine('INFO', termInfo, 'resolving workspace dependencies'),
        termLine('INFO', termInfo, 'compiling tom_core_kernel (12 files)'),
        termLine('INFO', termInfo, 'compiling tom_core_flutter (37 files)'),
        termLine('WARN', termWarn, 'deprecated API in tom_core_flutter/text.dart:42'),
        termLine('WARN', termWarn, 'unused import in main.dart:7'),
        termLine('INFO', termInfo, 'running analyzer pass'),
        termLine('ERR ', termErr, 'analyzer reported 1 issue (treating as fatal)'),
        termLine('INFO', termInfo, 'aborting build, see report.json'),
        TextSpan(
          text: '\$ ',
          style: TextStyle(color: termPrompt, fontWeight: FontWeight.w700),
        ),
        TextSpan(
          text: 'echo \$?\n',
          style: TextStyle(color: const Color(0xFFE0E0E0)),
        ),
        TextSpan(
          text: '1\n',
          style: TextStyle(color: termErr, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );

  final Widget terminalSection = Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
    decoration: BoxDecoration(
      gradient: gTerminal,
      color: terminalBg,
      borderRadius: BorderRadius.circular(10),
      boxShadow: <BoxShadow>[shadowTerminal],
      border: Border.all(color: const Color(0xFF222222)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '§ 6 — Terminal output',
          style: labelStyle.copyWith(color: termPrompt),
        ),
        const SizedBox(height: 12),
        terminalText,
      ],
    ),
  );

  // =================================================================
  // SECTION 7 — INLINE MATH
  //
  // RichText renders three inline equations using small font + baseline
  // offset to fake superscripts and subscripts. This is the "poor man's
  // MathJax" — fine for one-line formulas, not for fractions or roots.
  // =================================================================
  TextSpan sup(String t) => TextSpan(
        text: t,
        style: const TextStyle(fontSize: 9, height: 1, fontFeatures: <FontFeature>[FontFeature.superscripts()]),
      );
  TextSpan sub(String t) => TextSpan(
        text: t,
        style: const TextStyle(fontSize: 9, height: 1, fontFeatures: <FontFeature>[FontFeature.subscripts()]),
      );

  final Widget mathSection = Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: gMath,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentBlue.withValues(alpha: 0.20)),
      boxShadow: <BoxShadow>[shadowCardHi],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('§ 7 — Inline math', style: labelStyle),
        const SizedBox(height: 6),
        Text('Superscripts & subscripts via fontFeatures + smaller fontSize', style: subheadingStyle),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: baseProse.copyWith(fontSize: 18),
            children: <InlineSpan>[
              const TextSpan(text: 'Pythagoras:  '),
              TextSpan(
                style: TextStyle(color: accentBlue, fontWeight: FontWeight.w700),
                children: <InlineSpan>[
                  const TextSpan(text: 'a'),
                  sup('2'),
                  const TextSpan(text: ' + b'),
                  sup('2'),
                  const TextSpan(text: ' = c'),
                  sup('2'),
                ],
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            style: baseProse.copyWith(fontSize: 18),
            children: <InlineSpan>[
              const TextSpan(text: 'Water:  '),
              TextSpan(
                style: TextStyle(color: accentTeal, fontWeight: FontWeight.w700),
                children: <InlineSpan>[
                  const TextSpan(text: 'H'),
                  sub('2'),
                  const TextSpan(text: 'O'),
                ],
              ),
              const TextSpan(text: '   ·   Sulfate:  '),
              TextSpan(
                style: TextStyle(color: accentForest, fontWeight: FontWeight.w700),
                children: <InlineSpan>[
                  const TextSpan(text: 'SO'),
                  sub('4'),
                  sup('2−'),
                ],
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text.rich(
          TextSpan(
            style: baseProse.copyWith(fontSize: 18),
            children: <InlineSpan>[
              const TextSpan(text: 'Series:  '),
              TextSpan(
                style: TextStyle(color: accentMagenta, fontWeight: FontWeight.w700),
                children: <InlineSpan>[
                  const TextSpan(text: 'S'),
                  sub('n'),
                  const TextSpan(text: ' = a'),
                  sub('1'),
                  const TextSpan(text: ' + a'),
                  sub('1'),
                  const TextSpan(text: 'r + a'),
                  sub('1'),
                  const TextSpan(text: 'r'),
                  sup('2'),
                  const TextSpan(text: ' + … + a'),
                  sub('1'),
                  const TextSpan(text: 'r'),
                  sup('n−1'),
                ],
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
      ],
    ),
  );

  // =================================================================
  // SECTION 8 — WIDGETSPAN GALLERY
  //
  // A sentence with three WidgetSpan ornaments threaded through it: a
  // Material Chip, an Icon, and a custom badge Container. WidgetSpans
  // align with surrounding text via PlaceholderAlignment; we use
  // .middle for the chip and .baseline for the icon to demonstrate.
  // =================================================================
  final Widget chipWidget = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[shadowChip],
      ),
      child: Chip(
        avatar: CircleAvatar(
          backgroundColor: accentBlue,
          child: const Text(
            'F',
            style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
          ),
        ),
        label: const Text('Flutter'),
        labelStyle: TextStyle(
          color: accentBlue,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: accentBlue.withValues(alpha: 0.10),
        side: BorderSide(color: accentBlue.withValues(alpha: 0.35)),
      ),
    ),
  );

  final Widget iconWidget = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3),
    child: Icon(Icons.flash_on, color: accentGold, size: 18),
  );

  final Widget badgeWidget = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: accentRed,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[shadowBadge],
      ),
      child: const Text(
        'NEW',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.6,
        ),
      ),
    ),
  );

  final Widget widgetSpanSection = Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: gWidgetSpan,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentMagenta.withValues(alpha: 0.25)),
      boxShadow: <BoxShadow>[shadowCard],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('§ 8 — WidgetSpan gallery', style: labelStyle),
        const SizedBox(height: 6),
        Text('Embedded widgets aligned mid-sentence', style: subheadingStyle),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: baseProse.copyWith(fontSize: 16),
            children: <InlineSpan>[
              const TextSpan(text: 'Today we shipped a '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: chipWidget,
              ),
              const TextSpan(text: ' release with '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: iconWidget,
              ),
              const TextSpan(text: ' faster startup and a freshly painted '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: badgeWidget,
              ),
              const TextSpan(text: ' onboarding flow.'),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Tip: PlaceholderAlignment.middle centers the widget on the line\'s middle; '
          'PlaceholderAlignment.baseline + a baseline argument aligns the widget bottom to '
          'the alphabetic or ideographic baseline.',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontStyle: FontStyle.italic,
            fontSize: 13,
            color: inkSoft,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // =================================================================
  // SECTION 9 — TEXT SCALER / HEIGHT BEHAVIOR / STRUT STYLE
  //
  // The same paragraph rendered three ways:
  //   (a) default,
  //   (b) textScaler 1.4,
  //   (c) custom strutStyle and TextHeightBehavior.
  // =================================================================
  final TextSpan layoutSample = TextSpan(
    style: baseProse.copyWith(fontSize: 14),
    children: const <InlineSpan>[
      TextSpan(text: 'The carbon-paper ribbon kept catching on the bell. '),
      TextSpan(text: 'Halvard tightened the platen knob a quarter turn '),
      TextSpan(text: 'and tried again. The keys clattered like distant rain.'),
    ],
  );

  Widget layoutSampleBox(String label, Widget child) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: paperCream,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: paperDeep),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(label, style: labelStyle.copyWith(fontSize: 10)),
            const SizedBox(height: 6),
            child,
          ],
        ),
      ),
    );
  }

  final Widget layoutSection = Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paperDeep, width: 1.5),
      boxShadow: <BoxShadow>[shadowCard],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('§ 9 — textScaler / strutStyle / heightBehavior', style: labelStyle),
        const SizedBox(height: 6),
        Text('Same prose, three layout configurations', style: subheadingStyle),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            layoutSampleBox(
              'DEFAULT',
              RichText(text: layoutSample),
            ),
            const SizedBox(width: 10),
            layoutSampleBox(
              'textScaler 1.4',
              RichText(
                text: layoutSample,
                textScaler: const TextScaler.linear(1.4),
              ),
            ),
            const SizedBox(width: 10),
            layoutSampleBox(
              'strutStyle + heightBehavior',
              RichText(
                text: layoutSample,
                strutStyle: const StrutStyle(
                  fontFamily: 'Georgia',
                  fontSize: 14,
                  height: 1.9,
                  forceStrutHeight: true,
                ),
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                  applyHeightToLastDescent: false,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // =================================================================
  // SECTION 10 — RECOGNIZER HINT
  //
  // The TapGestureRecognizer pattern shown as a code listing only.
  // We do not actually attach a recognizer here because TextSpan does
  // not own its recognizer's lifecycle and this build() function has
  // no disposal hook.
  // =================================================================
  final RichText recognizerCode = RichText(
    text: TextSpan(
      style: baseMono,
      children: <InlineSpan>[
        cm('// 1. Owner widget creates and stores the recognizer.\n'),
        kw('class'),
        id(' '),
        ty('_LinkOwner'),
        id(' '),
        kw('extends'),
        id(' '),
        ty('State'),
        op('<'),
        ty('_LinkWidget'),
        op('> {\n'),
        id('  '),
        kw('late'),
        id(' '),
        kw('final'),
        id(' '),
        ty('TapGestureRecognizer'),
        id(' '),
        id('_tap'),
        op(';\n\n'),
        id('  '),
        op('@'),
        ty('override'),
        id('\n  '),
        kw('void'),
        id(' '),
        id('initState'),
        op('() {\n'),
        id('    '),
        kw('super'),
        op('.'),
        id('initState'),
        op('();\n'),
        id('    '),
        id('_tap'),
        op(' = '),
        ty('TapGestureRecognizer'),
        op('()'),
        op('..'),
        id('onTap'),
        op(' = () => '),
        id('print'),
        op('('),
        str("'tapped'"),
        op(');\n'),
        id('  '),
        op('}\n\n'),
        id('  '),
        op('@'),
        ty('override'),
        id('\n  '),
        kw('void'),
        id(' '),
        id('dispose'),
        op('() {\n'),
        id('    '),
        id('_tap'),
        op('.'),
        id('dispose'),
        op('();\n'),
        id('    '),
        kw('super'),
        op('.'),
        id('dispose'),
        op('();\n'),
        id('  '),
        op('}\n\n'),
        id('  '),
        op('@'),
        ty('override'),
        id('\n  '),
        ty('Widget'),
        id(' '),
        id('build'),
        op('('),
        ty('BuildContext'),
        id(' '),
        id('context'),
        op(') {\n'),
        id('    '),
        kw('return'),
        id(' '),
        ty('Text.rich'),
        op('('),
        ty('TextSpan'),
        op('(\n'),
        id('      '),
        id('children'),
        op(': <'),
        ty('InlineSpan'),
        op('>['),
        op('\n'),
        id('        '),
        ty('TextSpan'),
        op('('),
        id('text'),
        op(': '),
        str("'tap me'"),
        op(', '),
        id('recognizer'),
        op(': '),
        id('_tap'),
        op('),\n'),
        id('      ]),\n'),
        id('    );\n'),
        id('  '),
        op('}\n'),
        op('}\n'),
      ],
    ),
  );

  final Widget recognizerSection = Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: gEditor,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: editorGutter),
      boxShadow: <BoxShadow>[shadowEditor],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '§ 10 — Recognizer hint',
          style: labelStyle.copyWith(color: tokenKeyword),
        ),
        const SizedBox(height: 6),
        Text(
          'How a TapGestureRecognizer is wired (shown as code, not attached here)',
          style: subheadingStyle.copyWith(color: tokenComment),
        ),
        const SizedBox(height: 14),
        recognizerCode,
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF11111B),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: editorGutter),
          ),
          child: Text(
            'Why this demo does not attach a real recognizer:\n'
            'TapGestureRecognizer extends a disposable resource. The owning widget\n'
            'must call .dispose() in State.dispose to release pointer subscriptions.\n'
            'A static build() that returns a tree once has no disposal hook, so the\n'
            'recognizer would leak. Always couple a recognizer with a Stateful owner.',
            style: TextStyle(
              fontFamily: 'monospace',
              color: tokenIdent.withValues(alpha: 0.85),
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // =================================================================
  // SECTION 11 — PITFALLS
  //
  // Three callout boxes with common RichText/TextSpan mistakes and the
  // resolution for each.
  // =================================================================
  Widget pitfall(String title, String body) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: gPitfall,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accentRed.withValues(alpha: 0.35)),
        boxShadow: <BoxShadow>[shadowPitfall],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber_rounded, color: accentRed, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: accentRed,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: inkBlack,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  final Widget pitfallSection = Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: paperCream,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: paperDeep, width: 1.5),
      boxShadow: <BoxShadow>[shadowCard],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('§ 11 — Pitfalls', style: labelStyle),
        const SizedBox(height: 6),
        Text('Three traps, three rescues', style: subheadingStyle),
        const SizedBox(height: 14),
        pitfall(
          'RichText does not inherit DefaultTextStyle',
          'Unlike Text, the low-level RichText widget never consults the ambient '
          'DefaultTextStyle. If your root TextSpan has no explicit style, the text '
          'renders with engine defaults (typically 14pt black sans). Always provide '
          'a TextStyle on the root span — or use Text.rich, which DOES merge with '
          'DefaultTextStyle.',
        ),
        pitfall(
          'WidgetSpan baseline alignment uses placeholderAlignment',
          'A bare WidgetSpan defaults to PlaceholderAlignment.bottom, which often '
          'looks wrong next to glyphs. Use PlaceholderAlignment.middle for chips '
          'and pills, and PlaceholderAlignment.baseline (with a baseline: argument) '
          'when you want the widget\'s bottom to sit on the alphabetic baseline.',
        ),
        pitfall(
          'Long unbreakable spans can overflow',
          'A single TextSpan containing a long unbreakable token (a URL, a hash, '
          'an identifier) will not wrap and will trigger a layout overflow if the '
          'parent is constrained. Wrap such spans with softWrap-friendly characters, '
          'or break the token at known points (zero-width spaces, hyphens, slashes).',
        ),
      ],
    ),
  );

  // =================================================================
  // FOOTER
  // =================================================================
  final Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(28, 22, 28, 28),
    decoration: BoxDecoration(
      color: paperDeep,
      border: Border(top: BorderSide(color: inkSoft.withValues(alpha: 0.20), width: 1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'END OF FOUNDRY',
          style: labelStyle.copyWith(color: inkSoft),
        ),
        const SizedBox(height: 6),
        Text(
          'Eleven sections. Every span hand-authored. No loops, no random words.',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontStyle: FontStyle.italic,
            fontSize: 13,
            color: inkSoft,
          ),
        ),
      ],
    ),
  );

  // =================================================================
  // ASSEMBLY
  // =================================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'RichText Foundry',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: paperCream,
      textTheme: TextTheme(
        bodyMedium: baseProse,
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: accentBlue),
    ),
    home: Scaffold(
      backgroundColor: paperCream,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            header,
            heroWordmark,
            anatomy,
            treeSection,
            prose,
            codeSection,
            terminalSection,
            mathSection,
            widgetSpanSection,
            layoutSection,
            recognizerSection,
            pitfallSection,
            footer,
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// SMALL HELPERS
// =====================================================================
Widget _circleDot(Color color) {
  return Container(
    width: 12,
    height: 12,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.55),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    ),
  );
}
