// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo of ThemeExtension<T> (Material).
// ----------------------------------------------------------------------------
// ThemeExtension<T> is Flutter's mechanism for adding custom typed values to
// ThemeData without modifying the framework. Each extension is identified by
// its runtime Type and stored in ThemeData.extensions, a
// Map<Object, ThemeExtension<dynamic>>. Retrieval is type-safe via
// Theme.of(context).extension<MyExtension>().
//
// Why use ThemeExtension instead of ad-hoc fields on a custom theme class?
//   - Integrated with AnimatedTheme: lerp() is invoked during theme tweens.
//   - Inherited by InheritedTheme machinery: works in pushed routes.
//   - Compose freely: any number of extensions per ThemeData.
//   - Light/dark variants: register different instances per brightness.
//   - Discoverable: every team's tokens live in the same place.
//
// Required overrides for each ThemeExtension<T> subclass:
//   - Object get type           => T;
//   - ThemeExtension<T> copyWith({...})
//   - ThemeExtension<T> lerp(covariant ThemeExtension<T>? other, double t)
//   - == and hashCode (recommended; Flutter compares for diff detection).
//
// This script defines five ThemeExtension subclasses at file scope:
//   * BrandColors        - hero, accent, CTA, surface tints.
//   * SemanticSpacing    - xs/sm/md/lg/xl spacing tokens.
//   * Elevations         - depth ladder for cards.
//   * IllustrationStyle  - flat / gradient / embossed renderer hints.
//   * MarketingTokens    - hero ratios, CTA radii, header weight.
//
// Each is consumed in real widgets via Theme.of(context).extension<T>()!.
// ----------------------------------------------------------------------------

import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';

// ===========================================================================
// FILE-SCOPE EXTENSION CLASSES
// ===========================================================================

@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  const BrandColors({
    required this.hero,
    required this.accent,
    required this.cta,
    required this.ctaForeground,
    required this.surfaceTint,
    required this.heroForeground,
  });

  final Color hero;
  final Color accent;
  final Color cta;
  final Color ctaForeground;
  final Color surfaceTint;
  final Color heroForeground;

  @override
  Object get type => BrandColors;

  @override
  BrandColors copyWith({
    Color? hero,
    Color? accent,
    Color? cta,
    Color? ctaForeground,
    Color? surfaceTint,
    Color? heroForeground,
  }) {
    return BrandColors(
      hero: hero ?? this.hero,
      accent: accent ?? this.accent,
      cta: cta ?? this.cta,
      ctaForeground: ctaForeground ?? this.ctaForeground,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      heroForeground: heroForeground ?? this.heroForeground,
    );
  }

  @override
  BrandColors lerp(covariant BrandColors? other, double t) {
    if (other == null) return this;
    return BrandColors(
      hero: Color.lerp(hero, other.hero, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      cta: Color.lerp(cta, other.cta, t)!,
      ctaForeground: Color.lerp(ctaForeground, other.ctaForeground, t)!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
      heroForeground: Color.lerp(heroForeground, other.heroForeground, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BrandColors &&
        other.hero == hero &&
        other.accent == accent &&
        other.cta == cta &&
        other.ctaForeground == ctaForeground &&
        other.surfaceTint == surfaceTint &&
        other.heroForeground == heroForeground;
  }

  @override
  int get hashCode => Object.hash(
        hero,
        accent,
        cta,
        ctaForeground,
        surfaceTint,
        heroForeground,
      );

  @override
  String toString() =>
      'BrandColors(hero:$hero accent:$accent cta:$cta tint:$surfaceTint)';
}

@immutable
class SemanticSpacing extends ThemeExtension<SemanticSpacing> {
  const SemanticSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  EdgeInsets get cardPadding => EdgeInsets.all(md);
  EdgeInsets get pagePadding => EdgeInsets.all(lg);
  EdgeInsets get tilePadding =>
      EdgeInsets.symmetric(horizontal: md, vertical: sm);

  @override
  Object get type => SemanticSpacing;

  @override
  SemanticSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return SemanticSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  SemanticSpacing lerp(covariant SemanticSpacing? other, double t) {
    if (other == null) return this;
    return SemanticSpacing(
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SemanticSpacing &&
        other.xs == xs &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg &&
        other.xl == xl;
  }

  @override
  int get hashCode => Object.hash(xs, sm, md, lg, xl);

  @override
  String toString() =>
      'SemanticSpacing(xs:$xs sm:$sm md:$md lg:$lg xl:$xl)';
}

@immutable
class Elevations extends ThemeExtension<Elevations> {
  const Elevations({
    required this.flat,
    required this.low,
    required this.medium,
    required this.high,
    required this.dramatic,
    required this.shadow,
  });

  final double flat;
  final double low;
  final double medium;
  final double high;
  final double dramatic;
  final Color shadow;

  @override
  Object get type => Elevations;

  @override
  Elevations copyWith({
    double? flat,
    double? low,
    double? medium,
    double? high,
    double? dramatic,
    Color? shadow,
  }) {
    return Elevations(
      flat: flat ?? this.flat,
      low: low ?? this.low,
      medium: medium ?? this.medium,
      high: high ?? this.high,
      dramatic: dramatic ?? this.dramatic,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  Elevations lerp(covariant Elevations? other, double t) {
    if (other == null) return this;
    return Elevations(
      flat: lerpDouble(flat, other.flat, t)!,
      low: lerpDouble(low, other.low, t)!,
      medium: lerpDouble(medium, other.medium, t)!,
      high: lerpDouble(high, other.high, t)!,
      dramatic: lerpDouble(dramatic, other.dramatic, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Elevations &&
        other.flat == flat &&
        other.low == low &&
        other.medium == medium &&
        other.high == high &&
        other.dramatic == dramatic &&
        other.shadow == shadow;
  }

  @override
  int get hashCode =>
      Object.hash(flat, low, medium, high, dramatic, shadow);

  @override
  String toString() =>
      'Elevations(flat:$flat low:$low med:$medium high:$high)';
}

enum IllustrationMode { flat, gradient, embossed }

@immutable
class IllustrationStyle extends ThemeExtension<IllustrationStyle> {
  const IllustrationStyle({
    required this.mode,
    required this.primary,
    required this.secondary,
    required this.outline,
    required this.glowOpacity,
    required this.cornerRadius,
  });

  final IllustrationMode mode;
  final Color primary;
  final Color secondary;
  final Color outline;
  final double glowOpacity;
  final double cornerRadius;

  @override
  Object get type => IllustrationStyle;

  @override
  IllustrationStyle copyWith({
    IllustrationMode? mode,
    Color? primary,
    Color? secondary,
    Color? outline,
    double? glowOpacity,
    double? cornerRadius,
  }) {
    return IllustrationStyle(
      mode: mode ?? this.mode,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      outline: outline ?? this.outline,
      glowOpacity: glowOpacity ?? this.glowOpacity,
      cornerRadius: cornerRadius ?? this.cornerRadius,
    );
  }

  @override
  IllustrationStyle lerp(covariant IllustrationStyle? other, double t) {
    if (other == null) return this;
    return IllustrationStyle(
      // Enums don't lerp; snap at midpoint.
      mode: t < 0.5 ? mode : other.mode,
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      glowOpacity: lerpDouble(glowOpacity, other.glowOpacity, t)!,
      cornerRadius: lerpDouble(cornerRadius, other.cornerRadius, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IllustrationStyle &&
        other.mode == mode &&
        other.primary == primary &&
        other.secondary == secondary &&
        other.outline == outline &&
        other.glowOpacity == glowOpacity &&
        other.cornerRadius == cornerRadius;
  }

  @override
  int get hashCode => Object.hash(
        mode,
        primary,
        secondary,
        outline,
        glowOpacity,
        cornerRadius,
      );

  @override
  String toString() =>
      'IllustrationStyle(mode:${mode.name} radius:$cornerRadius)';
}

@immutable
class MarketingTokens extends ThemeExtension<MarketingTokens> {
  const MarketingTokens({
    required this.heroAspectRatio,
    required this.ctaRadius,
    required this.headerWeight,
    required this.dividerThickness,
    required this.heroOverlayOpacity,
  });

  final double heroAspectRatio;
  final double ctaRadius;
  final FontWeight headerWeight;
  final double dividerThickness;
  final double heroOverlayOpacity;

  @override
  Object get type => MarketingTokens;

  @override
  MarketingTokens copyWith({
    double? heroAspectRatio,
    double? ctaRadius,
    FontWeight? headerWeight,
    double? dividerThickness,
    double? heroOverlayOpacity,
  }) {
    return MarketingTokens(
      heroAspectRatio: heroAspectRatio ?? this.heroAspectRatio,
      ctaRadius: ctaRadius ?? this.ctaRadius,
      headerWeight: headerWeight ?? this.headerWeight,
      dividerThickness: dividerThickness ?? this.dividerThickness,
      heroOverlayOpacity: heroOverlayOpacity ?? this.heroOverlayOpacity,
    );
  }

  @override
  MarketingTokens lerp(covariant MarketingTokens? other, double t) {
    if (other == null) return this;
    return MarketingTokens(
      heroAspectRatio:
          lerpDouble(heroAspectRatio, other.heroAspectRatio, t)!,
      ctaRadius: lerpDouble(ctaRadius, other.ctaRadius, t)!,
      headerWeight: t < 0.5 ? headerWeight : other.headerWeight,
      dividerThickness:
          lerpDouble(dividerThickness, other.dividerThickness, t)!,
      heroOverlayOpacity:
          lerpDouble(heroOverlayOpacity, other.heroOverlayOpacity, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MarketingTokens &&
        other.heroAspectRatio == heroAspectRatio &&
        other.ctaRadius == ctaRadius &&
        other.headerWeight == headerWeight &&
        other.dividerThickness == dividerThickness &&
        other.heroOverlayOpacity == heroOverlayOpacity;
  }

  @override
  int get hashCode => Object.hash(
        heroAspectRatio,
        ctaRadius,
        headerWeight,
        dividerThickness,
        heroOverlayOpacity,
      );

  @override
  String toString() =>
      'MarketingTokens(aspect:$heroAspectRatio cta:$ctaRadius)';
}

// ===========================================================================
// SHARED SECTION CARD HELPER
// ===========================================================================

Widget _sectionCard({
  required String title,
  required String description,
  required Widget child,
  required Color background,
  required Color border,
  required Color titleColor,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 18),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: border, width: 1),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: titleColor.withOpacity(0.75),
            height: 1.35,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== ThemeExtension Deep Demo ===');

  // -------------------------------------------------------------------------
  // PALETTES - one per section.
  // -------------------------------------------------------------------------

  // Section 1 - intro slate
  const Color slateBg = Color(0xFFECEFF1);
  const Color slateBorder = Color(0xFFB0BEC5);
  const Color slateTitle = Color(0xFF263238);

  // Section 2 - before/after blue grey
  const Color s2Bg = Color(0xFFE3F2FD);
  const Color s2Border = Color(0xFF90CAF9);
  const Color s2Title = Color(0xFF0D47A1);
  const Color s2Hero = Color(0xFF1565C0);
  const Color s2HeroFg = Color(0xFFFFFFFF);
  const Color s2Cta = Color(0xFFFFB300);
  const Color s2CtaFg = Color(0xFF263238);
  const Color s2Accent = Color(0xFF42A5F5);
  const Color s2Tint = Color(0xFFBBDEFB);

  // Section 3 - brand teal
  const Color s3Bg = Color(0xFFE0F2F1);
  const Color s3Border = Color(0xFF4DB6AC);
  const Color s3Title = Color(0xFF004D40);
  const Color s3Hero = Color(0xFF00695C);
  const Color s3HeroFg = Color(0xFFE0F2F1);
  const Color s3Cta = Color(0xFFFF7043);
  const Color s3CtaFg = Color(0xFFFFFFFF);
  const Color s3Accent = Color(0xFF26A69A);
  const Color s3Tint = Color(0xFFB2DFDB);

  // Section 4 - spacing purple
  const Color s4Bg = Color(0xFFEDE7F6);
  const Color s4Border = Color(0xFF9575CD);
  const Color s4Title = Color(0xFF311B92);
  const Color s4Tile = Color(0xFFFFFFFF);
  const Color s4TileBorder = Color(0xFFD1C4E9);
  const Color s4TileText = Color(0xFF311B92);

  // Section 5 - elevations forest
  const Color s5Bg = Color(0xFFE8F5E9);
  const Color s5Border = Color(0xFF66BB6A);
  const Color s5Title = Color(0xFF1B5E20);
  const Color s5Card = Color(0xFFFFFFFF);
  const Color s5CardText = Color(0xFF1B5E20);
  const Color s5Shadow = Color(0xFF1B5E20);

  // Section 6 - illustration amber
  const Color s6Bg = Color(0xFFFFF8E1);
  const Color s6Border = Color(0xFFFFB300);
  const Color s6Title = Color(0xFFE65100);
  const Color s6FlatPrimary = Color(0xFFEF6C00);
  const Color s6FlatSecondary = Color(0xFFFFB74D);
  const Color s6FlatOutline = Color(0xFFBF360C);
  const Color s6GradientPrimary = Color(0xFF6A1B9A);
  const Color s6GradientSecondary = Color(0xFFEC407A);
  const Color s6GradientOutline = Color(0xFF4A148C);
  const Color s6EmbossPrimary = Color(0xFF455A64);
  const Color s6EmbossSecondary = Color(0xFFCFD8DC);
  const Color s6EmbossOutline = Color(0xFF263238);

  // Section 7 - animated lerp pink
  const Color s7Bg = Color(0xFFFCE4EC);
  const Color s7Border = Color(0xFFF06292);
  const Color s7Title = Color(0xFF880E4F);
  const Color s7HeroA = Color(0xFFAD1457);
  const Color s7HeroB = Color(0xFF1B5E20);
  const Color s7CtaA = Color(0xFFFFD600);
  const Color s7CtaB = Color(0xFF40C4FF);
  const Color s7AccentA = Color(0xFFEC407A);
  const Color s7AccentB = Color(0xFF66BB6A);
  const Color s7TintA = Color(0xFFF8BBD0);
  const Color s7TintB = Color(0xFFC8E6C9);

  // Section 8 - light vs dark indigo
  const Color s8Bg = Color(0xFFE8EAF6);
  const Color s8Border = Color(0xFF7986CB);
  const Color s8Title = Color(0xFF1A237E);
  const Color s8LightHero = Color(0xFF3949AB);
  const Color s8LightCta = Color(0xFFFFB300);
  const Color s8LightAccent = Color(0xFF7986CB);
  const Color s8LightTint = Color(0xFFC5CAE9);
  const Color s8LightSurface = Color(0xFFFFFFFF);
  const Color s8LightOnSurface = Color(0xFF1A237E);
  const Color s8DarkHero = Color(0xFF9FA8DA);
  const Color s8DarkCta = Color(0xFFFFD54F);
  const Color s8DarkAccent = Color(0xFF5C6BC0);
  const Color s8DarkTint = Color(0xFF3949AB);
  const Color s8DarkSurface = Color(0xFF1A237E);
  const Color s8DarkOnSurface = Color(0xFFE8EAF6);

  // Section 9 - composed multi-extension brown
  const Color s9Bg = Color(0xFFEFEBE9);
  const Color s9Border = Color(0xFFA1887F);
  const Color s9Title = Color(0xFF3E2723);
  const Color s9Hero = Color(0xFF5D4037);
  const Color s9HeroFg = Color(0xFFEFEBE9);
  const Color s9Cta = Color(0xFFFF8A65);
  const Color s9CtaFg = Color(0xFF3E2723);
  const Color s9Accent = Color(0xFF8D6E63);
  const Color s9Tint = Color(0xFFD7CCC8);

  // Section 10 - readout cyan
  const Color s10Bg = Color(0xFFE0F7FA);
  const Color s10Border = Color(0xFF4DD0E1);
  const Color s10Title = Color(0xFF006064);
  const Color s10Card = Color(0xFFFFFFFF);
  const Color s10CardText = Color(0xFF006064);

  // Section 11 - vs ad-hoc red
  const Color s11Bg = Color(0xFFFFEBEE);
  const Color s11Border = Color(0xFFEF9A9A);
  const Color s11Title = Color(0xFFB71C1C);
  const Color s11Bad = Color(0xFFC62828);
  const Color s11Good = Color(0xFF2E7D32);

  // Section 12 - decision lime
  const Color s12Bg = Color(0xFFF9FBE7);
  const Color s12Border = Color(0xFFC0CA33);
  const Color s12Title = Color(0xFF33691E);
  const Color s12Yes = Color(0xFF558B2F);
  const Color s12No = Color(0xFFC62828);

  // -------------------------------------------------------------------------
  // SHARED INSTANCES of extensions used by multiple sections.
  // -------------------------------------------------------------------------

  const brandLight = BrandColors(
    hero: s8LightHero,
    accent: s8LightAccent,
    cta: s8LightCta,
    ctaForeground: Color(0xFF263238),
    surfaceTint: s8LightTint,
    heroForeground: Color(0xFFFFFFFF),
  );

  const brandDark = BrandColors(
    hero: s8DarkHero,
    accent: s8DarkAccent,
    cta: s8DarkCta,
    ctaForeground: Color(0xFF1A237E),
    surfaceTint: s8DarkTint,
    heroForeground: Color(0xFF1A237E),
  );

  const spacingCompact = SemanticSpacing(
    xs: 2,
    sm: 4,
    md: 8,
    lg: 12,
    xl: 16,
  );

  const spacingDefault = SemanticSpacing(
    xs: 4,
    sm: 8,
    md: 12,
    lg: 20,
    xl: 32,
  );

  const spacingComfy = SemanticSpacing(
    xs: 6,
    sm: 12,
    md: 20,
    lg: 32,
    xl: 48,
  );

  const elevLow = Elevations(
    flat: 0,
    low: 1,
    medium: 3,
    high: 6,
    dramatic: 12,
    shadow: s5Shadow,
  );

  const elevHigh = Elevations(
    flat: 0,
    low: 2,
    medium: 6,
    high: 14,
    dramatic: 24,
    shadow: s5Shadow,
  );

  const illusFlat = IllustrationStyle(
    mode: IllustrationMode.flat,
    primary: s6FlatPrimary,
    secondary: s6FlatSecondary,
    outline: s6FlatOutline,
    glowOpacity: 0.0,
    cornerRadius: 8,
  );

  const illusGradient = IllustrationStyle(
    mode: IllustrationMode.gradient,
    primary: s6GradientPrimary,
    secondary: s6GradientSecondary,
    outline: s6GradientOutline,
    glowOpacity: 0.35,
    cornerRadius: 16,
  );

  const illusEmbossed = IllustrationStyle(
    mode: IllustrationMode.embossed,
    primary: s6EmbossPrimary,
    secondary: s6EmbossSecondary,
    outline: s6EmbossOutline,
    glowOpacity: 0.55,
    cornerRadius: 4,
  );

  const marketingDefault = MarketingTokens(
    heroAspectRatio: 16 / 9,
    ctaRadius: 12,
    headerWeight: FontWeight.w700,
    dividerThickness: 1,
    heroOverlayOpacity: 0.35,
  );

  const marketingBold = MarketingTokens(
    heroAspectRatio: 21 / 9,
    ctaRadius: 24,
    headerWeight: FontWeight.w900,
    dividerThickness: 2,
    heroOverlayOpacity: 0.55,
  );

  // -------------------------------------------------------------------------
  // ROOT THEME with all five extensions registered.
  // -------------------------------------------------------------------------

  final rootTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.indigo,
    extensions: const [
      brandLight,
      spacingDefault,
      elevLow,
      illusFlat,
      marketingDefault,
    ],
  );

  // =========================================================================
  // SECTION 1 - INTRODUCTION
  // =========================================================================

  final s1 = _sectionCard(
    title: '1. What is ThemeExtension<T>?',
    description:
        'A typed bag of design tokens registered on ThemeData. Resolved by '
        'runtime type via Theme.of(context).extension<T>(). Participates in '
        'AnimatedTheme tweens through lerp(). Survives route inheritance.',
    background: slateBg,
    border: slateBorder,
    titleColor: slateTitle,
    child: Builder(
      builder: (ctx) {
        final ext = Theme.of(ctx).extension<BrandColors>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Found BrandColors? ${ext != null}',
                style: const TextStyle(color: slateTitle)),
            const SizedBox(height: 4),
            const Text(
              'Five extensions registered: BrandColors, SemanticSpacing, '
              'Elevations, IllustrationStyle, MarketingTokens.',
              style: TextStyle(color: slateTitle, fontSize: 12),
            ),
          ],
        );
      },
    ),
  );

  // =========================================================================
  // SECTION 2 - BEFORE / AFTER
  // =========================================================================

  Widget marketingCardWithoutExtension() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFCFD8DC),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Before: hard-coded',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF263238),
              )),
          SizedBox(height: 6),
          Text(
            'Colors live inline. Reused across files? Copy-paste. Brand '
            'rebrand? Find-and-replace. Untyped, undiscoverable.',
            style: TextStyle(fontSize: 12, color: Color(0xFF263238)),
          ),
        ],
      ),
    );
  }

  Widget marketingCardWithExtension() {
    return Builder(
      builder: (ctx) {
        // Local mini-theme so this section has its own brand.
        return Theme(
          data: Theme.of(ctx).copyWith(
            extensions: const [
              BrandColors(
                hero: s2Hero,
                accent: s2Accent,
                cta: s2Cta,
                ctaForeground: s2CtaFg,
                surfaceTint: s2Tint,
                heroForeground: s2HeroFg,
              ),
            ],
          ),
          child: Builder(
            builder: (innerCtx) {
              final brand =
                  Theme.of(innerCtx).extension<BrandColors>()!;
              return Container(
                decoration: BoxDecoration(
                  color: brand.surfaceTint,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: brand.accent),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'After: typed token',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: brand.hero,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Reads brand.hero / brand.accent / brand.surfaceTint '
                      'from Theme.of(context).extension<BrandColors>().',
                      style: TextStyle(
                        fontSize: 12,
                        color: brand.hero,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: brand.cta,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Buy now',
                        style: TextStyle(
                          color: brand.ctaForeground,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  final s2 = _sectionCard(
    title: '2. Before / After',
    description:
        'Same widget. Left: hard-coded colors. Right: pulled from '
        'BrandColors extension. The right card swaps to any brand by '
        'changing one ThemeData.',
    background: s2Bg,
    border: s2Border,
    titleColor: s2Title,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: marketingCardWithoutExtension()),
        const SizedBox(width: 10),
        Expanded(child: marketingCardWithExtension()),
      ],
    ),
  );

  // =========================================================================
  // SECTION 3 - BRAND COLORS APPLIED TO MARKETING CARD
  // =========================================================================

  final s3 = _sectionCard(
    title: '3. BrandColors on a marketing card',
    description:
        'Hero band, surface tint backdrop, accent divider, CTA chip - every '
        'colour reads from BrandColors.',
    background: s3Bg,
    border: s3Border,
    titleColor: s3Title,
    child: Theme(
      data: rootTheme.copyWith(
        extensions: const [
          BrandColors(
            hero: s3Hero,
            accent: s3Accent,
            cta: s3Cta,
            ctaForeground: s3CtaFg,
            surfaceTint: s3Tint,
            heroForeground: s3HeroFg,
          ),
        ],
      ),
      child: Builder(
        builder: (ctx) {
          final brand = Theme.of(ctx).extension<BrandColors>()!;
          return Container(
            decoration: BoxDecoration(
              color: brand.surfaceTint,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: brand.hero,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Spring Sale',
                    style: TextStyle(
                      color: brand.heroForeground,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(height: 2, color: brand.accent),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Up to 40% off across the spring catalogue.',
                        style: TextStyle(color: brand.hero),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: brand.cta,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Shop',
                              style: TextStyle(
                                color: brand.ctaForeground,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: brand.accent, width: 1.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Learn more',
                              style: TextStyle(color: brand.hero),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );

  // =========================================================================
  // SECTION 4 - SEMANTIC SPACING IN A SETTINGS LIST
  // =========================================================================

  final settingsItems = <Map<String, String>>[
    {'icon': 'A', 'label': 'Account', 'sub': 'Profile, email, password'},
    {'icon': 'N', 'label': 'Notifications', 'sub': 'Push, email digest'},
    {'icon': 'P', 'label': 'Privacy', 'sub': 'Visibility, data export'},
    {'icon': 'B', 'label': 'Billing', 'sub': 'Plan, invoices, taxes'},
    {'icon': 'L', 'label': 'Language', 'sub': 'Locale, translations'},
    {'icon': 'H', 'label': 'Help', 'sub': 'Docs, contact support'},
  ];

  Widget settingsListWithSpacing(SemanticSpacing sp) {
    return Theme(
      data: rootTheme.copyWith(
        extensions: [
          brandLight,
          sp,
          elevLow,
          illusFlat,
          marketingDefault,
        ],
      ),
      child: Builder(
        builder: (ctx) {
          final spacing =
              Theme.of(ctx).extension<SemanticSpacing>()!;
          return Container(
            padding: spacing.pagePadding,
            decoration: BoxDecoration(
              color: s4Bg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                for (final item in settingsItems)
                  Container(
                    margin: EdgeInsets.only(bottom: spacing.sm),
                    padding: spacing.tilePadding,
                    decoration: BoxDecoration(
                      color: s4Tile,
                      border: Border.all(color: s4TileBorder),
                      borderRadius: BorderRadius.circular(spacing.xs + 2),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: spacing.xl,
                          height: spacing.xl,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD1C4E9),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            item['icon']!,
                            style: const TextStyle(
                              color: s4TileText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: spacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['label']!,
                                style: const TextStyle(
                                  color: s4TileText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spacing.xs),
                              Text(
                                item['sub']!,
                                style: const TextStyle(
                                  color: s4TileText,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  final s4 = _sectionCard(
    title: '4. SemanticSpacing in a settings list',
    description:
        'Same list rendered with three spacing densities. xs/sm/md/lg/xl '
        'flow from the extension into padding, gap, and tile sizing.',
    background: s4Bg,
    border: s4Border,
    titleColor: s4Title,
    child: StatefulBuilder(
      builder: (ctx, setState) {
        var current = 1; // 0 compact, 1 default, 2 comfy
        final variants = [spacingCompact, spacingDefault, spacingComfy];
        final names = ['Compact', 'Default', 'Comfy'];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              children: List.generate(3, (i) {
                final selected = i == current;
                return GestureDetector(
                  onTap: () => setState(() => current = i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: selected ? s4Title : s4Tile,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: s4Title),
                    ),
                    child: Text(
                      names[i],
                      style: TextStyle(
                        color: selected ? Colors.white : s4Title,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 12),
            settingsListWithSpacing(variants[current]),
          ],
        );
      },
    ),
  );

  // =========================================================================
  // SECTION 5 - ELEVATIONS DEPTH LADDER
  // =========================================================================

  Widget elevationLadder(Elevations e) {
    final levels = <Map<String, dynamic>>[
      {'name': 'flat', 'value': e.flat},
      {'name': 'low', 'value': e.low},
      {'name': 'medium', 'value': e.medium},
      {'name': 'high', 'value': e.high},
      {'name': 'dramatic', 'value': e.dramatic},
    ];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final l in levels)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Material(
                elevation: l['value'] as double,
                shadowColor: e.shadow,
                borderRadius: BorderRadius.circular(8),
                color: s5Card,
                child: SizedBox(
                  height: 80,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l['name'] as String,
                          style: const TextStyle(
                            color: s5CardText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          (l['value'] as double).toStringAsFixed(1),
                          style: const TextStyle(
                            color: s5CardText,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  final s5 = _sectionCard(
    title: '5. Elevations depth ladder',
    description:
        'Five named depths from a single Elevations extension. Toggle low '
        'vs high preset to see the ladder steepen.',
    background: s5Bg,
    border: s5Border,
    titleColor: s5Title,
    child: StatefulBuilder(
      builder: (ctx, setState) {
        var useHigh = false;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Switch(
                  value: useHigh,
                  onChanged: (v) => setState(() => useHigh = v),
                  activeColor: s5Title,
                ),
                const SizedBox(width: 8),
                Text(useHigh ? 'High preset' : 'Low preset',
                    style: const TextStyle(color: s5Title)),
              ],
            ),
            const SizedBox(height: 12),
            Theme(
              data: rootTheme.copyWith(
                extensions: [
                  brandLight,
                  spacingDefault,
                  useHigh ? elevHigh : elevLow,
                  illusFlat,
                  marketingDefault,
                ],
              ),
              child: Builder(
                builder: (innerCtx) {
                  final e =
                      Theme.of(innerCtx).extension<Elevations>()!;
                  return elevationLadder(e);
                },
              ),
            ),
          ],
        );
      },
    ),
  );

  // =========================================================================
  // SECTION 6 - ILLUSTRATION STYLE TOGGLE
  // =========================================================================

  Widget illustrationTile(IllustrationStyle s, String label) {
    BoxDecoration deco;
    switch (s.mode) {
      case IllustrationMode.flat:
        deco = BoxDecoration(
          color: s.primary,
          border: Border.all(color: s.outline, width: 2),
          borderRadius: BorderRadius.circular(s.cornerRadius),
        );
        break;
      case IllustrationMode.gradient:
        deco = BoxDecoration(
          gradient: LinearGradient(
            colors: [s.primary, s.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(s.cornerRadius),
          boxShadow: [
            BoxShadow(
              color: s.primary.withOpacity(s.glowOpacity),
              blurRadius: 18,
              spreadRadius: 2,
            ),
          ],
        );
        break;
      case IllustrationMode.embossed:
        deco = BoxDecoration(
          color: s.secondary,
          border: Border.all(color: s.outline, width: 2),
          borderRadius: BorderRadius.circular(s.cornerRadius),
          boxShadow: [
            BoxShadow(
              color: s.outline.withOpacity(s.glowOpacity),
              offset: const Offset(2, 2),
              blurRadius: 0,
            ),
            BoxShadow(
              color: s.primary.withOpacity(s.glowOpacity * 0.6),
              offset: const Offset(-2, -2),
              blurRadius: 0,
            ),
          ],
        );
        break;
    }
    return Container(
      height: 90,
      decoration: deco,
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: s.mode == IllustrationMode.embossed
              ? s.outline
              : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  final s6 = _sectionCard(
    title: '6. IllustrationStyle comparison strip',
    description:
        'Three modes - flat, gradient, embossed - rendered by the same tile '
        'widget. Mode and colors come from the IllustrationStyle extension.',
    background: s6Bg,
    border: s6Border,
    titleColor: s6Title,
    child: Row(
      children: [
        Expanded(
          child: Theme(
            data: rootTheme.copyWith(
              extensions: const [
                brandLight,
                spacingDefault,
                elevLow,
                illusFlat,
                marketingDefault,
              ],
            ),
            child: Builder(
              builder: (ctx) => illustrationTile(
                Theme.of(ctx).extension<IllustrationStyle>()!,
                'Flat',
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Theme(
            data: rootTheme.copyWith(
              extensions: const [
                brandLight,
                spacingDefault,
                elevLow,
                illusGradient,
                marketingDefault,
              ],
            ),
            child: Builder(
              builder: (ctx) => illustrationTile(
                Theme.of(ctx).extension<IllustrationStyle>()!,
                'Gradient',
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Theme(
            data: rootTheme.copyWith(
              extensions: const [
                brandLight,
                spacingDefault,
                elevLow,
                illusEmbossed,
                marketingDefault,
              ],
            ),
            child: Builder(
              builder: (ctx) => illustrationTile(
                Theme.of(ctx).extension<IllustrationStyle>()!,
                'Embossed',
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 7 - ANIMATED THEME LERP
  // =========================================================================

  final brandA = const BrandColors(
    hero: s7HeroA,
    accent: s7AccentA,
    cta: s7CtaA,
    ctaForeground: Color(0xFF212121),
    surfaceTint: s7TintA,
    heroForeground: Color(0xFFFFFFFF),
  );

  final brandB = const BrandColors(
    hero: s7HeroB,
    accent: s7AccentB,
    cta: s7CtaB,
    ctaForeground: Color(0xFF212121),
    surfaceTint: s7TintB,
    heroForeground: Color(0xFFFFFFFF),
  );

  Widget brandPreview(BrandColors brand) {
    return Container(
      decoration: BoxDecoration(
        color: brand.surfaceTint,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: brand.accent, width: 2),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: brand.hero,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              'Hi',
              style: TextStyle(
                color: brand.heroForeground,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lerp preview',
                  style: TextStyle(
                    color: brand.hero,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: brand.cta,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Action',
                    style: TextStyle(
                      color: brand.ctaForeground,
                      fontWeight: FontWeight.bold,
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

  final s7 = _sectionCard(
    title: '7. Animated lerp via slider',
    description:
        'Drive a slider from 0 to 1. Each tick computes brandA.lerp(brandB, '
        't) and renders the result. AnimatedTheme uses the same lerp on '
        'every frame of an automatic transition.',
    background: s7Bg,
    border: s7Border,
    titleColor: s7Title,
    child: StatefulBuilder(
      builder: (ctx, setState) {
        var t = 0.0;
        return StatefulBuilder(
          builder: (ctx2, setLocal) {
            final blended = brandA.lerp(brandB, t);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('A',
                        style: TextStyle(
                            color: s7Title,
                            fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Slider(
                        value: t,
                        onChanged: (v) => setLocal(() => t = v),
                        activeColor: s7Title,
                      ),
                    ),
                    const Text('B',
                        style: TextStyle(
                            color: s7Title,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Text('t = ${t.toStringAsFixed(2)}',
                    style: const TextStyle(color: s7Title)),
                const SizedBox(height: 8),
                brandPreview(blended),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: brandPreview(brandA)),
                    const SizedBox(width: 8),
                    Expanded(child: brandPreview(brandB)),
                  ],
                ),
              ],
            );
          },
        );
      },
    ),
  );

  // =========================================================================
  // SECTION 8 - LIGHT vs DARK
  // =========================================================================

  Widget brightnessSwatch(Brightness b) {
    final light = b == Brightness.light;
    final brand = light ? brandLight : brandDark;
    final surface = light ? s8LightSurface : s8DarkSurface;
    final onSurface = light ? s8LightOnSurface : s8DarkOnSurface;
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        brightness: b,
        extensions: [brand, spacingDefault, elevLow],
      ),
      child: Builder(
        builder: (ctx) {
          final br = Theme.of(ctx).extension<BrandColors>()!;
          return Container(
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: br.accent),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  light ? 'Light' : 'Dark',
                  style: TextStyle(
                    color: onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: br.hero,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Hero',
                    style: TextStyle(
                      color: br.heroForeground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: br.cta,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'CTA',
                    style: TextStyle(
                      color: br.ctaForeground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final s8 = _sectionCard(
    title: '8. Light vs Dark - separate extension instances',
    description:
        'Two ThemeData objects, one per brightness, each with its own '
        'BrandColors. Same widget code; rendering differs because '
        'Theme.of(context).extension<BrandColors>() resolves differently.',
    background: s8Bg,
    border: s8Border,
    titleColor: s8Title,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: brightnessSwatch(Brightness.light)),
        const SizedBox(width: 10),
        Expanded(child: brightnessSwatch(Brightness.dark)),
      ],
    ),
  );

  // =========================================================================
  // SECTION 9 - MULTIPLE EXTENSIONS COMPOSED
  // =========================================================================

  final s9 = _sectionCard(
    title: '9. Multiple extensions in one Theme',
    description:
        'BrandColors + SemanticSpacing + Elevations + IllustrationStyle + '
        'MarketingTokens, all on the same ThemeData. Each contributes a '
        'piece of the rendered hero block.',
    background: s9Bg,
    border: s9Border,
    titleColor: s9Title,
    child: Theme(
      data: rootTheme.copyWith(
        extensions: const [
          BrandColors(
            hero: s9Hero,
            accent: s9Accent,
            cta: s9Cta,
            ctaForeground: s9CtaFg,
            surfaceTint: s9Tint,
            heroForeground: s9HeroFg,
          ),
          spacingComfy,
          elevHigh,
          illusGradient,
          marketingBold,
        ],
      ),
      child: Builder(
        builder: (ctx) {
          final theme = Theme.of(ctx);
          final brand = theme.extension<BrandColors>()!;
          final sp = theme.extension<SemanticSpacing>()!;
          final el = theme.extension<Elevations>()!;
          final illus = theme.extension<IllustrationStyle>()!;
          final mk = theme.extension<MarketingTokens>()!;
          return Material(
            elevation: el.high,
            shadowColor: el.shadow,
            borderRadius: BorderRadius.circular(illus.cornerRadius),
            color: brand.surfaceTint,
            child: Padding(
              padding: sp.cardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: mk.heroAspectRatio,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [brand.hero, brand.accent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.circular(illus.cornerRadius),
                      ),
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.all(sp.md),
                      child: Text(
                        'Composed Hero',
                        style: TextStyle(
                          color: brand.heroForeground,
                          fontSize: 22,
                          fontWeight: mk.headerWeight,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: sp.md),
                  Divider(
                    color: brand.accent,
                    thickness: mk.dividerThickness,
                  ),
                  SizedBox(height: sp.sm),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: sp.lg,
                      vertical: sp.sm,
                    ),
                    decoration: BoxDecoration(
                      color: brand.cta,
                      borderRadius:
                          BorderRadius.circular(mk.ctaRadius),
                    ),
                    child: Text(
                      'Composed CTA',
                      style: TextStyle(
                        color: brand.ctaForeground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );

  // =========================================================================
  // SECTION 10 - DEBUG READOUT WIDGET
  // =========================================================================

  final s10 = _sectionCard(
    title: '10. Reading extensions from any context',
    description:
        'A diagnostic widget walks Theme.of(context) and prints every '
        'registered extension. Drop it anywhere in the tree - no plumbing.',
    background: s10Bg,
    border: s10Border,
    titleColor: s10Title,
    child: Theme(
      data: rootTheme,
      child: Builder(
        builder: (ctx) {
          final theme = Theme.of(ctx);
          final brand = theme.extension<BrandColors>();
          final sp = theme.extension<SemanticSpacing>();
          final el = theme.extension<Elevations>();
          final illus = theme.extension<IllustrationStyle>();
          final mk = theme.extension<MarketingTokens>();
          final lines = <String>[
            'BrandColors:        ${brand?.toString() ?? "<missing>"}',
            'SemanticSpacing:    ${sp?.toString() ?? "<missing>"}',
            'Elevations:         ${el?.toString() ?? "<missing>"}',
            'IllustrationStyle:  ${illus?.toString() ?? "<missing>"}',
            'MarketingTokens:    ${mk?.toString() ?? "<missing>"}',
            'Total registered:   ${theme.extensions.length}',
          ];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: s10Card,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: s10Border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final l in lines)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Text(
                      l,
                      style: const TextStyle(
                        color: s10CardText,
                        fontFamily: 'monospace',
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    ),
  );

  // =========================================================================
  // SECTION 11 - VS AD-HOC THEME FIELDS
  // =========================================================================

  final s11 = _sectionCard(
    title: '11. ThemeExtension vs ad-hoc fields',
    description:
        'Why not just stuff more fields into a custom AppTheme? Comparison '
        'of trade-offs.',
    background: s11Bg,
    border: s11Border,
    titleColor: s11Title,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _comparisonRow(
            'AnimatedTheme tweens',
            'Manual interpolation in app code.',
            'Built-in via lerp(); AnimatedTheme calls it for free.',
            s11Bad,
            s11Good),
        const SizedBox(height: 6),
        _comparisonRow(
            'Route inheritance',
            'Lost unless you wrap pushed routes manually.',
            'Carried by Theme through the standard machinery.',
            s11Bad,
            s11Good),
        const SizedBox(height: 6),
        _comparisonRow(
            'Per-subtree overrides',
            'Rebuild custom InheritedWidget for every layer.',
            'Theme(data: parent.copyWith(extensions: [...])) - done.',
            s11Bad,
            s11Good),
        const SizedBox(height: 6),
        _comparisonRow(
            'Composability',
            'One class, ever-growing fields, merge conflicts.',
            'Independent extensions per concern.',
            s11Bad,
            s11Good),
        const SizedBox(height: 6),
        _comparisonRow(
            'Type safety',
            'Stringly-typed lookups or untyped maps.',
            'extension<T>() returns T?, fully typed.',
            s11Bad,
            s11Good),
      ],
    ),
  );

  // =========================================================================
  // SECTION 12 - DECISION CARD
  // =========================================================================

  final s12 = _sectionCard(
    title: '12. When to use ThemeExtension',
    description:
        'Reach for ThemeExtension<T> when the answer to any of these is '
        'yes:',
    background: s12Bg,
    border: s12Border,
    titleColor: s12Title,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _decisionRow(
            'Token reused in 3+ places',
            'Brand colours, spacing scale, elevation ramps.',
            true,
            s12Yes,
            s12No),
        _decisionRow(
            'Light vs dark variants',
            'Ship two instances; theme machinery picks the right one.',
            true,
            s12Yes,
            s12No),
        _decisionRow(
            'Smooth theme transitions',
            'AnimatedTheme requires lerp(); ad-hoc fields cannot.',
            true,
            s12Yes,
            s12No),
        _decisionRow(
            'Per-subtree branding (whitelabel)',
            'Theme.copyWith(extensions: ...) wraps a route or subtree.',
            true,
            s12Yes,
            s12No),
        _decisionRow(
            'Single-use private constant',
            'Just declare a const at file scope; do not wrap it.',
            false,
            s12Yes,
            s12No),
        _decisionRow(
            'Runtime data (user prefs, server state)',
            'That belongs in app state, not ThemeData.',
            false,
            s12Yes,
            s12No),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // FINAL ASSEMBLY
  // -------------------------------------------------------------------------

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: rootTheme,
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('ThemeExtension Deep Demo'),
        backgroundColor: rootTheme.colorScheme.primary,
        foregroundColor: rootTheme.colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              s1,
              s2,
              s3,
              s4,
              s5,
              s6,
              s7,
              s8,
              s9,
              s10,
              s11,
              s12,
              const SizedBox(height: 24),
              const Text(
                'End of demo. ThemeExtension<T> = typed, lerpable, '
                'composable design tokens.',
                style: TextStyle(fontSize: 12, color: Color(0xFF424242)),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _comparisonRow(
  String label,
  String adHoc,
  String ext,
  Color bad,
  Color good,
) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(color: const Color(0xFFEF9A9A)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFB71C1C),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: bad,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'ad-hoc',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                adHoc,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF424242),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: good,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'ext',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                ext,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF424242),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _decisionRow(
  String label,
  String detail,
  bool useIt,
  Color yes,
  Color no,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(color: const Color(0xFFC0CA33)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: useIt ? yes : no,
            shape: BoxShape.circle,
          ),
          child: Text(
            useIt ? 'Y' : 'N',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF33691E),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                detail,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF33691E),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
