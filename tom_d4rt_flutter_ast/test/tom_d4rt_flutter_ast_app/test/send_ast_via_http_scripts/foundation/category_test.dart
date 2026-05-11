// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// ============================================================================
// CATEGORY DEEP DEMO
// ----------------------------------------------------------------------------
// This file is a manually-authored, fully static visual demo for the
// `@Category(["..."])` annotation family that lives in
// `package:flutter/foundation.dart`. The annotations covered here are:
//
//   - Category           : declares one or more catalog buckets for a class.
//   - DocumentationIcon  : URL pointing at the icon shown in docs.flutter.dev.
//   - Summary            : short marketing-style description for catalog cards.
//   - Unicode            : semantic marker for character class documentation.
//
// These annotations do not affect runtime behaviour at all. They are pure
// metadata consumed by external tooling: dartdoc, the Flutter widget catalog,
// IntelliJ / Android Studio Flutter inspector, and various documentation
// pipelines used by docs.flutter.dev to organise the widget index.
//
// The file is intentionally long and visually rich. It mocks up the
// downstream rendering surfaces that read these annotations so a developer
// can browse a single screen and understand the whole story.
// ============================================================================

// ----------------------------------------------------------------------------
// Color palette
// ----------------------------------------------------------------------------
const Color kBackground = Color(0xFFF4F6FB);
const Color kPanel = Color(0xFFFFFFFF);
const Color kInk = Color(0xFF1B2330);
const Color kInkSoft = Color(0xFF5A6577);
const Color kAccent = Color(0xFF2D6CDF);
const Color kAccentAlt = Color(0xFF7A4BD9);
const Color kAccentWarm = Color(0xFFE0843C);
const Color kAccentGreen = Color(0xFF2E9F6A);
const Color kAccentRose = Color(0xFFD94B6C);
const Color kAccentTeal = Color(0xFF1E9AA8);
const Color kAccentAmber = Color(0xFFC9A227);
const Color kBorder = Color(0xFFD7DCE5);
const Color kBorderSoft = Color(0xFFE8ECF3);
const Color kCodeBg = Color(0xFF1E2230);
const Color kCodeFg = Color(0xFFE6E9F2);
const Color kCodeComment = Color(0xFF7A8699);
const Color kCodeKeyword = Color(0xFFC678DD);
const Color kCodeString = Color(0xFF98C379);
const Color kCodeType = Color(0xFF61AFEF);
const Color kCodeAnnot = Color(0xFFE5C07B);

// ----------------------------------------------------------------------------
// Entry point used by the harness.
// ----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Category Annotation Deep Demo',
    theme: ThemeData(
      primaryColor: kAccent,
      scaffoldBackgroundColor: kBackground,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: kInk, fontSize: 14),
      ),
    ),
    home: Scaffold(
      backgroundColor: kBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _HeroBanner(),
            const SizedBox(height: 28),
            _AnnotationReferenceCards(),
            const SizedBox(height: 28),
            _ExampleWidgetGallery(),
            const SizedBox(height: 28),
            _CatalogBrowserMockup(),
            const SizedBox(height: 28),
            _DocumentationIconPreviewRows(),
            const SizedBox(height: 28),
            _SummaryBestPracticeCard(),
            const SizedBox(height: 28),
            _MultiCategoryVennDiagram(),
            const SizedBox(height: 28),
            _ToolingPipelineSection(),
            const SizedBox(height: 28),
            _PitfallsSection(),
            const SizedBox(height: 28),
            _FooterSection(),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 1 — Hero banner
// ============================================================================
class _HeroBanner extends StatelessWidget {
  const _HeroBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kAccent,
            kAccentAlt,
            kAccentRose,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kAccent.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                    ),
                  ),
                  child: const Text(
                    'package:flutter/foundation.dart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'monospace',
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  '@Category and friends',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Catalog grouping, documentation icons, marketing '
                  'summaries, and Unicode markers — the metadata family '
                  'that powers the Flutter widget catalog.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 15,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: <Widget>[
                    _HeroBadge(
                      label: 'Compile-time only',
                      icon: Icons.bolt,
                    ),
                    const SizedBox(width: 10),
                    _HeroBadge(
                      label: 'Read by dartdoc',
                      icon: Icons.menu_book,
                    ),
                    const SizedBox(width: 10),
                    _HeroBadge(
                      label: 'Powers docs.flutter.dev',
                      icon: Icons.travel_explore,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'At a glance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _HeroStatRow(label: 'Annotations', value: '4'),
                  _HeroStatRow(label: 'Runtime cost', value: '0'),
                  _HeroStatRow(label: 'Tooling readers', value: 'many'),
                  _HeroStatRow(label: 'Required imports', value: '1'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.32),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroStatRow extends StatelessWidget {
  const _HeroStatRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.82),
                fontSize: 13,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Shared section header used by most major sections.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.kicker,
    required this.title,
    required this.subtitle,
    required this.accent,
  });
  final String kicker;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: accent.withValues(alpha: 0.30)),
          ),
          child: Text(
            kicker,
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: kInk,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: kInkSoft,
            fontSize: 13.5,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION 2 — Annotation reference cards
// ----------------------------------------------------------------------------
// One card per annotation: usage syntax, where to declare it, who reads it,
// what happens when it is omitted, and a tiny code snippet.
// ============================================================================
class _AnnotationReferenceCards extends StatelessWidget {
  const _AnnotationReferenceCards();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: kPanel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'SECTION 02',
            title: 'Annotation reference',
            subtitle:
                'Each catalog annotation is a tiny class with a const constructor. '
                'Apply it to a public class declaration so dartdoc can pick it up.',
            accent: kAccent,
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _AnnotationCard(
                  name: '@Category',
                  signature: "Category(List<String> sections)",
                  accent: kAccent,
                  placement: 'Class declaration',
                  readers: 'Flutter widget catalog, IDE inspector',
                  fallback: 'Class hidden from catalog index',
                  snippet:
                      "@Category(<String>['basics', 'layout'])\n"
                      "class FancyPadding extends StatelessWidget { ... }",
                  description:
                      'Declares one or more catalog buckets the class '
                      'should appear in. A class may belong to multiple '
                      'categories at once — each string is a path segment '
                      'separated by slashes if nested.',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AnnotationCard(
                  name: '@DocumentationIcon',
                  signature: 'DocumentationIcon(String url)',
                  accent: kAccentAlt,
                  placement: 'Class declaration',
                  readers: 'docs.flutter.dev card thumbnails',
                  fallback: 'Card shows a generic placeholder',
                  snippet:
                      "@DocumentationIcon(\n"
                      "  'https://flutter.github.io/assets-for-api-docs/'\n"
                      "  'assets/widgets/padding.png',\n"
                      ")\n"
                      "class FancyPadding extends StatelessWidget { ... }",
                  description:
                      'Points at the icon shown next to the widget in '
                      'catalog cards. The URL must be absolute and HTTPS; '
                      'otherwise the docs build will skip rendering the '
                      'icon and fall back to a placeholder.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _AnnotationCard(
                  name: '@Summary',
                  signature: 'Summary(String text)',
                  accent: kAccentWarm,
                  placement: 'Class declaration',
                  readers: 'Catalog card body, search index',
                  fallback: 'Card uses first sentence of dartdoc',
                  snippet:
                      "@Summary('Adds breathing room around a child.')\n"
                      "class FancyPadding extends StatelessWidget { ... }",
                  description:
                      'A short, marketing-style description shown on '
                      'the widget catalog card. Aim for one sentence '
                      'under 80 characters, present tense, and avoid '
                      'restating the class name.',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _AnnotationCard(
                  name: '@Unicode',
                  signature: 'Unicode(String hexCodePoint)',
                  accent: kAccentTeal,
                  placement: 'Class declaration (character classes)',
                  readers: 'Character-set documentation',
                  fallback: 'No code-point chip in docs',
                  snippet:
                      "@Unicode('U+2603')\n"
                      "class SnowmanCharacter { ... }",
                  description:
                      'Semantic mark used on classes that represent a '
                      'specific Unicode character or character class. '
                      'Powers the small "U+XXXX" chip that appears next '
                      'to entries in CharacterSet documentation pages.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnnotationCard extends StatelessWidget {
  const _AnnotationCard({
    required this.name,
    required this.signature,
    required this.accent,
    required this.placement,
    required this.readers,
    required this.fallback,
    required this.snippet,
    required this.description,
  });
  final String name;
  final String signature;
  final Color accent;
  final String placement;
  final String readers;
  final String fallback;
  final String snippet;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            accent.withValues(alpha: 0.10),
            accent.withValues(alpha: 0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: accent.withValues(alpha: 0.32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.label_important, color: accent, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        color: accent,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      signature,
                      style: const TextStyle(
                        color: kInkSoft,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(
              color: kInk,
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12),
          _LabeledFact(
              label: 'Placement', value: placement, accent: accent),
          _LabeledFact(label: 'Readers', value: readers, accent: accent),
          _LabeledFact(
              label: 'If omitted', value: fallback, accent: accent),
          const SizedBox(height: 12),
          _CodeBlock(snippet: snippet),
        ],
      ),
    );
  }
}

class _LabeledFact extends StatelessWidget {
  const _LabeledFact({
    required this.label,
    required this.value,
    required this.accent,
  });
  final String label;
  final String value;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 78,
            child: Text(
              label,
              style: TextStyle(
                color: accent.withValues(alpha: 0.85),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: kInk,
                fontSize: 12.5,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.snippet});
  final String snippet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kCodeBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kCodeBg.withValues(alpha: 0.4)),
      ),
      child: Text(
        snippet,
        style: const TextStyle(
          color: kCodeFg,
          fontSize: 12,
          fontFamily: 'monospace',
          height: 1.45,
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION 3 — Example widget gallery
// ----------------------------------------------------------------------------
// Made-up annotated classes shown as code snippets in monospaced containers,
// each tagged with the categories it would belong to.
// ============================================================================
class _ExampleWidgetGallery extends StatelessWidget {
  const _ExampleWidgetGallery();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kPanel,
            kAccentGreen.withValues(alpha: 0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'SECTION 03',
            title: 'Example widget gallery',
            subtitle:
                'Hand-crafted widget declarations with the catalog '
                'annotation stack applied. None of these classes exist — '
                'they illustrate idiomatic placement and combinations.',
            accent: kAccentGreen,
          ),
          const SizedBox(height: 20),
          _GalleryItem(
            name: 'GlowCard',
            categories: <String>['basics', 'cupertino', 'material'],
            iconUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/glow_card.png',
            summary: 'A card with a soft animated glow halo.',
            source:
                "@Category(<String>['basics', 'cupertino', 'material'])\n"
                "@DocumentationIcon(\n"
                "  'https://flutter.github.io/assets-for-api-docs/'\n"
                "  'assets/widgets/glow_card.png',\n"
                ")\n"
                "@Summary('A card with a soft animated glow halo.')\n"
                "class GlowCard extends StatelessWidget {\n"
                "  const GlowCard({super.key, required this.child});\n"
                "  final Widget child;\n"
                "  @override\n"
                "  Widget build(BuildContext context) {\n"
                "    return Container(child: child);\n"
                "  }\n"
                "}",
          ),
          const SizedBox(height: 14),
          _GalleryItem(
            name: 'StaggeredGrid',
            categories: <String>['layout', 'scrolling'],
            iconUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/staggered_grid.png',
            summary: 'A two-dimensional grid that staggers row heights.',
            source:
                "@Category(<String>['layout', 'scrolling'])\n"
                "@DocumentationIcon(\n"
                "  'https://flutter.github.io/assets-for-api-docs/'\n"
                "  'assets/widgets/staggered_grid.png',\n"
                ")\n"
                "@Summary('A two-dimensional grid that staggers row heights.')\n"
                "class StaggeredGrid extends StatelessWidget {\n"
                "  const StaggeredGrid({super.key, required this.children});\n"
                "  final List<Widget> children;\n"
                "  @override\n"
                "  Widget build(BuildContext context) => const SizedBox();\n"
                "}",
          ),
          const SizedBox(height: 14),
          _GalleryItem(
            name: 'GradientButton',
            categories: <String>['basics', 'material', 'input'],
            iconUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/gradient_button.png',
            summary: 'A button that paints a gradient background.',
            source:
                "@Category(<String>['basics', 'material', 'input'])\n"
                "@DocumentationIcon(\n"
                "  'https://flutter.github.io/assets-for-api-docs/'\n"
                "  'assets/widgets/gradient_button.png',\n"
                ")\n"
                "@Summary('A button that paints a gradient background.')\n"
                "class GradientButton extends StatelessWidget {\n"
                "  const GradientButton({super.key, required this.label});\n"
                "  final String label;\n"
                "  @override\n"
                "  Widget build(BuildContext context) => const SizedBox();\n"
                "}",
          ),
          const SizedBox(height: 14),
          _GalleryItem(
            name: 'SnowmanCharacter',
            categories: <String>['painting', 'text'],
            iconUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/characters/snowman.png',
            summary: 'Represents the snowman code point.',
            unicode: 'U+2603',
            source:
                "@Category(<String>['painting', 'text'])\n"
                "@Unicode('U+2603')\n"
                "@DocumentationIcon(\n"
                "  'https://flutter.github.io/assets-for-api-docs/'\n"
                "  'assets/characters/snowman.png',\n"
                ")\n"
                "@Summary('Represents the snowman code point.')\n"
                "class SnowmanCharacter {\n"
                "  const SnowmanCharacter();\n"
                "}",
          ),
          const SizedBox(height: 14),
          _GalleryItem(
            name: 'RippleHero',
            categories: <String>['animation', 'painting'],
            iconUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/ripple_hero.png',
            summary: 'A hero transition that ripples outward from a focal point.',
            source:
                "@Category(<String>['animation', 'painting'])\n"
                "@DocumentationIcon(\n"
                "  'https://flutter.github.io/assets-for-api-docs/'\n"
                "  'assets/widgets/ripple_hero.png',\n"
                ")\n"
                "@Summary('A hero transition that ripples outward.')\n"
                "class RippleHero extends StatelessWidget {\n"
                "  const RippleHero({super.key, required this.tag});\n"
                "  final Object tag;\n"
                "  @override\n"
                "  Widget build(BuildContext context) => const SizedBox();\n"
                "}",
          ),
          const SizedBox(height: 14),
          _GalleryItem(
            name: 'FocusRingTheme',
            categories: <String>['accessibility', 'material'],
            iconUrl:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/focus_ring_theme.png',
            summary: 'Themable focus ring colors and thicknesses.',
            source:
                "@Category(<String>['accessibility', 'material'])\n"
                "@DocumentationIcon(\n"
                "  'https://flutter.github.io/assets-for-api-docs/'\n"
                "  'assets/widgets/focus_ring_theme.png',\n"
                ")\n"
                "@Summary('Themable focus ring colors and thicknesses.')\n"
                "class FocusRingTheme extends InheritedWidget {\n"
                "  const FocusRingTheme({super.key, required super.child});\n"
                "  @override\n"
                "  bool updateShouldNotify(InheritedWidget _) => false;\n"
                "}",
          ),
        ],
      ),
    );
  }
}

class _GalleryItem extends StatelessWidget {
  const _GalleryItem({
    required this.name,
    required this.categories,
    required this.iconUrl,
    required this.summary,
    required this.source,
    this.unicode,
  });
  final String name;
  final List<String> categories;
  final String iconUrl;
  final String summary;
  final String source;
  final String? unicode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kPanel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kBorderSoft),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      kAccentGreen.withValues(alpha: 0.85),
                      kAccentTeal.withValues(alpha: 0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.widgets_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          name,
                          style: const TextStyle(
                            color: kInk,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (unicode != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color:
                                  kAccentTeal.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              unicode!,
                              style: const TextStyle(
                                color: kAccentTeal,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      summary,
                      style: const TextStyle(
                        color: kInkSoft,
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: categories
                .map<Widget>(
                  (String c) => Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: kAccent.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(999),
                      border:
                          Border.all(color: kAccent.withValues(alpha: 0.30)),
                    ),
                    child: Text(
                      c,
                      style: const TextStyle(
                        color: kAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Icon(Icons.image_outlined, size: 14, color: kInkSoft),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  iconUrl,
                  style: const TextStyle(
                    color: kInkSoft,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _CodeBlock(snippet: source),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 4 — Catalog browser mockup
// ----------------------------------------------------------------------------
// Renders a static "categories tree" mimicking docs.flutter.dev's catalog
// landing page. Nested boxes show the hierarchy (Basics > Layout > Padding).
// ============================================================================
class _CatalogBrowserMockup extends StatelessWidget {
  const _CatalogBrowserMockup();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: kPanel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'SECTION 04',
            title: 'Catalog browser mockup',
            subtitle:
                'Approximation of docs.flutter.dev/widgets. Each box is '
                'a category bucket populated from @Category strings. '
                'Slashes inside a category string create nesting.',
            accent: kAccentAlt,
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  kAccentAlt.withValues(alpha: 0.08),
                  kAccent.withValues(alpha: 0.04),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: kAccentAlt.withValues(alpha: 0.25)),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.menu_book_outlined, color: kAccentAlt, size: 18),
                const SizedBox(width: 8),
                const Text(
                  'flutter.dev / docs / widgets',
                  style: TextStyle(
                    color: kInk,
                    fontSize: 13,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _CatalogNode(
            label: 'Basics',
            depth: 0,
            accent: kAccent,
            children: <_CatalogNode>[
              _CatalogNode(
                label: 'Container',
                depth: 1,
                accent: kAccent,
                leaf: true,
              ),
              _CatalogNode(
                label: 'Text',
                depth: 1,
                accent: kAccent,
                leaf: true,
              ),
              _CatalogNode(
                label: 'Image',
                depth: 1,
                accent: kAccent,
                leaf: true,
              ),
              _CatalogNode(
                label: 'GlowCard',
                depth: 1,
                accent: kAccent,
                leaf: true,
                pinned: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _CatalogNode(
            label: 'Layout',
            depth: 0,
            accent: kAccentAlt,
            children: <_CatalogNode>[
              _CatalogNode(
                label: 'Padding',
                depth: 1,
                accent: kAccentAlt,
                leaf: true,
              ),
              _CatalogNode(
                label: 'Center',
                depth: 1,
                accent: kAccentAlt,
                leaf: true,
              ),
              _CatalogNode(
                label: 'Row',
                depth: 1,
                accent: kAccentAlt,
                leaf: true,
              ),
              _CatalogNode(
                label: 'Column',
                depth: 1,
                accent: kAccentAlt,
                leaf: true,
              ),
              _CatalogNode(
                label: 'Single-child layout widgets',
                depth: 1,
                accent: kAccentAlt,
                children: <_CatalogNode>[
                  _CatalogNode(
                    label: 'Padding',
                    depth: 2,
                    accent: kAccentAlt,
                    leaf: true,
                  ),
                  _CatalogNode(
                    label: 'Align',
                    depth: 2,
                    accent: kAccentAlt,
                    leaf: true,
                  ),
                ],
              ),
              _CatalogNode(
                label: 'StaggeredGrid',
                depth: 1,
                accent: kAccentAlt,
                leaf: true,
                pinned: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _CatalogNode(
            label: 'Material Components',
            depth: 0,
            accent: kAccentRose,
            children: <_CatalogNode>[
              _CatalogNode(
                label: 'AppBar',
                depth: 1,
                accent: kAccentRose,
                leaf: true,
              ),
              _CatalogNode(
                label: 'Drawer',
                depth: 1,
                accent: kAccentRose,
                leaf: true,
              ),
              _CatalogNode(
                label: 'GradientButton',
                depth: 1,
                accent: kAccentRose,
                leaf: true,
                pinned: true,
              ),
              _CatalogNode(
                label: 'FocusRingTheme',
                depth: 1,
                accent: kAccentRose,
                leaf: true,
                pinned: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _CatalogNode(
            label: 'Painting',
            depth: 0,
            accent: kAccentWarm,
            children: <_CatalogNode>[
              _CatalogNode(
                label: 'CustomPaint',
                depth: 1,
                accent: kAccentWarm,
                leaf: true,
              ),
              _CatalogNode(
                label: 'Decoration',
                depth: 1,
                accent: kAccentWarm,
                leaf: true,
              ),
              _CatalogNode(
                label: 'RippleHero',
                depth: 1,
                accent: kAccentWarm,
                leaf: true,
                pinned: true,
              ),
              _CatalogNode(
                label: 'SnowmanCharacter',
                depth: 1,
                accent: kAccentWarm,
                leaf: true,
                pinned: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _CatalogNode(
            label: 'Accessibility',
            depth: 0,
            accent: kAccentGreen,
            children: <_CatalogNode>[
              _CatalogNode(
                label: 'Semantics',
                depth: 1,
                accent: kAccentGreen,
                leaf: true,
              ),
              _CatalogNode(
                label: 'MergeSemantics',
                depth: 1,
                accent: kAccentGreen,
                leaf: true,
              ),
              _CatalogNode(
                label: 'FocusRingTheme',
                depth: 1,
                accent: kAccentGreen,
                leaf: true,
                pinned: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kAccentAmber.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kAccentAmber.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.push_pin_outlined,
                    size: 16, color: kAccentAmber),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Pinned items above are the imaginary widgets from '
                    'Section 3. The catalog renders them under each '
                    'category they declared in @Category.',
                    style: TextStyle(color: kInk, fontSize: 12.5),
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

class _CatalogNode extends StatelessWidget {
  const _CatalogNode({
    required this.label,
    required this.depth,
    required this.accent,
    this.children = const <_CatalogNode>[],
    this.leaf = false,
    this.pinned = false,
  });
  final String label;
  final int depth;
  final Color accent;
  final List<_CatalogNode> children;
  final bool leaf;
  final bool pinned;

  @override
  Widget build(BuildContext context) {
    final double leftPad = depth * 18.0;
    return Padding(
      padding: EdgeInsets.only(left: leftPad, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: pinned
                  ? accent.withValues(alpha: 0.10)
                  : kPanel,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: pinned
                    ? accent.withValues(alpha: 0.4)
                    : kBorderSoft,
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  leaf
                      ? (pinned
                          ? Icons.star_rounded
                          : Icons.insert_drive_file_outlined)
                      : Icons.folder_outlined,
                  size: 16,
                  color: accent,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: kInk,
                      fontSize: 13,
                      fontWeight: leaf ? FontWeight.w500 : FontWeight.w700,
                      fontFamily: leaf ? 'monospace' : null,
                    ),
                  ),
                ),
                if (pinned)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'new',
                      style: TextStyle(
                        color: accent,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          for (final _CatalogNode child in children) child,
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 5 — Documentation icon preview rows
// ----------------------------------------------------------------------------
// Each row mocks a documentation icon entry: URL on the left, a tiny
// placeholder swatch standing in for the rendered icon, and a caption
// describing the asset.
// ============================================================================
class _DocumentationIconPreviewRows extends StatelessWidget {
  const _DocumentationIconPreviewRows();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kPanel,
            kAccentTeal.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'SECTION 05',
            title: 'Documentation icon previews',
            subtitle:
                'URLs supplied to @DocumentationIcon are absolute paths '
                'to images served from a CDN. The docs build downloads '
                'and crops them into 64x64 catalog thumbnails.',
            accent: kAccentTeal,
          ),
          const SizedBox(height: 18),
          _IconPreviewRow(
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/container.png',
            caption: 'Container — official Material widget icon',
            seed: 0xFF2D6CDF,
            ok: true,
          ),
          _IconPreviewRow(
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/padding.png',
            caption: 'Padding — used by Layout > Single-child widgets',
            seed: 0xFF7A4BD9,
            ok: true,
          ),
          _IconPreviewRow(
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/row.png',
            caption: 'Row — used by Layout > Multi-child widgets',
            seed: 0xFF2E9F6A,
            ok: true,
          ),
          _IconPreviewRow(
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/glow_card.png',
            caption: 'GlowCard — third-party widget illustration',
            seed: 0xFFE0843C,
            ok: true,
          ),
          _IconPreviewRow(
            url:
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/ripple_hero.png',
            caption: 'RippleHero — animated transition demo',
            seed: 0xFFD94B6C,
            ok: true,
          ),
          _IconPreviewRow(
            url: '/assets/widgets/typo_image.png',
            caption: 'Typo example — relative URL, will not render',
            seed: 0xFFC9A227,
            ok: false,
          ),
          _IconPreviewRow(
            url: 'http://insecure.example.com/icon.png',
            caption: 'Insecure URL — mixed content, fails on docs build',
            seed: 0xFF1E9AA8,
            ok: false,
          ),
        ],
      ),
    );
  }
}

class _IconPreviewRow extends StatelessWidget {
  const _IconPreviewRow({
    required this.url,
    required this.caption,
    required this.seed,
    required this.ok,
  });
  final String url;
  final String caption;
  final int seed;
  final bool ok;

  @override
  Widget build(BuildContext context) {
    final Color base = Color(seed);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kPanel,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ok
              ? kBorderSoft
              : kAccentRose.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  base.withValues(alpha: 0.95),
                  base.withValues(alpha: 0.55),
                  base.withValues(alpha: 0.30),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: base.withValues(alpha: 0.45)),
            ),
            alignment: Alignment.center,
            child: Icon(
              ok ? Icons.image_outlined : Icons.broken_image_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      ok ? Icons.check_circle : Icons.error_outline,
                      size: 14,
                      color: ok ? kAccentGreen : kAccentRose,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        url,
                        style: const TextStyle(
                          color: kInk,
                          fontSize: 12.5,
                          fontFamily: 'monospace',
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  caption,
                  style: const TextStyle(
                    color: kInkSoft,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: ok
                  ? kAccentGreen.withValues(alpha: 0.14)
                  : kAccentRose.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              ok ? 'render OK' : 'will fail',
              style: TextStyle(
                color: ok ? kAccentGreen : kAccentRose,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 6 — Summary best-practice card
// ----------------------------------------------------------------------------
// Do / Don't bullets for writing a Summary.
// ============================================================================
class _SummaryBestPracticeCard extends StatelessWidget {
  const _SummaryBestPracticeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kAccentWarm.withValues(alpha: 0.10),
            kAccentAmber.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kAccentWarm.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'SECTION 06',
            title: 'Writing a good @Summary',
            subtitle:
                'A Summary is shown on the catalog card under the widget '
                'name, and it is also indexed by the docs search. A weak '
                'summary loses you both clicks and discoverability.',
            accent: kAccentWarm,
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _BulletColumn(
                  title: 'Do',
                  accent: kAccentGreen,
                  icon: Icons.check_circle,
                  items: <String>[
                    'Lead with the action: "Adds breathing room around a child."',
                    'Keep it under 80 characters when possible.',
                    'Use present tense, indicative mood.',
                    'Avoid repeating the class name.',
                    'Treat it as marketing copy, not documentation.',
                    'Make it self-contained — no "see also" references.',
                    'Mention the primary use case so search ranks it well.',
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _BulletColumn(
                  title: "Don't",
                  accent: kAccentRose,
                  icon: Icons.cancel,
                  items: <String>[
                    'Don\'t start with "A widget that ..." — redundant.',
                    "Don't paste the dartdoc first sentence verbatim.",
                    "Don't include emoji or trademark symbols.",
                    "Don't end with a period for one-clause sentences.",
                    "Don't restate the class name.",
                    "Don't reference internal implementation details.",
                    "Don't exceed two lines when rendered at 320 px width.",
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kPanel,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kBorderSoft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Before / after example',
                  style: TextStyle(
                    color: kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: _BeforeAfter(
                        label: 'Before',
                        accent: kAccentRose,
                        text:
                            '@Summary(\'A widget that displays its child '
                            'with surrounding padding.\')',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _BeforeAfter(
                        label: 'After',
                        accent: kAccentGreen,
                        text:
                            '@Summary(\'Adds breathing room around a '
                            'child.\')',
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
  }
}

class _BulletColumn extends StatelessWidget {
  const _BulletColumn({
    required this.title,
    required this.accent,
    required this.icon,
    required this.items,
  });
  final String title;
  final Color accent;
  final IconData icon;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kPanel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: accent, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          for (final String item in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6, right: 8),
                    decoration: BoxDecoration(
                      color: accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: kInk,
                        fontSize: 12.5,
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
}

class _BeforeAfter extends StatelessWidget {
  const _BeforeAfter({
    required this.label,
    required this.accent,
    required this.text,
  });
  final String label;
  final Color accent;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              color: kInk,
              fontSize: 12,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 7 — Multi-category overlap (Venn-style diagram)
// ----------------------------------------------------------------------------
// Three overlapping circles drawn as Containers, showing how widgets can
// belong to multiple categories simultaneously.
// ============================================================================
class _MultiCategoryVennDiagram extends StatelessWidget {
  const _MultiCategoryVennDiagram();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: kPanel,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'SECTION 07',
            title: 'Multi-category overlap',
            subtitle:
                'A class may belong to several categories at once. The '
                'docs catalog deduplicates the entry but renders it under '
                'every bucket — handy for cross-cutting widgets.',
            accent: kAccentRose,
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 320,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 60,
                  top: 30,
                  child: _VennCircle(
                    label: 'Basics',
                    color: kAccent,
                  ),
                ),
                Positioned(
                  right: 60,
                  top: 30,
                  child: _VennCircle(
                    label: 'Layout',
                    color: kAccentAlt,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _VennCircle(
                      label: 'Material',
                      color: kAccentRose,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: kPanel,
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: kBorder),
                          ),
                          child: const Text(
                            'GlowCard, GradientButton',
                            style: TextStyle(
                              color: kInk,
                              fontSize: 11,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: <Widget>[
              _OverlapLegend(
                accent: kAccent,
                title: 'Basics only',
                example: 'Text, Image',
              ),
              _OverlapLegend(
                accent: kAccentAlt,
                title: 'Layout only',
                example: 'Row, Column',
              ),
              _OverlapLegend(
                accent: kAccentRose,
                title: 'Material only',
                example: 'AppBar, Drawer',
              ),
              _OverlapLegend(
                accent: kAccentGreen,
                title: 'All three',
                example: 'GlowCard, GradientButton',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _VennCircle extends StatelessWidget {
  const _VennCircle({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: <Color>[
            color.withValues(alpha: 0.45),
            color.withValues(alpha: 0.15),
            color.withValues(alpha: 0.05),
          ],
          stops: const <double>[0.0, 0.6, 1.0],
        ),
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withValues(alpha: 0.55),
          width: 2,
        ),
      ),
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _OverlapLegend extends StatelessWidget {
  const _OverlapLegend({
    required this.accent,
    required this.title,
    required this.example,
  });
  final Color accent;
  final String title;
  final String example;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            example,
            style: const TextStyle(
              color: kInkSoft,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 8 — Tooling pipeline
// ----------------------------------------------------------------------------
// Annotations → dartdoc → flutter.dev catalog. A labeled arrow chain.
// ============================================================================
class _ToolingPipelineSection extends StatelessWidget {
  const _ToolingPipelineSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kAccentTeal.withValues(alpha: 0.10),
            kAccent.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kAccentTeal.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'SECTION 08',
            title: 'Tooling pipeline',
            subtitle:
                'Source annotations flow through a chain of tools. Each '
                'stage reads a subset of the metadata and produces a '
                'different artifact downstream.',
            accent: kAccentTeal,
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _PipelineStage(
                  index: 1,
                  title: '.dart source',
                  subtitle: 'Class declares @Category, @Summary, '
                      '@DocumentationIcon, @Unicode.',
                  accent: kAccent,
                  icon: Icons.code,
                ),
              ),
              _PipelineArrow(),
              Expanded(
                child: _PipelineStage(
                  index: 2,
                  title: 'analyzer + dartdoc',
                  subtitle:
                      'Annotations are parsed and recorded into a '
                      'structured documentation tree.',
                  accent: kAccentAlt,
                  icon: Icons.account_tree,
                ),
              ),
              _PipelineArrow(),
              Expanded(
                child: _PipelineStage(
                  index: 3,
                  title: 'catalog generator',
                  subtitle:
                      'Buckets classes by @Category string, downloads '
                      'icons, and emits JSON manifest.',
                  accent: kAccentWarm,
                  icon: Icons.inventory_2_outlined,
                ),
              ),
              _PipelineArrow(),
              Expanded(
                child: _PipelineStage(
                  index: 4,
                  title: 'docs.flutter.dev',
                  subtitle:
                      'Renders catalog cards, search index, and '
                      'character-set tables.',
                  accent: kAccentGreen,
                  icon: Icons.public,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: kPanel,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kBorderSoft),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'What each stage actually reads',
                  style: TextStyle(
                    color: kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                _PipelineReadRow(
                  stage: 'analyzer',
                  annotations: 'all 4',
                  notes: 'just records the metadata',
                ),
                _PipelineReadRow(
                  stage: 'dartdoc',
                  annotations: '@Summary, @Category',
                  notes: 'rendered into HTML pages',
                ),
                _PipelineReadRow(
                  stage: 'catalog generator',
                  annotations: '@Category, @DocumentationIcon, @Summary',
                  notes: 'creates the JSON catalog manifest',
                ),
                _PipelineReadRow(
                  stage: 'character-set docs',
                  annotations: '@Unicode',
                  notes: 'adds the U+XXXX badge',
                ),
                _PipelineReadRow(
                  stage: 'IDE inspector',
                  annotations: '@Category, @Summary',
                  notes: 'enriches autocompletion popups',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PipelineStage extends StatelessWidget {
  const _PipelineStage({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.icon,
  });
  final int index;
  final String title;
  final String subtitle;
  final Color accent;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kPanel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$index',
                  style: TextStyle(
                    color: accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: accent, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: kInk,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PipelineArrow extends StatelessWidget {
  const _PipelineArrow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 30),
      child: Icon(Icons.arrow_forward, color: kInkSoft, size: 22),
    );
  }
}

class _PipelineReadRow extends StatelessWidget {
  const _PipelineReadRow({
    required this.stage,
    required this.annotations,
    required this.notes,
  });
  final String stage;
  final String annotations;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              stage,
              style: const TextStyle(
                color: kAccentTeal,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              annotations,
              style: const TextStyle(
                color: kInk,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              notes,
              style: const TextStyle(
                color: kInkSoft,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 9 — Pitfalls
// ----------------------------------------------------------------------------
// String typos, category name drift, leading slashes in icons, and similar
// foot-guns that the analyzer cannot catch.
// ============================================================================
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kAccentRose.withValues(alpha: 0.12),
            kAccentAmber.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: kAccentRose.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'SECTION 09',
            title: 'Pitfalls and footguns',
            subtitle:
                'The catalog annotation family is pure metadata — the '
                'analyzer cannot validate the strings inside them. Most '
                'mistakes only show up when docs are generated.',
            accent: kAccentRose,
          ),
          const SizedBox(height: 18),
          _PitfallEntry(
            title: 'Typos in category strings',
            badThing:
                "@Category(<String>['Basix']) — silently creates a new bucket",
            goodThing:
                "@Category(<String>['Basics']) — joins existing widgets",
            explanation:
                'Categories are matched by exact string. A typo creates '
                'a brand-new bucket with one inhabitant, which then never '
                'shows up on the curated landing page.',
          ),
          _PitfallEntry(
            title: 'Category name drift over time',
            badThing:
                "@Category(<String>['Material Widgets'])",
            goodThing:
                "@Category(<String>['material'])",
            explanation:
                'The Flutter team standardised on lower-case, '
                'space-free names like "material", "cupertino", '
                '"layout". Mixed-case names appear as orphan buckets.',
          ),
          _PitfallEntry(
            title: 'Leading slash in @DocumentationIcon',
            badThing:
                "@DocumentationIcon('/assets/widgets/foo.png')",
            goodThing:
                "@DocumentationIcon('https://flutter.github.io/"
                "assets-for-api-docs/assets/widgets/foo.png')",
            explanation:
                'The catalog generator interprets the string as an '
                'absolute URL. A leading slash turns into a 404 against '
                'whichever host the docs are served from.',
          ),
          _PitfallEntry(
            title: 'Summary that restates the class name',
            badThing:
                "@Summary('GlowCard widget which renders a glowing card.')",
            goodThing:
                "@Summary('A card with a soft animated glow halo.')",
            explanation:
                'Search uses the summary text. Repeating the class name '
                'wastes characters and dilutes relevant keywords.',
          ),
          _PitfallEntry(
            title: 'Wrong @Unicode format',
            badThing:
                "@Unicode('0x2603')",
            goodThing:
                "@Unicode('U+2603')",
            explanation:
                'The character-set rendering expects the canonical '
                '"U+XXXX" format. Hex literals like 0x2603 are dropped.',
          ),
          _PitfallEntry(
            title: 'Mixing private classes into the catalog',
            badThing:
                "@Category(<String>['basics'])\nclass _PrivateThing { ... }",
            goodThing:
                "@Category(<String>['basics'])\nclass PublicThing { ... }",
            explanation:
                'Dartdoc skips classes whose name starts with an '
                'underscore. The annotation is silently ignored, which '
                'often causes "where is my widget?" confusion.',
          ),
        ],
      ),
    );
  }
}

class _PitfallEntry extends StatelessWidget {
  const _PitfallEntry({
    required this.title,
    required this.badThing,
    required this.goodThing,
    required this.explanation,
  });
  final String title;
  final String badThing;
  final String goodThing;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kPanel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kBorderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber_rounded,
                  color: kAccentRose, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: kInk,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _PitfallSnippet(
                  label: 'Bad',
                  accent: kAccentRose,
                  text: badThing,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _PitfallSnippet(
                  label: 'Good',
                  accent: kAccentGreen,
                  text: goodThing,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            explanation,
            style: const TextStyle(
              color: kInkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _PitfallSnippet extends StatelessWidget {
  const _PitfallSnippet({
    required this.label,
    required this.accent,
    required this.text,
  });
  final String label;
  final Color accent;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withValues(alpha: 0.30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              color: kInk,
              fontSize: 12,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION 10 — Footer
// ============================================================================
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            kInk,
            kInk.withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Category annotation deep demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'A static visual reference for @Category, @Summary, '
                  '@DocumentationIcon, and @Unicode. All four live in '
                  'package:flutter/foundation.dart and shape the public '
                  'documentation surface of widget libraries.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.82),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    _FooterChip(label: '@Category'),
                    _FooterChip(label: '@DocumentationIcon'),
                    _FooterChip(label: '@Summary'),
                    _FooterChip(label: '@Unicode'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Further reading',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 8),
                _FooterLink(text: 'api.flutter.dev / foundation-library'),
                _FooterLink(text: 'docs.flutter.dev / widgets catalog'),
                _FooterLink(text: 'flutter / assets-for-api-docs repo'),
                _FooterLink(text: 'dart.dev / dartdoc reference'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterChip extends StatelessWidget {
  const _FooterChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11.5,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  const _FooterLink({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Icon(Icons.link, size: 13, color: Colors.white.withValues(alpha: 0.75)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.82),
                fontSize: 12,
                fontFamily: 'monospace',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
