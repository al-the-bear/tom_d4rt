// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo of ThemeData (Material)
// ----------------------------------------------------------------------------
// ThemeData is the central design contract of a Material app. Anything that
// reads `Theme.of(context)` resolves up the widget tree until it hits the
// closest `Theme` inherited widget; the topmost provider is normally the
// `MaterialApp.theme` (or `darkTheme`). ThemeData is composed from a
// `ColorScheme` plus per-component sub-themes (`cardTheme`, `chipTheme`,
// `appBarTheme`, ...), a `TextTheme`, a `iconTheme`, and a list of
// `ThemeExtension`s for custom design tokens.
//
// This demo intentionally does NOT change the app-wide theme. Each section
// wraps a sub-tree in a local `Theme(data: ThemeData(...), child: ...)` so
// the reader can compare the section's theme against the page chrome.
// ----------------------------------------------------------------------------

import 'package:flutter/material.dart';

// =============================================================================
// CUSTOM THEME EXTENSION
// =============================================================================
// `ThemeExtension<T>` lets apps add their own design tokens to ThemeData
// without monkey-patching. Subclasses MUST implement `copyWith` and `lerp` so
// `ThemeData.lerp` (used by `MaterialApp` when transitioning between themes)
// can interpolate the extension correctly.
// =============================================================================

@immutable
class BrandTokens extends ThemeExtension<BrandTokens> {
  const BrandTokens({
    required this.brandPrimary,
    required this.brandAccent,
    required this.successGreen,
    required this.warningAmber,
    required this.dangerRed,
    required this.brandRadius,
    required this.brandPadding,
  });

  final Color brandPrimary;
  final Color brandAccent;
  final Color successGreen;
  final Color warningAmber;
  final Color dangerRed;
  final double brandRadius;
  final double brandPadding;

  @override
  BrandTokens copyWith({
    Color? brandPrimary,
    Color? brandAccent,
    Color? successGreen,
    Color? warningAmber,
    Color? dangerRed,
    double? brandRadius,
    double? brandPadding,
  }) {
    return BrandTokens(
      brandPrimary: brandPrimary ?? this.brandPrimary,
      brandAccent: brandAccent ?? this.brandAccent,
      successGreen: successGreen ?? this.successGreen,
      warningAmber: warningAmber ?? this.warningAmber,
      dangerRed: dangerRed ?? this.dangerRed,
      brandRadius: brandRadius ?? this.brandRadius,
      brandPadding: brandPadding ?? this.brandPadding,
    );
  }

  @override
  BrandTokens lerp(ThemeExtension<BrandTokens>? other, double t) {
    if (other is! BrandTokens) {
      return this;
    }
    return BrandTokens(
      brandPrimary: Color.lerp(brandPrimary, other.brandPrimary, t)!,
      brandAccent: Color.lerp(brandAccent, other.brandAccent, t)!,
      successGreen: Color.lerp(successGreen, other.successGreen, t)!,
      warningAmber: Color.lerp(warningAmber, other.warningAmber, t)!,
      dangerRed: Color.lerp(dangerRed, other.dangerRed, t)!,
      brandRadius: brandRadius + (other.brandRadius - brandRadius) * t,
      brandPadding: brandPadding + (other.brandPadding - brandPadding) * t,
    );
  }

  static const BrandTokens fallback = BrandTokens(
    brandPrimary: Color(0xFF1B5E20),
    brandAccent: Color(0xFFFFB300),
    successGreen: Color(0xFF2E7D32),
    warningAmber: Color(0xFFF9A825),
    dangerRed: Color(0xFFC62828),
    brandRadius: 12.0,
    brandPadding: 16.0,
  );
}

dynamic build(BuildContext context) {
  print('=== ThemeData Deep Demo ===');

  // ===========================================================================
  // PALETTES — distinct per section so the reader can see each demo at a
  // glance. Section numbers follow the order in which they are rendered.
  // ===========================================================================

  // Section 1 – seed-color swatch grid (indigo seed)
  const Color s1Seed = Color(0xFF3F51B5);
  const Color s1Backdrop = Color(0xFFE8EAF6);

  // Section 2 – light vs dark
  const Color s2Backdrop = Color(0xFFF1F8E9);

  // Section 3 – M2 vs M3
  const Color s3Backdrop = Color(0xFFFFF3E0);

  // Section 4 – text theme
  const Color s4Backdrop = Color(0xFFE0F7FA);
  const Color s4Surface = Color(0xFFFFFFFF);
  const Color s4Heading = Color(0xFF006064);
  const Color s4Body = Color(0xFF263238);

  // Section 5 – icon themes
  const Color s5Backdrop = Color(0xFFFFEBEE);
  const Color s5Primary = Color(0xFFC62828);
  const Color s5Surface = Color(0xFFFFFFFF);

  // Section 6 – card theme
  const Color s6Backdrop = Color(0xFFEDE7F6);
  const Color s6CardColor = Color(0xFFD1C4E9);
  const Color s6Shadow = Color(0xFF311B92);

  // Section 7 – chip theme
  const Color s7Backdrop = Color(0xFFE3F2FD);
  const Color s7ChipBg = Color(0xFFBBDEFB);
  const Color s7ChipSelected = Color(0xFF1565C0);
  const Color s7ChipLabel = Color(0xFF0D47A1);

  // Section 8 – dialog theme
  const Color s8Backdrop = Color(0xFFFCE4EC);
  const Color s8DialogBg = Color(0xFFFFF0F5);
  const Color s8DialogTitle = Color(0xFFAD1457);

  // Section 9 – appBar theme
  const Color s9Backdrop = Color(0xFFE8F5E9);
  const Color s9AppBarBg = Color(0xFF2E7D32);
  const Color s9AppBarFg = Color(0xFFFFFFFF);

  // Section 10 – FAB theme
  const Color s10Backdrop = Color(0xFFFFF8E1);
  const Color s10FabBg = Color(0xFFFFA000);
  const Color s10FabFg = Color(0xFF3E2723);

  // Section 11 – snackBar theme
  const Color s11Backdrop = Color(0xFFE0F2F1);
  const Color s11SnackBg = Color(0xFF004D40);
  const Color s11SnackFg = Color(0xFFB2DFDB);

  // Section 12 – inputDecoration theme
  const Color s12Backdrop = Color(0xFFEFEBE9);
  const Color s12FieldFill = Color(0xFFD7CCC8);
  const Color s12FieldBorder = Color(0xFF5D4037);

  // Section 13 – misc colors (scaffold/divider/disabled/hover/focus)
  const Color s13Backdrop = Color(0xFFECEFF1);
  const Color s13Scaffold = Color(0xFFCFD8DC);
  const Color s13Divider = Color(0xFF455A64);

  // Section 14 – ThemeExtension
  const Color s14Backdrop = Color(0xFFE8F5E9);

  // Section 15 – copyWith
  const Color s15Backdrop = Color(0xFFF3E5F5);

  // Section 16 – brand showcase (corporate green/gold)
  const Color brandPrimary = Color(0xFF1B5E20);
  const Color brandAccent = Color(0xFFFFB300);
  const Color brandSurface = Color(0xFFFFFDE7);
  const Color brandOnSurface = Color(0xFF1A1A1A);

  // Section 17 – seed comparison
  const Color s17Backdrop = Color(0xFFFAFAFA);

  // ===========================================================================
  // HELPERS
  // ===========================================================================

  Widget sectionCard({
    required String title,
    required String description,
    required Widget body,
    String? caption,
    Color backdrop = const Color(0xFFFAFAFA),
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.black.withOpacity(0.06)),
        ),
        child: Container(
          color: backdrop,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 14),
              body,
              if (caption != null) ...<Widget>[
                const SizedBox(height: 10),
                Text(
                  caption,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget liveStrip(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      padding: const EdgeInsets.all(14),
      child: child,
    );
  }

  String hex(Color c) {
    final int v = c.value & 0xFFFFFFFF;
    return '#${v.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  // ===========================================================================
  // SECTION 1 — ColorScheme.fromSeed swatch grid
  // ===========================================================================

  final ColorScheme s1Scheme = ColorScheme.fromSeed(seedColor: s1Seed);

  Widget swatchTile(String label, Color bg, Color fg) {
    return Container(
      width: 150,
      height: 70,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            hex(bg),
            style: TextStyle(color: fg, fontSize: 10, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }

  final Widget section1 = sectionCard(
    backdrop: s1Backdrop,
    title: '1. ColorScheme.fromSeed',
    description:
        'ColorScheme.fromSeed derives a complete tonal palette from a single '
        'seed color. ThemeData.from(colorScheme: ...) wires every Material '
        'component to those tokens. Below is every slot in the resolved scheme '
        'with its hex value.',
    caption:
        'Seed = ${hex(s1Seed)}. The same seed is reused below in section 17 '
        'next to three other seeds for direct comparison.',
    body: liveStrip(
      Theme(
        data: ThemeData.from(colorScheme: s1Scheme, useMaterial3: true),
        child: Builder(
          builder: (BuildContext c) {
            final ColorScheme cs = Theme.of(c).colorScheme;
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                swatchTile('primary', cs.primary, cs.onPrimary),
                swatchTile('onPrimary', cs.onPrimary, cs.primary),
                swatchTile(
                  'primaryContainer',
                  cs.primaryContainer,
                  cs.onPrimaryContainer,
                ),
                swatchTile(
                  'onPrimaryContainer',
                  cs.onPrimaryContainer,
                  cs.primaryContainer,
                ),
                swatchTile('secondary', cs.secondary, cs.onSecondary),
                swatchTile('onSecondary', cs.onSecondary, cs.secondary),
                swatchTile(
                  'secondaryContainer',
                  cs.secondaryContainer,
                  cs.onSecondaryContainer,
                ),
                swatchTile(
                  'onSecondaryContainer',
                  cs.onSecondaryContainer,
                  cs.secondaryContainer,
                ),
                swatchTile('tertiary', cs.tertiary, cs.onTertiary),
                swatchTile('onTertiary', cs.onTertiary, cs.tertiary),
                swatchTile(
                  'tertiaryContainer',
                  cs.tertiaryContainer,
                  cs.onTertiaryContainer,
                ),
                swatchTile(
                  'onTertiaryContainer',
                  cs.onTertiaryContainer,
                  cs.tertiaryContainer,
                ),
                swatchTile('error', cs.error, cs.onError),
                swatchTile('onError', cs.onError, cs.error),
                swatchTile(
                  'errorContainer',
                  cs.errorContainer,
                  cs.onErrorContainer,
                ),
                swatchTile(
                  'onErrorContainer',
                  cs.onErrorContainer,
                  cs.errorContainer,
                ),
                swatchTile('surface', cs.surface, cs.onSurface),
                swatchTile('onSurface', cs.onSurface, cs.surface),
                swatchTile(
                  'surfaceVariant',
                  cs.surfaceVariant,
                  cs.onSurfaceVariant,
                ),
                swatchTile(
                  'onSurfaceVariant',
                  cs.onSurfaceVariant,
                  cs.surfaceVariant,
                ),
                swatchTile('outline', cs.outline, cs.surface),
                swatchTile('outlineVariant', cs.outlineVariant, cs.onSurface),
                swatchTile('shadow', cs.shadow, cs.surface),
                swatchTile('scrim', cs.scrim, cs.surface),
                swatchTile(
                  'inverseSurface',
                  cs.inverseSurface,
                  cs.onInverseSurface,
                ),
                swatchTile(
                  'onInverseSurface',
                  cs.onInverseSurface,
                  cs.inverseSurface,
                ),
                swatchTile(
                  'inversePrimary',
                  cs.inversePrimary,
                  cs.onPrimary,
                ),
              ],
            );
          },
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 2 — Light vs Dark via ThemeData.light()/dark()
  // ===========================================================================

  Widget lightDarkPanel(ThemeData td, String label) {
    return Theme(
      data: td,
      child: Builder(
        builder: (BuildContext c) {
          final ThemeData t = Theme.of(c);
          return Container(
            width: 280,
            decoration: BoxDecoration(
              color: t.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: t.colorScheme.outlineVariant),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$label · brightness=${t.brightness.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: t.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'colorScheme.surface = ${hex(t.colorScheme.surface)}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: t.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  'colorScheme.primary = ${hex(t.colorScheme.primary)}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: t.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    FilledButton(
                      onPressed: () {},
                      child: const Text('Filled'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Outlined'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Chip(label: Text('Tag', style: TextStyle(color: t.colorScheme.onSecondaryContainer))),
              ],
            ),
          );
        },
      ),
    );
  }

  final Widget section2 = sectionCard(
    backdrop: s2Backdrop,
    title: '2. Light vs Dark',
    description:
        'ThemeData.light() and ThemeData.dark() are factory constructors that '
        'pre-populate every component sub-theme for the corresponding '
        'brightness. The brightness enum drives default colors and even the '
        'system overlay style for the status bar.',
    caption:
        'Wire ThemeData.light() to MaterialApp.theme and ThemeData.dark() to '
        'MaterialApp.darkTheme; the system theme mode picks one.',
    body: liveStrip(
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          lightDarkPanel(ThemeData.light(useMaterial3: true), 'Light'),
          lightDarkPanel(ThemeData.dark(useMaterial3: true), 'Dark'),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 3 — Material 2 vs Material 3
  // ===========================================================================

  Widget m2vm3Panel(bool useM3) {
    return Theme(
      data: ThemeData(
        useMaterial3: useM3,
        colorSchemeSeed: const Color(0xFFFB8C00),
      ),
      child: Builder(
        builder: (BuildContext c) {
          return Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  useM3 ? 'useMaterial3: true' : 'useMaterial3: false',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: () {},
                  child: const Text('Filled button'),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(useM3 ? 'M3 card' : 'M2 card'),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: const <Widget>[
                    Chip(label: Text('alpha')),
                    Chip(label: Text('beta')),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Switch(value: true, onChanged: (_) {}),
                    Expanded(
                      child: Slider(value: 0.6, onChanged: (_) {}),
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

  final Widget section3 = sectionCard(
    backdrop: s3Backdrop,
    title: '3. useMaterial3: true vs false',
    description:
        'The M3 flag rewires default shapes (rounder corners), default '
        'elevations (less drop-shadow, more tonal elevation), and default '
        'component sizes. New apps default to M3; legacy apps may stay on M2.',
    caption:
        'Migration tip: flip useMaterial3 once, then audit Card / Chip / '
        'Button visuals — most surprises come from elevation deltas.',
    body: liveStrip(
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[m2vm3Panel(false), m2vm3Panel(true)],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 4 — TextTheme overrides
  // ===========================================================================

  final ThemeData s4Theme = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        color: s4Heading,
        letterSpacing: -1,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: s4Heading,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: s4Heading,
        letterSpacing: 0.4,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: s4Body, height: 1.5),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: s4Body,
        letterSpacing: 1.2,
      ),
    ),
  );

  final Widget section4 = sectionCard(
    backdrop: s4Backdrop,
    title: '4. TextTheme overrides',
    description:
        'TextTheme is a bundle of named TextStyle slots (displayLarge, '
        'headlineMedium, titleSmall, bodyMedium, labelSmall, ...). Components '
        'that render text — like ListTile, AppBar, Chip — read from these '
        'slots so a single override propagates everywhere.',
    caption:
        'Tip: prefer overriding individual slots on the existing TextTheme '
        '(via copyWith) rather than supplying a fresh one — it keeps default '
        'unspecified slots usable.',
    body: liveStrip(
      Theme(
        data: s4Theme,
        child: Container(
          color: s4Surface,
          padding: const EdgeInsets.all(16),
          child: Builder(
            builder: (BuildContext c) {
              final TextTheme tt = Theme.of(c).textTheme;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('displayLarge', style: tt.displayLarge),
                  const SizedBox(height: 6),
                  Text('headlineMedium', style: tt.headlineMedium),
                  const SizedBox(height: 6),
                  Text('titleSmall', style: tt.titleSmall),
                  const SizedBox(height: 6),
                  Text(
                    'bodyMedium · long sample text demonstrating line-height '
                    'and color rendering in flowing copy.',
                    style: tt.bodyMedium,
                  ),
                  const SizedBox(height: 6),
                  Text('LABELSMALL · STATUS · 2026-05-02', style: tt.labelSmall),
                ],
              );
            },
          ),
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 5 — IconTheme & PrimaryIconTheme
  // ===========================================================================

  final ThemeData s5Theme = ThemeData(
    useMaterial3: true,
    iconTheme: const IconThemeData(
      color: s5Primary,
      size: 28,
      opacity: 1.0,
    ),
    primaryIconTheme: const IconThemeData(
      color: Colors.white,
      size: 22,
    ),
    primaryColor: s5Primary,
  );

  final Widget section5 = sectionCard(
    backdrop: s5Backdrop,
    title: '5. iconTheme & primaryIconTheme',
    description:
        'iconTheme is the default style for `Icon` widgets in the body. '
        'primaryIconTheme is used for icons rendered on top of primary-color '
        'surfaces (e.g. icons inside an old-style AppBar). Both are '
        'IconThemeData with color, size, opacity.',
    caption:
        'In M3 most icon coloring is handled by component sub-themes; '
        'iconTheme is still the global fallback for ad-hoc Icons.',
    body: liveStrip(
      Theme(
        data: s5Theme,
        child: Container(
          color: s5Surface,
          padding: const EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              const Expanded(
                child: Wrap(
                  spacing: 14,
                  runSpacing: 8,
                  children: <Widget>[
                    Icon(Icons.home),
                    Icon(Icons.favorite),
                    Icon(Icons.bolt),
                    Icon(Icons.flag),
                    Icon(Icons.shield),
                    Icon(Icons.bookmark),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                color: s5Primary,
                child: Builder(
                  builder: (BuildContext c) {
                    final IconThemeData primary = Theme.of(c).primaryIconTheme;
                    return IconTheme(
                      data: primary,
                      child: const Row(
                        children: <Widget>[
                          Icon(Icons.menu),
                          SizedBox(width: 10),
                          Icon(Icons.search),
                          SizedBox(width: 10),
                          Icon(Icons.account_circle),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 6 — CardTheme
  // ===========================================================================

  final ThemeData s6Theme = ThemeData(
    useMaterial3: true,
    cardTheme: CardThemeData(
      color: s6CardColor,
      elevation: 6,
      shadowColor: s6Shadow,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: s6Shadow, width: 1.5),
      ),
    ),
  );

  final Widget section6 = sectionCard(
    backdrop: s6Backdrop,
    title: '6. cardTheme',
    description:
        'CardThemeData controls every Card descendant: color, elevation, '
        'shadowColor, margin, and shape. The same Card widgets below pick up '
        'the styling without any per-instance overrides.',
    caption:
        'Use cardTheme over per-instance Card properties so design tweaks '
        'happen in one place.',
    body: liveStrip(
      Theme(
        data: s6Theme,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const <Widget>[
            SizedBox(
              width: 220,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text('Card A — themed via ThemeData.cardTheme.'),
                ),
              ),
            ),
            SizedBox(
              width: 220,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text('Card B — same theme, different content.'),
                ),
              ),
            ),
            SizedBox(
              width: 220,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text('Card C — picks up shape & shadow as well.'),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 7 — ChipTheme
  // ===========================================================================

  final ThemeData s7Theme = ThemeData(
    useMaterial3: true,
    chipTheme: ChipThemeData(
      backgroundColor: s7ChipBg,
      selectedColor: s7ChipSelected,
      disabledColor: const Color(0xFFCFD8DC),
      labelStyle: const TextStyle(
        color: s7ChipLabel,
        fontWeight: FontWeight.w600,
      ),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: s7ChipLabel),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
  );

  final Widget section7 = sectionCard(
    backdrop: s7Backdrop,
    title: '7. chipTheme',
    description:
        'ChipThemeData themes Chip, ActionChip, FilterChip, ChoiceChip, and '
        'InputChip in one place. Includes background, selected, disabled '
        'colors, label styles, padding, and shape.',
    caption: 'StatefulBuilder demos a FilterChip toggling selectedColor.',
    body: liveStrip(
      Theme(
        data: s7Theme,
        child: StatefulBuilder(
          builder: (BuildContext sb, StateSetter setState) {
            bool sel1 = true;
            bool sel2 = false;
            return StatefulBuilder(
              builder: (BuildContext c, StateSetter s) {
                return Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: <Widget>[
                    const Chip(label: Text('Plain')),
                    FilterChip(
                      label: const Text('Filter A'),
                      selected: sel1,
                      onSelected: (bool v) => s(() => sel1 = v),
                    ),
                    FilterChip(
                      label: const Text('Filter B'),
                      selected: sel2,
                      onSelected: (bool v) => s(() => sel2 = v),
                    ),
                    const Chip(
                      label: Text('Disabled'),
                      onDeleted: null,
                    ),
                    ActionChip(
                      label: const Text('Action'),
                      onPressed: () {},
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 8 — DialogTheme
  // ===========================================================================

  final ThemeData s8Theme = ThemeData(
    useMaterial3: true,
    dialogTheme: DialogThemeData(
      backgroundColor: s8DialogBg,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      titleTextStyle: const TextStyle(
        color: s8DialogTitle,
        fontWeight: FontWeight.w800,
        fontSize: 20,
      ),
      contentTextStyle: const TextStyle(
        color: Color(0xFF6A1B4D),
        fontSize: 14,
        height: 1.5,
      ),
    ),
  );

  final Widget section8 = sectionCard(
    backdrop: s8Backdrop,
    title: '8. dialogTheme',
    description:
        'DialogThemeData drives showDialog content: backgroundColor, '
        'elevation, shape, title/content text styles, and icon color. The '
        'snippet below renders a faux dialog (no overlay) so the static '
        'demo reads cleanly.',
    caption:
        'For real showDialog calls these same tokens apply automatically.',
    body: liveStrip(
      Theme(
        data: s8Theme,
        child: Builder(
          builder: (BuildContext c) {
            final DialogThemeData d = Theme.of(c).dialogTheme;
            return Container(
              decoration: ShapeDecoration(
                color: d.backgroundColor,
                shape: d.shape ?? const RoundedRectangleBorder(),
                shadows: <BoxShadow>[
                  BoxShadow(
                    blurRadius: (d.elevation ?? 0) * 2,
                    color: Colors.black.withOpacity(0.20),
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Confirm deletion', style: d.titleTextStyle),
                  const SizedBox(height: 10),
                  Text(
                    'This will permanently remove the selected items. '
                    'The action cannot be undone.',
                    style: d.contentTextStyle,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(onPressed: () {}, child: const Text('Cancel')),
                      const SizedBox(width: 8),
                      FilledButton(onPressed: () {}, child: const Text('Delete')),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 9 — AppBarTheme
  // ===========================================================================

  final ThemeData s9Theme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: s9AppBarBg,
      foregroundColor: s9AppBarFg,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: s9AppBarFg,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
      iconTheme: IconThemeData(color: s9AppBarFg),
    ),
  );

  final Widget section9 = sectionCard(
    backdrop: s9Backdrop,
    title: '9. appBarTheme',
    description:
        'AppBarTheme themes every AppBar instance: background, foreground, '
        'elevation, title style, system overlay style. centerTitle is '
        'app-wide here so all AppBars start centered.',
    caption:
        'Tip: keep brand colors in appBarTheme; per-screen tweaks should '
        'still go through ThemeData.copyWith.',
    body: liveStrip(
      Theme(
        data: s9Theme,
        child: SizedBox(
          height: 80,
          child: AppBar(
            title: const Text('Themed AppBar'),
            leading: const Icon(Icons.menu),
            actions: const <Widget>[
              Icon(Icons.search),
              SizedBox(width: 16),
              Icon(Icons.more_vert),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 10 — FloatingActionButtonTheme
  // ===========================================================================

  final ThemeData s10Theme = ThemeData(
    useMaterial3: true,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: s10FabBg,
      foregroundColor: s10FabFg,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );

  final Widget section10 = sectionCard(
    backdrop: s10Backdrop,
    title: '10. floatingActionButtonTheme',
    description:
        'FloatingActionButtonThemeData covers FAB color, shape, elevation, '
        'splash, focus and hover. All FABs in the subtree pick this up.',
    caption: 'Three FABs below — none specifies an explicit color.',
    body: liveStrip(
      Theme(
        data: s10Theme,
        child: Row(
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 12),
            FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.send),
              label: const Text('Send'),
            ),
            const SizedBox(width: 12),
            FloatingActionButton.small(
              onPressed: () {},
              child: const Icon(Icons.bolt),
            ),
          ],
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 11 — SnackBarTheme
  // ===========================================================================

  final ThemeData s11Theme = ThemeData(
    useMaterial3: true,
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: s11SnackBg,
      contentTextStyle: TextStyle(
        color: s11SnackFg,
        fontWeight: FontWeight.w600,
      ),
      actionTextColor: s11SnackFg,
      behavior: SnackBarBehavior.floating,
      elevation: 6,
    ),
  );

  final Widget section11 = sectionCard(
    backdrop: s11Backdrop,
    title: '11. snackBarTheme',
    description:
        'SnackBarThemeData controls how every snack bar shown via '
        'ScaffoldMessenger looks: background, content text style, action '
        'text color, behavior (fixed vs floating), shape, width, elevation.',
    caption: 'Faux snack bar below — no scaffold messenger required.',
    body: liveStrip(
      Theme(
        data: s11Theme,
        child: Builder(
          builder: (BuildContext c) {
            final SnackBarThemeData s = Theme.of(c).snackBarTheme;
            return Container(
              decoration: BoxDecoration(
                color: s.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    blurRadius: 12,
                    color: Color(0x33000000),
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Saved successfully.', style: s.contentTextStyle),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(foregroundColor: s.actionTextColor),
                    child: const Text('UNDO'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 12 — InputDecorationTheme
  // ===========================================================================

  final ThemeData s12Theme = ThemeData(
    useMaterial3: true,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: s12FieldFill,
      labelStyle: const TextStyle(color: s12FieldBorder),
      hintStyle: const TextStyle(color: Color(0xFF8D6E63)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: s12FieldBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: s12FieldBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: s12FieldBorder, width: 2),
      ),
    ),
  );

  final Widget section12 = sectionCard(
    backdrop: s12Backdrop,
    title: '12. inputDecorationTheme',
    description:
        'InputDecorationTheme drives every TextField, DropdownButtonFormField, '
        'and FormField subclass. Configure fill, borders, label and hint '
        'styles in one place — every form field in the app stays consistent.',
    caption: 'TextField + Dropdown below all share the same decoration.',
    body: liveStrip(
      Theme(
        data: s12Theme,
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: 'Full name',
                hintText: 'e.g. Jane Doe',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'name@example.com',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Country',
                prefixIcon: Icon(Icons.public),
              ),
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem<String>(value: 'us', child: Text('United States')),
                DropdownMenuItem<String>(value: 'fr', child: Text('France')),
                DropdownMenuItem<String>(value: 'jp', child: Text('Japan')),
              ],
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 13 — Scaffold/Divider/Disabled/Hover/Focus colors
  // ===========================================================================

  final ThemeData s13Theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: s13Scaffold,
    dividerColor: s13Divider,
    disabledColor: const Color(0xFF90A4AE),
    hoverColor: const Color(0x1A2196F3),
    focusColor: const Color(0x332196F3),
  );

  final Widget section13 = sectionCard(
    backdrop: s13Backdrop,
    title: '13. scaffoldBackgroundColor / dividerColor / disabledColor / hoverColor / focusColor',
    description:
        'Several top-level color slots configure the surfaces a Scaffold '
        'paints behind its body, the default Divider color, the color used '
        'for disabled controls, and the overlays for hover/focus states.',
    caption:
        'Hover and focus colors are typically translucent — they are painted '
        'on top of the underlying widget background.',
    body: liveStrip(
      Theme(
        data: s13Theme,
        child: Builder(
          builder: (BuildContext c) {
            final ThemeData t = Theme.of(c);
            return Container(
              color: t.scaffoldBackgroundColor,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('scaffoldBackgroundColor = ${hex(t.scaffoldBackgroundColor)}'),
                  const SizedBox(height: 10),
                  Container(
                    height: 1,
                    color: t.dividerColor,
                  ),
                  const SizedBox(height: 10),
                  Text('dividerColor = ${hex(t.dividerColor)}'),
                  const SizedBox(height: 14),
                  Row(
                    children: <Widget>[
                      ElevatedButton(onPressed: null, child: const Text('Disabled')),
                      const SizedBox(width: 12),
                      Text('disabledColor = ${hex(t.disabledColor)}'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: t.hoverColor,
                    padding: const EdgeInsets.all(8),
                    child: Text('hoverColor swatch = ${hex(t.hoverColor)}'),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    color: t.focusColor,
                    padding: const EdgeInsets.all(8),
                    child: Text('focusColor swatch = ${hex(t.focusColor)}'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 14 — ThemeExtension<BrandTokens>
  // ===========================================================================

  final ThemeData s14Theme = ThemeData(
    useMaterial3: true,
    extensions: const <ThemeExtension<dynamic>>[
      BrandTokens(
        brandPrimary: Color(0xFF1B5E20),
        brandAccent: Color(0xFFFFB300),
        successGreen: Color(0xFF2E7D32),
        warningAmber: Color(0xFFF9A825),
        dangerRed: Color(0xFFC62828),
        brandRadius: 14.0,
        brandPadding: 18.0,
      ),
    ],
  );

  final Widget section14 = sectionCard(
    backdrop: s14Backdrop,
    title: '14. ThemeExtension<BrandTokens>',
    description:
        'ThemeExtension<T> adds your own design tokens to ThemeData without '
        'forking. Components read them via Theme.of(context).extension<T>(). '
        'BrandTokens is defined at the top of this file and consumed below.',
    caption:
        'copyWith and lerp are required so MaterialApp can interpolate when '
        'switching themes.',
    body: liveStrip(
      Theme(
        data: s14Theme,
        child: Builder(
          builder: (BuildContext c) {
            final BrandTokens b =
                Theme.of(c).extension<BrandTokens>() ?? BrandTokens.fallback;
            Widget statusPill(String label, Color color) {
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: b.brandPadding * 0.6,
                  vertical: b.brandPadding * 0.25,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(b.brandRadius),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }

            return Container(
              padding: EdgeInsets.all(b.brandPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(b.brandRadius),
                border: Border.all(color: b.brandPrimary, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'BrandTokens.brandPrimary = ${hex(b.brandPrimary)}',
                    style: TextStyle(color: b.brandPrimary, fontWeight: FontWeight.w700),
                  ),
                  Text('BrandTokens.brandRadius = ${b.brandRadius}'),
                  Text('BrandTokens.brandPadding = ${b.brandPadding}'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      statusPill('SUCCESS', b.successGreen),
                      statusPill('WARNING', b.warningAmber),
                      statusPill('DANGER', b.dangerRed),
                      statusPill('ACCENT', b.brandAccent),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 15 — copyWith
  // ===========================================================================

  final ThemeData s15Base = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF6A1B9A),
  );
  final ThemeData s15Derived = s15Base.copyWith(
    cardTheme: s15Base.cardTheme.copyWith(
      color: const Color(0xFFE1BEE7),
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    ),
    chipTheme: s15Base.chipTheme.copyWith(
      backgroundColor: const Color(0xFFCE93D8),
      labelStyle: const TextStyle(color: Color(0xFF4A148C)),
    ),
  );

  Widget themePanel(ThemeData td, String label) {
    return Theme(
      data: td,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text('Card sample'),
              ),
            ),
            Wrap(
              spacing: 6,
              children: const <Widget>[
                Chip(label: Text('alpha')),
                Chip(label: Text('beta')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final Widget section15 = sectionCard(
    backdrop: s15Backdrop,
    title: '15. ThemeData.copyWith',
    description:
        'copyWith is the canonical way to derive a theme from another. Below '
        'a base theme is built once with colorSchemeSeed; a derived theme '
        'overrides cardTheme + chipTheme but keeps everything else.',
    caption:
        'Per-screen variants should always use copyWith; never construct a '
        'fresh ThemeData from scratch — you will lose default sub-themes.',
    body: liveStrip(
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          themePanel(s15Base, 'Base'),
          themePanel(s15Derived, 'copyWith'),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 16 — Brand showcase
  // ===========================================================================

  final ThemeData brandTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: brandPrimary,
      primary: brandPrimary,
      secondary: brandAccent,
      surface: brandSurface,
    ),
    cardTheme: CardThemeData(
      color: brandSurface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: brandPrimary,
      foregroundColor: Color(0xFFFFFDE7),
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: brandAccent,
      foregroundColor: brandOnSurface,
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: Color(0xFFE8F5E9),
      labelStyle: TextStyle(color: brandPrimary, fontWeight: FontWeight.w600),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: brandPrimary,
        fontWeight: FontWeight.w800,
      ),
      bodyMedium: TextStyle(color: brandOnSurface, height: 1.5),
    ),
    extensions: const <ThemeExtension<dynamic>>[BrandTokens.fallback],
  );

  final Widget section16 = sectionCard(
    backdrop: const Color(0xFFE8F5E9),
    title: '16. Real-world brand showcase',
    description:
        'A self-contained sample card built entirely from a brand ThemeData. '
        'Every component below — AppBar, Card, Chip, FAB, Body text — picks '
        'up the brand tokens with zero per-instance styling.',
    caption: 'This is the recommended deployment pattern for product themes.',
    body: liveStrip(
      Theme(
        data: brandTheme,
        child: Container(
          decoration: BoxDecoration(
            color: brandSurface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: brandPrimary, width: 1.2),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 56,
                child: AppBar(
                  title: const Text('Acme Co · Dashboard'),
                  actions: const <Widget>[
                    Icon(Icons.notifications_outlined),
                    SizedBox(width: 14),
                    Icon(Icons.account_circle_outlined),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Builder(
                      builder: (BuildContext c) => Text(
                        'Welcome back, Jane',
                        style: Theme.of(c).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'You have three approvals waiting and two reports '
                      'scheduled for today.',
                    ),
                    const SizedBox(height: 14),
                    const Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Active accounts'),
                                  SizedBox(height: 4),
                                  Text(
                                    '1,284',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('MRR'),
                                  SizedBox(height: 4),
                                  Text(
                                    '\$92.4k',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Wrap(
                      spacing: 8,
                      children: <Widget>[
                        Chip(label: Text('Production')),
                        Chip(label: Text('Stable')),
                        Chip(label: Text('Region: EU-1')),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: <Widget>[
                        FilledButton(
                          onPressed: () {},
                          child: const Text('Open report'),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text('Schedule meeting'),
                        ),
                        const Spacer(),
                        FloatingActionButton.small(
                          onPressed: () {},
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  // ===========================================================================
  // SECTION 17 — Seed comparison mini-tool
  // ===========================================================================

  Widget seedPanel(Color seed, String name) {
    final ColorScheme cs = ColorScheme.fromSeed(seedColor: seed);
    return Container(
      width: 220,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: seed,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black26),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '$name · ${hex(seed)}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Theme(
            data: ThemeData.from(colorScheme: cs, useMaterial3: true),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FilledButton(onPressed: () {}, child: const Text('Filled')),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'primaryContainer',
                    style: TextStyle(color: cs.onPrimaryContainer),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: cs.secondaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'secondaryContainer',
                    style: TextStyle(color: cs.onSecondaryContainer),
                  ),
                ),
                const SizedBox(height: 6),
                const Wrap(
                  spacing: 6,
                  children: <Widget>[
                    Chip(label: Text('alpha')),
                    Chip(label: Text('beta')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget section17 = sectionCard(
    backdrop: s17Backdrop,
    title: '17. Choosing seed color',
    description:
        'Four seeds, four full themes. ColorScheme.fromSeed produces a '
        'tonally-balanced palette from any input — pick a seed that matches '
        'your brand and let Material 3 handle the rest.',
    caption:
        'Tip: try your brand color, then a complementary accent, then a '
        'high-contrast neutral. Compare side by side.',
    body: liveStrip(
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: <Widget>[
          seedPanel(const Color(0xFF3F51B5), 'Indigo'),
          seedPanel(const Color(0xFF00897B), 'Teal'),
          seedPanel(const Color(0xFFC62828), 'Crimson'),
          seedPanel(const Color(0xFFFB8C00), 'Amber'),
        ],
      ),
    ),
  );

  // ===========================================================================
  // RETURN APP
  // ===========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ThemeData deep demo',
    theme: ThemeData(useMaterial3: true),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('ThemeData Deep Demo'),
        backgroundColor: const Color(0xFF263238),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: Text(
                  'ThemeData & Theme.of(context)',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 12),
                child: Text(
                  'Seventeen self-contained scenarios covering ColorScheme '
                  'seeding, light vs dark, M2 vs M3, every component '
                  'sub-theme, ThemeExtension, copyWith, and a real-world '
                  'brand showcase. Each demo is wrapped in a local Theme so '
                  'the page chrome itself does not change.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
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
              section15,
              section16,
              section17,
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}
