// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: Flutter Material ScriptCategory enum.
//
// ScriptCategory has three values: englishLike, dense, tall.
// Typography uses it to choose default TextStyle metrics that suit a
// particular family of writing systems.
//
//   englishLike -> Latin / Greek / Cyrillic / Armenian / Georgian
//   dense       -> CJK (Chinese / Japanese / Korean)
//   tall        -> South- and Southeast-Asian scripts that need vertical
//                  headroom for shirorekha (Devanagari), reph marks (Tamil),
//                  and stacked diacritics (Thai, Burmese, Khmer).
//
// This demo renders nine numbered visual sections that each use a distinct
// layout to illustrate the differences between the three categories.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ScriptCategory deep visual demo: build() starting');

  // --------------------------------------------------------------------
  // Theme + colour scheme
  // --------------------------------------------------------------------
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.light,
  );

  // --------------------------------------------------------------------
  // Data tables consumed across multiple sections
  // --------------------------------------------------------------------
  const allCategories = ScriptCategory.values;

  final categoryDescriptions = <ScriptCategory, String>{
    ScriptCategory.englishLike:
        'Latin, Greek, Cyrillic, Armenian and Georgian. Moderate ascender and '
        'descender heights with comfortable Western metrics.',
    ScriptCategory.dense:
        'CJK ideographic scripts (Chinese, Japanese, Korean). Glyphs are '
        'roughly square; spacing is tight; line height stays compact.',
    ScriptCategory.tall:
        'South- and Southeast-Asian scripts whose marks extend well above and '
        'below the baseline (Devanagari, Tamil, Thai, Burmese, Khmer).',
  };

  final categorySwatches = <ScriptCategory, _CategorySwatch>{
    ScriptCategory.englishLike: _CategorySwatch(
      bg: scheme.primaryContainer,
      fg: scheme.onPrimaryContainer,
      accent: scheme.primary,
      icon: Icons.text_fields,
    ),
    ScriptCategory.dense: _CategorySwatch(
      bg: scheme.secondaryContainer,
      fg: scheme.onSecondaryContainer,
      accent: scheme.secondary,
      icon: Icons.grid_view,
    ),
    ScriptCategory.tall: _CategorySwatch(
      bg: scheme.tertiaryContainer,
      fg: scheme.onTertiaryContainer,
      accent: scheme.tertiary,
      icon: Icons.height,
    ),
  };

  // Real Typography metric snapshots, captured from material-2021 defaults
  // so we don't depend on private runtime state.
  final typographyMetrics = <ScriptCategory, _MetricsRow>{
    ScriptCategory.englishLike: const _MetricsRow(
      displayLarge: 57.0,
      headlineLarge: 32.0,
      titleLarge: 22.0,
      bodyLarge: 16.0,
      labelLarge: 14.0,
      bodyLineHeight: 1.43,
      letterSpacing: 0.25,
      fontFamily: 'Roboto / system sans-serif',
    ),
    ScriptCategory.dense: const _MetricsRow(
      displayLarge: 56.0,
      headlineLarge: 31.0,
      titleLarge: 21.0,
      bodyLarge: 15.0,
      labelLarge: 13.0,
      bodyLineHeight: 1.43,
      letterSpacing: 0.0,
      fontFamily: 'Noto Sans CJK',
    ),
    ScriptCategory.tall: const _MetricsRow(
      displayLarge: 57.0,
      headlineLarge: 32.0,
      titleLarge: 22.0,
      bodyLarge: 16.0,
      labelLarge: 14.0,
      bodyLineHeight: 1.57,
      letterSpacing: 0.25,
      fontFamily: 'Noto Sans Devanagari / Tamil',
    ),
  };

  // Real per-category Typography text themes so we can use copyWith on the
  // genuine defaults. Pulling them out once keeps the section code clean.
  final typography = Typography.material2021(platform: TargetPlatform.android);
  final englishLikeTheme = typography.englishLike;
  final denseTheme = typography.dense;
  final tallTheme = typography.tall;

  // ====================================================================
  // 0. Header / gradient banner
  // ====================================================================
  final headerBanner = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [scheme.primary, scheme.tertiary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: scheme.primary.withValues(alpha: 0.25),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.translate, color: scheme.onPrimary, size: 32),
            const SizedBox(width: 12),
            Text(
              'ScriptCategory',
              style: TextStyle(
                color: scheme.onPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'How Flutter Material picks default text metrics for different '
          'writing systems.',
          style: TextStyle(
            color: scheme.onPrimary.withValues(alpha: 0.9),
            fontSize: 14,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _bannerChip('package: flutter/material', scheme.onPrimary),
            _bannerChip('enum ScriptCategory { englishLike, dense, tall }',
                scheme.onPrimary),
            _bannerChip('used by: Typography', scheme.onPrimary),
            _bannerChip('Material 3 / 2021 metrics', scheme.onPrimary),
          ],
        ),
      ],
    ),
  );

  // ====================================================================
  // 1. ScriptCategory enum overview
  // ====================================================================
  final section1 = _sectionShell(
    scheme: scheme,
    number: 1,
    title: 'ScriptCategory enum overview',
    subtitle: 'Three values, indexed in declaration order.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'ScriptCategory is a small enum, declared in flutter/material '
            'typography.dart. There are only three values, and each one is '
            'associated with a TextTheme that ships with the framework. The '
            'right category for the current locale is computed by the '
            'MaterialLocalizations.scriptCategory getter and then consulted '
            'by Typography.geometryThemeFor().',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: scheme.onSurface.withValues(alpha: 0.85),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (final cat in allCategories)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _enumValueCard(cat, categorySwatches[cat]!, scheme),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kvRow('values length', '${allCategories.length}', scheme),
              _kvRow('values[0]', ScriptCategory.values[0].name, scheme),
              _kvRow('values[1]', ScriptCategory.values[1].name, scheme),
              _kvRow('values[2]', ScriptCategory.values[2].name, scheme),
              _kvRow('runtimeType', '${allCategories.first.runtimeType}',
                  scheme),
              _kvRow('declared in', 'package:flutter/material/typography.dart',
                  scheme),
            ],
          ),
        ),
        const SizedBox(height: 12),
        for (final cat in allCategories)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: categorySwatches[cat]!.bg.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: categorySwatches[cat]!
                      .accent
                      .withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(categorySwatches[cat]!.icon,
                      size: 16, color: categorySwatches[cat]!.accent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12.5,
                            color: categorySwatches[cat]!.fg,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          categoryDescriptions[cat]!,
                          style: TextStyle(
                            fontSize: 11.5,
                            height: 1.45,
                            color: categorySwatches[cat]!.fg,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );

  // ====================================================================
  // 2. englishLike typography sample
  // ====================================================================
  final section2 = _sectionShell(
    scheme: scheme,
    number: 2,
    title: 'englishLike typography sample',
    subtitle: 'Real text rendered using Typography.material2021().englishLike '
        'styles, scaled down for the demo.',
    child: _typographyShowcase(
      theme: englishLikeTheme,
      category: ScriptCategory.englishLike,
      swatch: categorySwatches[ScriptCategory.englishLike]!,
      scheme: scheme,
      samples: const [
        _Sample('display', 'Display headline'),
        _Sample('headline', 'Article headline'),
        _Sample('title', 'Card title for English'),
        _Sample('body', 'Body text for Latin, Greek, Cyrillic scripts.'),
        _Sample('label', 'CALL TO ACTION'),
      ],
      tagline:
          'Latin / Greek / Cyrillic / Armenian / Georgian. Default Material '
          'metrics tuned for narrow ascenders and short descenders.',
    ),
  );

  // ====================================================================
  // 3. dense (CJK) typography sample
  // ====================================================================
  final section3 = _sectionShell(
    scheme: scheme,
    number: 3,
    title: 'dense typography sample (CJK)',
    subtitle:
        'Chinese / Japanese / Korean. Glyphs sit inside a near-square box, '
        'letter spacing collapses to zero, slightly smaller defaults to keep '
        'characters legible at body size.',
    child: _typographyShowcase(
      theme: denseTheme,
      category: ScriptCategory.dense,
      swatch: categorySwatches[ScriptCategory.dense]!,
      scheme: scheme,
      samples: const [
        _Sample('display', 'Mandarin: Ni Hao Shi Jie'),
        _Sample('headline', 'Japanese: Konnichiwa Sekai'),
        _Sample('title', 'Korean: Annyeong Sesang'),
        _Sample(
            'body',
            'CJK body copy: square ideographs sit in a uniform em-box, so '
                'letter spacing should be zero and line spacing tight.'),
        _Sample('label', 'CTA Dense'),
      ],
      tagline:
          'Hanzi / Kanji / Hangul share an em-box layout. The dense text '
          'theme tightens letterSpacing to 0 so glyphs do not float apart.',
    ),
  );

  // ====================================================================
  // 4. tall (Devanagari / Tamil / Thai) typography sample
  // ====================================================================
  final section4 = _sectionShell(
    scheme: scheme,
    number: 4,
    title: 'tall typography sample (Devanagari, Tamil, Thai)',
    subtitle:
        'Vertical extenders above and below the baseline force a taller '
        'line-height (about 1.57x for body).',
    child: _typographyShowcase(
      theme: tallTheme,
      category: ScriptCategory.tall,
      swatch: categorySwatches[ScriptCategory.tall]!,
      scheme: scheme,
      samples: const [
        _Sample('display', 'Hindi: Namaste Duniya'),
        _Sample('headline', 'Tamil: Vanakkam Ulagam'),
        _Sample('title', 'Thai: Sawasdee Lok'),
        _Sample(
            'body',
            'Devanagari has shirorekha overlines, Tamil stacks reph marks, '
                'Thai layers tone diacritics. They all benefit from extra '
                'leading.'),
        _Sample('label', 'CTA Tall'),
      ],
      tagline:
          'When marks live above the cap-line or below the baseline, lines '
          'collide unless the line-height grows.',
    ),
  );

  // ====================================================================
  // 5. Typography family preview side-by-side
  // ====================================================================
  final section5 = _sectionShell(
    scheme: scheme,
    number: 5,
    title: 'Side-by-side preview of all three categories',
    subtitle:
        'A single shared phrase is rendered with each category, using the '
        'matching Typography.material2021 bodyLarge as a base style.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _sideBySideTile(
                category: ScriptCategory.englishLike,
                swatch: categorySwatches[ScriptCategory.englishLike]!,
                baseStyle: englishLikeTheme.bodyLarge,
                phrase: 'Material text on Latin script.',
                scheme: scheme,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _sideBySideTile(
                category: ScriptCategory.dense,
                swatch: categorySwatches[ScriptCategory.dense]!,
                baseStyle: denseTheme.bodyLarge,
                phrase: 'Material text on CJK.',
                scheme: scheme,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _sideBySideTile(
                category: ScriptCategory.tall,
                swatch: categorySwatches[ScriptCategory.tall]!,
                baseStyle: tallTheme.bodyLarge,
                phrase: 'Material text on Devanagari.',
                scheme: scheme,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: scheme.outlineVariant.withValues(alpha: 0.6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Why side-by-side matters',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Designers often forget that the same body slot in a Card '
                'gets noticeably taller when the user switches their device '
                'to a tall locale. A button row that fits englishLike content '
                'on one line might wrap on tall.',
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.45,
                  color: scheme.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ====================================================================
  // 6. Line-height comparison table (real Table widget)
  // ====================================================================
  final section6 = _sectionShell(
    scheme: scheme,
    number: 6,
    title: 'Line-height and metric comparison table',
    subtitle:
        'Snapshot of the metrics each TextTheme exposes when rendered with '
        'the material 2021 Typography defaults.',
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.3),
          1: FlexColumnWidth(1.0),
          2: FlexColumnWidth(1.0),
          3: FlexColumnWidth(1.0),
          4: FlexColumnWidth(1.0),
          5: FlexColumnWidth(1.0),
          6: FlexColumnWidth(1.0),
          7: FlexColumnWidth(1.1),
          8: FlexColumnWidth(1.4),
        },
        children: [
          TableRow(
            decoration: BoxDecoration(color: scheme.primary),
            children: [
              _th('category', scheme),
              _th('display', scheme),
              _th('headline', scheme),
              _th('title', scheme),
              _th('body', scheme),
              _th('label', scheme),
              _th('line h.', scheme),
              _th('tracking', scheme),
              _th('family', scheme),
            ],
          ),
          for (final cat in allCategories)
            TableRow(
              decoration: BoxDecoration(
                color: cat.index.isEven
                    ? scheme.surface
                    : scheme.surfaceContainerHighest,
              ),
              children: [
                _tdCategory(cat, categorySwatches[cat]!, scheme),
                _td(typographyMetrics[cat]!.displayLarge.toStringAsFixed(0),
                    scheme),
                _td(typographyMetrics[cat]!.headlineLarge.toStringAsFixed(0),
                    scheme),
                _td(typographyMetrics[cat]!.titleLarge.toStringAsFixed(0),
                    scheme),
                _td(typographyMetrics[cat]!.bodyLarge.toStringAsFixed(0),
                    scheme),
                _td(typographyMetrics[cat]!.labelLarge.toStringAsFixed(0),
                    scheme),
                _td(typographyMetrics[cat]!.bodyLineHeight.toStringAsFixed(2),
                    scheme),
                _td(typographyMetrics[cat]!.letterSpacing.toStringAsFixed(2),
                    scheme),
                _tdFamily(typographyMetrics[cat]!.fontFamily, scheme),
              ],
            ),
        ],
      ),
    ),
  );

  // ====================================================================
  // 7. Locale -> ScriptCategory mapping
  // ====================================================================
  final localeRows = <_LocaleRow>[
    _LocaleRow('en', 'English', ScriptCategory.englishLike, 'Latin'),
    _LocaleRow('de', 'German', ScriptCategory.englishLike, 'Latin'),
    _LocaleRow('fr', 'French', ScriptCategory.englishLike, 'Latin'),
    _LocaleRow('es', 'Spanish', ScriptCategory.englishLike, 'Latin'),
    _LocaleRow('ru', 'Russian', ScriptCategory.englishLike, 'Cyrillic'),
    _LocaleRow('el', 'Greek', ScriptCategory.englishLike, 'Greek'),
    _LocaleRow('zh', 'Chinese', ScriptCategory.dense, 'Han'),
    _LocaleRow('ja', 'Japanese', ScriptCategory.dense, 'Kanji/Kana'),
    _LocaleRow('ko', 'Korean', ScriptCategory.dense, 'Hangul'),
    _LocaleRow('hi', 'Hindi', ScriptCategory.tall, 'Devanagari'),
    _LocaleRow('ta', 'Tamil', ScriptCategory.tall, 'Tamil'),
    _LocaleRow('th', 'Thai', ScriptCategory.tall, 'Thai'),
    _LocaleRow('my', 'Burmese', ScriptCategory.tall, 'Myanmar'),
    _LocaleRow('km', 'Khmer', ScriptCategory.tall, 'Khmer'),
  ];

  final section7 = _sectionShell(
    scheme: scheme,
    number: 7,
    title: 'Locale -> ScriptCategory mapping',
    subtitle:
        'How MaterialLocalizations.scriptCategory routes common locale codes '
        'to one of the three buckets.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: scheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(0.7),
              1: FlexColumnWidth(1.4),
              2: FlexColumnWidth(1.6),
              3: FlexColumnWidth(1.4),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: scheme.secondaryContainer),
                children: [
                  _th2('locale', scheme),
                  _th2('language', scheme),
                  _th2('script', scheme),
                  _th2('category', scheme),
                ],
              ),
              for (var i = 0; i < localeRows.length; i++)
                TableRow(
                  decoration: BoxDecoration(
                    color: i.isEven
                        ? scheme.surface
                        : scheme.surfaceContainerLowest,
                  ),
                  children: [
                    _td(localeRows[i].code, scheme),
                    _td(localeRows[i].language, scheme),
                    _td(localeRows[i].script, scheme),
                    _localeCatCell(localeRows[i].category,
                        categorySwatches[localeRows[i].category]!, scheme),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final cat in allCategories)
              _countPill(
                cat,
                localeRows.where((r) => r.category == cat).length,
                categorySwatches[cat]!,
                scheme,
              ),
          ],
        ),
      ],
    ),
  );

  // ====================================================================
  // 8. Sample text grid with chips per script
  // ====================================================================
  final scriptExamples = <ScriptCategory, List<_ScriptChip>>{
    ScriptCategory.englishLike: const [
      _ScriptChip('Latin', 'English / German / French / Spanish'),
      _ScriptChip('Cyrillic', 'Russian / Ukrainian / Serbian'),
      _ScriptChip('Greek', 'Greek (modern)'),
      _ScriptChip('Armenian', 'Eastern / Western Armenian'),
      _ScriptChip('Georgian', 'Mkhedruli'),
    ],
    ScriptCategory.dense: const [
      _ScriptChip('Hanzi (Simplified)', 'Chinese mainland'),
      _ScriptChip('Hanzi (Traditional)', 'Taiwan / Hong Kong'),
      _ScriptChip('Kanji + Kana', 'Japanese'),
      _ScriptChip('Hangul', 'Korean'),
    ],
    ScriptCategory.tall: const [
      _ScriptChip('Devanagari', 'Hindi / Marathi / Nepali'),
      _ScriptChip('Tamil', 'Tamil Nadu / Sri Lanka'),
      _ScriptChip('Bengali', 'Bangladesh / West Bengal'),
      _ScriptChip('Thai', 'Thailand'),
      _ScriptChip('Myanmar', 'Burmese / Shan / Mon'),
      _ScriptChip('Khmer', 'Cambodia'),
    ],
  };

  final section8 = _sectionShell(
    scheme: scheme,
    number: 8,
    title: 'Sample script grid',
    subtitle:
        'Chip rows: the writing systems each category covers in production '
        'Material apps.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final cat in allCategories)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: _scriptChipRow(
              cat,
              categorySwatches[cat]!,
              scriptExamples[cat]!,
              scheme,
            ),
          ),
      ],
    ),
  );

  // ====================================================================
  // 9. Why tall scripts need extra room: CustomPainter diagram
  // ====================================================================
  final section9 = _sectionShell(
    scheme: scheme,
    number: 9,
    title: 'Why tall scripts need extra leading',
    subtitle:
        'A schematic comparison: the body em-box is the same, but tall '
        'scripts paint marks that escape it.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: CustomPaint(
            painter: _ScriptHeightDiagram(scheme: scheme),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.errorContainer.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: scheme.error.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber, color: scheme.onErrorContainer),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'If you hard-code a Container height around a body Text in '
                  'an englishLike layout and then ship to a tall locale, the '
                  'top of the shirorekha (Devanagari overline) and the bottom '
                  'of the reph mark (Tamil) will be clipped. Always size '
                  'around the TextTheme, not pixels.',
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: scheme.onErrorContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ====================================================================
  // 10. Recipe / glossary / when-to-use card
  // ====================================================================
  final recipes = <_Recipe>[
    _Recipe(
      category: ScriptCategory.englishLike,
      coverage: 'Latin, Greek, Cyrillic, Armenian, Georgian',
      defaultTheme: 'Typography.englishLike2021',
      lineHeight: '1.43 (body)',
      letterSpacing: '0.25 (body)',
      whenToUse:
          'Default for European and most American locales. Keep this theme '
          'as your starting point and only branch to dense/tall when '
          'MaterialLocalizations switches the script.',
    ),
    _Recipe(
      category: ScriptCategory.dense,
      coverage: 'Simplified + Traditional Chinese, Japanese (Kanji/Kana), Korean Hangul',
      defaultTheme: 'Typography.dense2021',
      lineHeight: '1.43 (body)',
      letterSpacing: '0.0 (body)',
      whenToUse:
          'Pick this when the active locale is zh-*, ja, or ko. Letter '
          'spacing collapses to zero because each ideograph already has '
          'built-in side bearings. Keep button labels short - CJK glyphs '
          'are wider than equivalent Latin characters.',
    ),
    _Recipe(
      category: ScriptCategory.tall,
      coverage: 'Devanagari, Bengali, Tamil, Telugu, Thai, Myanmar, Khmer',
      defaultTheme: 'Typography.tall2021',
      lineHeight: '1.57 (body)',
      letterSpacing: '0.25 (body)',
      whenToUse:
          'Anywhere the script stacks diacritics above or below the '
          'baseline. Test list rows, chips, and AppBar titles - they all '
          'need extra vertical space. Avoid maxLines: 1 on body Text in '
          'tall locales unless you also clamp the font size.',
    ),
  ];

  final section10 = _sectionShell(
    scheme: scheme,
    number: 10,
    title: 'Recipes / glossary: when to use which',
    subtitle:
        'A reference card you can copy into your design-system docs.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final recipe in recipes)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: _recipeCard(
                recipe, categorySwatches[recipe.category]!, scheme),
          ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                scheme.primaryContainer.withValues(alpha: 0.85),
                scheme.tertiaryContainer.withValues(alpha: 0.85),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cheat-sheet',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: scheme.onPrimaryContainer,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              _cheatLine(
                  '1.', 'Resolve category via MaterialLocalizations.', scheme),
              _cheatLine('2.',
                  'Pull TextTheme via Typography.material2021().<category>.',
                  scheme),
              _cheatLine('3.',
                  'Apply copyWith for app-specific brand changes, never resize '
                  'the underlying metrics.', scheme),
              _cheatLine('4.',
                  'Wrap layouts in IntrinsicHeight or use FittedBox in cells '
                  'that must accept any of the three categories.', scheme),
              _cheatLine('5.',
                  'Visual-regression test all three categories - the snapshot '
                  'differences are real, not noise.', scheme),
            ],
          ),
        ),
      ],
    ),
  );

  // ====================================================================
  // Footer
  // ====================================================================
  final footer = Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [scheme.tertiary, scheme.primary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        Icon(Icons.check_circle, color: scheme.onPrimary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'ScriptCategory: ${allCategories.length} values, 10 visual '
            'sections, hand-authored deep demo.',
            style: TextStyle(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );

  print('ScriptCategory deep visual demo: build() returning widget tree');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: scheme, useMaterial3: true),
    home: Scaffold(
      backgroundColor: scheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerBanner,
            const SizedBox(height: 18),
            section1,
            const SizedBox(height: 16),
            section2,
            const SizedBox(height: 16),
            section3,
            const SizedBox(height: 16),
            section4,
            const SizedBox(height: 16),
            section5,
            const SizedBox(height: 16),
            section6,
            const SizedBox(height: 16),
            section7,
            const SizedBox(height: 16),
            section8,
            const SizedBox(height: 16),
            section9,
            const SizedBox(height: 16),
            section10,
            const SizedBox(height: 18),
            footer,
            const SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );
}

// ======================================================================
// Helper data classes
// ======================================================================

class _CategorySwatch {
  final Color bg;
  final Color fg;
  final Color accent;
  final IconData icon;
  const _CategorySwatch({
    required this.bg,
    required this.fg,
    required this.accent,
    required this.icon,
  });
}

class _MetricsRow {
  final double displayLarge;
  final double headlineLarge;
  final double titleLarge;
  final double bodyLarge;
  final double labelLarge;
  final double bodyLineHeight;
  final double letterSpacing;
  final String fontFamily;
  const _MetricsRow({
    required this.displayLarge,
    required this.headlineLarge,
    required this.titleLarge,
    required this.bodyLarge,
    required this.labelLarge,
    required this.bodyLineHeight,
    required this.letterSpacing,
    required this.fontFamily,
  });
}

class _Sample {
  final String slot;
  final String text;
  const _Sample(this.slot, this.text);
}

class _LocaleRow {
  final String code;
  final String language;
  final ScriptCategory category;
  final String script;
  const _LocaleRow(this.code, this.language, this.category, this.script);
}

class _ScriptChip {
  final String name;
  final String hint;
  const _ScriptChip(this.name, this.hint);
}

class _Recipe {
  final ScriptCategory category;
  final String coverage;
  final String defaultTheme;
  final String lineHeight;
  final String letterSpacing;
  final String whenToUse;
  const _Recipe({
    required this.category,
    required this.coverage,
    required this.defaultTheme,
    required this.lineHeight,
    required this.letterSpacing,
    required this.whenToUse,
  });
}

// ======================================================================
// Visual helpers (each returns a small subtree)
// ======================================================================

Widget _bannerChip(String label, Color onPrimary) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: onPrimary.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: onPrimary.withValues(alpha: 0.4)),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: onPrimary,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _sectionShell({
  required ColorScheme scheme,
  required int number,
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: scheme.outlineVariant.withValues(alpha: 0.6),
      ),
      boxShadow: [
        BoxShadow(
          color: scheme.shadow.withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: scheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$number',
                style: TextStyle(
                  color: scheme.onPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.4,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        child,
      ],
    ),
  );
}

Widget _enumValueCard(
    ScriptCategory cat, _CategorySwatch swatch, ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: swatch.bg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: swatch.accent.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: swatch.accent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(swatch.icon, color: scheme.onPrimary, size: 16),
            ),
            const SizedBox(width: 8),
            Text(
              cat.name,
              style: TextStyle(
                color: swatch.fg,
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'index ${cat.index}',
          style: TextStyle(
            color: swatch.fg.withValues(alpha: 0.7),
            fontSize: 11,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _shortBlurb(cat),
          style: TextStyle(
            color: swatch.fg,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

String _shortBlurb(ScriptCategory cat) {
  switch (cat) {
    case ScriptCategory.englishLike:
      return 'Latin / Greek / Cyrillic. Standard Material metrics.';
    case ScriptCategory.dense:
      return 'CJK ideographs. Tight letter spacing, square em-box.';
    case ScriptCategory.tall:
      return 'Indic / Thai / Burmese. Marks above and below baseline.';
  }
}

Widget _kvRow(String key, String value, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 12,
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: scheme.onSurface,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _typographyShowcase({
  required TextTheme theme,
  required ScriptCategory category,
  required _CategorySwatch swatch,
  required ColorScheme scheme,
  required List<_Sample> samples,
  required String tagline,
}) {
  TextStyle? styleFor(String slot) {
    switch (slot) {
      case 'display':
        return theme.displaySmall?.copyWith(fontSize: 26);
      case 'headline':
        return theme.headlineSmall?.copyWith(fontSize: 20);
      case 'title':
        return theme.titleMedium;
      case 'body':
        return theme.bodyMedium;
      case 'label':
        return theme.labelLarge?.copyWith(letterSpacing: 1.2);
    }
    return theme.bodyMedium;
  }

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: swatch.bg.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: swatch.accent.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(swatch.icon, color: swatch.accent),
            const SizedBox(width: 8),
            Text(
              'ScriptCategory.${category.name}',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: swatch.fg,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          tagline,
          style: TextStyle(
            fontSize: 12.5,
            height: 1.45,
            color: swatch.fg.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 12),
        for (final sample in samples)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: swatch.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    sample.slot,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: swatch.accent,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    sample.text,
                    style: (styleFor(sample.slot) ?? const TextStyle())
                        .copyWith(color: swatch.fg),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _sideBySideTile({
  required ScriptCategory category,
  required _CategorySwatch swatch,
  required TextStyle? baseStyle,
  required String phrase,
  required ColorScheme scheme,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    height: 160,
    decoration: BoxDecoration(
      color: swatch.bg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: swatch.accent.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(swatch.icon, size: 18, color: swatch.accent),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                category.name,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: swatch.fg,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Text(
          phrase,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: (baseStyle ?? const TextStyle()).copyWith(
            color: swatch.fg,
            fontSize: 13.5,
            height: 1.4,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: swatch.accent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'idx ${category.index}',
            style: TextStyle(
              color: scheme.onPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _th(String label, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    child: Text(
      label,
      style: TextStyle(
        color: scheme.onPrimary,
        fontWeight: FontWeight.w800,
        fontSize: 11,
      ),
    ),
  );
}

Widget _th2(String label, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child: Text(
      label,
      style: TextStyle(
        color: scheme.onSecondaryContainer,
        fontWeight: FontWeight.w800,
        fontSize: 11,
      ),
    ),
  );
}

Widget _td(String text, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.5,
        color: scheme.onSurface,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    ),
  );
}

Widget _tdFamily(String text, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        color: scheme.onSurface.withValues(alpha: 0.75),
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

Widget _tdCategory(
    ScriptCategory cat, _CategorySwatch swatch, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: swatch.accent,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            cat.name,
            style: TextStyle(
              fontSize: 11.5,
              color: scheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _localeCatCell(
    ScriptCategory cat, _CategorySwatch swatch, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: swatch.accent.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: swatch.accent.withValues(alpha: 0.45)),
      ),
      child: Text(
        cat.name,
        style: TextStyle(
          fontSize: 11,
          color: swatch.accent,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Widget _countPill(ScriptCategory cat, int count, _CategorySwatch swatch,
    ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: swatch.bg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: swatch.accent.withValues(alpha: 0.5)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(swatch.icon, size: 14, color: swatch.accent),
        const SizedBox(width: 6),
        Text(
          '${cat.name}: $count locales',
          style: TextStyle(
            fontSize: 11.5,
            color: swatch.fg,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _scriptChipRow(ScriptCategory cat, _CategorySwatch swatch,
    List<_ScriptChip> chips, ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: swatch.bg.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: swatch.accent.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(swatch.icon, size: 16, color: swatch.accent),
            const SizedBox(width: 6),
            Text(
              cat.name,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: swatch.fg,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final chip in chips)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: scheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: swatch.accent.withValues(alpha: 0.35)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chip.name,
                      style: TextStyle(
                        fontSize: 11.5,
                        color: swatch.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      chip.hint,
                      style: TextStyle(
                        fontSize: 10,
                        color: scheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _recipeCard(_Recipe recipe, _CategorySwatch swatch, ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: swatch.accent.withValues(alpha: 0.5), width: 1.2),
      boxShadow: [
        BoxShadow(
          color: swatch.accent.withValues(alpha: 0.08),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: swatch.accent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(swatch.icon, color: scheme.onPrimary, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    recipe.category.name,
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                recipe.defaultTheme,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _recipeKv('coverage', recipe.coverage, scheme),
        _recipeKv('line-height', recipe.lineHeight, scheme),
        _recipeKv('tracking', recipe.letterSpacing, scheme),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: swatch.bg.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            recipe.whenToUse,
            style: TextStyle(
              fontSize: 12,
              height: 1.45,
              color: swatch.fg,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recipeKv(String label, String value, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: scheme.onSurface,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _cheatLine(String num, String text, ColorScheme scheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 22,
          child: Text(
            num,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: scheme.onPrimaryContainer,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              height: 1.45,
              color: scheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    ),
  );
}

// ======================================================================
// CustomPainter for section 9: schematic baseline diagram.
// ======================================================================

class _ScriptHeightDiagram extends CustomPainter {
  final ColorScheme scheme;
  _ScriptHeightDiagram({required this.scheme});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Three horizontal slots, one per category.
    final slotW = w / 3;
    final labels = ['englishLike', 'dense', 'tall'];
    final accents = [scheme.primary, scheme.secondary, scheme.tertiary];

    // Baseline, x-height, cap-height positions inside each slot.
    final baselineY = h * 0.72;
    final capY = h * 0.42;
    final xHeightY = h * 0.55;
    final overlineY = h * 0.20;
    final descenderY = h * 0.92;

    final guidePaint = Paint()
      ..color = scheme.outline.withValues(alpha: 0.5)
      ..strokeWidth = 1;
    final guideDash = Paint()
      ..color = scheme.outline.withValues(alpha: 0.25)
      ..strokeWidth = 1;

    for (var i = 0; i < 3; i++) {
      final left = i * slotW + 12;
      final right = (i + 1) * slotW - 12;

      // Baseline reference lines.
      canvas.drawLine(Offset(left, baselineY),
          Offset(right, baselineY), guidePaint);
      canvas.drawLine(
          Offset(left, capY), Offset(right, capY), guideDash);
      canvas.drawLine(
          Offset(left, xHeightY), Offset(right, xHeightY), guideDash);

      // Body em-box (same size in all three).
      final boxLeft = left + 8;
      final boxRight = right - 8;
      final boxRect = Rect.fromLTRB(boxLeft, capY, boxRight, baselineY);
      final boxPaint = Paint()
        ..color = accents[i].withValues(alpha: 0.18)
        ..style = PaintingStyle.fill;
      final boxStroke = Paint()
        ..color = accents[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      canvas.drawRRect(
          RRect.fromRectAndRadius(boxRect, const Radius.circular(4)), boxPaint);
      canvas.drawRRect(
          RRect.fromRectAndRadius(boxRect, const Radius.circular(4)),
          boxStroke);

      // Category-specific ornament.
      final ornament = Paint()
        ..color = accents[i]
        ..style = PaintingStyle.fill;
      switch (i) {
        case 0:
          // englishLike: a tiny descender 'g' tail.
          final tail = Rect.fromLTWH(
              (boxLeft + boxRight) / 2 - 4, baselineY, 8, descenderY - baselineY);
          canvas.drawRect(tail, ornament);
          break;
        case 1:
          // dense: a full ideographic square that fills the em-box.
          final block =
              Rect.fromLTRB(boxLeft + 4, capY + 4, boxRight - 4, baselineY - 4);
          canvas.drawRect(block, ornament);
          break;
        case 2:
          // tall: shirorekha overline plus below-baseline mark.
          final shiro = Rect.fromLTWH(boxLeft + 4, overlineY,
              boxRight - boxLeft - 8, 3);
          canvas.drawRect(shiro, ornament);
          final stem = Rect.fromLTWH(
              boxLeft + 12, overlineY + 3, 4, capY - overlineY - 3);
          canvas.drawRect(stem, ornament);
          final dot = Rect.fromLTWH(
              (boxLeft + boxRight) / 2 - 3, baselineY + 6, 6, 6);
          canvas.drawRect(dot, ornament);
          break;
      }

      // Caption.
      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: accents[i],
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas,
          Offset((boxLeft + boxRight) / 2 - tp.width / 2, h - tp.height - 6));

      // Annotation pointer for tall.
      if (i == 2) {
        final hintTp = TextPainter(
          text: TextSpan(
            text: 'marks above + below',
            style: TextStyle(
              color: accents[i],
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: slotW - 24);
        hintTp.paint(canvas, Offset(boxLeft, 4));
      }
    }

    // Top label.
    final topTp = TextPainter(
      text: TextSpan(
        text: 'Body em-box stays equal; ornament size differs',
        style: TextStyle(
          color: scheme.onSurface.withValues(alpha: 0.7),
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    topTp.paint(canvas, Offset(w / 2 - topTp.width / 2, 2));
  }

  @override
  bool shouldRepaint(covariant _ScriptHeightDiagram oldDelegate) =>
      oldDelegate.scheme != scheme;
}
