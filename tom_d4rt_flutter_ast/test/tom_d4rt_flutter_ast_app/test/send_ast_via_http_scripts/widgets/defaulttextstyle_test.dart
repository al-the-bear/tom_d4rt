// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
// D4rt deep visual demo: DefaultTextStyle — inheritable default styling
// Covers: style, textAlign, softWrap, overflow, maxLines, textWidthBasis,
// textHeightBehavior, merge, fallback, DefaultTextStyle.of(context).
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

dynamic build(BuildContext context) {
  // ── Diagnostic context flag (uses foundation kReleaseMode) ─────────
  final bool isReleaseBuild = kReleaseMode;
  final DiagnosticsNode debugDescription =
      DiagnosticsProperty<bool>('isReleaseBuild', isReleaseBuild);
  final String diagSummary = debugDescription.toString();

  // ── Palette: Sage / Forest ─────────────────────────────────────────
  const deepForest = Color(0xFF0F2E1F);
  const mossGreen = Color(0xFF1F4A30);
  const sageGreen = Color(0xFF4A7A5C);
  const mistSage = Color(0xFF87A89A);
  const palePistachio = Color(0xFFBFD8C5);
  const creamMint = Color(0xFFE8F0E8);
  const ivory = Color(0xFFF7FAF6);
  const goldAccent = Color(0xFFB8860B);
  const rustContrast = Color(0xFFA0522D);
  const indigoContrast = Color(0xFF3F3B6A);
  const wineAccent = Color(0xFF6B2737);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 22, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: bg.withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 17)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12.5)),
            ),
        ],
      ),
    );
  }

  Widget noteBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: deepForest, height: 1.4)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 180,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(
                    fontSize: 13,
                    color: deepForest,
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget cardWrap(String label, Widget child, Color border) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: ivory,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: border.withValues(alpha: 0.18),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10)),
            ),
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: deepForest)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: child),
        ],
      ),
    );
  }

  Widget swatch(Color c, String label) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: deepForest.withValues(alpha: 0.2)),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 11,
              color: c.computeLuminance() < 0.5 ? ivory : deepForest,
              fontWeight: FontWeight.w600)),
    );
  }

  // ───────────────────────────────────────────────────────────────────
  // Title banner
  // ───────────────────────────────────────────────────────────────────
  final title = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [deepForest, mossGreen, sageGreen],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('DefaultTextStyle',
            style: TextStyle(
                color: ivory,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5)),
        const SizedBox(height: 6),
        Text(
            'Inheritable default text styling for descendant Text widgets',
            style: TextStyle(
                color: palePistachio,
                fontSize: 14,
                fontStyle: FontStyle.italic)),
        const SizedBox(height: 14),
        Wrap(
          children: [
            swatch(deepForest, 'deepForest'),
            swatch(mossGreen, 'mossGreen'),
            swatch(sageGreen, 'sageGreen'),
            swatch(mistSage, 'mistSage'),
            swatch(palePistachio, 'palePistachio'),
            swatch(creamMint, 'creamMint'),
            swatch(goldAccent, 'goldAccent'),
            swatch(rustContrast, 'rustContrast'),
          ],
        ),
      ],
    ),
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 1: Dossier
  // ───────────────────────────────────────────────────────────────────
  final dossier = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '1. Dossier',
          'Inheritable, ancestor-supplied default style for descendant Text widgets',
          deepForest,
          ivory),
      noteBox(
          'DefaultTextStyle is an inherited widget that supplies a default TextStyle '
          'and a bundle of layout-related text properties (textAlign, softWrap, overflow, '
          'maxLines, textWidthBasis, textHeightBehavior) to descendant Text widgets that do '
          'not explicitly set those values. The MaterialApp and Scaffold both insert a '
          'DefaultTextStyle near the root so most apps already have one ambient.',
          sageGreen,
          creamMint),
      noteBox(
          'Crucially, DefaultTextStyle is consulted ONLY when a Text widget does not '
          'supply its own value for the corresponding property. A Text(style: ...) is '
          'NOT layered on top of DefaultTextStyle automatically unless you also pass '
          'style: DefaultTextStyle.of(context).style.merge(localStyle) or use '
          'Text("…", style: ..., inherit: true).',
          rustContrast,
          ivory),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: creamMint,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: sageGreen.withValues(alpha: 0.4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quick facts',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: deepForest)),
            const SizedBox(height: 8),
            dataRow('Type', 'InheritedWidget (subclass)', mossGreen),
            dataRow('Library', 'package:flutter/widgets.dart', mossGreen),
            dataRow('Default in MaterialApp', 'Yes (Theme.of textTheme.body)',
                mossGreen),
            dataRow('Animatable variant', 'AnimatedDefaultTextStyle',
                mossGreen),
            dataRow('Affects', 'Text, RichText, ListTile labels, …',
                mossGreen),
            dataRow('Does NOT affect', 'TextSpan style on RichText directly',
                mossGreen),
            dataRow('Lookup helper', 'DefaultTextStyle.of(context)',
                mossGreen),
            dataRow('Merge helper', 'DefaultTextStyle.merge(...)', mossGreen),
            dataRow('Fallback constructor', 'DefaultTextStyle.fallback()',
                mossGreen),
          ],
        ),
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 2: Anatomy — every constructor parameter visualized
  // ───────────────────────────────────────────────────────────────────
  final paramStyle = cardWrap(
    'style — the TextStyle every descendant Text picks up',
    DefaultTextStyle(
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: mossGreen,
          letterSpacing: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('First descendant Text — no style:'),
          Text('Second descendant — also no style'),
          Text('Third descendant — also no style'),
        ],
      ),
    ),
    sageGreen,
  );

  final paramTextAlign = cardWrap(
    'textAlign — default horizontal alignment',
    DefaultTextStyle(
      style: TextStyle(fontSize: 14, color: deepForest),
      textAlign: TextAlign.center,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        color: palePistachio,
        child: const Text(
            'Centered by DefaultTextStyle.textAlign — Text supplies no align'),
      ),
    ),
    sageGreen,
  );

  final paramSoftWrap = cardWrap(
    'softWrap — whether long text wraps to a new line',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: creamMint,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 13, color: deepForest),
            softWrap: true,
            child: const Text(
                'softWrap=true: this long sentence will wrap onto multiple lines when '
                'it exceeds the available width of its container.'),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(8),
          color: palePistachio,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 13, color: deepForest),
            softWrap: false,
            overflow: TextOverflow.fade,
            child: const Text(
                'softWrap=false: this long sentence will not wrap and may be clipped at the right edge.'),
          ),
        ),
      ],
    ),
    sageGreen,
  );

  final paramOverflow = cardWrap(
    'overflow — how text is visually clipped when overflowing',
    DefaultTextStyle(
      style: TextStyle(fontSize: 13, color: deepForest),
      overflow: TextOverflow.ellipsis,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(8),
        color: creamMint,
        child: const Text(
            'overflow=ellipsis truncates the long content with an ellipsis at the end',
            maxLines: 1),
      ),
    ),
    sageGreen,
  );

  final paramMaxLines = cardWrap(
    'maxLines — clamp on how many lines a Text may render',
    DefaultTextStyle(
      style: TextStyle(fontSize: 13, color: deepForest, height: 1.4),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: creamMint,
        child: const Text(
            'Line one of a longer paragraph. Line two of a longer paragraph. '
            'Line three will be truncated because DefaultTextStyle.maxLines=2. '
            'Line four also drops out.'),
      ),
    ),
    sageGreen,
  );

  final paramTextWidthBasis = cardWrap(
    'textWidthBasis — parent vs longestLine',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          color: creamMint,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 13, color: deepForest),
            textWidthBasis: TextWidthBasis.parent,
            child: const Text('parent: text occupies the full parent width.'),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(6),
          color: palePistachio,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 13, color: deepForest),
            textWidthBasis: TextWidthBasis.longestLine,
            child: const Text('longestLine: width matches the longest line.'),
          ),
        ),
      ],
    ),
    sageGreen,
  );

  final paramTextHeightBehavior = cardWrap(
    'textHeightBehavior — first/last line height adjustments',
    DefaultTextStyle(
      style: TextStyle(fontSize: 14, height: 2.0, color: deepForest),
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
        applyHeightToLastDescent: false,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        color: creamMint,
        child: const Text(
            'Two lines of text where the leading above the first ascent and '
            'below the last descent is suppressed by TextHeightBehavior.'),
      ),
    ),
    sageGreen,
  );

  final anatomy = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner('2. Anatomy', 'Every constructor parameter, visualized',
          mossGreen, ivory),
      paramStyle,
      paramTextAlign,
      paramSoftWrap,
      paramOverflow,
      paramMaxLines,
      paramTextWidthBasis,
      paramTextHeightBehavior,
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 3: Recipes
  // ───────────────────────────────────────────────────────────────────
  Widget headingDemo(String levelName, double size, FontWeight weight,
      Color color) {
    return DefaultTextStyle(
      style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
          letterSpacing: -0.3,
          height: 1.15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text('$levelName — Sample Heading at $size px'),
      ),
    );
  }

  final recipeHeadings = cardWrap(
    'Recipe: theme heading H1–H6 via DefaultTextStyle',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headingDemo('H1', 32, FontWeight.w800, deepForest),
        headingDemo('H2', 26, FontWeight.w700, mossGreen),
        headingDemo('H3', 22, FontWeight.w700, sageGreen),
        headingDemo('H4', 18, FontWeight.w600, sageGreen),
        headingDemo('H5', 15, FontWeight.w600, mistSage),
        headingDemo('H6', 13, FontWeight.w600, mistSage),
      ],
    ),
    deepForest,
  );

  final recipeBodyCaption = cardWrap(
    'Recipe: body and caption inheritance',
    DefaultTextStyle(
      style: TextStyle(
          fontSize: 14, color: deepForest, height: 1.5, letterSpacing: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
              'This is body text supplied by the ambient DefaultTextStyle. '
              'Every line in this column inherits the same family, size, color, '
              'line-height, and letter-spacing without repeating the TextStyle.'),
          const SizedBox(height: 10),
          DefaultTextStyle.merge(
            style: TextStyle(
                fontSize: 11,
                color: mistSage,
                fontStyle: FontStyle.italic,
                letterSpacing: 0.2),
            child: const Text(
                '— caption: rendered by a merged child DefaultTextStyle that overrides '
                'size, color, style, and letter-spacing while inheriting height from above.'),
          ),
        ],
      ),
    ),
    mossGreen,
  );

  final recipeChatBubble = cardWrap(
    'Recipe: chat bubble theming',
    Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 260),
            margin: const EdgeInsets.only(bottom: 8),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: palePistachio,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 14, color: deepForest, height: 1.35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Did the deploy finish?'),
                  SizedBox(height: 4),
                  Text('I am about to head out for lunch.'),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 260),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: mossGreen,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 14, color: ivory, height: 1.35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('Yes, all green.'),
                  SizedBox(height: 4),
                  Text('Enjoy your lunch.'),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
    sageGreen,
  );

  Widget tableCol(String header, List<String> rows, double width,
      TextAlign align, Color headerBg) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 6),
            color: headerBg,
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: ivory,
                  letterSpacing: 0.4),
              textAlign: align,
              child: Text(header),
            ),
          ),
          for (final r in rows)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color:
                            mistSage.withValues(alpha: 0.5))),
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                    fontSize: 12,
                    color: deepForest,
                    fontFamily: 'monospace'),
                textAlign: align,
                child: Text(r),
              ),
            ),
        ],
      ),
    );
  }

  final recipeDashboardTable = cardWrap(
    'Recipe: dashboard table column styles (per-column DefaultTextStyle)',
    SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          tableCol('SYMBOL', const ['AAPL', 'GOOG', 'TSLA', 'MSFT'], 90,
              TextAlign.left, deepForest),
          tableCol('PRICE',
              const ['188.42', '143.10', '241.75', '378.22'], 110,
              TextAlign.right, mossGreen),
          tableCol('Δ %',
              const ['+1.42', '-0.31', '+3.10', '+0.88'], 90,
              TextAlign.right, sageGreen),
          tableCol('VOL',
              const ['52.1M', '21.7M', '88.4M', '33.9M'], 90,
              TextAlign.right, mossGreen),
        ],
      ),
    ),
    deepForest,
  );

  final recipeDialog = cardWrap(
    'Recipe: dialog title vs content default styles',
    Container(
      decoration: BoxDecoration(
        color: ivory,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: mistSage.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: deepForest,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ivory),
              child: const Text('Confirm deletion'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 13.5,
                  color: deepForest,
                  height: 1.45),
              child: const Text(
                  'Are you sure you want to delete this record? '
                  'This action cannot be undone and all associated history '
                  'will be permanently removed.'),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: rustContrast,
                  letterSpacing: 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('CANCEL'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('DELETE'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    mossGreen,
  );

  final recipeFallback = cardWrap(
    'Recipe: DefaultTextStyle.fallback() — safe default when none ancestor exists',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        noteBox(
            'DefaultTextStyle.fallback() returns a const DefaultTextStyle with '
            'an empty TextStyle and standard defaults. It is the value returned '
            'by DefaultTextStyle.of(context) when no ancestor is found and is '
            'safe to use as a baseline to merge against.',
            sageGreen,
            creamMint),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: creamMint,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Builder(
            builder: (BuildContext ctx) {
              final DefaultTextStyle base = DefaultTextStyle.of(ctx);
              return DefaultTextStyle(
                style: base.style.merge(TextStyle(
                    fontSize: 14,
                    color: deepForest,
                    fontWeight: FontWeight.w500)),
                child: const Text(
                    'Style merged on top of ambient DefaultTextStyle.of(context).'),
              );
            },
          ),
        ),
      ],
    ),
    sageGreen,
  );

  final recipes = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '3. Recipes',
          'Real-world DefaultTextStyle patterns: headings, body, captions, chat, tables, dialogs, fallback',
          sageGreen,
          ivory),
      recipeHeadings,
      recipeBodyCaption,
      recipeChatBubble,
      recipeDashboardTable,
      recipeDialog,
      recipeFallback,
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 4: DefaultTextStyle.merge demonstration
  // ───────────────────────────────────────────────────────────────────
  final mergeBaseExample = cardWrap(
    'Merge: parent style + child overrides',
    DefaultTextStyle(
      style: TextStyle(
          fontSize: 14,
          color: deepForest,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.2,
          height: 1.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Parent style: size 14, deepForest, weight 400'),
          const SizedBox(height: 8),
          DefaultTextStyle.merge(
            style: TextStyle(
                color: rustContrast, fontWeight: FontWeight.w700),
            child: const Text(
                'Merged: inherits size & spacing, overrides color & weight'),
          ),
          const SizedBox(height: 8),
          DefaultTextStyle.merge(
            style: TextStyle(
                fontStyle: FontStyle.italic, color: indigoContrast),
            child: const Text(
                'Merged: still size 14 & weight 400, but italic & indigo'),
          ),
          const SizedBox(height: 8),
          DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 18),
            child: DefaultTextStyle.merge(
              style: TextStyle(
                  color: goldAccent, fontWeight: FontWeight.w700),
              child: const Text(
                  'Nested merges: size 18 (inner merge), gold + bold'),
            ),
          ),
        ],
      ),
    ),
    mossGreen,
  );

  final mergeOverridesTable = cardWrap(
    'Merge: which properties override and which inherit',
    Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: creamMint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataRow('Parent property', 'Child merge result', mossGreen),
          dataRow('style.fontSize=14',
              'inherited unless child sets fontSize', sageGreen),
          dataRow('style.color=deepForest',
              'inherited unless child sets color', sageGreen),
          dataRow('style.fontWeight=w400',
              'inherited unless child sets fontWeight', sageGreen),
          dataRow('textAlign=start',
              'inherited unless child passes textAlign', sageGreen),
          dataRow('softWrap=true',
              'inherited unless child passes softWrap', sageGreen),
          dataRow('overflow=clip',
              'inherited unless child passes overflow', sageGreen),
          dataRow('maxLines=null',
              'inherited unless child passes maxLines', sageGreen),
        ],
      ),
    ),
    mossGreen,
  );

  final mergeLayered = cardWrap(
    'Merge: three layers of style merging',
    DefaultTextStyle(
      style: TextStyle(
          fontSize: 13, color: deepForest, fontFamily: 'serif'),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: creamMint,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Layer 1 (root): size 13, deepForest, serif'),
            DefaultTextStyle.merge(
              style: TextStyle(color: mossGreen, letterSpacing: 0.6),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Layer 2: + mossGreen + letterSpacing 0.6'),
                    DefaultTextStyle.merge(
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                          decorationColor: goldAccent,
                          decorationThickness: 2),
                      child: const Text(
                          'Layer 3: + bold + underline (gold thick)'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    sageGreen,
  );

  final mergeSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '4. DefaultTextStyle.merge',
          'Combine an ancestor style with child overrides without replacing it wholesale',
          sageGreen,
          ivory),
      noteBox(
          'DefaultTextStyle.merge is a static convenience constructor that wraps '
          'its child in a new DefaultTextStyle whose style is the ancestor style '
          'merged with the provided style. textAlign, softWrap, overflow, '
          'maxLines and textWidthBasis fall back to the ancestor values when not '
          'supplied. Use merge when you want to extend the inherited style, not '
          'replace it.',
          sageGreen,
          creamMint),
      mergeBaseExample,
      mergeOverridesTable,
      mergeLayered,
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 5: TextOverflow modes panel
  // ───────────────────────────────────────────────────────────────────
  Widget overflowCard(String name, TextOverflow mode, String description,
      Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: ivory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: accent.withValues(alpha: 0.18),
            child: Text(name,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: deepForest)),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 240,
                  height: 36,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: creamMint,
                    border:
                        Border.all(color: accent.withValues(alpha: 0.5)),
                  ),
                  child: DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 13, color: deepForest),
                    overflow: mode,
                    softWrap: false,
                    child: const Text(
                        'A long single line of text that exceeds the box width.',
                        maxLines: 1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(description,
                    style: TextStyle(
                        fontSize: 11,
                        color: mistSage,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final overflowPanel = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '5. TextOverflow modes',
          'clip / fade / ellipsis / visible — visual comparison',
          mossGreen,
          ivory),
      overflowCard(
          'TextOverflow.clip',
          TextOverflow.clip,
          'Hard cut at the box boundary, no indicator.',
          mossGreen),
      overflowCard(
          'TextOverflow.fade',
          TextOverflow.fade,
          'Soft fade-out gradient at the edge.',
          sageGreen),
      overflowCard(
          'TextOverflow.ellipsis',
          TextOverflow.ellipsis,
          'Truncates and inserts an … glyph at the end.',
          rustContrast),
      overflowCard(
          'TextOverflow.visible',
          TextOverflow.visible,
          'Text is allowed to draw past the bounding box (may overlap).',
          goldAccent),
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 6: softWrap true vs false
  // ───────────────────────────────────────────────────────────────────
  final softWrapComparison = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '6. softWrap true vs false',
          'Whether descendant Text widgets wrap at the right edge',
          sageGreen,
          ivory),
      cardWrap(
        'softWrap: true (default)',
        Container(
          padding: const EdgeInsets.all(8),
          color: creamMint,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 13, color: deepForest),
            softWrap: true,
            child: const Text(
                'When softWrap is true, this paragraph wraps onto as many '
                'lines as needed to render every word inside the available '
                'width. This is the natural behavior for body text.'),
          ),
        ),
        sageGreen,
      ),
      cardWrap(
        'softWrap: false (single line, with fade)',
        Container(
          padding: const EdgeInsets.all(8),
          color: palePistachio,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 13, color: deepForest),
            softWrap: false,
            overflow: TextOverflow.fade,
            child: const Text(
                'When softWrap is false, the text stays on one line and '
                'whatever does not fit is handled by the overflow setting — '
                'here a soft fade.'),
          ),
        ),
        rustContrast,
      ),
      cardWrap(
        'softWrap: false (single line, with ellipsis)',
        Container(
          padding: const EdgeInsets.all(8),
          color: palePistachio,
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 13, color: deepForest),
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            child: const Text(
                'softWrap=false combined with overflow=ellipsis is a common '
                'choice for compact list items and table cells.',
                maxLines: 1),
          ),
        ),
        rustContrast,
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 7: maxLines grid (1..5)
  // ───────────────────────────────────────────────────────────────────
  Widget maxLinesCell(int n) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ivory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sageGreen),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 6, vertical: 3),
            color: deepForest,
            child: Text('maxLines: $n',
                style: TextStyle(
                    color: ivory,
                    fontSize: 11,
                    fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 220,
            child: DefaultTextStyle(
              style:
                  TextStyle(fontSize: 12, color: deepForest, height: 1.35),
              maxLines: n,
              overflow: TextOverflow.ellipsis,
              child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Sed do eiusmod tempor incididunt ut labore et dolore '
                  'magna aliqua. Ut enim ad minim veniam, quis nostrud '
                  'exercitation ullamco laboris nisi ut aliquip ex ea '
                  'commodo consequat. Duis aute irure dolor in reprehenderit.'),
            ),
          ),
        ],
      ),
    );
  }

  final maxLinesGrid = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '7. maxLines grid',
          'How DefaultTextStyle.maxLines clamps descendant Text',
          mossGreen,
          ivory),
      Wrap(
        children: [
          maxLinesCell(1),
          maxLinesCell(2),
          maxLinesCell(3),
          maxLinesCell(4),
          maxLinesCell(5),
        ],
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 8: TextWidthBasis comparison
  // ───────────────────────────────────────────────────────────────────
  Widget basisCard(String name, TextWidthBasis basis, String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ivory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sageGreen),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: deepForest)),
          const SizedBox(height: 6),
          Container(
            color: creamMint,
            padding: const EdgeInsets.all(6),
            child: DefaultTextStyle(
              style:
                  TextStyle(fontSize: 13, color: deepForest, height: 1.3),
              textWidthBasis: basis,
              textAlign: TextAlign.center,
              child: const Text(
                  'A short line\nand a much longer second line of content.'),
            ),
          ),
          const SizedBox(height: 4),
          Text(hint,
              style: TextStyle(
                  fontSize: 11,
                  color: mistSage,
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  final textWidthBasisSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '8. TextWidthBasis',
          'parent vs longestLine — sizing of the text box',
          sageGreen,
          ivory),
      basisCard('TextWidthBasis.parent', TextWidthBasis.parent,
          'Text occupies the full parent width; centering uses parent extent.'),
      basisCard('TextWidthBasis.longestLine', TextWidthBasis.longestLine,
          'Box shrinks to the longest line; centering is within that narrower box.'),
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 9: TextHeightBehavior comparison
  // ───────────────────────────────────────────────────────────────────
  Widget heightBehaviorCard(String name, TextHeightBehavior behavior,
      String hint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ivory,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: mossGreen),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: deepForest)),
          const SizedBox(height: 6),
          Container(
            color: creamMint,
            padding: const EdgeInsets.all(6),
            child: DefaultTextStyle(
              style: TextStyle(
                  fontSize: 14, color: deepForest, height: 2.0),
              textHeightBehavior: behavior,
              child: const Text(
                  'Line one with height 2.0.\nLine two with height 2.0.\nLine three with height 2.0.'),
            ),
          ),
          const SizedBox(height: 4),
          Text(hint,
              style: TextStyle(
                  fontSize: 11,
                  color: mistSage,
                  fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }

  final textHeightBehaviorSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '9. TextHeightBehavior',
          'Suppressing leading on first ascent / last descent',
          mossGreen,
          ivory),
      heightBehaviorCard(
          'Default (both true)',
          const TextHeightBehavior(),
          'Leading applied above first ascent and below last descent.'),
      heightBehaviorCard(
          'applyHeightToFirstAscent: false',
          const TextHeightBehavior(applyHeightToFirstAscent: false),
          'No leading above the first line — useful for top-aligned headings.'),
      heightBehaviorCard(
          'applyHeightToLastDescent: false',
          const TextHeightBehavior(applyHeightToLastDescent: false),
          'No leading below the last line — useful when stacking blocks.'),
      heightBehaviorCard(
          'Both suppressed',
          const TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false),
          'Tightest vertical packing; only inter-line leading remains.'),
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 10: Comparison vs RichText vs Text(style:…)
  // ───────────────────────────────────────────────────────────────────
  final comparison = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '10. DefaultTextStyle vs RichText vs Text(style:…)',
          'When to use which mechanism',
          sageGreen,
          ivory),
      cardWrap(
        'DefaultTextStyle — broadcast a default to many descendants',
        DefaultTextStyle(
          style: TextStyle(
              fontSize: 14, color: mossGreen, fontWeight: FontWeight.w600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Descendant A inherits the default'),
              Text('Descendant B inherits the default'),
              Text('Descendant C inherits the default'),
            ],
          ),
        ),
        sageGreen,
      ),
      cardWrap(
        'Text(style:…) — explicit, scoped style',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Explicit only on this Text',
                style: TextStyle(
                    fontSize: 14,
                    color: mossGreen,
                    fontWeight: FontWeight.w600)),
            const Text(
                'Other Text widgets use whatever ambient default is in effect'),
          ],
        ),
        rustContrast,
      ),
      cardWrap(
        'RichText — fully manual TextSpan tree, no inheritance',
        RichText(
          text: TextSpan(
            text: 'RichText does ',
            style: TextStyle(
                fontSize: 14,
                color: deepForest,
                fontWeight: FontWeight.w500),
            children: <TextSpan>[
              TextSpan(
                text: 'NOT ',
                style: TextStyle(
                    color: rustContrast, fontWeight: FontWeight.w800),
              ),
              const TextSpan(
                  text:
                      'consult the ambient DefaultTextStyle. Every span needs an explicit style.'),
            ],
          ),
        ),
        goldAccent,
      ),
      noteBox(
          'Rule of thumb: use DefaultTextStyle for theming a subtree, '
          'Text.rich + Text.style for a single-paragraph mix of styles, '
          'and RichText only when you need to control every span yourself '
          '(e.g. WidgetSpan-heavy content).',
          mossGreen,
          creamMint),
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 11: Common pitfalls
  // ───────────────────────────────────────────────────────────────────
  final pitfalls = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '11. Common pitfalls',
          'Things that surprise newcomers to DefaultTextStyle',
          rustContrast,
          ivory),
      noteBox(
          'Pitfall 1 — Must be an ancestor. DefaultTextStyle uses '
          'InheritedWidget lookup; sibling widgets are not affected. '
          'Wrap the subtree whose Text widgets should inherit, not the '
          'whole parent or you will inherit unintended Text widgets.',
          rustContrast,
          ivory),
      noteBox(
          'Pitfall 2 — Will not override Text(style: …). If a Text widget '
          'passes its own style, the explicit style replaces (or merges '
          'partially with) the ambient style. To enforce a default, omit '
          'style on the Text widget or set Text(style: ..., inherit: true) '
          'so unspecified fields fall back.',
          rustContrast,
          ivory),
      noteBox(
          'Pitfall 3 — RichText is opaque. DefaultTextStyle is consulted '
          'by Text and Text.rich, but RichText receives a raw TextSpan tree '
          'and never auto-merges. If you need RichText to follow the ambient '
          'style, read DefaultTextStyle.of(context).style yourself.',
          rustContrast,
          ivory),
      noteBox(
          'Pitfall 4 — MaterialApp already inserts one. Calling '
          'DefaultTextStyle.of(context) inside MaterialApp returns the '
          'theme-derived style, not DefaultTextStyle.fallback(). When '
          'merging, you are extending the theme, not replacing it.',
          rustContrast,
          ivory),
      noteBox(
          'Pitfall 5 — softWrap=false without overflow gives clipped '
          'glyphs. Always pair softWrap=false with an explicit overflow '
          'mode (ellipsis, fade, clip) to control the visual result.',
          rustContrast,
          ivory),
      noteBox(
          'Pitfall 6 — maxLines on the wrapper is silent for Text widgets '
          'that pass their own maxLines. Always check both ancestor and '
          'descendant for conflicting values when debugging truncation.',
          rustContrast,
          ivory),
      noteBox(
          'Pitfall 7 — AnimatedDefaultTextStyle is the animated cousin '
          'and is required if you want size/color transitions; a plain '
          'DefaultTextStyle change snaps to the new style on the next '
          'frame with no interpolation.',
          rustContrast,
          ivory),
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 12: Glossary
  // ───────────────────────────────────────────────────────────────────
  Widget glossaryEntry(String term, String def) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: creamMint,
        borderRadius: BorderRadius.circular(6),
        border: Border(
            left: BorderSide(color: sageGreen, width: 3)),
      ),
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: '$term — ',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: deepForest)),
            TextSpan(
                text: def,
                style: TextStyle(
                    fontSize: 12, color: deepForest, height: 1.35)),
          ],
        ),
      ),
    );
  }

  final glossary = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '12. Glossary',
          'Key terms appearing in this demo',
          mossGreen,
          ivory),
      glossaryEntry('DefaultTextStyle',
          'Inherited widget that supplies default text properties to descendants.'),
      glossaryEntry('TextStyle',
          'Immutable description of font family, weight, size, color, decoration, etc.'),
      glossaryEntry('textAlign',
          'Default horizontal alignment of paragraphs inside a Text widget.'),
      glossaryEntry('softWrap',
          'Whether overflow text wraps to a new line at the right edge.'),
      glossaryEntry('overflow',
          'How text is visually handled when it does not fit (clip/fade/ellipsis/visible).'),
      glossaryEntry('maxLines',
          'Maximum lines a Text widget may render before being truncated.'),
      glossaryEntry('TextWidthBasis',
          'Whether width is the parent extent or the longest measured line.'),
      glossaryEntry('TextHeightBehavior',
          'Per-text policy for applying line-height leading on first / last lines.'),
      glossaryEntry('DefaultTextStyle.merge',
          'Static helper that wraps a child in a DefaultTextStyle whose style is parent.merge(extra).'),
      glossaryEntry('DefaultTextStyle.fallback',
          'Const constructor returning a baseline default with empty TextStyle.'),
      glossaryEntry('DefaultTextStyle.of',
          'Static method that returns the nearest ancestor DefaultTextStyle (or the fallback).'),
      glossaryEntry('InheritedWidget',
          'Flutter framework primitive for top-down propagation of values via O(1) lookup.'),
      glossaryEntry('RichText',
          'Lower-level widget rendering a TextSpan tree; does NOT consult DefaultTextStyle.'),
      glossaryEntry('AnimatedDefaultTextStyle',
          'Animated cousin that interpolates between style values over a duration.'),
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // SECTION 13: Recap
  // ───────────────────────────────────────────────────────────────────
  Widget recapPoint(String n, String t, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color, shape: BoxShape.circle),
            child: Text(n,
                style: TextStyle(
                    color: ivory,
                    fontSize: 12,
                    fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(t,
                style: TextStyle(
                    fontSize: 13, color: deepForest, height: 1.4)),
          ),
        ],
      ),
    );
  }

  final recap = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      sectionBanner(
          '13. Recap',
          'Six things to remember about DefaultTextStyle',
          deepForest,
          ivory),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: creamMint,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: sageGreen.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            recapPoint('1',
                'DefaultTextStyle broadcasts a default TextStyle and text-layout '
                'properties to descendant Text widgets.',
                deepForest),
            recapPoint('2',
                'It only applies when descendants do NOT override the corresponding '
                'property — explicit Text(style: …) wins.',
                mossGreen),
            recapPoint('3',
                'Use DefaultTextStyle.merge to extend ancestor style instead of '
                'replacing it; nested merges compose cleanly.',
                sageGreen),
            recapPoint('4',
                'softWrap, overflow, and maxLines compose as a layout triad; '
                'do not set one without thinking about the others.',
                rustContrast),
            recapPoint('5',
                'RichText does NOT consult DefaultTextStyle. Reach for Text or '
                'Text.rich whenever you want the ambient default to apply.',
                goldAccent),
            recapPoint('6',
                'For animated style changes use AnimatedDefaultTextStyle; a '
                'plain DefaultTextStyle change snaps instantly.',
                indigoContrast),
          ],
        ),
      ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [deepForest, mossGreen],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('End of dossier',
                style: TextStyle(
                    color: ivory,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
                'You have now seen every constructor parameter of DefaultTextStyle, '
                'its merge & fallback helpers, comparison against RichText and '
                'Text(style:…), and the common pitfalls that arise in real code.',
                style: TextStyle(
                    color: palePistachio, fontSize: 12, height: 1.4)),
          ],
        ),
      ),
    ],
  );

  // ───────────────────────────────────────────────────────────────────
  // Assemble final report
  // ───────────────────────────────────────────────────────────────────
  return Container(
    color: ivory,
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        title,
        dossier,
        anatomy,
        recipes,
        mergeSection,
        overflowPanel,
        softWrapComparison,
        maxLinesGrid,
        textWidthBasisSection,
        textHeightBehaviorSection,
        comparison,
        pitfalls,
        glossary,
        recap,
      ],
    ),
  );
}
