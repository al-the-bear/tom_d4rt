// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo of advanced ThemeData features.
//
// This hand-authored deep demo walks through the *practical* anatomy of the
// modern Material 3 ThemeData object — the part developers actually touch on
// real apps — by rendering each concept as concrete widgets instead of
// describing it in prose. The build() function returns a Scaffold whose body
// is a SingleChildScrollView; the d4rt-AST harness wraps it in a MaterialApp.
//
// Concepts demonstrated:
//   * ColorScheme.fromSeed() — both Brightness.light and Brightness.dark
//   * useMaterial3: true and the M3 token model
//   * Theme(data: ...) local overrides via copyWith chains
//   * Sub-themes: AppBarTheme, CardThemeData, ChipThemeData, DividerThemeData,
//     ElevatedButtonThemeData, IconThemeData, InputDecorationTheme,
//     ListTileThemeData, SnackBarThemeData, TextTheme
//   * WidgetStateProperty.resolveWith — pressed / hovered / focused /
//     disabled / default visualised in a row of static button copies
//   * Theme extensions concept (without subclassing ThemeExtension<T>): the
//     concept is described visually using a code-card and an explanation of
//     Theme.of(context).extensions reads.
//
// Hard d4rt constraints obeyed:
//   * No subclassing of bridged abstract classes (no ThemeExtension<T>,
//     no Decoration, no BorderSide derivations, etc.).
//   * No StatefulWidget, no setState, no live animation.
//   * Only top-level entry is `dynamic build(BuildContext context)`.
//   * Allowed ignore_for_file leading block only — no inline ignores.
//   * Uses .withValues(alpha:) — never .withOpacity().
//   * No for-in loops over bridged values.
//
// Palette: a deep navy/indigo backdrop punctuated by violet, teal, amber and
// rose accents. Each section keeps a consistent header strip and footer
// signature so the document reads like a single, layered specimen.
import 'package:flutter/material.dart';

// ============================================================================
// STATIC DATA RECORDS (no Stateful state — pure const composition)
// ============================================================================

class _ColorChip {
  final String token;
  final Color color;
  final Color onColor;
  final String hex;
  final String purpose;
  const _ColorChip(this.token, this.color, this.onColor, this.hex, this.purpose);
}

class _TypeRow {
  final String name;
  final TextStyle? Function(TextTheme t) pick;
  final String sample;
  const _TypeRow(this.name, this.pick, this.sample);
}

class _StateBox {
  final String label;
  final Color background;
  final Color foreground;
  final String description;
  const _StateBox(this.label, this.background, this.foreground, this.description);
}

class _Tip {
  final String title;
  final String body;
  final IconData icon;
  final Color tone;
  const _Tip(this.title, this.body, this.icon, this.tone);
}

dynamic build(BuildContext context) {
  print('themes_advanced_test test executing');
  print('themes_advanced_test: building deep ThemeData visual demo');
  print('themes_advanced_test: 11 sections, hand-authored, no subclassing');

  // ==========================================================================
  // SHARED PALETTE
  // ==========================================================================
  // Cool greys for the page background and structural lines, indigo/violet
  // for hero gradients, teal for "M3 token" callouts, amber for warnings,
  // rose for state-error visuals, emerald for success accents.
  const Color slate50 = Color(0xFFF8FAFC);
  const Color slate100 = Color(0xFFF1F5F9);
  const Color slate200 = Color(0xFFE2E8F0);
  const Color slate300 = Color(0xFFCBD5E1);
  const Color slate400 = Color(0xFF94A3B8);
  const Color slate500 = Color(0xFF64748B);
  const Color slate600 = Color(0xFF475569);
  const Color slate700 = Color(0xFF334155);
  const Color slate800 = Color(0xFF1E293B);
  const Color slate900 = Color(0xFF0F172A);

  const Color indigo300 = Color(0xFFA5B4FC);
  const Color indigo400 = Color(0xFF818CF8);
  const Color indigo500 = Color(0xFF6366F1);
  const Color indigo600 = Color(0xFF4F46E5);
  const Color indigo700 = Color(0xFF4338CA);
  const Color indigo800 = Color(0xFF3730A3);
  const Color indigo900 = Color(0xFF312E81);

  const Color violet300 = Color(0xFFC4B5FD);
  const Color violet400 = Color(0xFFA78BFA);
  const Color violet500 = Color(0xFF8B5CF6);
  const Color violet600 = Color(0xFF7C3AED);
  const Color violet700 = Color(0xFF6D28D9);
  const Color violet900 = Color(0xFF4C1D95);

  const Color teal300 = Color(0xFF5EEAD4);
  const Color teal500 = Color(0xFF14B8A6);
  const Color teal600 = Color(0xFF0D9488);
  const Color teal700 = Color(0xFF0F766E);

  const Color amber300 = Color(0xFFFCD34D);
  const Color amber400 = Color(0xFFFBBF24);
  const Color amber600 = Color(0xFFD97706);
  const Color amber700 = Color(0xFFB45309);

  const Color rose300 = Color(0xFFFDA4AF);
  const Color rose500 = Color(0xFFF43F5E);
  const Color rose600 = Color(0xFFE11D48);

  const Color emerald400 = Color(0xFF34D399);
  const Color emerald500 = Color(0xFF10B981);
  const Color emerald600 = Color(0xFF059669);

  // Helper closures (not top-level functions) for repeated visual primitives.
  // These keep build() fully self-contained.
  Widget sectionTitle(String number, String title, String subtitle, Color tone) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0, bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[tone, tone.withValues(alpha: 0.55)],
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: tone.withValues(alpha: 0.35),
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16.0,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    color: slate900,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: slate600,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  height: 3.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        tone,
                        tone.withValues(alpha: 0.0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget codeCard(String code, Color frame) {
    return Container(
      decoration: BoxDecoration(
        color: slate900,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: frame.withValues(alpha: 0.45), width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14.0),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12.0,
          color: Color(0xFFE2E8F0),
          height: 1.45,
        ),
      ),
    );
  }

  Widget pill(String text, Color tone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(color: tone.withValues(alpha: 0.45), width: 1.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          color: tone,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  print('themes_advanced_test: palette + helpers ready');

  // ==========================================================================
  // SECTION 1 — HEADER ANATOMY DIAGRAM
  // ==========================================================================
  // Renders the conceptual "ThemeData is flat" diagram: a horizontal grid
  // showing the major buckets of properties (colorScheme, textTheme,
  // useMaterial3, sub-themes, extensions). This is a static visual; nothing
  // in this section reads from Theme.of yet.
  print('themes_advanced_test: section 1 — header anatomy');

  final Widget heroIcon = SizedBox(
    width: 92.0,
    height: 92.0,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 0.0,
          top: 14.0,
          child: Container(
            width: 78.0,
            height: 64.0,
            decoration: BoxDecoration(
              color: violet500.withValues(alpha: 0.40),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: violet700.withValues(alpha: 0.45),
                  blurRadius: 12.0,
                  offset: const Offset(0.0, 6.0),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 8.0,
          top: 6.0,
          child: Container(
            width: 78.0,
            height: 64.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[indigo500, violet500],
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: indigo700.withValues(alpha: 0.55),
                  blurRadius: 14.0,
                  offset: const Offset(0.0, 8.0),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.palette_outlined, color: Colors.white, size: 30.0),
          ),
        ),
      ],
    ),
  );

  final Widget heroHeader = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[slate900, indigo900, violet700],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: indigo900.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: const Offset(0.0, 14.0),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(24.0, 28.0, 24.0, 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            heroIcon,
            const SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999.0),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.30)),
                    ),
                    child: const Text(
                      'DEEP DEMO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'ThemeData — Advanced',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'ColorScheme.fromSeed · Brightness · M3 sub-themes · WidgetStateProperty',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 13.0,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22.0),
        // Anatomy diagram strip — five named buckets.
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
          ),
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'ThemeData is a flat record of design tokens',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  _bucket('colorScheme', 'fromSeed / fromSwatch', indigo300),
                  const SizedBox(width: 8.0),
                  _bucket('textTheme', 'TextTheme + per-style', teal300),
                  const SizedBox(width: 8.0),
                  _bucket('useMaterial3', 'M2 vs M3 token model', amber300),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: <Widget>[
                  _bucket('subThemes', 'AppBar/Card/Chip/...', rose300),
                  const SizedBox(width: 8.0),
                  _bucket('extensions', 'Map<Object,ThemeExtension>', violet400),
                  const SizedBox(width: 8.0),
                  _bucket('brightness', 'light · dark', emerald400),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('themes_advanced_test: hero rendered');

  // ==========================================================================
  // SECTION 2 — THREE THEMED CARDS (LIGHT / DARK / SEEDED)
  // ==========================================================================
  // Three side-by-side cards, each wrapped in `Theme(data: ...)` to override
  // the local theme. Demonstrates how a sub-tree can have an entirely
  // different ColorScheme without disturbing the rest of the page.
  print('themes_advanced_test: section 2 — themed sub-trees');

  Widget themedSampleCard({
    required String title,
    required String subtitle,
    required ThemeData theme,
  }) {
    return Theme(
      data: theme,
      child: Builder(
        builder: (BuildContext c) {
          final ColorScheme s = Theme.of(c).colorScheme;
          return Container(
            decoration: BoxDecoration(
              color: s.surface,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: s.outlineVariant, width: 1.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 4.0),
                ),
              ],
            ),
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 30.0,
                      height: 30.0,
                      decoration: BoxDecoration(
                        color: s.primary,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.style_outlined, color: s.onPrimary, size: 18.0),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: s.onSurface,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: s.onSurface.withValues(alpha: 0.75),
                    fontSize: 12.5,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: s.primaryContainer,
                        borderRadius: BorderRadius.circular(999.0),
                      ),
                      child: Text(
                        'primary',
                        style: TextStyle(color: s.onPrimaryContainer, fontSize: 11.5, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: s.secondaryContainer,
                        borderRadius: BorderRadius.circular(999.0),
                      ),
                      child: Text(
                        'secondary',
                        style: TextStyle(color: s.onSecondaryContainer, fontSize: 11.5, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    FilledButton(onPressed: () {}, child: const Text('Action')),
                    const SizedBox(width: 8.0),
                    OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: indigo500, brightness: Brightness.light),
  );
  final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: indigo500, brightness: Brightness.dark),
  );
  final ThemeData seedTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: teal500, brightness: Brightness.light),
  );

  final Widget threeThemed = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: themedSampleCard(
          title: 'Light · indigo seed',
          subtitle: 'ColorScheme.fromSeed(indigo, light)',
          theme: lightTheme,
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: themedSampleCard(
          title: 'Dark · indigo seed',
          subtitle: 'ColorScheme.fromSeed(indigo, dark)',
          theme: darkTheme,
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: themedSampleCard(
          title: 'Light · teal seed',
          subtitle: 'ColorScheme.fromSeed(teal, light)',
          theme: seedTheme,
        ),
      ),
    ],
  );
  print('themes_advanced_test: three themed cards rendered');

  // ==========================================================================
  // SECTION 3 — COLORSCHEME GRID
  // ==========================================================================
  // A grid of swatches displaying the major M3 ColorScheme tokens with their
  // hex code and a one-line purpose. The chips are read directly from a
  // `ColorScheme.fromSeed(indigo, light)` instance.
  print('themes_advanced_test: section 3 — colorscheme grid');

  final ColorScheme cs = ColorScheme.fromSeed(seedColor: indigo500, brightness: Brightness.light);
  String hex(Color c) {
    final int v = c.toARGB32() & 0xFFFFFF;
    final String s = v.toRadixString(16).toUpperCase().padLeft(6, '0');
    return '#$s';
  }

  final List<_ColorChip> swatches = <_ColorChip>[
    _ColorChip('primary', cs.primary, cs.onPrimary, hex(cs.primary), 'Brand colour, high-emphasis surfaces'),
    _ColorChip('onPrimary', cs.onPrimary, cs.primary, hex(cs.onPrimary), 'Foreground over primary'),
    _ColorChip('primaryContainer', cs.primaryContainer, cs.onPrimaryContainer, hex(cs.primaryContainer), 'Lower-emphasis primary surface'),
    _ColorChip('secondary', cs.secondary, cs.onSecondary, hex(cs.secondary), 'Less prominent accent'),
    _ColorChip('onSecondary', cs.onSecondary, cs.secondary, hex(cs.onSecondary), 'Foreground over secondary'),
    _ColorChip('tertiary', cs.tertiary, cs.onTertiary, hex(cs.tertiary), 'Contrasting accent'),
    _ColorChip('surface', cs.surface, cs.onSurface, hex(cs.surface), 'Default container surface'),
    _ColorChip('surfaceContainerHighest', cs.surfaceContainerHighest, cs.onSurface, hex(cs.surfaceContainerHighest), 'Elevated container surface'),
    _ColorChip('error', cs.error, cs.onError, hex(cs.error), 'Validation/destructive'),
    _ColorChip('onError', cs.onError, cs.error, hex(cs.onError), 'Foreground over error'),
    _ColorChip('outline', cs.outline, cs.onSurface, hex(cs.outline), 'Strong dividers/borders'),
    _ColorChip('outlineVariant', cs.outlineVariant, cs.onSurface, hex(cs.outlineVariant), 'Subtle dividers'),
  ];

  Widget swatchCard(_ColorChip s) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: slate200),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 64.0,
            decoration: BoxDecoration(
              color: s.color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(11.0)),
            ),
            alignment: Alignment.center,
            child: Text(
              'Aa',
              style: TextStyle(color: s.onColor, fontWeight: FontWeight.w800, fontSize: 22.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  s.token,
                  style: const TextStyle(
                    color: slate900,
                    fontWeight: FontWeight.w800,
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  s.hex,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: slate600,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  s.purpose,
                  style: const TextStyle(fontSize: 10.5, color: slate500, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget swatchGrid = Wrap(
    spacing: 10.0,
    runSpacing: 10.0,
    children: <Widget>[
      SizedBox(width: 168.0, child: swatchCard(swatches[0])),
      SizedBox(width: 168.0, child: swatchCard(swatches[1])),
      SizedBox(width: 168.0, child: swatchCard(swatches[2])),
      SizedBox(width: 168.0, child: swatchCard(swatches[3])),
      SizedBox(width: 168.0, child: swatchCard(swatches[4])),
      SizedBox(width: 168.0, child: swatchCard(swatches[5])),
      SizedBox(width: 168.0, child: swatchCard(swatches[6])),
      SizedBox(width: 168.0, child: swatchCard(swatches[7])),
      SizedBox(width: 168.0, child: swatchCard(swatches[8])),
      SizedBox(width: 168.0, child: swatchCard(swatches[9])),
      SizedBox(width: 168.0, child: swatchCard(swatches[10])),
      SizedBox(width: 168.0, child: swatchCard(swatches[11])),
    ],
  );
  print('themes_advanced_test: swatch grid rendered (${swatches.length} tokens)');

  // ==========================================================================
  // SECTION 4 — TYPOGRAPHY LADDER
  // ==========================================================================
  // The full M3 type scale rendered as actual Text widgets at the resolved
  // size. Each row pulls its style from `TextTheme` via Theme.of(context).
  // We then wrap the ladder in a `Theme(data: ...)` that swaps the textTheme
  // for a Roboto/serif-flavoured copyWith chain so the ladder visibly responds
  // to the override.
  print('themes_advanced_test: section 4 — typography ladder');

  final List<_TypeRow> typeRows = <_TypeRow>[
    _TypeRow('displayLarge', (TextTheme t) => t.displayLarge, 'The quick brown fox'),
    _TypeRow('displayMedium', (TextTheme t) => t.displayMedium, 'The quick brown fox'),
    _TypeRow('displaySmall', (TextTheme t) => t.displaySmall, 'The quick brown fox'),
    _TypeRow('headlineLarge', (TextTheme t) => t.headlineLarge, 'Headlines lead the page'),
    _TypeRow('headlineMedium', (TextTheme t) => t.headlineMedium, 'Headlines lead the page'),
    _TypeRow('headlineSmall', (TextTheme t) => t.headlineSmall, 'Headlines lead the page'),
    _TypeRow('titleLarge', (TextTheme t) => t.titleLarge, 'Titles introduce sections'),
    _TypeRow('titleMedium', (TextTheme t) => t.titleMedium, 'Titles introduce sections'),
    _TypeRow('titleSmall', (TextTheme t) => t.titleSmall, 'Titles introduce sections'),
    _TypeRow('bodyLarge', (TextTheme t) => t.bodyLarge, 'Body text carries the prose'),
    _TypeRow('bodyMedium', (TextTheme t) => t.bodyMedium, 'Body text carries the prose'),
    _TypeRow('bodySmall', (TextTheme t) => t.bodySmall, 'Body text carries the prose'),
    _TypeRow('labelLarge', (TextTheme t) => t.labelLarge, 'LABELS · BUTTONS · CHIPS'),
    _TypeRow('labelMedium', (TextTheme t) => t.labelMedium, 'LABELS · BUTTONS · CHIPS'),
    _TypeRow('labelSmall', (TextTheme t) => t.labelSmall, 'LABELS · BUTTONS · CHIPS'),
  ];

  final ThemeData typeTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: indigo500),
  );

  Widget typeRow(_TypeRow row, TextTheme tt) {
    final TextStyle? style = row.pick(tt);
    final double fontSize = style?.fontSize ?? 14.0;
    final FontWeight weight = style?.fontWeight ?? FontWeight.w400;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: slate200, width: 1.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  row.name,
                  style: const TextStyle(
                    color: slate800,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    fontSize: 12.0,
                  ),
                ),
                Text(
                  '${fontSize.toStringAsFixed(1)}px · w${weight.index + 1}00',
                  style: const TextStyle(color: slate500, fontSize: 10.5, fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              row.sample,
              style: style?.copyWith(color: slate900),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  final Widget typographyLadder = Theme(
    data: typeTheme,
    child: Builder(
      builder: (BuildContext c) {
        final TextTheme tt = Theme.of(c).textTheme;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: slate200),
          ),
          child: Column(
            children: <Widget>[
              typeRow(typeRows[0], tt),
              typeRow(typeRows[1], tt),
              typeRow(typeRows[2], tt),
              typeRow(typeRows[3], tt),
              typeRow(typeRows[4], tt),
              typeRow(typeRows[5], tt),
              typeRow(typeRows[6], tt),
              typeRow(typeRows[7], tt),
              typeRow(typeRows[8], tt),
              typeRow(typeRows[9], tt),
              typeRow(typeRows[10], tt),
              typeRow(typeRows[11], tt),
              typeRow(typeRows[12], tt),
              typeRow(typeRows[13], tt),
              typeRow(typeRows[14], tt),
            ],
          ),
        );
      },
    ),
  );
  print('themes_advanced_test: typography ladder rendered (${typeRows.length} rows)');

  // ==========================================================================
  // SECTION 5 — COMPONENT THEME GRID (DEFAULTS vs OVERRIDDEN)
  // ==========================================================================
  // Each row shows a component rendered first under the default M3 theme,
  // then a second time under a strongly-styled `Theme(data: ...)` override.
  // The override theme uses the full set of named sub-theme records.
  print('themes_advanced_test: section 5 — component theme grid');

  final ThemeData overriddenTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: violet600, brightness: Brightness.light),
    appBarTheme: const AppBarTheme(
      backgroundColor: violet600,
      foregroundColor: Colors.white,
      elevation: 4.0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
        letterSpacing: 0.4,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 6.0,
      color: Colors.white,
      shadowColor: violet700.withValues(alpha: 0.25),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.all(8.0),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: violet500.withValues(alpha: 0.12),
      selectedColor: violet500,
      labelStyle: const TextStyle(color: violet700, fontWeight: FontWeight.w700),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: violet500, width: 1.0),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: violet400,
      thickness: 2.0,
      space: 16.0,
    ),
    iconTheme: const IconThemeData(color: violet700, size: 22.0),
    listTileTheme: const ListTileThemeData(
      iconColor: violet600,
      textColor: violet900,
      tileColor: Color(0xFFF5F3FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: slate900,
      contentTextStyle: const TextStyle(color: Colors.white),
      actionTextColor: violet300,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF5F3FF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: violet500),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: violet400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: violet700, width: 2.0),
      ),
      labelStyle: const TextStyle(color: violet700),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: violet600,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.4),
      ),
    ),
  );

  Widget componentRow(String label, Widget defaultSample, Widget overriddenSample) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: slate200, width: 1.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 120.0,
            child: Text(
              label,
              style: const TextStyle(
                color: slate800,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: slate50,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: defaultSample,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF5FF),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: violet400.withValues(alpha: 0.40)),
              ),
              child: Theme(data: overriddenTheme, child: overriddenSample),
            ),
          ),
        ],
      ),
    );
  }

  final Widget componentGrid = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: slate200),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          decoration: const BoxDecoration(
            color: slate100,
            borderRadius: BorderRadius.vertical(top: Radius.circular(11.0)),
            border: Border(bottom: BorderSide(color: slate200, width: 1.0)),
          ),
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 120.0,
                child: Text('component',
                    style: TextStyle(
                        color: slate600,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                        fontSize: 11.5)),
              ),
              Expanded(
                child: Text('default M3',
                    style: TextStyle(
                        color: slate600,
                        fontWeight: FontWeight.w700,
                        fontSize: 11.5,
                        letterSpacing: 0.4)),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text('overridden via Theme(data: ...)',
                    style: TextStyle(
                        color: violet700,
                        fontWeight: FontWeight.w700,
                        fontSize: 11.5,
                        letterSpacing: 0.4)),
              ),
            ],
          ),
        ),
        componentRow(
          'Card',
          Card(
            elevation: 1.0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: const Text('Default card surface'),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: const Text('Themed card surface'),
            ),
          ),
        ),
        componentRow(
          'Chip',
          Wrap(
            spacing: 6.0,
            children: <Widget>[
              Chip(label: const Text('alpha')),
              Chip(label: const Text('beta')),
            ],
          ),
          Wrap(
            spacing: 6.0,
            children: <Widget>[
              Chip(label: const Text('alpha')),
              Chip(label: const Text('beta')),
            ],
          ),
        ),
        componentRow(
          'ElevatedButton',
          ElevatedButton(onPressed: () {}, child: const Text('Confirm')),
          ElevatedButton(onPressed: () {}, child: const Text('Confirm')),
        ),
        componentRow(
          'FilledButton',
          FilledButton(onPressed: () {}, child: const Text('Filled')),
          FilledButton(onPressed: () {}, child: const Text('Filled')),
        ),
        componentRow(
          'OutlinedButton',
          OutlinedButton(onPressed: () {}, child: const Text('Outline')),
          OutlinedButton(onPressed: () {}, child: const Text('Outline')),
        ),
        componentRow(
          'TextButton',
          TextButton(onPressed: () {}, child: const Text('Inline')),
          TextButton(onPressed: () {}, child: const Text('Inline')),
        ),
        componentRow(
          'IconButton',
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline)),
        ),
        componentRow(
          'ListTile',
          const ListTile(
            leading: Icon(Icons.folder_outlined),
            title: Text('Documents'),
            subtitle: Text('1.2 GB'),
          ),
          const ListTile(
            leading: Icon(Icons.folder_outlined),
            title: Text('Documents'),
            subtitle: Text('1.2 GB'),
          ),
        ),
        componentRow(
          'Switch',
          Row(children: const <Widget>[
            Switch(value: true, onChanged: null),
            SizedBox(width: 8.0),
            Switch(value: false, onChanged: null),
          ]),
          Row(children: const <Widget>[
            Switch(value: true, onChanged: null),
            SizedBox(width: 8.0),
            Switch(value: false, onChanged: null),
          ]),
        ),
        componentRow(
          'Checkbox',
          Row(children: const <Widget>[
            Checkbox(value: true, onChanged: null),
            SizedBox(width: 8.0),
            Checkbox(value: false, onChanged: null),
          ]),
          Row(children: const <Widget>[
            Checkbox(value: true, onChanged: null),
            SizedBox(width: 8.0),
            Checkbox(value: false, onChanged: null),
          ]),
        ),
        componentRow(
          'Radio',
          Row(children: const <Widget>[
            Radio<int>(value: 1, groupValue: 1, onChanged: null),
            Radio<int>(value: 2, groupValue: 1, onChanged: null),
          ]),
          Row(children: const <Widget>[
            Radio<int>(value: 1, groupValue: 1, onChanged: null),
            Radio<int>(value: 2, groupValue: 1, onChanged: null),
          ]),
        ),
        componentRow(
          'Slider',
          Slider(value: 0.4, onChanged: (double _) {}),
          Slider(value: 0.4, onChanged: (double _) {}),
        ),
        componentRow(
          'Divider',
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('above'),
              Divider(),
              Text('below'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('above'),
              Divider(),
              Text('below'),
            ],
          ),
        ),
      ],
    ),
  );
  print('themes_advanced_test: component grid rendered');

  // ==========================================================================
  // SECTION 6 — WIDGETSTATEPROPERTY RESOLVER
  // ==========================================================================
  // Five static "snapshots" of an ElevatedButton, each with backgroundColor
  // and foregroundColor wired through ElevatedButton.styleFrom(...) for the
  // pressed/hovered/focused/disabled/default visual states. Above the row
  // sits a code-card showing how WidgetStateProperty.resolveWith would
  // express the same in real code.
  print('themes_advanced_test: section 6 — WidgetStateProperty resolver');

  final List<_StateBox> stateBoxes = <_StateBox>[
    const _StateBox('default', indigo500, Colors.white, 'no states active'),
    const _StateBox('hovered', indigo400, Colors.white, 'pointer entered'),
    const _StateBox('focused', indigo700, Colors.white, 'tab focus / a11y'),
    const _StateBox('pressed', indigo800, Colors.white, 'pointer/key down'),
    const _StateBox('disabled', slate300, slate500, 'onPressed: null'),
  ];

  Widget stateButton(_StateBox box) {
    final bool disabled = box.label == 'disabled';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ElevatedButton(
          onPressed: disabled ? null : () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: box.background,
            foregroundColor: box.foreground,
            disabledBackgroundColor: box.background,
            disabledForegroundColor: box.foreground,
            elevation: disabled ? 0.0 : 2.0,
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          child: Text(box.label),
        ),
        const SizedBox(height: 6.0),
        Text(
          box.label.toUpperCase(),
          style: const TextStyle(
            color: slate700,
            fontFamily: 'monospace',
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          box.description,
          style: const TextStyle(color: slate500, fontSize: 10.0),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  final Widget stateResolver = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: slate200),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        codeCard(
          'ElevatedButton(\n'
          '  style: ButtonStyle(\n'
          '    backgroundColor: WidgetStateProperty.resolveWith<Color?>(\n'
          '      (Set<WidgetState> s) {\n'
          '        if (s.contains(WidgetState.disabled)) return slate300;\n'
          '        if (s.contains(WidgetState.pressed))  return indigo800;\n'
          '        if (s.contains(WidgetState.focused))  return indigo700;\n'
          '        if (s.contains(WidgetState.hovered))  return indigo400;\n'
          '        return indigo500;\n'
          '      },\n'
          '    ),\n'
          '  ),\n'
          '  onPressed: () {},\n'
          '  child: Text(\'resolve\'),\n'
          ')',
          indigo500,
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Center(child: stateButton(stateBoxes[0]))),
            Expanded(child: Center(child: stateButton(stateBoxes[1]))),
            Expanded(child: Center(child: stateButton(stateBoxes[2]))),
            Expanded(child: Center(child: stateButton(stateBoxes[3]))),
            Expanded(child: Center(child: stateButton(stateBoxes[4]))),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            pill('WidgetState.pressed', indigo700),
            const SizedBox(width: 6.0),
            pill('WidgetState.hovered', indigo500),
            const SizedBox(width: 6.0),
            pill('WidgetState.focused', teal600),
            const SizedBox(width: 6.0),
            pill('WidgetState.disabled', slate500),
            const SizedBox(width: 6.0),
            pill('default', emerald600),
          ],
        ),
      ],
    ),
  );
  print('themes_advanced_test: state resolver rendered');

  // ==========================================================================
  // SECTION 7 — INPUTDECORATIONTHEME DEMO (3 OVERRIDES)
  // ==========================================================================
  // Three TextFields (no controllers — read-only) wrapped in three different
  // Theme(data: ...) overrides demonstrating outline / filled / underline
  // input variants.
  print('themes_advanced_test: section 7 — input decoration theme');

  final ThemeData inputThemeOutline = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: indigo500),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: indigo500),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: indigo300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: indigo700, width: 2.0),
      ),
      labelStyle: const TextStyle(color: indigo700),
      hintStyle: const TextStyle(color: slate400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      prefixIconColor: indigo600,
    ),
  );

  final ThemeData inputThemeFilled = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: teal500),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFECFEFF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.0),
        borderSide: const BorderSide(color: teal600, width: 2.0),
      ),
      labelStyle: const TextStyle(color: teal700, fontWeight: FontWeight.w700),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      prefixIconColor: teal600,
    ),
  );

  final ThemeData inputThemeUnderline = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: rose500),
    inputDecorationTheme: const InputDecorationTheme(
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: rose500, width: 1.5),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: rose300, width: 1.0),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: rose600, width: 2.0),
      ),
      labelStyle: TextStyle(color: rose600),
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
      prefixIconColor: rose500,
    ),
  );

  Widget inputColumn({
    required String title,
    required Color tone,
    required ThemeData theme,
    required String description,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: slate200),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  color: tone,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: const TextStyle(
                  color: slate900,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Theme(
            data: theme,
            child: const TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Email address',
                hintText: 'name@example.com',
                prefixIcon: Icon(Icons.alternate_email),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Theme(
            data: theme,
            child: const TextField(
              readOnly: true,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.visibility_outlined),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            description,
            style: const TextStyle(color: slate500, fontSize: 11.5, height: 1.4),
          ),
        ],
      ),
    );
  }

  final Widget inputDemo = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: inputColumn(
          title: 'Outline · indigo',
          tone: indigo500,
          theme: inputThemeOutline,
          description: 'OutlineInputBorder + matching enabled/focused borders.',
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: inputColumn(
          title: 'Filled · teal',
          tone: teal500,
          theme: inputThemeFilled,
          description: 'filled: true, no visible border, fillColor accent.',
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: inputColumn(
          title: 'Underline · rose',
          tone: rose500,
          theme: inputThemeUnderline,
          description: 'UnderlineInputBorder · airy density, classic M2 vibe.',
        ),
      ),
    ],
  );
  print('themes_advanced_test: input decoration demo rendered');

  // ==========================================================================
  // SECTION 8 — SNACKBAR / DIALOG / BOTTOMSHEET PREVIEWS
  // ==========================================================================
  // Static "preview shells" that mimic the visual of SnackBar, Dialog, and
  // BottomSheet without invoking the imperative APIs (which require a
  // ScaffoldMessenger or showDialog call we deliberately avoid).
  print('themes_advanced_test: section 8 — surface previews');

  final Widget snackBarPreview = Container(
    decoration: BoxDecoration(
      color: slate900,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.30),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
    child: Row(
      children: <Widget>[
        const Icon(Icons.cloud_done_outlined, color: emerald400),
        const SizedBox(width: 12.0),
        const Expanded(
          child: Text(
            'Document saved to cloud',
            style: TextStyle(color: Colors.white, fontSize: 13.5),
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(foregroundColor: indigo300),
          child: const Text('UNDO'),
        ),
      ],
    ),
  );

  final Widget dialogPreview = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 24.0,
          offset: const Offset(0.0, 12.0),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: amber400.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.warning_amber_rounded, color: amber700, size: 20.0),
            ),
            const SizedBox(width: 12.0),
            const Text(
              'Discard changes?',
              style: TextStyle(
                color: slate900,
                fontSize: 17.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'You have unsaved changes. Closing this editor will discard them permanently.',
          style: TextStyle(color: slate600, fontSize: 13.0, height: 1.45),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(onPressed: () {}, child: const Text('Cancel')),
            const SizedBox(width: 6.0),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(backgroundColor: rose600),
              child: const Text('Discard'),
            ),
          ],
        ),
      ],
    ),
  );

  final Widget bottomSheetPreview = Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(22.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.14),
          blurRadius: 18.0,
          offset: const Offset(0.0, -6.0),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Center(
          child: Container(
            width: 40.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: slate300,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Share this document',
          style: TextStyle(
            color: slate900,
            fontWeight: FontWeight.w800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _shareIcon(Icons.mail_outline, 'Email', indigo500),
            _shareIcon(Icons.link, 'Copy link', teal500),
            _shareIcon(Icons.qr_code_2, 'QR code', amber600),
            _shareIcon(Icons.print_outlined, 'Print', slate600),
          ],
        ),
        const SizedBox(height: 12.0),
        const Divider(),
        const SizedBox(height: 6.0),
        Row(
          children: <Widget>[
            const Icon(Icons.lock_outline, color: slate500, size: 16.0),
            const SizedBox(width: 6.0),
            const Text(
              'Only people with the link can view',
              style: TextStyle(color: slate500, fontSize: 12.0),
            ),
          ],
        ),
      ],
    ),
  );

  final Widget surfacesRow = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 6.0),
              child: Text('SnackBarTheme preview',
                  style: TextStyle(color: slate700, fontSize: 12.0, fontWeight: FontWeight.w700)),
            ),
            snackBarPreview,
          ],
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 6.0),
              child: Text('DialogTheme preview',
                  style: TextStyle(color: slate700, fontSize: 12.0, fontWeight: FontWeight.w700)),
            ),
            dialogPreview,
          ],
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 6.0),
              child: Text('BottomSheetTheme preview',
                  style: TextStyle(color: slate700, fontSize: 12.0, fontWeight: FontWeight.w700)),
            ),
            bottomSheetPreview,
          ],
        ),
      ),
    ],
  );
  print('themes_advanced_test: surface previews rendered');

  // ==========================================================================
  // SECTION 9 — BRIGHTNESS COMPARISON
  // ==========================================================================
  // Same content rendered in two columns: one wrapped with the lightTheme
  // and one with the darkTheme. Demonstrates that ColorScheme.fromSeed
  // generates a coherent dark variant automatically.
  print('themes_advanced_test: section 9 — brightness comparison');

  Widget brightnessSample(ThemeData theme, String label) {
    return Theme(
      data: theme,
      child: Builder(
        builder: (BuildContext c) {
          final ColorScheme sc = Theme.of(c).colorScheme;
          return Container(
            decoration: BoxDecoration(
              color: sc.surface,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: sc.outlineVariant),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      theme.brightness == Brightness.light
                          ? Icons.light_mode_outlined
                          : Icons.dark_mode_outlined,
                      color: sc.primary,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      label,
                      style: TextStyle(
                        color: sc.onSurface,
                        fontWeight: FontWeight.w800,
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14.0),
                Container(
                  decoration: BoxDecoration(
                    color: sc.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 18.0,
                        backgroundColor: sc.primary,
                        child: Icon(Icons.person_outline, color: sc.onPrimary, size: 18.0),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Ada Lovelace',
                                style: TextStyle(
                                    color: sc.onSurface, fontWeight: FontWeight.w700)),
                            Text('ada@enchanted.org',
                                style: TextStyle(
                                    color: sc.onSurface.withValues(alpha: 0.7), fontSize: 12.0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: <Widget>[
                    Chip(label: const Text('analyst')),
                    Chip(label: const Text('mathematics')),
                    Chip(label: const Text('victorian')),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FilledButton(onPressed: () {}, child: const Text('Confirm')),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: OutlinedButton(onPressed: () {}, child: const Text('Cancel')),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final Widget brightnessRow = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(child: brightnessSample(lightTheme, 'Brightness.light')),
      const SizedBox(width: 12.0),
      Expanded(child: brightnessSample(darkTheme, 'Brightness.dark')),
    ],
  );
  print('themes_advanced_test: brightness comparison rendered');

  // ==========================================================================
  // SECTION 10 — TIPS / PITFALLS
  // ==========================================================================
  // Common mistakes and the recommended pattern. Each tip is rendered as a
  // Container with its tone-coloured icon strip on the left.
  print('themes_advanced_test: section 10 — tips / pitfalls');

  final List<_Tip> tips = <_Tip>[
    const _Tip(
      'Always set useMaterial3: true',
      'M3 is the default in current Flutter. Setting it explicitly stops your '
          'app from accidentally falling back to legacy M2 token defaults when '
          'a sub-theme is omitted.',
      Icons.check_circle_outline,
      emerald500,
    ),
    const _Tip(
      'Generate, do not hand-pick',
      'ColorScheme.fromSeed produces a tonally-balanced palette. Hand-picking '
          'every container/onContainer pair risks unreadable contrast in dark '
          'mode.',
      Icons.auto_awesome_outlined,
      indigo600,
    ),
    const _Tip(
      'Override locally with Theme(data: ...)',
      'For a single subtree (a card, a panel) prefer Theme(data: parent.copyWith(...)) '
          'over a global override. It keeps the change scoped and reviewable.',
      Icons.layers_outlined,
      teal600,
    ),
    const _Tip(
      'Resolve states with WidgetStateProperty',
      'For interactive widgets (buttons, switches, chips), wire backgroundColor / '
          'foregroundColor through WidgetStateProperty.resolveWith so each '
          'visual state stays coherent.',
      Icons.swap_horiz_outlined,
      violet600,
    ),
    const _Tip(
      'Theme extensions: define once, read via Theme.of',
      'Extensions are stored in Theme.of(context).extensions. Read them with '
          'theme.extension<T>() — but defining a custom T requires subclassing '
          'ThemeExtension<T>, which is intentionally NOT done in this demo.',
      Icons.extension_outlined,
      amber700,
    ),
    const _Tip(
      'Avoid .withOpacity()',
      'Use .withValues(alpha: x) instead of .withOpacity(x) — it is the '
          'modern API and preserves wide-gamut precision.',
      Icons.report_outlined,
      rose600,
    ),
  ];

  Widget tipCard(_Tip t) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: t.tone.withValues(alpha: 0.30)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: 6.0,
              decoration: BoxDecoration(
                color: t.tone,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(11.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: t.tone.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.center,
                child: Icon(t.icon, color: t.tone, size: 20.0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 12.0, 14.0, 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      t.title,
                      style: TextStyle(
                        color: slate900,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      t.body,
                      style: const TextStyle(
                        color: slate600,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget tipsList = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      tipCard(tips[0]),
      const SizedBox(height: 10.0),
      tipCard(tips[1]),
      const SizedBox(height: 10.0),
      tipCard(tips[2]),
      const SizedBox(height: 10.0),
      tipCard(tips[3]),
      const SizedBox(height: 10.0),
      tipCard(tips[4]),
      const SizedBox(height: 10.0),
      tipCard(tips[5]),
    ],
  );

  // Theme extensions concept card — describes the API without subclassing it.
  final Widget extensionsConceptCard = Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF1E1B4B), Color(0xFF312E81)],
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: indigo900.withValues(alpha: 0.35),
          blurRadius: 16.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: violet400.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: violet400.withValues(alpha: 0.50)),
              ),
              child: const Text(
                'CONCEPT',
                style: TextStyle(
                  color: violet300,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Theme extensions',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'ThemeData.extensions is an Iterable<ThemeExtension<dynamic>>. To '
          'define your own extension you would subclass ThemeExtension<T> and '
          'override copyWith/lerp. This demo intentionally does NOT subclass '
          'ThemeExtension<T> — instead, the box below shows the concept as a '
          'code-card and reads Theme.of(context).extensions to confirm the '
          'collection is non-null.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 14.0),
        codeCard(
          '// Conceptual sketch — NOT instantiated in this demo.\n'
          '// class BrandColors extends ThemeExtension<BrandColors> {\n'
          '//   final Color hero;  final Color accent;\n'
          '//   const BrandColors({required this.hero, required this.accent});\n'
          '//   @override BrandColors copyWith({Color? hero, Color? accent}) =>\n'
          '//     BrandColors(hero: hero ?? this.hero, accent: accent ?? this.accent);\n'
          '//   @override BrandColors lerp(ThemeExtension<BrandColors>? o, double t) =>\n'
          '//     this; // simplified\n'
          '// }\n'
          '\n'
          '// Read at runtime:\n'
          '// final BrandColors? brand = Theme.of(context).extension<BrandColors>();',
          violet400,
        ),
        const SizedBox(height: 12.0),
        Builder(
          builder: (BuildContext c) {
            final int extCount = Theme.of(c).extensions.length;
            return Row(
              children: <Widget>[
                const Icon(Icons.info_outline, color: violet300, size: 16.0),
                const SizedBox(width: 8.0),
                Text(
                  'Theme.of(context).extensions resolves to a collection with $extCount entries.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.80), fontSize: 12.0),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );

  print('themes_advanced_test: tips + extensions concept rendered');

  // ==========================================================================
  // SECTION 11 — FOOTER WITH SUMMARY STATS
  // ==========================================================================
  print('themes_advanced_test: section 11 — footer');

  final Widget footer = Container(
    width: double.infinity,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[slate900, indigo900],
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    padding: const EdgeInsets.fromLTRB(22.0, 18.0, 22.0, 18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.0),
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.bar_chart_outlined, color: Colors.white, size: 22.0),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'themes_advanced_test · summary',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                '11 sections · ${swatches.length} swatches · ${typeRows.length} type rows · '
                '${stateBoxes.length} state snapshots · ${tips.length} tips',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.78),
                  fontSize: 12.0,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: emerald500.withValues(alpha: 0.20),
            borderRadius: BorderRadius.circular(999.0),
            border: Border.all(color: emerald400.withValues(alpha: 0.50)),
          ),
          child: const Text(
            'M3 · light/dark',
            style: TextStyle(
              color: emerald400,
              fontWeight: FontWeight.w800,
              fontSize: 11.5,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
  print('themes_advanced_test: footer rendered');

  // ==========================================================================
  // FINAL ASSEMBLY
  // ==========================================================================
  // Compose every section into a single SingleChildScrollView. Section
  // separators use sectionTitle() with a tone colour that matches each
  // section's accent.
  print('themes_advanced_test: assembling final scaffold');

  return Scaffold(
    backgroundColor: slate50,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          heroHeader,

          sectionTitle('1', 'Anatomy of ThemeData',
              'Five flat buckets compose the entire theme', indigo500),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: slate200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'ThemeData groups every Material design token into named records. '
                  'A widget never reads "the indigo colour" directly — it reads '
                  'Theme.of(context).colorScheme.primary, which is resolved by walking '
                  'the inherited theme chain.',
                  style: TextStyle(color: slate700, fontSize: 13.0, height: 1.5),
                ),
                const SizedBox(height: 12.0),
                codeCard(
                  'final ThemeData theme = ThemeData(\n'
                  '  useMaterial3: true,\n'
                  '  colorScheme: ColorScheme.fromSeed(\n'
                  '    seedColor: Colors.indigo,\n'
                  '    brightness: Brightness.light,\n'
                  '  ),\n'
                  '  textTheme: Typography.material2021().black,\n'
                  '  appBarTheme: const AppBarTheme(centerTitle: true),\n'
                  '  cardTheme: CardThemeData(elevation: 2.0),\n'
                  '  extensions: const <ThemeExtension<dynamic>>[],\n'
                  ');',
                  indigo500,
                ),
              ],
            ),
          ),

          sectionTitle('2', 'Three themed sub-trees',
              'Theme(data: ...) overrides scope to a subtree', violet500),
          threeThemed,

          sectionTitle('3', 'ColorScheme tokens',
              'fromSeed(indigo, light) · 12 of the most common roles', teal500),
          swatchGrid,

          sectionTitle('4', 'Typography ladder',
              'TextTheme display · headline · title · body · label', amber600),
          typographyLadder,

          sectionTitle('5', 'Component theme grid',
              'Default M3 vs strongly overridden Theme(data: ...)', rose500),
          componentGrid,

          sectionTitle('6', 'WidgetStateProperty resolver',
              'pressed · hovered · focused · disabled · default', indigo700),
          stateResolver,

          sectionTitle('7', 'InputDecorationTheme',
              'Outline · Filled · Underline — three coordinated overrides', teal600),
          inputDemo,

          sectionTitle('8', 'Surface previews',
              'SnackBar · Dialog · BottomSheet visual shells', amber700),
          surfacesRow,

          sectionTitle('9', 'Brightness comparison',
              'Same content under light and dark seeded schemes', slate800),
          brightnessRow,

          sectionTitle('10', 'Tips and pitfalls',
              'What works on real apps · what bites in dark mode', emerald600),
          tipsList,
          const SizedBox(height: 14.0),
          extensionsConceptCard,

          sectionTitle('11', 'Footer',
              'Demo summary statistics', violet700),
          footer,
        ],
      ),
    ),
  );
}

// ============================================================================
// PRIVATE HELPER WIDGETS (top-level for layout reuse — no state, no classes
// extending bridged abstracts)
// ============================================================================

Widget _bucket(String name, String detail, Color tone) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: tone.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              color: tone,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            detail,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 10.5,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _shareIcon(IconData icon, String label, Color tone) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 44.0,
        height: 44.0,
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(12.0),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: tone, size: 22.0),
      ),
      const SizedBox(height: 6.0),
      Text(
        label,
        style: const TextStyle(
          color: Color(0xFF334155),
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
