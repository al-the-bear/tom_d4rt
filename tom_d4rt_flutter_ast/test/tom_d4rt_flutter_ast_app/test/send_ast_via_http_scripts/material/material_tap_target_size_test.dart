// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
/// Deep visual demo for MaterialTapTargetSize (padded, shrinkWrap).
///
/// Design plan:
/// - Hand-authored, fully stateless. Root: MaterialApp -> Scaffold ->
///   SingleChildScrollView -> Column. No StatefulWidget, no controllers, no
///   timers, no async, no navigation.
/// - Material 3 ColorScheme via ColorScheme.fromSeed.
/// - 12 numbered sections, each prints `=== Section N: <title> ===` and
///   renders real widgets:
///   1) Header gradient banner introducing the enum.
///   2) The 48dp accessibility minimum (WCAG / Material rationale).
///   3) Enum constants side-by-side (padded vs shrinkWrap diagrams).
///   4) Side-by-side button rows: IconButton, TextButton, ElevatedButton
///      under each tap target size with translucent red 48x48 overlay.
///   5) Toggle controls (Checkbox / Radio / Switch) sized comparison.
///   6) Wrap layouts: dense (shrinkWrap) vs comfortable (padded).
///   7) ThemeData.materialTapTargetSize theming demo with two nested
///      Theme widgets so consumers can observe inheritance.
///   8) Recipe cards: toolbar, settings form, card actions.
///   9) Accessibility implications: hit-target heatmap visualisation.
///  10) Decision matrix: when to choose padded vs shrinkWrap.
///  11) Anti-patterns and pitfalls.
///  12) Glossary + summary recipes.
/// - All ASCII narrative. No emoji.
library;

import 'package:flutter/material.dart';

// ===========================================================================
// Theme tokens. Material 3 ColorScheme idioms surfaced as top-level helpers
// so every section can pull from one consistent palette.
// ===========================================================================

const Color _kSeed = Color(0xFF3E63DD);

ColorScheme _scheme() => ColorScheme.fromSeed(
  seedColor: _kSeed,
  brightness: Brightness.light,
);

ColorScheme _schemeDark() => ColorScheme.fromSeed(
  seedColor: _kSeed,
  brightness: Brightness.dark,
);

void _noop() {}

// ===========================================================================
// Entry point. Required by HARD CONSTRAINT 7.
// ===========================================================================

dynamic build(BuildContext context) => const MaterialTapTargetSizeDemoApp();

// ===========================================================================
// Root application widget. Stateless. Returns MaterialApp -> Scaffold ->
// SingleChildScrollView -> Column as mandated.
// ===========================================================================

class MaterialTapTargetSizeDemoApp extends StatelessWidget {
  const MaterialTapTargetSizeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('MaterialTapTargetSize Deep Demo executing');
    final ColorScheme scheme = _scheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MaterialTapTargetSize Deep Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontWeight: FontWeight.w800),
          titleLarge: TextStyle(fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(height: 1.35),
        ),
      ),
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const _HeaderBanner(),
              const SizedBox(height: 28.0),
              const _SectionAccessibilityMinimum(),
              const SizedBox(height: 28.0),
              const _SectionEnumConstants(),
              const SizedBox(height: 28.0),
              const _SectionButtonRows(),
              const SizedBox(height: 28.0),
              const _SectionToggles(),
              const SizedBox(height: 28.0),
              const _SectionWrapDensity(),
              const SizedBox(height: 28.0),
              const _SectionThemeOverride(),
              const SizedBox(height: 28.0),
              const _SectionRecipes(),
              const SizedBox(height: 28.0),
              const _SectionAccessibilityHeatmap(),
              const SizedBox(height: 28.0),
              const _SectionDecisionMatrix(),
              const SizedBox(height: 28.0),
              const _SectionAntipatterns(),
              const SizedBox(height: 28.0),
              const _SectionGlossary(),
              const SizedBox(height: 36.0),
              const _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// SECTION 1: Header gradient banner.
// ===========================================================================

class _HeaderBanner extends StatelessWidget {
  const _HeaderBanner();

  @override
  Widget build(BuildContext context) {
    print('=== Section 1: Header Banner ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primary,
            scheme.tertiary,
            scheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.25),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
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
                  Icons.touch_app_outlined,
                  size: 32.0,
                  color: scheme.onPrimary,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'MaterialTapTargetSize',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                        color: scheme.onPrimary,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'padded   vs   shrinkWrap',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: scheme.onPrimary.withValues(alpha: 0.85),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          Text(
            'A two-value enum that controls whether Material widgets reserve '
            'a 48dp x 48dp hit region. Used by IconButton, TextButton, '
            'ElevatedButton, Checkbox, Radio, Switch, and many other tappable '
            'widgets via ThemeData.materialTapTargetSize.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: scheme.onPrimary.withValues(alpha: 0.95),
            ),
          ),
          const SizedBox(height: 14.0),
          Wrap(
            spacing: 10.0,
            runSpacing: 8.0,
            children: <Widget>[
              _bannerChip(scheme, 'enum', Icons.code),
              _bannerChip(scheme, '2 constants', Icons.looks_two_outlined),
              _bannerChip(scheme, '48dp guideline', Icons.accessibility_new),
              _bannerChip(scheme, 'theme-aware', Icons.color_lens_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bannerChip(ColorScheme scheme, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: scheme.onPrimary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14.0, color: scheme.onPrimary),
          const SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: scheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 2: The 48dp accessibility minimum.
// ===========================================================================

class _SectionAccessibilityMinimum extends StatelessWidget {
  const _SectionAccessibilityMinimum();

  @override
  Widget build(BuildContext context) {
    print('=== Section 2: The 48dp Accessibility Minimum ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _SectionFrame(
      number: 2,
      title: 'The 48dp accessibility minimum',
      blurb:
          'Material guidelines and most accessibility standards (WCAG 2.5.5, '
          'Apple HIG, Android Accessibility) prescribe a minimum touch target '
          'of roughly 48dp x 48dp. MaterialTapTargetSize.padded enforces this '
          'on common Material widgets; shrinkWrap opts out.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _measurementCard(
                  scheme: scheme,
                  title: 'Reference: 48 x 48 logical pixels',
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.20),
                          border: Border.all(
                            color: Colors.red.withValues(alpha: 0.55),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: scheme.primary.withValues(alpha: 0.85),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16.0,
                          color: scheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _measurementCard(
                  scheme: scheme,
                  title: 'Visual element: 24dp icon glyph',
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: scheme.tertiary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.star,
                          size: 16.0,
                          color: scheme.onTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _measurementCard(
                  scheme: scheme,
                  title: 'Padded composite: glyph + 12dp ring',
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          color: scheme.primaryContainer,
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.bolt,
                          size: 14.0,
                          color: scheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          _factBox(
            scheme,
            <_Fact>[
              const _Fact(
                Icons.straighten,
                '48 logical pixels is approximately 9mm on a typical mobile '
                'display.',
              ),
              const _Fact(
                Icons.touch_app,
                'Approximates the average adult finger pad contact area '
                '(Henze et al. 2011: 8 to 10mm).',
              ),
              const _Fact(
                Icons.rule,
                'WCAG 2.5.5 (AAA) requires at least 44 CSS pixels; Material '
                'uses 48 to give a small safety margin.',
              ),
              const _Fact(
                Icons.warning_amber_outlined,
                'Tap targets below ~40dp produce a measurable spike in '
                'mis-tap rates, especially in motion or for users with '
                'tremor.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _measurementCard({
    required ColorScheme scheme,
    required String title,
    required Widget child,
  }) {
    return Container(
      height: 168.0,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        border: Border.all(color: scheme.outlineVariant),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(child: Center(child: child)),
        ],
      ),
    );
  }

  Widget _factBox(ColorScheme scheme, List<_Fact> facts) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final _Fact f in facts)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(f.icon, size: 18.0, color: scheme.secondary),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      f.text,
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.4,
                        color: scheme.onSecondaryContainer,
                      ),
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

class _Fact {
  final IconData icon;
  final String text;
  const _Fact(this.icon, this.text);
}

// ===========================================================================
// SECTION 3: Enum constants side-by-side.
// ===========================================================================

class _SectionEnumConstants extends StatelessWidget {
  const _SectionEnumConstants();

  @override
  Widget build(BuildContext context) {
    print('=== Section 3: Enum Constants ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _SectionFrame(
      number: 3,
      title: 'Enum constants: padded and shrinkWrap',
      blurb:
          'MaterialTapTargetSize has exactly two values. Both diagrams below '
          'show the same visual glyph; only the reserved hit region differs.',
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _enumCard(
                  scheme: scheme,
                  accent: scheme.primary,
                  accentContainer: scheme.primaryContainer,
                  onAccentContainer: scheme.onPrimaryContainer,
                  title: 'padded',
                  oneLiner:
                      'Hit region inflated to a minimum of 48 x 48 logical '
                      'pixels.',
                  bullets: const <String>[
                    'Default for most public-facing apps.',
                    'Default value on ThemeData when platform is touch.',
                    'Adds invisible padding around the visible glyph.',
                    'Recommended for IconButtons in toolbars and FABs.',
                  ],
                  diagram: const _HitRegionDiagram(showHitRegion: true),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _enumCard(
                  scheme: scheme,
                  accent: scheme.tertiary,
                  accentContainer: scheme.tertiaryContainer,
                  onAccentContainer: scheme.onTertiaryContainer,
                  title: 'shrinkWrap',
                  oneLiner:
                      'Hit region equals the visible bounds. No extra padding.',
                  bullets: const <String>[
                    'Used for dense desktop / data-heavy UIs.',
                    'Required for tight Wrap or Row layouts.',
                    'Accessibility risk on touch devices.',
                    'Common inside data tables and inline editors.',
                  ],
                  diagram: const _HitRegionDiagram(showHitRegion: false),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.info_outline, size: 20.0, color: scheme.primary),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Tip: the visible glyph never changes. Only the padding '
                    'that intercepts pointer events does. To prove this, look '
                    'at the red overlays in Section 4.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: scheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _enumCard({
    required ColorScheme scheme,
    required Color accent,
    required Color accentContainer,
    required Color onAccentContainer,
    required String title,
    required String oneLiner,
    required List<String> bullets,
    required Widget diagram,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        border: Border.all(color: accent.withValues(alpha: 0.55), width: 1.2),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: accentContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'MaterialTapTargetSize.$title',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: onAccentContainer,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            oneLiner,
            style: TextStyle(
              fontSize: 13.0,
              height: 1.45,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 14.0),
          Center(child: diagram),
          const SizedBox(height: 14.0),
          for (final String b in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.circle, size: 7.0, color: accent),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      b,
                      style: TextStyle(
                        fontSize: 12.0,
                        height: 1.4,
                        color: scheme.onSurfaceVariant,
                      ),
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

class _HitRegionDiagram extends StatelessWidget {
  final bool showHitRegion;
  const _HitRegionDiagram({required this.showHitRegion});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 140.0,
      height: 110.0,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (showHitRegion)
            Container(
              width: 96.0,
              height: 96.0,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.13),
                border: Border.all(
                  color: Colors.red.withValues(alpha: 0.50),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(Icons.favorite, size: 24.0, color: scheme.onPrimary),
          ),
          Positioned(
            bottom: 0.0,
            child: Text(
              showHitRegion ? 'hit: 96 (scaled view of 48)' : 'hit: 48 (raw)',
              style: TextStyle(
                fontSize: 10.5,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 4: Button rows with measurement overlays.
// ===========================================================================

class _SectionButtonRows extends StatelessWidget {
  const _SectionButtonRows();

  @override
  Widget build(BuildContext context) {
    print('=== Section 4: Button Rows With Overlays ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _SectionFrame(
      number: 4,
      title: 'Buttons under each tap target size',
      blurb:
          'Each tile renders a button on top of a translucent red 48 x 48 '
          'reference square. Where the red bleeds past the visible button, '
          'that bleed IS the hit region that padded reserves.',
      child: Column(
        children: <Widget>[
          _buttonRow(
            scheme,
            label: 'MaterialTapTargetSize.padded',
            accent: scheme.primary,
            tapTargetSize: MaterialTapTargetSize.padded,
          ),
          const SizedBox(height: 16.0),
          _buttonRow(
            scheme,
            label: 'MaterialTapTargetSize.shrinkWrap',
            accent: scheme.tertiary,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _buttonRow(
    ColorScheme scheme, {
    required String label,
    required Color accent,
    required MaterialTapTargetSize tapTargetSize,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _overlayedButton(
                label: 'IconButton',
                child: IconButton(
                  onPressed: _noop,
                  icon: const Icon(Icons.menu),
                  style: IconButton.styleFrom(tapTargetSize: tapTargetSize),
                ),
              ),
              _overlayedButton(
                label: 'TextButton',
                child: TextButton(
                  onPressed: _noop,
                  style: TextButton.styleFrom(tapTargetSize: tapTargetSize),
                  child: const Text('Save'),
                ),
              ),
              _overlayedButton(
                label: 'ElevatedButton',
                child: ElevatedButton(
                  onPressed: _noop,
                  style: ElevatedButton.styleFrom(tapTargetSize: tapTargetSize),
                  child: const Text('Submit'),
                ),
              ),
              _overlayedButton(
                label: 'OutlinedButton',
                child: OutlinedButton(
                  onPressed: _noop,
                  style: OutlinedButton.styleFrom(tapTargetSize: tapTargetSize),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overlayedButton({required String label, required Widget child}) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 96.0,
          height: 64.0,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.18),
                  border: Border.all(
                    color: Colors.red.withValues(alpha: 0.55),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              child,
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

// ===========================================================================
// SECTION 5: Toggle controls (Checkbox / Radio / Switch).
// ===========================================================================

class _SectionToggles extends StatelessWidget {
  const _SectionToggles();

  @override
  Widget build(BuildContext context) {
    print('=== Section 5: Toggle Controls ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _SectionFrame(
      number: 5,
      title: 'Checkbox, Radio, Switch under each tap target size',
      blurb:
          'Toggle widgets also honour materialTapTargetSize. In settings '
          'forms the padded variant is almost always correct; shrinkWrap is '
          'useful for filter chips and table-cell editors.',
      child: Column(
        children: <Widget>[
          _toggleRow(
            scheme,
            tapTargetSize: MaterialTapTargetSize.padded,
            label: 'padded',
            accent: scheme.primary,
          ),
          const SizedBox(height: 16.0),
          _toggleRow(
            scheme,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            label: 'shrinkWrap',
            accent: scheme.tertiary,
          ),
        ],
      ),
    );
  }

  Widget _toggleRow(
    ColorScheme scheme, {
    required MaterialTapTargetSize tapTargetSize,
    required String label,
    required Color accent,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.0),
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
            ],
          ),
          const SizedBox(height: 14.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _toggleTile(
                label: 'Checkbox',
                child: Checkbox(
                  value: true,
                  onChanged: (_) {},
                  materialTapTargetSize: tapTargetSize,
                ),
              ),
              _toggleTile(
                label: 'Radio',
                child: Radio<int>(
                  value: 1,
                  groupValue: 1,
                  onChanged: (_) {},
                  materialTapTargetSize: tapTargetSize,
                ),
              ),
              _toggleTile(
                label: 'Switch',
                child: Switch(
                  value: true,
                  onChanged: (_) {},
                  materialTapTargetSize: tapTargetSize,
                ),
              ),
              _toggleTile(
                label: 'Checkbox (off)',
                child: Checkbox(
                  value: false,
                  onChanged: (_) {},
                  materialTapTargetSize: tapTargetSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _toggleTile({required String label, required Widget child}) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 96.0,
          height: 64.0,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 48.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.18),
                  border: Border.all(
                    color: Colors.red.withValues(alpha: 0.55),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
              child,
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

// ===========================================================================
// SECTION 6: Wrap layouts demonstrating density.
// ===========================================================================

class _SectionWrapDensity extends StatelessWidget {
  const _SectionWrapDensity();

  @override
  Widget build(BuildContext context) {
    print('=== Section 6: Wrap Density Comparison ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;
    const List<String> tags = <String>[
      'tag-1',
      'tag-2',
      'mid-length',
      'longish-label',
      'x',
      'one',
      'two',
      'three',
      'tag-9',
      'tag-10',
      'tag-11',
      'tag-12',
    ];

    return _SectionFrame(
      number: 6,
      title: 'Wrap layouts: padded vs shrinkWrap density',
      blurb:
          'When you cram many tappable elements into a Wrap, padded inflates '
          'every child by ~16dp on both axes. Below: the same 12 OutlinedButton '
          'tags rendered with each value. Notice how shrinkWrap can fit two '
          'extra rows worth of content in the same width.',
      child: Column(
        children: <Widget>[
          _wrapPanel(
            scheme,
            label: 'padded (accessible, ~9mm targets)',
            accent: scheme.primary,
            tapTargetSize: MaterialTapTargetSize.padded,
            tags: tags,
          ),
          const SizedBox(height: 18.0),
          _wrapPanel(
            scheme,
            label: 'shrinkWrap (dense, desktop)',
            accent: scheme.tertiary,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            tags: tags,
          ),
        ],
      ),
    );
  }

  Widget _wrapPanel(
    ColorScheme scheme, {
    required String label,
    required Color accent,
    required MaterialTapTargetSize tapTargetSize,
    required List<String> tags,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              for (final String t in tags)
                OutlinedButton(
                  onPressed: _noop,
                  style: OutlinedButton.styleFrom(
                    tapTargetSize: tapTargetSize,
                    visualDensity:
                        tapTargetSize == MaterialTapTargetSize.shrinkWrap
                        ? VisualDensity.compact
                        : VisualDensity.standard,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 8.0,
                    ),
                  ),
                  child: Text(t),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 7: ThemeData override demo.
// ===========================================================================

class _SectionThemeOverride extends StatelessWidget {
  const _SectionThemeOverride();

  @override
  Widget build(BuildContext context) {
    print('=== Section 7: ThemeData Override ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _SectionFrame(
      number: 7,
      title: 'ThemeData.materialTapTargetSize and nesting',
      blurb:
          'Most apps set the tap target size once on the root ThemeData. The '
          'two boxes below host an identical IconButton + Switch pair inside '
          'nested Theme widgets so consumers see the inherited value applied '
          'without per-call style overrides.',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _themedScopeCard(
              scheme: scheme,
              accent: scheme.primary,
              label: 'Theme: padded',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: scheme,
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: _themedScopeCard(
              scheme: scheme,
              accent: scheme.tertiary,
              label: 'Theme: shrinkWrap',
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: scheme,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _themedScopeCard({
    required ColorScheme scheme,
    required Color accent,
    required String label,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              color: accent,
            ),
          ),
          const SizedBox(height: 12.0),
          Theme(
            data: theme,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(onPressed: _noop, icon: const Icon(Icons.add)),
                      IconButton(
                        onPressed: _noop,
                        icon: const Icon(Icons.edit_outlined),
                      ),
                      IconButton(
                        onPressed: _noop,
                        icon: const Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                  const Divider(height: 18.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Checkbox(value: true, onChanged: (_) {}),
                      Switch(value: false, onChanged: (_) {}),
                      Radio<int>(
                        value: 1,
                        groupValue: 1,
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextButton(onPressed: _noop, child: const Text('TXT')),
                      ElevatedButton(
                        onPressed: _noop,
                        child: const Text('ELV'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 8: Recipe cards for common contexts.
// ===========================================================================

class _SectionRecipes extends StatelessWidget {
  const _SectionRecipes();

  @override
  Widget build(BuildContext context) {
    print('=== Section 8: Recipes ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return _SectionFrame(
      number: 8,
      title: 'Recipes: when to pick which value',
      blurb:
          'Three opinionated, copy-pasteable patterns for the most common '
          'screens. The narrative for each recipe explains the trade-off.',
      child: Column(
        children: <Widget>[
          _recipeCard(
            scheme: scheme,
            accent: scheme.primary,
            title: 'Toolbar / app bar actions',
            recommendation: 'padded',
            rationale:
                'Toolbar IconButtons are touched while scrolling. The 48dp '
                'pad protects users from accidentally tapping the wrong '
                'icon. The visual gap is enforced by the theme, so the '
                'padding matches across every toolbar in the app.',
            preview: Container(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 6.0,
              ),
              child: Row(
                children: <Widget>[
                  IconButton(onPressed: _noop, icon: const Icon(Icons.menu)),
                  const Spacer(),
                  Text(
                    'Inbox',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _noop,
                    icon: const Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: _noop,
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          _recipeCard(
            scheme: scheme,
            accent: scheme.secondary,
            title: 'Settings form rows',
            recommendation: 'padded',
            rationale:
                'A settings row pairs a label with a Switch or Checkbox. '
                'Padded keeps the trailing toggle aligned with the row '
                'height (at least 48dp) and prevents stacking artefacts '
                'when row subtitles wrap to two lines.',
            preview: Container(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  _settingsRow('Notifications', true),
                  const Divider(height: 1.0),
                  _settingsRow('Dark mode (system)', false),
                  const Divider(height: 1.0),
                  _settingsRow('Auto-update modules', true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          _recipeCard(
            scheme: scheme,
            accent: scheme.tertiary,
            title: 'Data card inline actions',
            recommendation: 'shrinkWrap',
            rationale:
                'Cards rendered inside dense feeds (price lists, dashboards, '
                'commit graphs) often pack a dozen actions per row. '
                'shrinkWrap collapses the empty padding around each button '
                'so the action cluster fits without overflow.',
            preview: Container(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'PR #4827  Refactor scheduler heuristics',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _denseIconButton(Icons.thumb_up_outlined, scheme),
                  _denseIconButton(Icons.comment_outlined, scheme),
                  _denseIconButton(Icons.flag_outlined, scheme),
                  _denseIconButton(Icons.merge_outlined, scheme),
                  _denseIconButton(Icons.more_horiz, scheme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsRow(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label)),
          Switch(
            value: value,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }

  Widget _denseIconButton(IconData icon, ColorScheme scheme) {
    return IconButton(
      onPressed: _noop,
      icon: Icon(icon, size: 16.0),
      style: IconButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.all(4.0),
        foregroundColor: scheme.onSurfaceVariant,
      ),
    );
  }

  Widget _recipeCard({
    required ColorScheme scheme,
    required Color accent,
    required String title,
    required String recommendation,
    required String rationale,
    required Widget preview,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  recommendation,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                ),
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
          const SizedBox(height: 10.0),
          preview,
          const SizedBox(height: 10.0),
          Text(
            rationale,
            style: TextStyle(
              fontSize: 12.0,
              height: 1.45,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SECTION 9: Accessibility heatmap.
// ===========================================================================

class _SectionAccessibilityHeatmap extends StatelessWidget {
  const _SectionAccessibilityHeatmap();

  @override
  Widget build(BuildContext context) {
    print('=== Section 9: Accessibility Heatmap ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    // Synthetic mis-tap percentages per target size for illustration.
    const List<_HeatRow> rows = <_HeatRow>[
      _HeatRow('< 24dp', 38, 'unusable'),
      _HeatRow('24dp', 24, 'high error'),
      _HeatRow('32dp', 14, 'risky'),
      _HeatRow('40dp', 8, 'borderline'),
      _HeatRow('44dp', 5, 'minimum WCAG'),
      _HeatRow('48dp', 3, 'Material padded'),
      _HeatRow('56dp', 2, 'FAB territory'),
      _HeatRow('64dp', 2, 'desktop only'),
    ];

    return _SectionFrame(
      number: 9,
      title: 'Accessibility heatmap',
      blurb:
          'Illustrative mis-tap percentages by target size. Numbers are '
          'representative of figures reported in mobile UX literature; '
          'they are NOT precise empirical values. Use to argue against '
          'shrinkWrap on touch screens.',
      child: Column(
        children: <Widget>[
          for (final _HeatRow r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: _heatBar(r, scheme),
            ),
          const SizedBox(height: 12.0),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: scheme.errorContainer.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.warning_amber_outlined,
                  size: 18.0,
                  color: scheme.error,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'When using shrinkWrap on a mobile screen, manually pad '
                    'the surrounding container so the effective touch '
                    'rectangle stays around 48dp.',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: scheme.onErrorContainer,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _heatBar(_HeatRow r, ColorScheme scheme) {
    final double fraction = (r.errorPercent / 40.0).clamp(0.0, 1.0);
    final Color barColor = Color.lerp(
      scheme.tertiary,
      scheme.error,
      fraction,
    )!;
    return Row(
      children: <Widget>[
        SizedBox(
          width: 64.0,
          child: Text(
            r.label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: scheme.onSurface,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: <Widget>[
              Container(
                height: 14.0,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
              FractionallySizedBox(
                widthFactor: fraction,
                child: Container(
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
        SizedBox(
          width: 36.0,
          child: Text(
            '${r.errorPercent}%',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: 8.0),
        SizedBox(
          width: 110.0,
          child: Text(
            r.note,
            style: TextStyle(
              fontSize: 11.0,
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

class _HeatRow {
  final String label;
  final int errorPercent;
  final String note;
  const _HeatRow(this.label, this.errorPercent, this.note);
}

// ===========================================================================
// SECTION 10: Decision matrix.
// ===========================================================================

class _SectionDecisionMatrix extends StatelessWidget {
  const _SectionDecisionMatrix();

  @override
  Widget build(BuildContext context) {
    print('=== Section 10: Decision Matrix ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    const List<_MatrixRow> rows = <_MatrixRow>[
      _MatrixRow(
        'Primary touch app on phone',
        'padded',
        'Use the default. Override only inside dense lists.',
      ),
      _MatrixRow(
        'Tablet kiosk with stylus',
        'padded',
        'Stylus accuracy is high but the user is at arm length; keep '
            'targets generous.',
      ),
      _MatrixRow(
        'Desktop admin console',
        'shrinkWrap',
        'Mouse + keyboard. Tight rows are expected.',
      ),
      _MatrixRow(
        'Data table cell editor',
        'shrinkWrap',
        'Padded buttons would inflate every cell.',
      ),
      _MatrixRow(
        'TextField suffix actions',
        'shrinkWrap',
        'The field is the hit target; the icon is a visual hint.',
      ),
      _MatrixRow(
        'FAB cluster / speed dial',
        'padded',
        'Each FAB is a primary CTA; protect against mis-taps.',
      ),
      _MatrixRow(
        'Filter chip strip',
        'shrinkWrap',
        'Chips have their own internal padding; doubling it wastes space.',
      ),
      _MatrixRow(
        'In-page wizard buttons',
        'padded',
        'Cancel and Next are commit actions; never make them small.',
      ),
      _MatrixRow(
        'In-text inline action',
        'shrinkWrap',
        'A button inline with body text should be no larger than the line '
            'height.',
      ),
      _MatrixRow(
        'Game UI HUD',
        'shrinkWrap',
        'HUDs typically own their own hit testing.',
      ),
    ];

    return _SectionFrame(
      number: 10,
      title: 'Decision matrix',
      blurb:
          'A reference table of common contexts and the recommended value. '
          'Treat shrinkWrap as opt-in, not default.',
      child: Container(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          children: <Widget>[
            _matrixHeader(scheme),
            for (int i = 0; i < rows.length; i++)
              _matrixRowWidget(rows[i], scheme, alt: i.isOdd),
          ],
        ),
      ),
    );
  }

  Widget _matrixHeader(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              'Context',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Recommendation',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'Why',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _matrixRowWidget(
    _MatrixRow r,
    ColorScheme scheme, {
    required bool alt,
  }) {
    final bool isPadded = r.recommendation == 'padded';
    final Color accent = isPadded ? scheme.primary : scheme.tertiary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      color: alt ? scheme.surfaceContainer : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              r.context,
              style: TextStyle(
                fontSize: 12.0,
                color: scheme.onSurface,
                height: 1.35,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                r.recommendation,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: accent,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              r.why,
              style: TextStyle(
                fontSize: 12.0,
                height: 1.45,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixRow {
  final String context;
  final String recommendation;
  final String why;
  const _MatrixRow(this.context, this.recommendation, this.why);
}

// ===========================================================================
// SECTION 11: Anti-patterns.
// ===========================================================================

class _SectionAntipatterns extends StatelessWidget {
  const _SectionAntipatterns();

  @override
  Widget build(BuildContext context) {
    print('=== Section 11: Anti-patterns ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;

    const List<_AntiPattern> items = <_AntiPattern>[
      _AntiPattern(
        bad:
            'Globally setting MaterialTapTargetSize.shrinkWrap to make the '
            'app feel dense.',
        good:
            'Keep the global theme padded. Apply shrinkWrap per widget where '
            'density is genuinely needed.',
      ),
      _AntiPattern(
        bad: 'Wrapping a 12dp icon in a shrinkWrap IconButton in a toolbar.',
        good:
            'Use the default padded IconButton, or manually inflate the '
            'surrounding tappable area.',
      ),
      _AntiPattern(
        bad:
            'Mixing padded and shrinkWrap in the same row, producing '
            'misaligned baselines.',
        good:
            'Pick one mode per row. If you need vertical alignment, set both '
            'and add a SizedBox(height: 48) around the shrinkWrap children.',
      ),
      _AntiPattern(
        bad: 'Using shrinkWrap on Checkbox in a settings page.',
        good:
            'Settings tables are touched while distracted; keep them padded.',
      ),
      _AntiPattern(
        bad: 'Relying on Container padding alone to satisfy accessibility.',
        good:
            'Container padding is not a touch target. Use Material widgets '
            'with padded or wrap with InkWell sized to >= 48dp.',
      ),
      _AntiPattern(
        bad: 'Removing the 48dp padding to fix overflow in a Row.',
        good:
            'Use Expanded / Flexible, or switch to Wrap. Tap targets should '
            'never be sacrificed to layout failure.',
      ),
    ];

    return _SectionFrame(
      number: 11,
      title: 'Anti-patterns and pitfalls',
      blurb:
          'Common mistakes seen during code review. Each item shows the '
          'symptom and a safer alternative.',
      child: Column(
        children: <Widget>[
          for (final _AntiPattern p in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: _antiPatternRow(p, scheme),
            ),
        ],
      ),
    );
  }

  Widget _antiPatternRow(_AntiPattern p, ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.close_rounded,
                  size: 18.0,
                  color: scheme.error,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    p.bad,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: scheme.onSurface,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.check_rounded,
                  size: 18.0,
                  color: scheme.primary,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    p.good,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: scheme.onSurfaceVariant,
                      height: 1.4,
                    ),
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

class _AntiPattern {
  final String bad;
  final String good;
  const _AntiPattern({required this.bad, required this.good});
}

// ===========================================================================
// SECTION 12: Glossary, summary recipes, and quick reference.
// ===========================================================================

class _SectionGlossary extends StatelessWidget {
  const _SectionGlossary();

  @override
  Widget build(BuildContext context) {
    print('=== Section 12: Glossary And Summary ===');
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final ColorScheme dark = _schemeDark();

    const List<_GlossaryItem> glossary = <_GlossaryItem>[
      _GlossaryItem(
        term: 'Hit region',
        definition:
            'The rectangle Flutter hit-test phase considers part of a '
            'tappable widget. Not necessarily the same as the visible '
            'bounds.',
      ),
      _GlossaryItem(
        term: 'Logical pixel (dp)',
        definition:
            'A device-independent measurement Flutter uses for sizing. 1dp '
            'is about 1/160 inch.',
      ),
      _GlossaryItem(
        term: 'VisualDensity',
        definition:
            'Independent knob that adjusts padding within widgets. Often '
            'paired with materialTapTargetSize for compact layouts.',
      ),
      _GlossaryItem(
        term: 'IconButton.padding',
        definition:
            'The inner padding around the icon. Independent of '
            'materialTapTargetSize, which only affects the outer hit slop.',
      ),
      _GlossaryItem(
        term: 'tapTargetSize on ButtonStyle',
        definition:
            'Per-button override. Lets a single button opt out of the theme '
            'value without disturbing siblings.',
      ),
      _GlossaryItem(
        term: 'Material 3',
        definition:
            'The current Material design system. Defaults retain '
            'materialTapTargetSize.padded for touch device factors.',
      ),
      _GlossaryItem(
        term: 'WCAG 2.5.5',
        definition:
            'Web accessibility success criterion that asks for 44 CSS-pixel '
            'minimum target sizes.',
      ),
      _GlossaryItem(
        term: 'ThemeData.materialTapTargetSize',
        definition:
            'Top-level ThemeData field; the canonical place to set the '
            'default value once.',
      ),
    ];

    const List<_QuickRecipe> recipes = <_QuickRecipe>[
      _QuickRecipe(
        title: 'App-wide default',
        code:
            'ThemeData(\n'
            '  useMaterial3: true,\n'
            '  materialTapTargetSize: MaterialTapTargetSize.padded,\n'
            ')',
      ),
      _QuickRecipe(
        title: 'Per-button override',
        code:
            'TextButton(\n'
            '  style: TextButton.styleFrom(\n'
            '    tapTargetSize: MaterialTapTargetSize.shrinkWrap,\n'
            '  ),\n'
            '  onPressed: _save,\n'
            '  child: const Text("Save"),\n'
            ')',
      ),
      _QuickRecipe(
        title: 'Dense data row',
        code:
            'IconButton(\n'
            '  onPressed: _edit,\n'
            '  style: IconButton.styleFrom(\n'
            '    tapTargetSize: MaterialTapTargetSize.shrinkWrap,\n'
            '    visualDensity: VisualDensity.compact,\n'
            '    padding: const EdgeInsets.all(4),\n'
            '  ),\n'
            '  icon: const Icon(Icons.edit, size: 16),\n'
            ')',
      ),
      _QuickRecipe(
        title: 'Nested scope (table cell)',
        code:
            'Theme(\n'
            '  data: Theme.of(context).copyWith(\n'
            '    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,\n'
            '  ),\n'
            '  child: _Cell(),\n'
            ')',
      ),
    ];

    return _SectionFrame(
      number: 12,
      title: 'Glossary, summary recipes, quick reference',
      blurb:
          'A compact reference card. Keep the glossary handy when reviewing '
          'PRs that touch tap target sizing.',
      child: Column(
        children: <Widget>[
          _glossaryGrid(glossary, scheme),
          const SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _recipeBlock(recipes[0], dark)),
              const SizedBox(width: 12.0),
              Expanded(child: _recipeBlock(recipes[1], dark)),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _recipeBlock(recipes[2], dark)),
              const SizedBox(width: 12.0),
              Expanded(child: _recipeBlock(recipes[3], dark)),
            ],
          ),
          const SizedBox(height: 16.0),
          _summaryPanel(scheme),
        ],
      ),
    );
  }

  Widget _glossaryGrid(List<_GlossaryItem> items, ColorScheme scheme) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: <Widget>[
        for (final _GlossaryItem g in items)
          SizedBox(
            width: 280.0,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    g.term,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      color: scheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    g.definition,
                    style: TextStyle(
                      fontSize: 12.0,
                      height: 1.4,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _recipeBlock(_QuickRecipe r, ColorScheme dark) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: dark.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.terminal, size: 16.0, color: dark.tertiary),
              const SizedBox(width: 8.0),
              Text(
                r.title,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: dark.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: dark.surface,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              r.code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                height: 1.45,
                color: dark.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryPanel(ColorScheme scheme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            scheme.primaryContainer.withValues(alpha: 0.85),
            scheme.tertiaryContainer.withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Summary',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
              color: scheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 10.0),
          _summaryLine(
            scheme,
            'Default to MaterialTapTargetSize.padded on touch surfaces.',
            Icons.check_circle_outline,
          ),
          _summaryLine(
            scheme,
            'Opt into shrinkWrap only when density is required and pointer '
            'precision is high (mouse, stylus).',
            Icons.check_circle_outline,
          ),
          _summaryLine(
            scheme,
            'Set the value once on ThemeData; override locally with '
            'ButtonStyle.tapTargetSize or Theme widgets.',
            Icons.check_circle_outline,
          ),
          _summaryLine(
            scheme,
            'Never sacrifice tap target size to fix layout overflow.',
            Icons.check_circle_outline,
          ),
          _summaryLine(
            scheme,
            'Pair shrinkWrap with VisualDensity.compact when the visual '
            'density should match the tap density.',
            Icons.check_circle_outline,
          ),
        ],
      ),
    );
  }

  Widget _summaryLine(ColorScheme scheme, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 16.0, color: scheme.onPrimaryContainer),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: scheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlossaryItem {
  final String term;
  final String definition;
  const _GlossaryItem({required this.term, required this.definition});
}

class _QuickRecipe {
  final String title;
  final String code;
  const _QuickRecipe({required this.title, required this.code});
}

// ===========================================================================
// Footer + shared section frame.
// ===========================================================================

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.menu_book_outlined,
            size: 18.0,
            color: scheme.primary,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'MaterialTapTargetSize Deep Demo - end of document. Twelve '
              'sections covered the enum constants, the 48dp guideline, '
              'visual measurement overlays, widget-by-widget interactions, '
              'density trade-offs, theming, recipes, anti-patterns, and a '
              'glossary.',
              style: TextStyle(
                fontSize: 12.0,
                color: scheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionFrame extends StatelessWidget {
  final int number;
  final String title;
  final String blurb;
  final Widget child;

  const _SectionFrame({
    required this.number,
    required this.title,
    required this.blurb,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 18.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.04),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: scheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    '$number',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: scheme.onPrimary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            blurb,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.5,
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14.0),
          child,
        ],
      ),
    );
  }
}
