// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for TextTheme,
// ThemeData typography and the TextStyle merge/copyWith family
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Background
// ---------------------------------------------------------------------------
// Material 3 reorganized the legacy 2018 thirteen-style scale into a fresh
// fifteen-style scale built around five role groups: Display, Headline, Title,
// Body and Label. Each role has three sizes (Large, Medium, Small) yielding
// 15 named entries on the TextTheme. This script tours all 15, contrasts
// 2018 vs 2021 typography presets, then exercises TextStyle.merge, copyWith,
// FontWeight ladders, FontStyle italic vs normal, OpenType FontFeature samples
// and FontVariation axis tags.
//
// We never touch StatefulWidget, AnimationController, async, Future, Timer or
// Stream. All structures are computed once at build() and composed top-down.
// ---------------------------------------------------------------------------

// A small immutable triple describing one named TextTheme entry so the
// gallery can iterate via index loops without using bridged iterators.
class _Sample {
  final String name;
  final String role;
  final TextStyle? style;
  const _Sample(this.name, this.role, this.style);
}

// Spec rows for the typography preset comparison table.
class _PresetRow {
  final String label;
  final String preset2018;
  final String preset2021;
  const _PresetRow(this.label, this.preset2018, this.preset2021);
}

// Weight ladder entry.
class _WeightStop {
  final String tag;
  final FontWeight weight;
  final String note;
  const _WeightStop(this.tag, this.weight, this.note);
}

// FontFeature sample entry.
class _FeatureRow {
  final String tag;
  final String description;
  final List<FontFeature> features;
  final String sample;
  const _FeatureRow(this.tag, this.description, this.features, this.sample);
}

// FontVariation axis demo.
class _VariationRow {
  final String axis;
  final double value;
  final String description;
  const _VariationRow(this.axis, this.value, this.description);
}

// A small palette tuned to read on either light or dark surfaces.
const Color _kInk = Color(0xFF1A1F2C);
const Color _kInkSoft = Color(0xFF3F485A);
const Color _kAccent = Color(0xFF1E60D0);
const Color _kAccentSoft = Color(0xFFE5EEFC);
const Color _kHairline = Color(0xFFD0D6E2);
const Color _kSurface = Color(0xFFF7F8FC);
const Color _kSurfaceAlt = Color(0xFFEEF1F8);
const Color _kRoleDisplay = Color(0xFF7437B5);
const Color _kRoleHeadline = Color(0xFFB54737);
const Color _kRoleTitle = Color(0xFFB58637);
const Color _kRoleBody = Color(0xFF2E7C42);
const Color _kRoleLabel = Color(0xFF37709E);

// ---------------------------------------------------------------------------
// Entry point
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('[texttheme_test] build() entered');
  print('[texttheme_test] composing deep visual TextTheme demo');

  // ---- Inspect the current Theme.of(context) typography baseline ---------
  final ThemeData incoming = Theme.of(context);
  final TextTheme inheritedText = incoming.textTheme;
  print('[texttheme_test] inherited textTheme.bodyMedium.fontSize='
      '${inheritedText.bodyMedium?.fontSize}');
  print('[texttheme_test] inherited textTheme.titleLarge.fontWeight='
      '${inheritedText.titleLarge?.fontWeight}');
  print('[texttheme_test] inherited textTheme.displayLarge.fontSize='
      '${inheritedText.displayLarge?.fontSize}');

  // ---- Build an explicit Material 3 TextTheme with all 15 named entries --
  final TextTheme galleryTheme = _buildMaterial3TextTheme();
  print('[texttheme_test] galleryTheme displayLarge=${galleryTheme.displayLarge?.fontSize}');
  print('[texttheme_test] galleryTheme bodyMedium=${galleryTheme.bodyMedium?.fontSize}');
  print('[texttheme_test] galleryTheme labelSmall=${galleryTheme.labelSmall?.fontSize}');

  // ---- Demonstrate TextTheme.copyWith on a single role -------------------
  final TextTheme tweakedTheme = galleryTheme.copyWith(
    bodyLarge: galleryTheme.bodyLarge?.copyWith(
      color: _kAccent,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
  );
  print('[texttheme_test] tweakedTheme bodyLarge color=${tweakedTheme.bodyLarge?.color}');

  // ---- Demonstrate TextTheme.apply (bulk recolor / size factor) ----------
  final TextTheme appliedTheme = galleryTheme.apply(
    fontSizeFactor: 1.0,
    bodyColor: _kInk,
    displayColor: _kInk,
  );
  print('[texttheme_test] appliedTheme displayMedium color=${appliedTheme.displayMedium?.color}');

  // ---- Demonstrate TextTheme.merge -------------------------------------
  final TextTheme partial = const TextTheme(
    bodyMedium: TextStyle(letterSpacing: 0.5),
    labelLarge: TextStyle(fontFeatures: <FontFeature>[FontFeature.tabularFigures()]),
  );
  final TextTheme mergedTheme = appliedTheme.merge(partial);
  print('[texttheme_test] mergedTheme bodyMedium letterSpacing=${mergedTheme.bodyMedium?.letterSpacing}');
  print('[texttheme_test] mergedTheme labelLarge features=${mergedTheme.labelLarge?.fontFeatures?.length}');

  // ---- Section assembly -------------------------------------------------
  print('[texttheme_test] section A: TextTheme gallery (15 named styles)');
  final Widget sectionA = _buildGallerySection(mergedTheme);

  print('[texttheme_test] section B: Typography preset comparison');
  final Widget sectionB = _buildTypographyComparisonSection();

  print('[texttheme_test] section C: TextStyle.merge & copyWith recipes');
  final Widget sectionC = _buildMergeRecipeSection(mergedTheme);

  print('[texttheme_test] section D: FontWeight ladder w100..w900');
  final Widget sectionD = _buildWeightLadderSection(mergedTheme);

  print('[texttheme_test] section E: FontStyle italic vs normal');
  final Widget sectionE = _buildItalicSection(mergedTheme);

  print('[texttheme_test] section F: FontFeature OpenType samples');
  final Widget sectionF = _buildFeatureSection(mergedTheme);

  print('[texttheme_test] section G: FontVariation axes');
  final Widget sectionG = _buildVariationSection(mergedTheme);

  print('[texttheme_test] section H: Theming via Theme.of(context).textTheme');
  final Widget sectionH = _buildContextThemeSection(mergedTheme);

  print('[texttheme_test] section I: TextStyle.inherit explainer');
  final Widget sectionI = _buildInheritSection(mergedTheme);

  print('[texttheme_test] all sections composed');

  // ---- Compose the final MaterialApp ------------------------------------
  final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: _kAccent,
      onPrimary: Colors.white,
      surface: _kSurface,
      onSurface: _kInk,
    ),
    scaffoldBackgroundColor: _kSurface,
    textTheme: mergedTheme,
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextTheme Deep Visual Demo',
    theme: appTheme,
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: _kAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'TextTheme Deep Visual Demo',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(34),
          child: Container(
            width: double.infinity,
            color: _kAccent,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: const Text(
              'Material 3 typography tour - display / headline / title / body / label',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _topBanner(mergedTheme),
            const SizedBox(height: 24),
            sectionA,
            const SizedBox(height: 32),
            sectionB,
            const SizedBox(height: 32),
            sectionC,
            const SizedBox(height: 32),
            sectionD,
            const SizedBox(height: 32),
            sectionE,
            const SizedBox(height: 32),
            sectionF,
            const SizedBox(height: 32),
            sectionG,
            const SizedBox(height: 32),
            sectionH,
            const SizedBox(height: 32),
            sectionI,
            const SizedBox(height: 32),
            _footerBanner(mergedTheme),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Helpers: building the canonical Material 3 TextTheme
// ---------------------------------------------------------------------------
TextTheme _buildMaterial3TextTheme() {
  // These figures are the Material 3 reference values, transcribed by hand so
  // the script does not depend on any private typography constants. Numbers
  // are sourced from the published Material Design 3 specification.
  return const TextTheme(
    // Display - reserved for short, high-impact text such as hero banners.
    displayLarge: TextStyle(
      fontSize: 57.0,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      height: 64.0 / 57.0,
    ),
    displayMedium: TextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      height: 52.0 / 45.0,
    ),
    displaySmall: TextStyle(
      fontSize: 36.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      height: 44.0 / 36.0,
    ),

    // Headline - section headings within a screen.
    headlineLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      height: 40.0 / 32.0,
    ),
    headlineMedium: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      height: 36.0 / 28.0,
    ),
    headlineSmall: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.0,
      height: 32.0 / 24.0,
    ),

    // Title - prominent text such as dialog titles and card headings.
    titleLarge: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.0,
      height: 28.0 / 22.0,
    ),
    titleMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 24.0 / 16.0,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 20.0 / 14.0,
    ),

    // Body - paragraphs of running text.
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 24.0 / 16.0,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 20.0 / 14.0,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 16.0 / 12.0,
    ),

    // Label - small UI text on buttons, chips, tabs, badges.
    labelLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 20.0 / 14.0,
    ),
    labelMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 16.0 / 12.0,
    ),
    labelSmall: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 16.0 / 11.0,
    ),
  );
}

// ---------------------------------------------------------------------------
// Top / footer banners
// ---------------------------------------------------------------------------
Widget _topBanner(TextTheme tt) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kAccent, Color(0xFF7437B5)],
      ),
    ),
    padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'TextTheme',
          style: tt.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'A guided tour of every named style and how Theme.of(context).textTheme '
          'composes with TextStyle.merge, copyWith and Material 3 typography.',
          style: tt.bodyMedium?.copyWith(color: Colors.white70),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _pill('15 named styles', Colors.white24, Colors.white),
            _pill('5 role groups', Colors.white24, Colors.white),
            _pill('Material 3', Colors.white24, Colors.white),
            _pill('TextStyle.merge', Colors.white24, Colors.white),
            _pill('FontFeature', Colors.white24, Colors.white),
            _pill('FontVariation', Colors.white24, Colors.white),
          ],
        ),
      ],
    ),
  );
}

Widget _footerBanner(TextTheme tt) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    decoration: BoxDecoration(
      color: _kAccentSoft,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kHairline),
    ),
    child: Row(
      children: <Widget>[
        const Icon(Icons.text_fields, color: _kAccent),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'End of demo. The full Material 3 type scale spans 15 named styles '
            'across Display, Headline, Title, Body and Label roles.',
            style: tt.bodyMedium?.copyWith(color: _kInk),
          ),
        ),
      ],
    ),
  );
}

Widget _pill(String text, Color bg, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: fg,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.3,
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section A: Full gallery of all 15 named TextTheme entries
// ---------------------------------------------------------------------------
Widget _buildGallerySection(TextTheme tt) {
  // Build the index list manually so we never iterate a bridged collection.
  final List<_Sample> samples = <_Sample>[
    _Sample('displayLarge', 'Display', tt.displayLarge),
    _Sample('displayMedium', 'Display', tt.displayMedium),
    _Sample('displaySmall', 'Display', tt.displaySmall),
    _Sample('headlineLarge', 'Headline', tt.headlineLarge),
    _Sample('headlineMedium', 'Headline', tt.headlineMedium),
    _Sample('headlineSmall', 'Headline', tt.headlineSmall),
    _Sample('titleLarge', 'Title', tt.titleLarge),
    _Sample('titleMedium', 'Title', tt.titleMedium),
    _Sample('titleSmall', 'Title', tt.titleSmall),
    _Sample('bodyLarge', 'Body', tt.bodyLarge),
    _Sample('bodyMedium', 'Body', tt.bodyMedium),
    _Sample('bodySmall', 'Body', tt.bodySmall),
    _Sample('labelLarge', 'Label', tt.labelLarge),
    _Sample('labelMedium', 'Label', tt.labelMedium),
    _Sample('labelSmall', 'Label', tt.labelSmall),
  ];

  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < samples.length; i++) {
    cards.add(_galleryCard(samples[i]));
    if (i != samples.length - 1) {
      cards.add(const SizedBox(height: 10));
    }
  }

  return _sectionShell(
    title: 'A. Complete TextTheme gallery',
    subtitle: 'All 15 named styles rendered at their natural size with role tags '
        'and size / weight callouts.',
    accent: _kRoleDisplay,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cards,
    ),
  );
}

Widget _galleryCard(_Sample sample) {
  final TextStyle? style = sample.style;
  final Color roleColor = _roleColor(sample.role);
  final String sampleText = _sampleTextFor(sample.role);

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kHairline),
    ),
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: roleColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                sample.role.toUpperCase(),
                style: TextStyle(
                  color: roleColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              sample.name,
              style: const TextStyle(
                color: _kInkSoft,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              _styleSpecOf(style),
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 11,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          sampleText,
          style: style?.copyWith(color: _kInk),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

String _sampleTextFor(String role) {
  if (role == 'Display') {
    return 'Skyline crests';
  } else if (role == 'Headline') {
    return 'Chapter heading';
  } else if (role == 'Title') {
    return 'Card title';
  } else if (role == 'Body') {
    return 'The quick brown fox jumps over the lazy dog.';
  }
  return 'BUTTON LABEL';
}

Color _roleColor(String role) {
  if (role == 'Display') return _kRoleDisplay;
  if (role == 'Headline') return _kRoleHeadline;
  if (role == 'Title') return _kRoleTitle;
  if (role == 'Body') return _kRoleBody;
  return _kRoleLabel;
}

String _styleSpecOf(TextStyle? s) {
  if (s == null) return '-';
  final String size = s.fontSize == null ? '?' : s.fontSize!.toStringAsFixed(0);
  final String weight = _weightTag(s.fontWeight);
  final String letter = s.letterSpacing == null
      ? ''
      : ', ls=${s.letterSpacing!.toStringAsFixed(2)}';
  return '${size}sp / $weight$letter';
}

String _weightTag(FontWeight? w) {
  if (w == null) return 'w?';
  if (w == FontWeight.w100) return 'w100';
  if (w == FontWeight.w200) return 'w200';
  if (w == FontWeight.w300) return 'w300';
  if (w == FontWeight.w400) return 'w400';
  if (w == FontWeight.w500) return 'w500';
  if (w == FontWeight.w600) return 'w600';
  if (w == FontWeight.w700) return 'w700';
  if (w == FontWeight.w800) return 'w800';
  if (w == FontWeight.w900) return 'w900';
  return 'w?';
}

// ---------------------------------------------------------------------------
// Section B: Typography preset comparison
// ---------------------------------------------------------------------------
Widget _buildTypographyComparisonSection() {
  // We hand-spec four presets because they are independent of the running
  // platform. Each row labels which preset uses which legacy/M3 name. Field
  // values are the published preset highlights.
  final List<_PresetRow> rows = <_PresetRow>[
    _PresetRow('Headline 1 / displayLarge', '96 / w300', '57 / w400'),
    _PresetRow('Headline 2 / displayMedium', '60 / w300', '45 / w400'),
    _PresetRow('Headline 3 / displaySmall', '48 / w400', '36 / w400'),
    _PresetRow('Headline 4 / headlineLarge', '34 / w400', '32 / w400'),
    _PresetRow('Headline 5 / headlineMedium', '24 / w400', '28 / w400'),
    _PresetRow('Headline 6 / headlineSmall', '20 / w500', '24 / w400'),
    _PresetRow('Subtitle 1 / titleLarge', '16 / w400', '22 / w500'),
    _PresetRow('Subtitle 2 / titleMedium', '14 / w500', '16 / w500'),
    _PresetRow('Body 1 / bodyLarge', '16 / w400', '16 / w400'),
    _PresetRow('Body 2 / bodyMedium', '14 / w400', '14 / w400'),
    _PresetRow('Button / labelLarge', '14 / w500 caps', '14 / w500'),
    _PresetRow('Caption / bodySmall', '12 / w400', '12 / w400'),
    _PresetRow('Overline / labelSmall', '10 / w400 caps', '11 / w500'),
  ];

  final List<Widget> rowWidgets = <Widget>[];
  rowWidgets.add(_presetHeaderRow());
  for (int i = 0; i < rows.length; i++) {
    rowWidgets.add(_presetDataRow(rows[i], i.isEven));
  }

  // Also surface a few Typography preset objects so we lean on the actual
  // Flutter API and not just literals.
  final Typography typo = Typography.material2021(platform: TargetPlatform.android);
  final Typography typoOld = Typography.material2018(platform: TargetPlatform.android);
  final Typography typoIos = Typography.material2021(platform: TargetPlatform.iOS);
  final Typography typoLinux = Typography.material2021(platform: TargetPlatform.linux);

  print('[texttheme_test] Typography.material2021 black.bodyMedium='
      '${typo.black.bodyMedium?.fontSize}');
  print('[texttheme_test] Typography.material2018 black.bodyMedium='
      '${typoOld.black.bodyMedium?.fontSize}');
  print('[texttheme_test] Typography.material2021 iOS black.titleLarge='
      '${typoIos.black.titleLarge?.fontSize}');
  print('[texttheme_test] Typography.material2021 linux black.titleLarge='
      '${typoLinux.black.titleLarge?.fontSize}');

  final List<TextStyle?> liveSizes = <TextStyle?>[
    typo.black.displayLarge,
    typo.black.headlineMedium,
    typo.black.titleLarge,
    typo.black.bodyMedium,
    typo.black.labelSmall,
  ];
  final List<String> liveLabels = <String>[
    'displayLarge',
    'headlineMedium',
    'titleLarge',
    'bodyMedium',
    'labelSmall',
  ];

  final List<Widget> liveChips = <Widget>[];
  for (int i = 0; i < liveLabels.length; i++) {
    final TextStyle? s = liveSizes[i];
    final String size = s?.fontSize == null ? '?' : s!.fontSize!.toStringAsFixed(0);
    liveChips.add(_pill('${liveLabels[i]} ${size}sp', _kAccentSoft, _kAccent));
  }

  return _sectionShell(
    title: 'B. Typography preset comparison',
    subtitle: 'Material 2018 (legacy) vs Material 2021 (M3) named-style sizing. '
        'Both presets ship through the Typography class.',
    accent: _kRoleHeadline,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _kHairline),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(children: rowWidgets),
        ),
        const SizedBox(height: 14),
        Text(
          'Live values from Typography.material2021(platform: android).black:',
          style: TextStyle(color: _kInkSoft, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: liveChips),
      ],
    ),
  );
}

Widget _presetHeaderRow() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: const BoxDecoration(
      color: _kSurfaceAlt,
      border: Border(bottom: BorderSide(color: _kHairline)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            'Named style (2018 / 2021)',
            style: TextStyle(
              color: _kInk,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Material 2018',
            style: TextStyle(
              color: _kInk,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Material 2021',
            style: TextStyle(
              color: _kInk,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _presetDataRow(_PresetRow row, bool zebra) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: zebra ? Colors.white : _kSurface,
      border: const Border(bottom: BorderSide(color: _kHairline)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            row.label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: _kInk,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            row.preset2018,
            style: const TextStyle(fontSize: 12, color: _kInkSoft),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            row.preset2021,
            style: const TextStyle(fontSize: 12, color: _kInkSoft),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section C: TextStyle.merge & copyWith recipes
// ---------------------------------------------------------------------------
Widget _buildMergeRecipeSection(TextTheme tt) {
  // Build a base, a partial, and the merged result so we can show side-by-side.
  final TextStyle base = (tt.titleLarge ?? const TextStyle()).copyWith(
    color: _kInk,
    fontWeight: FontWeight.w500,
  );
  final TextStyle partial = const TextStyle(
    color: _kAccent,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dotted,
    decorationColor: _kAccent,
  );
  final TextStyle merged = base.merge(partial);

  final TextStyle copyExample = base.copyWith(
    color: _kRoleDisplay,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
  );

  // ApplyExample - bulk transform via TextStyle.apply
  final TextStyle appliedExample = base.apply(
    color: _kRoleBody,
    fontSizeFactor: 1.1,
    decoration: TextDecoration.overline,
  );

  return _sectionShell(
    title: 'C. TextStyle.merge / copyWith / apply',
    subtitle: 'Three independent recipes for layering style attributes. '
        'merge picks non-null fields from the argument, copyWith only changes '
        'the explicitly named fields, and apply transforms numeric attributes.',
    accent: _kRoleTitle,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _recipeCard('base', 'titleLarge starting point', base, 'Quartz Headline'),
        const SizedBox(height: 10),
        _recipeCard(
          'partial',
          'Layer applied via .merge(partial)',
          partial,
          'Quartz Headline',
        ),
        const SizedBox(height: 10),
        _recipeCard(
          'base.merge(partial)',
          'Result: italic underline + accent color, weight preserved',
          merged,
          'Quartz Headline',
        ),
        const SizedBox(height: 14),
        _recipeCard(
          'base.copyWith(...)',
          'Only the named fields change; everything else inherits from base',
          copyExample,
          'Quartz Headline',
        ),
        const SizedBox(height: 10),
        _recipeCard(
          'base.apply(...)',
          'Numeric/color transform - fontSizeFactor: 1.1, color, overline',
          appliedExample,
          'Quartz Headline',
        ),
      ],
    ),
  );
}

Widget _recipeCard(String label, String description, TextStyle style, String sample) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _kHairline),
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _kAccentSoft,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: _kAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(sample, style: style),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section D: FontWeight ladder w100 .. w900
// ---------------------------------------------------------------------------
Widget _buildWeightLadderSection(TextTheme tt) {
  final List<_WeightStop> stops = <_WeightStop>[
    _WeightStop('w100', FontWeight.w100, 'Thin / Hairline'),
    _WeightStop('w200', FontWeight.w200, 'Extra Light'),
    _WeightStop('w300', FontWeight.w300, 'Light'),
    _WeightStop('w400', FontWeight.w400, 'Regular / FontWeight.normal'),
    _WeightStop('w500', FontWeight.w500, 'Medium'),
    _WeightStop('w600', FontWeight.w600, 'Semi Bold'),
    _WeightStop('w700', FontWeight.w700, 'Bold / FontWeight.bold'),
    _WeightStop('w800', FontWeight.w800, 'Extra Bold'),
    _WeightStop('w900', FontWeight.w900, 'Black'),
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < stops.length; i++) {
    final _WeightStop s = stops[i];
    rows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.white : _kSurface,
          border: i == stops.length - 1
              ? null
              : const Border(bottom: BorderSide(color: _kHairline)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 50,
              child: Text(
                s.tag,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: _kInkSoft,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Aurora typography ladder',
                style: tt.titleLarge?.copyWith(
                  fontWeight: s.weight,
                  color: _kInk,
                ),
              ),
            ),
            SizedBox(
              width: 140,
              child: Text(
                s.note,
                textAlign: TextAlign.right,
                style: const TextStyle(color: _kInkSoft, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    title: 'D. FontWeight ladder',
    subtitle: 'Nine canonical weights w100 to w900. FontWeight.normal == w400, '
        'FontWeight.bold == w700.',
    accent: _kRoleBody,
    body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kHairline),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: rows),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section E: FontStyle italic vs normal
// ---------------------------------------------------------------------------
Widget _buildItalicSection(TextTheme tt) {
  final TextStyle headline = tt.headlineSmall ?? const TextStyle(fontSize: 24);

  return _sectionShell(
    title: 'E. FontStyle.italic vs FontStyle.normal',
    subtitle: 'FontStyle is an independent axis from FontWeight. It applies a '
        'true italic glyph variant where the font provides one.',
    accent: _kRoleLabel,
    body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kHairline),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'FontStyle.normal',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: _kInkSoft,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Calm river flows',
                      style: headline.copyWith(
                        color: _kInk,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'FontStyle.italic',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: _kInkSoft,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Calm river flows',
                      style: headline.copyWith(
                        color: _kAccent,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: _kHairline, height: 1),
          const SizedBox(height: 12),
          Text(
            'Italics also compose with weight. Below: w300 italic + w700 italic.',
            style: tt.bodySmall?.copyWith(color: _kInkSoft),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Whispered headline',
                  style: headline.copyWith(
                    color: _kInk,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Whispered headline',
                  style: headline.copyWith(
                    color: _kRoleDisplay,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section F: FontFeature samples
// ---------------------------------------------------------------------------
Widget _buildFeatureSection(TextTheme tt) {
  final List<_FeatureRow> rows = <_FeatureRow>[
    _FeatureRow(
      'tnum',
      'Tabular figures - all digits get equal advance width, ideal for tables.',
      <FontFeature>[FontFeature.tabularFigures()],
      '1234567890\n0192837465',
    ),
    _FeatureRow(
      'pnum',
      'Proportional figures - default mode, digits use their natural width.',
      <FontFeature>[FontFeature.proportionalFigures()],
      '1234567890\n0192837465',
    ),
    _FeatureRow(
      'onum',
      'Old-style figures - some digits descend below the baseline.',
      <FontFeature>[FontFeature.oldstyleFigures()],
      '1234567890',
    ),
    _FeatureRow(
      'lnum',
      'Lining figures - all digits sit on the baseline at cap height.',
      <FontFeature>[FontFeature.liningFigures()],
      '1234567890',
    ),
    _FeatureRow(
      'smcp',
      'Small caps - lowercase letters render as small uppercase glyphs.',
      <FontFeature>[FontFeature.enable('smcp')],
      'Small Caps Headline',
    ),
    _FeatureRow(
      'liga',
      'Standard ligatures - common pairs render as single glyphs (fi, fl).',
      <FontFeature>[FontFeature.enable('liga')],
      'fish fly waffles',
    ),
    _FeatureRow(
      'dlig',
      'Discretionary ligatures - opt-in stylistic ligatures.',
      <FontFeature>[FontFeature.enable('dlig')],
      'ct st discretionary',
    ),
    _FeatureRow(
      'frac',
      'Fractions - sequences like 1/2 render as a single fraction glyph.',
      <FontFeature>[FontFeature.enable('frac')],
      '1/2 3/4 7/8',
    ),
    _FeatureRow(
      'ss01',
      'Stylistic set 1 - font-specific alternate glyph set.',
      <FontFeature>[FontFeature.stylisticSet(1)],
      'Stylistic Set One',
    ),
    _FeatureRow(
      'cv01',
      'Character variant 1 - font-specific alternate per character.',
      <FontFeature>[FontFeature.alternative(1)],
      'Character Variant',
    ),
  ];

  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    cards.add(_featureCard(tt, rows[i]));
    if (i != rows.length - 1) cards.add(const SizedBox(height: 10));
  }

  return _sectionShell(
    title: 'F. FontFeature OpenType samples',
    subtitle: 'OpenType feature tags exposed via dart:ui FontFeature. Most '
        'tags require font support to produce a visible difference.',
    accent: _kRoleHeadline,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cards,
    ),
  );
}

Widget _featureCard(TextTheme tt, _FeatureRow row) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _kHairline),
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _kRoleTitle.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                row.tag,
                style: const TextStyle(
                  color: _kRoleTitle,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                row.description,
                style: const TextStyle(
                  color: _kInkSoft,
                  fontSize: 12,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          row.sample,
          style: tt.titleMedium?.copyWith(
            color: _kInk,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontFeatures: row.features,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section G: FontVariation axes
// ---------------------------------------------------------------------------
Widget _buildVariationSection(TextTheme tt) {
  final List<_VariationRow> rows = <_VariationRow>[
    _VariationRow('wght', 300, 'Weight axis - light end'),
    _VariationRow('wght', 500, 'Weight axis - medium'),
    _VariationRow('wght', 800, 'Weight axis - heavy'),
    _VariationRow('wdth', 75, 'Width axis - condensed'),
    _VariationRow('wdth', 100, 'Width axis - normal'),
    _VariationRow('wdth', 125, 'Width axis - extended'),
    _VariationRow('opsz', 14, 'Optical size axis - body copy'),
    _VariationRow('opsz', 72, 'Optical size axis - display'),
    _VariationRow('slnt', -10, 'Slant axis - negative slant'),
    _VariationRow('slnt', 0, 'Slant axis - upright'),
  ];

  final List<Widget> rowWidgets = <Widget>[];
  for (int i = 0; i < rows.length; i++) {
    final _VariationRow row = rows[i];
    rowWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.white : _kSurface,
          border: i == rows.length - 1
              ? null
              : const Border(bottom: BorderSide(color: _kHairline)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 60,
              child: Text(
                row.axis,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: _kInkSoft,
                ),
              ),
            ),
            SizedBox(
              width: 60,
              child: Text(
                row.value.toStringAsFixed(0),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: _kInk,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Variable axis preview',
                style: tt.titleMedium?.copyWith(
                  color: _kInk,
                  fontVariations: <FontVariation>[
                    FontVariation(row.axis, row.value),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 180,
              child: Text(
                row.description,
                textAlign: TextAlign.right,
                style: const TextStyle(color: _kInkSoft, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return _sectionShell(
    title: 'G. FontVariation axes',
    subtitle: 'Variable fonts expose continuous axes via four-character tags. '
        'wght, wdth, opsz, slnt are the canonical registered axes.',
    accent: _kRoleDisplay,
    body: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _kHairline),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: rowWidgets),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section H: Theme.of(context).textTheme + ThemeData.textTheme + DefaultTextStyle
// ---------------------------------------------------------------------------
Widget _buildContextThemeSection(TextTheme tt) {
  return _sectionShell(
    title: 'H. Theme.of(context).textTheme and DefaultTextStyle',
    subtitle: 'Three layered ways the framework resolves the actual TextStyle '
        'applied to a Text widget.',
    accent: _kRoleTitle,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _layerCard(
          '1. ThemeData.textTheme',
          'Set at MaterialApp construction. Defines all 15 roles workspace-wide. '
          'Components read this through Theme.of(context).textTheme.',
          tt.bodyMedium,
        ),
        const SizedBox(height: 10),
        _layerCard(
          '2. Theme(data: ThemeData.copyWith(textTheme: ...))',
          'A nested Theme overrides selected roles for its subtree.',
          tt.bodyMedium,
        ),
        const SizedBox(height: 10),
        _layerCard(
          '3. DefaultTextStyle.merge(style: TextStyle(...))',
          'Direct style overlay - merges into the inherited default for child '
          'Text widgets without going through ThemeData.',
          tt.bodyMedium,
        ),
        const SizedBox(height: 14),
        // Live nested Theme demonstration.
        Builder(builder: (BuildContext outerContext) {
        return Theme(
          data: Theme.of(outerContext).copyWith(
            textTheme: tt.copyWith(
              titleLarge: tt.titleLarge?.copyWith(
                color: _kRoleHeadline,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          child: Builder(
            builder: (BuildContext nestedContext) {
              final TextStyle? nestedTitle =
                  Theme.of(nestedContext).textTheme.titleLarge;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: _kHairline),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Nested Theme override',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: _kInkSoft,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('Resolved titleLarge', style: nestedTitle),
                  ],
                ),
              );
            },
          ),
        );
        }),
        const SizedBox(height: 10),
        DefaultTextStyle(
          style: TextStyle(
            color: _kRoleBody,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _kHairline),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'DefaultTextStyle overlay',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: _kInkSoft,
                  ),
                ),
                SizedBox(height: 6),
                Text('All raw Text widgets in this subtree inherit this style.'),
                SizedBox(height: 2),
                Text('Including nested rows like this one.'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _layerCard(String label, String body, TextStyle? bodyStyle) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _kHairline),
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            color: _kAccent,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(body, style: bodyStyle?.copyWith(color: _kInk)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section I: TextStyle.inherit semantics
// ---------------------------------------------------------------------------
Widget _buildInheritSection(TextTheme tt) {
  // When inherit is true, the style merges with the closest DefaultTextStyle.
  // When false, the style stands alone - missing fields use framework defaults.
  final TextStyle inheriting = TextStyle(
    inherit: true,
    color: _kRoleHeadline,
    fontWeight: FontWeight.w600,
  );

  final TextStyle standalone = TextStyle(
    inherit: false,
    color: _kRoleBody,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    fontFamily: 'sans-serif',
    height: 1.3,
    decoration: TextDecoration.none,
  );

  return _sectionShell(
    title: 'I. TextStyle.inherit explained',
    subtitle: 'inherit:true merges with the ambient DefaultTextStyle, '
        'inherit:false fully replaces it.',
    accent: _kRoleBody,
    body: DefaultTextStyle(
      style: TextStyle(
        color: _kInkSoft,
        fontSize: 14,
        fontStyle: FontStyle.italic,
        decoration: TextDecoration.underline,
        decorationStyle: TextDecorationStyle.wavy,
        decorationColor: _kAccentSoft,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _kHairline),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Ambient DefaultTextStyle: italic + wavy underline',
              style: tt.bodySmall?.copyWith(color: _kInkSoft),
            ),
            const SizedBox(height: 12),
            const Text('Pure ambient: this Text has no explicit style.'),
            const SizedBox(height: 10),
            Text(
              'Inheriting Text: color + weight set, italic + underline kept.',
              style: inheriting,
            ),
            const SizedBox(height: 10),
            Text(
              'Standalone Text: inherit:false drops italic and underline.',
              style: standalone,
            ),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section shell - shared chrome around each topic
// ---------------------------------------------------------------------------
Widget _sectionShell({
  required String title,
  required String subtitle,
  required Color accent,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _kSurfaceAlt,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _kHairline),
    ),
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8,
              height: 28,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: _kInkSoft,
            fontSize: 13,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        body,
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// End of file
// ---------------------------------------------------------------------------
