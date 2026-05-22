// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for dart:ui BoxWidthStyle (and its
// inseparable companion BoxHeightStyle). The two enums together control how
// text selection / highlight rectangles are sized around laid-out glyphs.
//
// Design plan (overview of the file structure):
//   Section 1 -- Header banner: a gradient hero card naming the enums and
//                summarising what they govern in the painting pipeline.
//   Section 2 -- Anatomy of a selection rect: annotated diagram-cards that
//                break down "where does the rectangle come from" for tight
//                vs max widths, and tight/includeLineSpacing* for heights.
//   Section 3 -- Side-by-side comparison grid: identical TextSpans painted
//                with .tight and .max width styles, plus a TextStyle.height
//                sweep (1.0, 1.4, 1.8, 2.4) to show how line height changes
//                the gap that 'max' fills but 'tight' leaves blank.
//   Section 4 -- Multi-line selections: paragraphs with line breaks, the
//                same selection rendered with both width styles, showing how
//                'max' yields a contiguous block highlight (good for search
//                hits) while 'tight' leaves jagged right edges (good for
//                precise glyph hugging).
//   Section 5 -- Edge cases: empty lines, trailing whitespace, mixed scripts
//                in a single span, and TextSpans with nested children. Each
//                edge case is shown with both width styles and a caption.
//   Section 6 -- Recipes & glossary: ready-to-copy TextSpan recipes for
//                highlighted code blocks, search-result snippets, citation
//                styling, plus a closing glossary table of all enum values
//                and the painter-level terms (line metrics, run, leading).
//
// All sections render real Flutter widgets (Containers, Wraps, Rows, Text /
// RichText / Text.rich). Material 3 ColorScheme idioms are used: we read
// primary, secondary, tertiary, error and their *Container variants for
// surfaces. No emoji anywhere in code or comments -- plain ASCII narrative.
//
// IMPORTANT painter note: this file does NOT call dart:ui Paragraph APIs
// directly (D4rt-AST cannot drive low-level engine paragraphs). Instead we
// simulate the visual effect of tight vs max highlight rectangles using
// nested Containers behind a Text widget. That mirrors what the framework
// does internally when it paints selection highlights via the enums.

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Root widget
// ---------------------------------------------------------------------------

class BoxWidthStyleDemoApp extends StatelessWidget {
  const BoxWidthStyleDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoxWidthStyle / BoxHeightStyle Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF5B6CFF),
        brightness: Brightness.light,
      ),
      home: const _DemoScaffold(),
    );
  }
}

class _DemoScaffold extends StatelessWidget {
  const _DemoScaffold();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _HeaderBanner(),
            const SizedBox(height: 28.0),
            const _SectionTitle(number: 1, title: 'Header & framing'),
            const _IntroParagraph(),
            const SizedBox(height: 32.0),
            const _SectionTitle(
              number: 2,
              title: 'Anatomy of a selection rect',
            ),
            const _AnatomySection(),
            const SizedBox(height: 32.0),
            const _SectionTitle(
              number: 3,
              title: 'Tight vs max -- a controlled grid',
            ),
            const _ComparisonGrid(),
            const SizedBox(height: 32.0),
            const _SectionTitle(
              number: 4,
              title: 'Multi-line selections',
            ),
            const _MultiLineSection(),
            const SizedBox(height: 32.0),
            const _SectionTitle(
              number: 5,
              title: 'Edge cases: empty, trailing, mixed',
            ),
            const _EdgeCasesSection(),
            const SizedBox(height: 32.0),
            const _SectionTitle(
              number: 6,
              title: 'Recipes & glossary',
            ),
            const _RecipesSection(),
            const SizedBox(height: 16.0),
            const _Glossary(),
            const SizedBox(height: 40.0),
            const _FooterCard(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header banner (gradient hero)
// ---------------------------------------------------------------------------

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    print('=== Section 1: Header & framing ===');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary,
            scheme.secondary,
            scheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.35),
            blurRadius: 22.0,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: scheme.onPrimary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Icon(
                  Icons.format_color_fill,
                  size: 38.0,
                  color: scheme.onPrimary,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'BoxWidthStyle  +  BoxHeightStyle',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w800,
                        color: scheme.onPrimary,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'How dart:ui sizes the boxes that highlight your text',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: scheme.onPrimary.withValues(alpha: 0.9),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: <Widget>[
              _Pill(
                label: 'enum BoxWidthStyle',
                fg: scheme.onPrimary,
                bg: scheme.onPrimary.withValues(alpha: 0.18),
              ),
              _Pill(
                label: 'tight',
                fg: scheme.onPrimary,
                bg: scheme.onPrimary.withValues(alpha: 0.28),
              ),
              _Pill(
                label: 'max',
                fg: scheme.onPrimary,
                bg: scheme.onPrimary.withValues(alpha: 0.28),
              ),
              _Pill(
                label: 'pairs with BoxHeightStyle',
                fg: scheme.onPrimary,
                bg: scheme.onPrimary.withValues(alpha: 0.18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.fg, required this.bg});

  final String label;
  final Color fg;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: fg,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared section title
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.number, required this.title});

  final int number;
  final String title;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: scheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
          Container(
            height: 2.0,
            width: 60.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[scheme.primary, scheme.tertiary],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroParagraph extends StatelessWidget {
  const _IntroParagraph();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Why these enums exist',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'When Flutter paints a selection highlight, a TextSpan background, '
            'or a search result marker, it asks dart:ui for a list of rects '
            'covering the matched glyph range. BoxWidthStyle controls the '
            'horizontal extent of each line-segment rect, and BoxHeightStyle '
            'controls the vertical extent. tight hugs the glyphs; max '
            'stretches each segment to the full line width or full line '
            'height, producing the contiguous block look familiar from code '
            'editors and search panels.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2: Anatomy
// ---------------------------------------------------------------------------

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    print('=== Section 2: Anatomy of a selection rect ===');
    return Column(
      children: const <Widget>[
        _AnatomyCard(
          title: 'Width: tight',
          subtitle:
              'Right edge of each segment ends exactly at the last glyph in the run.',
          accent: _AccentSlot.primary,
          icon: Icons.text_fields,
          widthStyle: _SimulatedBoxWidthStyle.tight,
        ),
        SizedBox(height: 14.0),
        _AnatomyCard(
          title: 'Width: max',
          subtitle:
              'Right edge of each segment extends to the line width, filling trailing whitespace.',
          accent: _AccentSlot.secondary,
          icon: Icons.wrap_text,
          widthStyle: _SimulatedBoxWidthStyle.max,
        ),
        SizedBox(height: 14.0),
        _AnatomyCard(
          title: 'Height pairing',
          subtitle:
              'BoxHeightStyle.tight uses ascent+descent; .max fills the entire line box including leading.',
          accent: _AccentSlot.tertiary,
          icon: Icons.height,
          widthStyle: _SimulatedBoxWidthStyle.max,
        ),
      ],
    );
  }
}

enum _SimulatedBoxWidthStyle { tight, max }

enum _AccentSlot { primary, secondary, tertiary, error }

class _AnatomyCard extends StatelessWidget {
  const _AnatomyCard({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.icon,
    required this.widthStyle,
  });

  final String title;
  final String subtitle;
  final _AccentSlot accent;
  final IconData icon;
  final _SimulatedBoxWidthStyle widthStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accentBg = _containerOf(scheme, accent);
    final accentFg = _onContainerOf(scheme, accent);
    final highlight = _accentOf(scheme, accent).withValues(alpha: 0.28);

    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: accentBg,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: _accentOf(scheme, accent).withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: _accentOf(scheme, accent).withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: accentFg, size: 22.0),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: accentFg,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.4,
                    color: accentFg.withValues(alpha: 0.85),
                  ),
                ),
                const SizedBox(height: 14.0),
                _SimulatedHighlight(
                  text: 'select this run',
                  trailing: '          ',
                  widthStyle: widthStyle,
                  highlight: highlight,
                  textColor: accentFg,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Color _accentOf(ColorScheme scheme, _AccentSlot a) {
  switch (a) {
    case _AccentSlot.primary:
      return scheme.primary;
    case _AccentSlot.secondary:
      return scheme.secondary;
    case _AccentSlot.tertiary:
      return scheme.tertiary;
    case _AccentSlot.error:
      return scheme.error;
  }
}

Color _containerOf(ColorScheme scheme, _AccentSlot a) {
  switch (a) {
    case _AccentSlot.primary:
      return scheme.primaryContainer;
    case _AccentSlot.secondary:
      return scheme.secondaryContainer;
    case _AccentSlot.tertiary:
      return scheme.tertiaryContainer;
    case _AccentSlot.error:
      return scheme.errorContainer;
  }
}

Color _onContainerOf(ColorScheme scheme, _AccentSlot a) {
  switch (a) {
    case _AccentSlot.primary:
      return scheme.onPrimaryContainer;
    case _AccentSlot.secondary:
      return scheme.onSecondaryContainer;
    case _AccentSlot.tertiary:
      return scheme.onTertiaryContainer;
    case _AccentSlot.error:
      return scheme.onErrorContainer;
  }
}

// _SimulatedHighlight paints a Text inside a box whose width either hugs the
// text (tight) or fills the parent (max). The trailing parameter represents
// whitespace that BoxWidthStyle.tight would *exclude* from the highlight but
// BoxWidthStyle.max *includes*.
class _SimulatedHighlight extends StatelessWidget {
  const _SimulatedHighlight({
    required this.text,
    required this.trailing,
    required this.widthStyle,
    required this.highlight,
    required this.textColor,
  });

  final String text;
  final String trailing;
  final _SimulatedBoxWidthStyle widthStyle;
  final Color highlight;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final isMax = widthStyle == _SimulatedBoxWidthStyle.max;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Stack(
        children: <Widget>[
          // The simulated highlight rectangle behind the glyphs.
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: isMax ? 1.0 : 0.62,
                child: Container(
                  decoration: BoxDecoration(
                    color: highlight,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 6.0,
              vertical: 4.0,
            ),
            child: Text(
              '$text$trailing',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 16.0,
                height: 1.4,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3: Comparison grid
// ---------------------------------------------------------------------------

class _ComparisonGrid extends StatelessWidget {
  const _ComparisonGrid();

  @override
  Widget build(BuildContext context) {
    print('=== Section 3: Tight vs max -- a controlled grid ===');
    final scheme = Theme.of(context).colorScheme;
    // Sweep TextStyle.height values. We will show the same span paired with
    // BoxWidthStyle.tight and BoxWidthStyle.max for each height.
    const heights = <double>[1.0, 1.4, 1.8, 2.4];

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _GridLegend(),
          const SizedBox(height: 14.0),
          for (final h in heights) ...<Widget>[
            _GridRow(textHeight: h),
            const SizedBox(height: 12.0),
          ],
          const SizedBox(height: 4.0),
          const _GridFootnote(),
        ],
      ),
    );
  }
}

class _GridLegend extends StatelessWidget {
  const _GridLegend();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'TextStyle.height',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
              fontSize: 13.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: _LegendBadge(
                  label: 'BoxWidthStyle.tight',
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _LegendBadge(
                  label: 'BoxWidthStyle.max',
                  color: scheme.tertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LegendBadge extends StatelessWidget {
  const _LegendBadge({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridRow extends StatelessWidget {
  const _GridRow({required this.textHeight});

  final double textHeight;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 6.0,
            ),
            decoration: BoxDecoration(
              color: scheme.secondaryContainer,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'height: $textHeight',
              style: TextStyle(
                fontFamily: 'monospace',
                color: scheme.onSecondaryContainer,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          flex: 3,
          child: Row(
            children: <Widget>[
              Expanded(
                child: _GridCell(
                  textHeight: textHeight,
                  widthStyle: _SimulatedBoxWidthStyle.tight,
                  color: scheme.primary,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _GridCell(
                  textHeight: textHeight,
                  widthStyle: _SimulatedBoxWidthStyle.max,
                  color: scheme.tertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({
    required this.textHeight,
    required this.widthStyle,
    required this.color,
  });

  final double textHeight;
  final _SimulatedBoxWidthStyle widthStyle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isMax = widthStyle == _SimulatedBoxWidthStyle.max;
    return Container(
      height: 56.0,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: isMax ? 1.0 : 0.55,
                heightFactor: 0.7,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.28),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'highlight',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14.0,
                  height: textHeight,
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridFootnote extends StatelessWidget {
  const _GridFootnote();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.lightbulb_outline,
            size: 18.0,
            color: scheme.onTertiaryContainer,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'As TextStyle.height grows, the gap between the glyph bounds '
              'and the line box grows too. BoxHeightStyle.tight stays glued '
              'to the glyphs; BoxHeightStyle.max grows with the line.',
              style: TextStyle(
                fontSize: 12.0,
                height: 1.4,
                color: scheme.onTertiaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4: Multi-line selections
// ---------------------------------------------------------------------------

class _MultiLineSection extends StatelessWidget {
  const _MultiLineSection();

  @override
  Widget build(BuildContext context) {
    print('=== Section 4: Multi-line selections ===');
    final scheme = Theme.of(context).colorScheme;
    const paragraph =
        'The quick brown fox jumps over the lazy dog. '
        'Pack my box with five dozen liquor jugs. '
        'How vexingly quick daft zebras jump.';
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _MultilinePane(
            title: 'tight: per-run rectangles',
            description:
                'Each rendered line ends its highlight at the last glyph, '
                'so the right edge is jagged when the paragraph wraps.',
            paragraph: paragraph,
            widthStyle: _SimulatedBoxWidthStyle.tight,
            accent: scheme.primary,
          ),
          const SizedBox(height: 14.0),
          _MultilinePane(
            title: 'max: contiguous block',
            description:
                'Each line is extended to the paragraph width, producing '
                'the classic flush-right "block highlight" effect.',
            paragraph: paragraph,
            widthStyle: _SimulatedBoxWidthStyle.max,
            accent: scheme.tertiary,
          ),
        ],
      ),
    );
  }
}

class _MultilinePane extends StatelessWidget {
  const _MultilinePane({
    required this.title,
    required this.description,
    required this.paragraph,
    required this.widthStyle,
    required this.accent,
  });

  final String title;
  final String description;
  final String paragraph;
  final _SimulatedBoxWidthStyle widthStyle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    // Split paragraph into virtual lines for the simulation. In a real
    // dart:ui paragraph the engine would do this for us via getBoxesForRange.
    final words = paragraph.split(' ');
    final lines = <String>[];
    final buffer = StringBuffer();
    var lineWords = 0;
    for (final w in words) {
      if (lineWords >= 6) {
        lines.add(buffer.toString().trimRight());
        buffer.clear();
        lineWords = 0;
      }
      buffer.write(w);
      buffer.write(' ');
      lineWords++;
    }
    if (buffer.isNotEmpty) {
      lines.add(buffer.toString().trimRight());
    }
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.view_agenda, color: accent, size: 18.0),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: accent,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              height: 1.4,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12.0),
          for (final line in lines)
            _SimulatedLine(
              text: line,
              widthStyle: widthStyle,
              accent: accent,
            ),
        ],
      ),
    );
  }
}

class _SimulatedLine extends StatelessWidget {
  const _SimulatedLine({
    required this.text,
    required this.widthStyle,
    required this.accent,
  });

  final String text;
  final _SimulatedBoxWidthStyle widthStyle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isMax = widthStyle == _SimulatedBoxWidthStyle.max;
    // For tight we pick a different fractional width per line to simulate
    // varying right-edge positions.
    final tightFactor = 0.55 + (text.length % 7) * 0.05;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: isMax ? 1.0 : tightFactor.clamp(0.45, 0.95),
                child: Container(
                  height: 22.0,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 13.0,
                height: 1.5,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5: Edge cases
// ---------------------------------------------------------------------------

class _EdgeCasesSection extends StatelessWidget {
  const _EdgeCasesSection();

  @override
  Widget build(BuildContext context) {
    print('=== Section 5: Edge cases: empty, trailing, mixed ===');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _EdgeCaseCard(
          icon: Icons.crop_din,
          title: 'Empty line in the middle of a selection',
          explanation:
              'tight collapses the empty line to a zero-width sliver; max '
              'still paints a full-width rectangle, preserving the visual '
              'flow of the block highlight.',
          caseRows: <_EdgeCaseRow>[
            _EdgeCaseRow(text: 'first selected line', isEmpty: false),
            _EdgeCaseRow(text: '', isEmpty: true),
            _EdgeCaseRow(text: 'third selected line', isEmpty: false),
          ],
        ),
        SizedBox(height: 14.0),
        _EdgeCaseCard(
          icon: Icons.space_bar,
          title: 'Trailing whitespace at end of line',
          explanation:
              'tight stops at the last glyph, dropping the spaces; max '
              'includes them up to the line width. Visible only when the '
              'highlight color contrasts with the page.',
          caseRows: <_EdgeCaseRow>[
            _EdgeCaseRow(text: 'hello world          ', isEmpty: false),
            _EdgeCaseRow(text: 'second line', isEmpty: false),
          ],
        ),
        SizedBox(height: 14.0),
        _EdgeCaseCard(
          icon: Icons.translate,
          title: 'Mixed scripts and tall glyphs',
          explanation:
              'Diacritics and combining marks affect the glyph bounding box. '
              'tight may produce a taller-than-expected highlight per run; '
              'max forces uniform line-height boxes for the whole selection.',
          caseRows: <_EdgeCaseRow>[
            _EdgeCaseRow(text: 'cafe naive jalapeno', isEmpty: false),
            _EdgeCaseRow(text: 'Latin + simulated tall glyphs', isEmpty: false),
          ],
        ),
        SizedBox(height: 14.0),
        _EdgeCaseCard(
          icon: Icons.format_indent_increase,
          title: 'Nested TextSpan children',
          explanation:
              'When a child span has its own background, BoxWidthStyle still '
              'applies to the *selection* range, not to the background-rich '
              'span. Backgrounds and selections layer independently.',
          caseRows: <_EdgeCaseRow>[
            _EdgeCaseRow(
              text: 'outer text [inner bg] outer tail',
              isEmpty: false,
            ),
          ],
        ),
      ],
    );
  }
}

class _EdgeCaseRow {
  const _EdgeCaseRow({required this.text, required this.isEmpty});

  final String text;
  final bool isEmpty;
}

class _EdgeCaseCard extends StatelessWidget {
  const _EdgeCaseCard({
    required this.icon,
    required this.title,
    required this.explanation,
    required this.caseRows,
  });

  final IconData icon;
  final String title;
  final String explanation;
  final List<_EdgeCaseRow> caseRows;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: scheme.errorContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(icon, color: scheme.onErrorContainer, size: 18.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            explanation,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _EdgeCasePane(
                  label: 'tight',
                  accent: scheme.primary,
                  rows: caseRows,
                  widthStyle: _SimulatedBoxWidthStyle.tight,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: _EdgeCasePane(
                  label: 'max',
                  accent: scheme.tertiary,
                  rows: caseRows,
                  widthStyle: _SimulatedBoxWidthStyle.max,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EdgeCasePane extends StatelessWidget {
  const _EdgeCasePane({
    required this.label,
    required this.accent,
    required this.rows,
    required this.widthStyle,
  });

  final String label;
  final Color accent;
  final List<_EdgeCaseRow> rows;
  final _SimulatedBoxWidthStyle widthStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: accent,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          for (final r in rows)
            _EdgeCaseLine(row: r, accent: accent, widthStyle: widthStyle),
        ],
      ),
    );
  }
}

class _EdgeCaseLine extends StatelessWidget {
  const _EdgeCaseLine({
    required this.row,
    required this.accent,
    required this.widthStyle,
  });

  final _EdgeCaseRow row;
  final Color accent;
  final _SimulatedBoxWidthStyle widthStyle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isMax = widthStyle == _SimulatedBoxWidthStyle.max;
    // For tight on empty lines: produce zero-width strip. For max on empty
    // lines: still fill the row width.
    final tightFactor = row.isEmpty ? 0.0 : 0.55;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: isMax ? 1.0 : tightFactor,
                child: Container(
                  height: 18.0,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.28),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Text(
              row.text.isEmpty ? ' ' : row.text,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6: Recipes & glossary
// ---------------------------------------------------------------------------

class _RecipesSection extends StatelessWidget {
  const _RecipesSection();

  @override
  Widget build(BuildContext context) {
    print('=== Section 6: Recipes & glossary ===');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const <Widget>[
        _RecipeCard(
          title: 'Highlighted code block',
          guidance:
              'Use BoxWidthStyle.max + BoxHeightStyle.max for the contiguous '
              'block look that matches code editor selections.',
          code:
              'final s = Paint()..color = scheme.primary.withValues(alpha: 0.25);\n'
              'TextSpan(\n'
              "  text: 'final answer = compute();',\n"
              '  style: TextStyle(background: s),\n'
              ');',
          highlightFactor: 1.0,
          accent: _AccentSlot.primary,
        ),
        SizedBox(height: 12.0),
        _RecipeCard(
          title: 'Search-result snippet',
          guidance:
              'Use BoxWidthStyle.tight + BoxHeightStyle.tight to hug the '
              'matched substring without bleeding into surrounding text.',
          code:
              'TextSpan(\n'
              "  text: 'box',\n"
              "  style: TextStyle(\n"
              "    background: Paint()..color = scheme.tertiary.withValues(alpha: 0.3),\n"
              '  ),\n'
              ');',
          highlightFactor: 0.4,
          accent: _AccentSlot.tertiary,
        ),
        SizedBox(height: 12.0),
        _RecipeCard(
          title: 'Citation styling',
          guidance:
              'For block-quote citations, prefer BoxWidthStyle.max so the '
              'sidebar accent reads as a uniform column rather than a ragged '
              'highlight.',
          code:
              'final cite = TextStyle(\n'
              '  background: Paint()..color = scheme.secondaryContainer,\n'
              '  fontStyle: FontStyle.italic,\n'
              ');',
          highlightFactor: 0.85,
          accent: _AccentSlot.secondary,
        ),
        SizedBox(height: 12.0),
        _RecipeCard(
          title: 'Error underline-style hit',
          guidance:
              'Pair BoxWidthStyle.tight with BoxHeightStyle.strut for a slim '
              'error wash that does not overlap the line below.',
          code:
              'final err = TextStyle(\n'
              '  background: Paint()..color = scheme.error.withValues(alpha: 0.18),\n'
              '  decoration: TextDecoration.underline,\n'
              '  decorationColor: scheme.error,\n'
              ');',
          highlightFactor: 0.5,
          accent: _AccentSlot.error,
        ),
      ],
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({
    required this.title,
    required this.guidance,
    required this.code,
    required this.highlightFactor,
    required this.accent,
  });

  final String title;
  final String guidance;
  final String code;
  final double highlightFactor;
  final _AccentSlot accent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ac = _accentOf(scheme, accent);
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _containerOf(scheme, accent),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: ac.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book, color: ac, size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: _onContainerOf(scheme, accent),
                    fontSize: 14.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            guidance,
            style: TextStyle(
              fontSize: 12.0,
              height: 1.45,
              color: _onContainerOf(scheme, accent).withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 12.0),
          // Preview strip
          SizedBox(
            height: 36.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: highlightFactor,
                      heightFactor: 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ac.withValues(alpha: 0.28),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Text(
                    'preview: ${(highlightFactor * 100).round()}% width',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      color: _onContainerOf(scheme, accent),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.78),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.45,
                color: Color(0xFFB8E6FF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Glossary extends StatelessWidget {
  const _Glossary();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final entries = <_GlossaryEntry>[
      const _GlossaryEntry(
        term: 'BoxWidthStyle.tight',
        meaning:
            'Each line-segment rectangle ends at the trailing glyph edge of '
            'the run. Whitespace at end of line is excluded.',
        icon: Icons.compress,
      ),
      const _GlossaryEntry(
        term: 'BoxWidthStyle.max',
        meaning:
            'Each line-segment rectangle stretches to the rendered line '
            'width, producing flush-right block highlights.',
        icon: Icons.open_in_full,
      ),
      const _GlossaryEntry(
        term: 'BoxHeightStyle.tight',
        meaning:
            'Box height equals ascent+descent of the run; the line leading '
            'is not included in the rectangle.',
        icon: Icons.vertical_align_center,
      ),
      const _GlossaryEntry(
        term: 'BoxHeightStyle.max',
        meaning:
            'Box height equals the full line height, including any leading '
            'introduced by TextStyle.height.',
        icon: Icons.swap_vert,
      ),
      const _GlossaryEntry(
        term: 'BoxHeightStyle.includeLineSpacingMiddle',
        meaning:
            'Half the leading is split above and below; gives a soft, '
            'centered rectangle that feels balanced for inline reading.',
        icon: Icons.format_align_center,
      ),
      const _GlossaryEntry(
        term: 'BoxHeightStyle.includeLineSpacingTop',
        meaning:
            'Full leading is appended above each line; useful for sticky '
            'note style emphasis below a heading.',
        icon: Icons.vertical_align_top,
      ),
      const _GlossaryEntry(
        term: 'BoxHeightStyle.includeLineSpacingBottom',
        meaning:
            'Full leading is appended below each line; useful for highlights '
            'sitting above a divider.',
        icon: Icons.vertical_align_bottom,
      ),
      const _GlossaryEntry(
        term: 'BoxHeightStyle.strut',
        meaning:
            'Uses the strut metrics defined on the paragraph for the height, '
            'guaranteeing uniform boxes across runs of different fonts.',
        icon: Icons.straighten,
      ),
      const _GlossaryEntry(
        term: 'Ascent / descent',
        meaning:
            'Font metrics describing how far glyphs reach above and below '
            'the baseline; the basis for tight box heights.',
        icon: Icons.format_size,
      ),
      const _GlossaryEntry(
        term: 'Leading',
        meaning:
            'Extra space inserted between lines beyond ascent+descent; '
            'governed by TextStyle.height and the font itself.',
        icon: Icons.line_weight,
      ),
      const _GlossaryEntry(
        term: 'Run',
        meaning:
            'A contiguous range of glyphs that share the same style and '
            'direction. Selection rectangles are computed per run.',
        icon: Icons.short_text,
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book, color: scheme.primary, size: 22.0),
              const SizedBox(width: 10.0),
              Text(
                'Glossary',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          for (final e in entries) ...<Widget>[
            _GlossaryRow(entry: e),
            const SizedBox(height: 8.0),
          ],
        ],
      ),
    );
  }
}

class _GlossaryEntry {
  const _GlossaryEntry({
    required this.term,
    required this.meaning,
    required this.icon,
  });

  final String term;
  final String meaning;
  final IconData icon;
}

class _GlossaryRow extends StatelessWidget {
  const _GlossaryRow({required this.entry});

  final _GlossaryEntry entry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              entry.icon,
              size: 18.0,
              color: scheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.term,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    color: scheme.primary,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  entry.meaning,
                  style: TextStyle(
                    fontSize: 12.0,
                    height: 1.45,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 22.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.tertiaryContainer,
            scheme.primaryContainer,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.check_circle_outline,
            size: 36.0,
            color: scheme.onPrimaryContainer,
          ),
          const SizedBox(height: 10.0),
          Text(
            'Deep visual demo complete',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w800,
              color: scheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'BoxWidthStyle and BoxHeightStyle together turn glyph runs into '
            'either snug per-word highlights or flush block selections.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: scheme.onPrimaryContainer.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) => const BoxWidthStyleDemoApp();
