// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for CupertinoTheme and CupertinoThemeData.
// Renders every CupertinoThemeData property, the full CupertinoTextThemeData
// surface area, light vs dark brightness comparisons and a set of mock iOS
// "swatch app" frames using custom primaryColor variants. Static AST: no
// navigation, no async work, no dialogs.

// DESIGN PLAN
// ===========
// This file is a hand-authored visual reference for the Cupertino theming
// system. It is deliberately verbose - every section narrates the iOS look
// for a different combination of CupertinoThemeData fields and the
// CupertinoTextThemeData sub-object.
//
// Outer chrome:
//   Material 3 wrapper (ColorScheme.fromSeed) so the page itself has a
//   modern Material look. Inside each phone frame we switch to Cupertino
//   semantics by using CupertinoColors, CupertinoIcons and CupertinoTheme.
//
// Sections (each prints `=== Section N: <title> ===`):
//   1. Header gradient banner with a brief CupertinoTheme legend.
//   2. CupertinoThemeData anatomy - per-property cards (brightness,
//      primaryColor, primaryContrastingColor, textTheme, barBackgroundColor,
//      scaffoldBackgroundColor, applyThemeToAll).
//   3. CupertinoTextThemeData surface area - cards previewing textStyle,
//      actionTextStyle, tabLabelTextStyle, navTitleTextStyle,
//      navLargeTitleTextStyle, navActionTextStyle, pickerTextStyle and
//      dateTimePickerTextStyle.
//   4. Light vs dark brightness side-by-side: two phone frames showing the
//      same "Inbox" layout under Brightness.light then Brightness.dark.
//   5. Tinted control previews - CupertinoButton, CupertinoSwitch and
//      CupertinoSlider rendered under five custom primaryColor palettes.
//   6. Swatch app grid - five full mini-phone frames (default light, default
//      dark, custom blue, custom green, custom red) each wrapped in a
//      CupertinoTheme to demonstrate inheritance.
//   7. Recipes - code-styled cards for app-level theming patterns.
//   8. Glossary - alphabetised reference of CupertinoThemeData fields.
//
// Terminal line: void main() => runApp(const CupertinoThemeDemoApp());

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const CupertinoThemeDemoApp());

// ---------------------------------------------------------------------------
// Root widget
// ---------------------------------------------------------------------------

class CupertinoThemeDemoApp extends StatelessWidget {
  const CupertinoThemeDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('CupertinoTheme Deep Demo executing');

    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0A84FF),
      brightness: Brightness.light,
    );

    final ThemeData materialTheme = ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 14.0, height: 1.4),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CupertinoTheme Deep Demo',
      theme: materialTheme,
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeaderBanner(scheme),
              const SizedBox(height: 28.0),
              _buildSection1Banner(scheme),
              const SizedBox(height: 32.0),
              _buildSection2Anatomy(scheme),
              const SizedBox(height: 32.0),
              _buildSection3TextTheme(scheme),
              const SizedBox(height: 32.0),
              _buildSection4Brightness(scheme),
              const SizedBox(height: 32.0),
              _buildSection5TintedControls(scheme),
              const SizedBox(height: 32.0),
              _buildSection6SwatchApps(scheme),
              const SizedBox(height: 32.0),
              _buildSection7Recipes(scheme),
              const SizedBox(height: 32.0),
              _buildSection8Glossary(scheme),
              const SizedBox(height: 28.0),
              _buildFooter(scheme),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header banner
// ---------------------------------------------------------------------------

Widget _buildHeaderBanner(ColorScheme scheme) {
  print('=== Header: CupertinoTheme overview ===');
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0A84FF),
          Color(0xFF5E5CE6),
          Color(0xFFBF5AF2),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0A84FF).withValues(alpha: 0.35),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: const Offset(0, 12),
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
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Icon(
                CupertinoIcons.paintbrush_fill,
                color: Colors.white,
                size: 32.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'CupertinoTheme & CupertinoThemeData',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'iOS-flavoured theming surface for Flutter',
                    style: TextStyle(
                      color: Color(0xFFE3E0FF),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.20),
              width: 1.0,
            ),
          ),
          child: const Text(
            'CupertinoTheme inherits down the widget tree. Every Cupertino '
            'widget reads brightness, primaryColor, primaryContrastingColor, '
            'textTheme, barBackgroundColor and scaffoldBackgroundColor from '
            'the nearest CupertinoTheme. CupertinoThemeData is immutable; use '
            'copyWith() to derive variants.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 1: Banner / concept legend
// ---------------------------------------------------------------------------

Widget _buildSection1Banner(ColorScheme scheme) {
  print('=== Section 1: Concept legend ===');

  final List<_LegendItem> items = <_LegendItem>[
    _LegendItem(
      icon: CupertinoIcons.color_filter,
      title: 'Theme inheritance',
      body: 'CupertinoTheme widgets propagate CupertinoThemeData via context. '
          'Wrap any subtree to override the inherited theme.',
      color: const Color(0xFF0A84FF),
    ),
    _LegendItem(
      icon: CupertinoIcons.sun_max,
      title: 'Brightness drives defaults',
      body: 'CupertinoColors resolve against Brightness.light / dark. The '
          'rest of the theme follows brightness when unspecified.',
      color: const Color(0xFFFF9F0A),
    ),
    _LegendItem(
      icon: CupertinoIcons.textformat,
      title: 'Typography is structured',
      body: 'CupertinoTextThemeData exposes eight named text styles, each '
          'used by a specific Cupertino widget category.',
      color: const Color(0xFF30D158),
    ),
    _LegendItem(
      icon: CupertinoIcons.paintbrush,
      title: 'Tint controls everything',
      body: 'primaryColor is the system tint for buttons, switches, sliders '
          'and active tab items. Pick brand-appropriate colours.',
      color: const Color(0xFFBF5AF2),
    ),
  ];

  return _buildSectionShell(
    scheme: scheme,
    sectionNumber: 1,
    title: 'Concept legend',
    subtitle: 'Mental model for the Cupertino theming pipeline.',
    child: Wrap(
      spacing: 14.0,
      runSpacing: 14.0,
      children: items.map((_LegendItem item) {
        return SizedBox(
          width: 260.0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(
                color: item.color.withValues(alpha: 0.32),
                width: 1.4,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: item.color.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Icon(item.icon, color: item.color, size: 22.0),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: item.color,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  item.body,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: scheme.onSurface.withValues(alpha: 0.75),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ),
  );
}

class _LegendItem {
  const _LegendItem({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });
  final IconData icon;
  final String title;
  final String body;
  final Color color;
}

// ---------------------------------------------------------------------------
// Section 2: CupertinoThemeData anatomy
// ---------------------------------------------------------------------------

Widget _buildSection2Anatomy(ColorScheme scheme) {
  print('=== Section 2: CupertinoThemeData property anatomy ===');

  // Build a sample theme so cards can read real resolved values from it.
  final CupertinoThemeData baseTheme = const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF0A84FF),
    primaryContrastingColor: CupertinoColors.white,
    barBackgroundColor: Color(0xF0F9F9F9),
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    applyThemeToAll: false,
  );
  print('Sample theme brightness: ${baseTheme.brightness}');
  print('Sample theme primaryColor: ${baseTheme.primaryColor}');
  print('Sample theme applyThemeToAll: ${baseTheme.applyThemeToAll}');

  final List<_PropertyCard> propertyCards = <_PropertyCard>[
    _PropertyCard(
      icon: CupertinoIcons.sun_max_fill,
      label: 'brightness',
      type: 'Brightness?',
      description:
          'Root brightness for the subtree. Drives all unspecified colour '
          'defaults. Null means inherit from MediaQuery or ancestor theme.',
      swatchColor: const Color(0xFFFFD60A),
      preview: _buildBrightnessPreview(baseTheme),
    ),
    _PropertyCard(
      icon: CupertinoIcons.paintbrush_fill,
      label: 'primaryColor',
      type: 'Color',
      description:
          'The system tint colour. Used for interactive elements like '
          'CupertinoButton text, CupertinoSwitch thumb track, '
          'CupertinoSlider active fill and active CupertinoTabBar items.',
      swatchColor: baseTheme.primaryColor,
      preview: _buildPrimaryColorPreview(baseTheme),
    ),
    _PropertyCard(
      icon: CupertinoIcons.circle_lefthalf_fill,
      label: 'primaryContrastingColor',
      type: 'Color',
      description:
          'Contrasting colour used over primaryColor surfaces. Typical '
          'choice is CupertinoColors.white over a saturated tint.',
      swatchColor: baseTheme.primaryContrastingColor,
      preview: _buildContrastingPreview(baseTheme),
    ),
    _PropertyCard(
      icon: CupertinoIcons.textformat,
      label: 'textTheme',
      type: 'CupertinoTextThemeData',
      description:
          'Aggregated text styles. Eight named entries cover system text, '
          'action buttons, tab labels, nav titles and pickers.',
      swatchColor: const Color(0xFF8E8E93),
      preview: _buildTextThemePreview(baseTheme),
    ),
    _PropertyCard(
      icon: CupertinoIcons.rectangle_stack,
      label: 'barBackgroundColor',
      type: 'Color',
      description:
          'Background for CupertinoNavigationBar, CupertinoSliverNavigationBar '
          'and CupertinoTabBar. Defaults to translucent system chrome.',
      swatchColor: baseTheme.barBackgroundColor,
      preview: _buildBarBackgroundPreview(baseTheme),
    ),
    _PropertyCard(
      icon: CupertinoIcons.square_stack_3d_up_fill,
      label: 'scaffoldBackgroundColor',
      type: 'Color',
      description:
          'Background of CupertinoPageScaffold and CupertinoTabScaffold. '
          'Defaults to CupertinoColors.systemBackground.',
      swatchColor: baseTheme.scaffoldBackgroundColor,
      preview: _buildScaffoldBackgroundPreview(baseTheme),
    ),
    _PropertyCard(
      icon: CupertinoIcons.layers_alt_fill,
      label: 'applyThemeToAll',
      type: 'bool',
      description:
          'When true, the theme propagates into descendant Material widgets '
          'too. Useful when mixing iOS-style chrome with Material content.',
      swatchColor: const Color(0xFF5E5CE6),
      preview: _buildApplyThemeToAllPreview(baseTheme),
    ),
  ];

  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < propertyCards.length; i++) {
    final _PropertyCard card = propertyCards[i];
    cards.add(_renderPropertyCard(card, scheme, i + 1));
    if (i != propertyCards.length - 1) cards.add(const SizedBox(height: 16.0));
  }

  return _buildSectionShell(
    scheme: scheme,
    sectionNumber: 2,
    title: 'CupertinoThemeData anatomy',
    subtitle: 'Every theme property with a focused visual preview.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cards,
    ),
  );
}

class _PropertyCard {
  const _PropertyCard({
    required this.icon,
    required this.label,
    required this.type,
    required this.description,
    required this.swatchColor,
    required this.preview,
  });
  final IconData icon;
  final String label;
  final String type;
  final String description;
  final Color swatchColor;
  final Widget preview;
}

Widget _renderPropertyCard(_PropertyCard card, ColorScheme scheme, int index) {
  return Container(
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(
        color: scheme.outlineVariant,
        width: 1.0,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Left: icon + index
        Column(
          children: <Widget>[
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: card.swatchColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(
                  color: card.swatchColor.withValues(alpha: 0.55),
                  width: 1.5,
                ),
              ),
              child: Icon(card.icon, color: card.swatchColor, size: 28.0),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: card.swatchColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                'P$index',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                  color: card.swatchColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        // Middle: text
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    card.label,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 1.0,
                    ),
                    decoration: BoxDecoration(
                      color: card.swatchColor.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      card.type,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: card.swatchColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                card.description,
                style: TextStyle(
                  fontSize: 12.5,
                  color: scheme.onSurface.withValues(alpha: 0.75),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),
        // Right: preview
        SizedBox(width: 140.0, child: card.preview),
      ],
    ),
  );
}

Widget _buildBrightnessPreview(CupertinoThemeData base) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Container(
          height: 90.0,
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
            border: Border.all(color: CupertinoColors.systemGrey4),
          ),
          child: const Center(
            child: Text(
              'light',
              style: TextStyle(
                color: CupertinoColors.black,
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 90.0,
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            border: Border.all(color: const Color(0xFF1C1C1E)),
          ),
          child: const Center(
            child: Text(
              'dark',
              style: TextStyle(
                color: CupertinoColors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _buildPrimaryColorPreview(CupertinoThemeData base) {
  return Container(
    height: 90.0,
    decoration: BoxDecoration(
      color: CupertinoColors.systemBackground,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: CupertinoColors.systemGrey4),
    ),
    child: Center(
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: base.primaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'Action',
          style: TextStyle(
            color: base.primaryContrastingColor,
            fontWeight: FontWeight.w600,
            fontSize: 13.0,
          ),
        ),
      ),
    ),
  );
}

Widget _buildContrastingPreview(CupertinoThemeData base) {
  return Container(
    height: 90.0,
    decoration: BoxDecoration(
      color: base.primaryColor,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Center(
      child: Text(
        'Aa',
        style: TextStyle(
          color: base.primaryContrastingColor,
          fontWeight: FontWeight.w700,
          fontSize: 28.0,
        ),
      ),
    ),
  );
}

Widget _buildTextThemePreview(CupertinoThemeData base) {
  return Container(
    height: 90.0,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: CupertinoColors.systemBackground,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: CupertinoColors.systemGrey4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Nav Title',
          style: base.textTheme.navTitleTextStyle.copyWith(fontSize: 14.0),
        ),
        Text(
          'Body text style',
          style: base.textTheme.textStyle.copyWith(fontSize: 11.0),
        ),
        Text(
          'Action',
          style: base.textTheme.actionTextStyle.copyWith(fontSize: 11.0),
        ),
      ],
    ),
  );
}

Widget _buildBarBackgroundPreview(CupertinoThemeData base) {
  return Container(
    height: 90.0,
    decoration: BoxDecoration(
      color: CupertinoColors.systemBackground,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: CupertinoColors.systemGrey4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 28.0,
          decoration: BoxDecoration(
            color: base.barBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            border: const Border(
              bottom: BorderSide(color: CupertinoColors.systemGrey4),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            'Title',
            style: base.textTheme.navTitleTextStyle.copyWith(fontSize: 12.0),
          ),
        ),
        const Expanded(child: SizedBox.shrink()),
      ],
    ),
  );
}

Widget _buildScaffoldBackgroundPreview(CupertinoThemeData base) {
  return Container(
    height: 90.0,
    decoration: BoxDecoration(
      color: base.scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: CupertinoColors.systemGrey4),
    ),
    child: Center(
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text(
          'Page',
          style: TextStyle(
            color: CupertinoColors.black,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

Widget _buildApplyThemeToAllPreview(CupertinoThemeData base) {
  return Container(
    height: 90.0,
    decoration: BoxDecoration(
      color: CupertinoColors.systemBackground,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: CupertinoColors.systemGrey4),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(CupertinoIcons.arrow_down_circle,
            color: base.primaryColor, size: 26.0),
        const SizedBox(height: 4.0),
        Text(
          base.applyThemeToAll ? 'cascades' : 'isolated',
          style: TextStyle(
            color: base.primaryColor,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3: CupertinoTextThemeData surface area
// ---------------------------------------------------------------------------

Widget _buildSection3TextTheme(ColorScheme scheme) {
  print('=== Section 3: CupertinoTextThemeData ===');

  final CupertinoTextThemeData textTheme = const CupertinoTextThemeData(
    primaryColor: Color(0xFF0A84FF),
  );

  final List<_TextStyleCard> entries = <_TextStyleCard>[
    _TextStyleCard(
      name: 'textStyle',
      description: 'Default body text. Used wherever no more specific style '
          'is applicable. Size 17 on iOS.',
      style: textTheme.textStyle,
      sample: 'The quick brown fox jumps over the lazy dog.',
      icon: CupertinoIcons.textformat_size,
      accent: const Color(0xFF0A84FF),
    ),
    _TextStyleCard(
      name: 'actionTextStyle',
      description:
          'Used by CupertinoButton when no explicit style is provided. '
          'Tinted with primaryColor.',
      style: textTheme.actionTextStyle,
      sample: 'Tap to Continue',
      icon: CupertinoIcons.cursor_rays,
      accent: const Color(0xFF5E5CE6),
    ),
    _TextStyleCard(
      name: 'tabLabelTextStyle',
      description:
          'Caption-sized label under CupertinoTabBar icons. Used for both '
          'active and inactive tabs.',
      style: textTheme.tabLabelTextStyle,
      sample: 'HOME',
      icon: CupertinoIcons.square_grid_2x2,
      accent: const Color(0xFFFF9F0A),
    ),
    _TextStyleCard(
      name: 'navTitleTextStyle',
      description:
          'Mid-weight title shown in the centre of CupertinoNavigationBar.',
      style: textTheme.navTitleTextStyle,
      sample: 'Inbox',
      icon: CupertinoIcons.rectangle_stack_fill,
      accent: const Color(0xFF30D158),
    ),
    _TextStyleCard(
      name: 'navLargeTitleTextStyle',
      description:
          'Large bold title used by CupertinoSliverNavigationBar when '
          'expanded at the top of a scroll view.',
      style: textTheme.navLargeTitleTextStyle,
      sample: 'Inbox',
      icon: CupertinoIcons.text_badge_plus,
      accent: const Color(0xFFFF453A),
    ),
    _TextStyleCard(
      name: 'navActionTextStyle',
      description:
          'Used by leading/trailing CupertinoButton entries inside a '
          'CupertinoNavigationBar.',
      style: textTheme.navActionTextStyle,
      sample: 'Edit',
      icon: CupertinoIcons.pencil,
      accent: const Color(0xFFBF5AF2),
    ),
    _TextStyleCard(
      name: 'pickerTextStyle',
      description:
          'Style for CupertinoPicker selectable items. Slightly larger '
          'than body text for accessibility.',
      style: textTheme.pickerTextStyle,
      sample: 'Option Two',
      icon: CupertinoIcons.slider_horizontal_3,
      accent: const Color(0xFF64D2FF),
    ),
    _TextStyleCard(
      name: 'dateTimePickerTextStyle',
      description:
          'Used by CupertinoDatePicker for date / time wheel entries.',
      style: textTheme.dateTimePickerTextStyle,
      sample: '12 : 45',
      icon: CupertinoIcons.clock,
      accent: const Color(0xFFFFD60A),
    ),
  ];

  final List<Widget> rendered = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    rendered.add(_renderTextStyleCard(entries[i], scheme));
    if (i != entries.length - 1) {
      rendered.add(const SizedBox(height: 12.0));
    }
  }

  return _buildSectionShell(
    scheme: scheme,
    sectionNumber: 3,
    title: 'CupertinoTextThemeData',
    subtitle: 'Eight named text styles consumed by Cupertino widgets.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rendered,
    ),
  );
}

class _TextStyleCard {
  const _TextStyleCard({
    required this.name,
    required this.description,
    required this.style,
    required this.sample,
    required this.icon,
    required this.accent,
  });
  final String name;
  final String description;
  final TextStyle style;
  final String sample;
  final IconData icon;
  final Color accent;
}

Widget _renderTextStyleCard(_TextStyleCard card, ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: card.accent.withValues(alpha: 0.35),
        width: 1.2,
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: card.accent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Icon(card.icon, color: card.accent, size: 24.0),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    card.name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 1.0,
                    ),
                    decoration: BoxDecoration(
                      color: card.accent.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'TextStyle',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: card.accent,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                card.description,
                style: TextStyle(
                  fontSize: 11.5,
                  color: scheme.onSurface.withValues(alpha: 0.7),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBackground,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: CupertinoColors.systemGrey5),
                ),
                child: Text(card.sample, style: card.style),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 4: Light vs Dark brightness comparison
// ---------------------------------------------------------------------------

Widget _buildSection4Brightness(ColorScheme scheme) {
  print('=== Section 4: Light vs Dark brightness ===');

  final CupertinoThemeData lightTheme = const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF0A84FF),
    scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
  );

  final CupertinoThemeData darkTheme = const CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF0A84FF),
    scaffoldBackgroundColor: Color(0xFF000000),
    barBackgroundColor: Color(0xF01D1D1D),
  );

  print('Light scaffold bg: ${lightTheme.scaffoldBackgroundColor}');
  print('Dark scaffold bg: ${darkTheme.scaffoldBackgroundColor}');

  return _buildSectionShell(
    scheme: scheme,
    sectionNumber: 4,
    title: 'Light vs Dark brightness',
    subtitle:
        'Same Inbox layout, two CupertinoThemeData brightness settings.',
    child: Wrap(
      alignment: WrapAlignment.center,
      spacing: 16.0,
      runSpacing: 16.0,
      children: <Widget>[
        _buildPhoneFrame(
          label: 'Brightness.light',
          theme: lightTheme,
          accent: const Color(0xFF0A84FF),
          isDark: false,
        ),
        _buildPhoneFrame(
          label: 'Brightness.dark',
          theme: darkTheme,
          accent: const Color(0xFF0A84FF),
          isDark: true,
        ),
      ],
    ),
  );
}

Widget _buildPhoneFrame({
  required String label,
  required CupertinoThemeData theme,
  required Color accent,
  required bool isDark,
}) {
  final Color bg = theme.scaffoldBackgroundColor;
  final Color barBg = theme.barBackgroundColor;
  final Color textPrimary =
      isDark ? CupertinoColors.white : CupertinoColors.black;
  final Color textSecondary =
      isDark ? const Color(0xFF8E8E93) : const Color(0xFF6C6C70);
  final Color rowBg = isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white;
  final Color sep =
      isDark ? const Color(0xFF38383A) : const Color(0xFFE5E5EA);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13.0,
          color: accent,
        ),
      ),
      const SizedBox(height: 8.0),
      Container(
        width: 280.0,
        height: 500.0,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(color: isDark ? Colors.black : Colors.black12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 18.0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            // Status bar
            Container(
              height: 28.0,
              color: barBg,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '9:41',
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(CupertinoIcons.wifi,
                          color: textPrimary, size: 13.0),
                      const SizedBox(width: 4.0),
                      Icon(CupertinoIcons.battery_full,
                          color: textPrimary, size: 16.0),
                    ],
                  ),
                ],
              ),
            ),
            // Nav bar
            Container(
              height: 44.0,
              color: barBg,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Edit',
                    style:
                        theme.textTheme.navActionTextStyle.copyWith(
                      fontSize: 15.0,
                      color: accent,
                    ),
                  ),
                  Text(
                    'Inbox',
                    style: theme.textTheme.navTitleTextStyle.copyWith(
                      color: textPrimary,
                    ),
                  ),
                  Icon(CupertinoIcons.square_pencil,
                      color: accent, size: 22.0),
                ],
              ),
            ),
            Container(height: 1.0, color: sep),
            // Large title section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              color: bg,
              child: Text(
                'Inbox',
                style:
                    theme.textTheme.navLargeTitleTextStyle.copyWith(
                  color: textPrimary,
                ),
              ),
            ),
            // Mail rows
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _buildMailRow('Apple', 'Welcome to iCloud+',
                      '9:30 AM', textPrimary, textSecondary, rowBg, sep, accent,
                      unread: true),
                  _buildMailRow('Travel', 'Your itinerary',
                      '8:42 AM', textPrimary, textSecondary, rowBg, sep, accent,
                      unread: true),
                  _buildMailRow('GitHub', 'PR review requested',
                      'Yesterday', textPrimary, textSecondary, rowBg, sep,
                      accent),
                  _buildMailRow('Alice Chen', 'Lunch tomorrow?',
                      'Yesterday', textPrimary, textSecondary, rowBg, sep,
                      accent),
                  _buildMailRow('Stripe', 'Receipt for invoice',
                      'Mon', textPrimary, textSecondary, rowBg, sep, accent),
                  _buildMailRow('Bob', 'Recipes from the weekend',
                      'Sun', textPrimary, textSecondary, rowBg, sep, accent),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildMailRow(
  String sender,
  String preview,
  String time,
  Color textPrimary,
  Color textSecondary,
  Color rowBg,
  Color sep,
  Color accent, {
  bool unread = false,
}) {
  return Container(
    color: rowBg,
    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
    child: Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              margin: const EdgeInsets.only(top: 6.0, right: 8.0),
              decoration: BoxDecoration(
                color: unread ? accent : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        sender,
                        style: TextStyle(
                          fontWeight:
                              unread ? FontWeight.w700 : FontWeight.w600,
                          fontSize: 13.0,
                          color: textPrimary,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    preview,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Container(height: 0.5, color: sep),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5: Tinted control previews
// ---------------------------------------------------------------------------

Widget _buildSection5TintedControls(ColorScheme scheme) {
  print('=== Section 5: Tinted controls ===');

  final List<_TintSample> tints = <_TintSample>[
    _TintSample('System Blue', const Color(0xFF0A84FF)),
    _TintSample('System Green', const Color(0xFF30D158)),
    _TintSample('System Indigo', const Color(0xFF5E5CE6)),
    _TintSample('System Orange', const Color(0xFFFF9F0A)),
    _TintSample('System Pink', const Color(0xFFFF375F)),
  ];

  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < tints.length; i++) {
    rows.add(_buildTintRow(tints[i], scheme));
    if (i != tints.length - 1) rows.add(const SizedBox(height: 12.0));
  }

  return _buildSectionShell(
    scheme: scheme,
    sectionNumber: 5,
    title: 'Tinted control previews',
    subtitle:
        'CupertinoButton / Switch / Slider rendered with five primaryColor '
        'choices. Controls are static placeholders (no interactivity).',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    ),
  );
}

class _TintSample {
  const _TintSample(this.label, this.color);
  final String label;
  final Color color;
}

Widget _buildTintRow(_TintSample tint, ColorScheme scheme) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(
        color: tint.color.withValues(alpha: 0.45),
        width: 1.4,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 48.0,
          height: 48.0,
          decoration: BoxDecoration(
            color: tint.color,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: tint.color.withValues(alpha: 0.4),
                blurRadius: 10.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            CupertinoIcons.paintbrush_fill,
            color: Colors.white,
            size: 22.0,
          ),
        ),
        const SizedBox(width: 14.0),
        SizedBox(
          width: 110.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                tint.label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                  color: tint.color,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                _formatHex(tint.color),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: scheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        // Static button preview
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: tint.color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Button',
            style: TextStyle(
              color: CupertinoColors.white,
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        // Switch preview
        _buildSwitchPreview(tint.color),
        const SizedBox(width: 12.0),
        // Slider preview
        Expanded(child: _buildSliderPreview(tint.color)),
      ],
    ),
  );
}

Widget _buildSwitchPreview(Color tint) {
  return Container(
    width: 52.0,
    height: 32.0,
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Container(
          width: 28.0,
          height: 28.0,
          decoration: const BoxDecoration(
            color: CupertinoColors.white,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x44000000),
                blurRadius: 4.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildSliderPreview(Color tint) {
  return SizedBox(
    height: 24.0,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Container(
          height: 4.0,
          decoration: BoxDecoration(
            color: CupertinoColors.systemGrey4,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        FractionallySizedBox(
          widthFactor: 0.6,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 4.0,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0.2, 0.0),
          child: Container(
            width: 22.0,
            height: 22.0,
            decoration: const BoxDecoration(
              color: CupertinoColors.white,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

String _formatHex(Color c) {
  final int v = c.toARGB32();
  final String hex = v.toRadixString(16).padLeft(8, '0').toUpperCase();
  return '#$hex';
}

// ---------------------------------------------------------------------------
// Section 6: Swatch app grid - five mini-phones
// ---------------------------------------------------------------------------

Widget _buildSection6SwatchApps(ColorScheme scheme) {
  print('=== Section 6: Cupertino swatch app grid ===');

  final List<_SwatchTheme> themes = <_SwatchTheme>[
    _SwatchTheme(
      title: 'Default Light',
      subtitle: 'Brightness.light, system blue',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF0A84FF),
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      ),
      isDark: false,
    ),
    _SwatchTheme(
      title: 'Default Dark',
      subtitle: 'Brightness.dark, system blue',
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF0A84FF),
        scaffoldBackgroundColor: Color(0xFF000000),
        barBackgroundColor: Color(0xF01D1D1D),
      ),
      isDark: true,
    ),
    _SwatchTheme(
      title: 'Custom Blue',
      subtitle: 'Brand indigo tint',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF1E40AF),
        primaryContrastingColor: CupertinoColors.white,
        scaffoldBackgroundColor: Color(0xFFEFF4FF),
        barBackgroundColor: Color(0xF0DCE6FF),
      ),
      isDark: false,
    ),
    _SwatchTheme(
      title: 'Custom Green',
      subtitle: 'Forest green tint',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF166534),
        primaryContrastingColor: CupertinoColors.white,
        scaffoldBackgroundColor: Color(0xFFF0FDF4),
        barBackgroundColor: Color(0xF0DCFCE7),
      ),
      isDark: false,
    ),
    _SwatchTheme(
      title: 'Custom Red',
      subtitle: 'Crimson tint',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFFB91C1C),
        primaryContrastingColor: CupertinoColors.white,
        scaffoldBackgroundColor: Color(0xFFFEF2F2),
        barBackgroundColor: Color(0xF0FECACA),
      ),
      isDark: false,
    ),
  ];

  print('Building ${themes.length} swatch phone frames');

  return _buildSectionShell(
    scheme: scheme,
    sectionNumber: 6,
    title: 'Cupertino swatch app grid',
    subtitle:
        'Five mini-phone frames, each wrapped in its own CupertinoTheme. '
        'Same Library layout, different primaryColor and brightness.',
    child: Wrap(
      alignment: WrapAlignment.center,
      spacing: 18.0,
      runSpacing: 18.0,
      children: themes.map((_SwatchTheme s) {
        return _buildSwatchPhone(s);
      }).toList(),
    ),
  );
}

class _SwatchTheme {
  const _SwatchTheme({
    required this.title,
    required this.subtitle,
    required this.theme,
    required this.isDark,
  });
  final String title;
  final String subtitle;
  final CupertinoThemeData theme;
  final bool isDark;
}

Widget _buildSwatchPhone(_SwatchTheme sample) {
  final CupertinoThemeData t = sample.theme;
  final Color accent = t.primaryColor;
  final Color textPrimary =
      sample.isDark ? CupertinoColors.white : CupertinoColors.black;
  final Color textSecondary =
      sample.isDark ? const Color(0xFF8E8E93) : const Color(0xFF6C6C70);
  final Color rowBg =
      sample.isDark ? const Color(0xFF1C1C1E) : CupertinoColors.white;
  final Color sep =
      sample.isDark ? const Color(0xFF38383A) : const Color(0xFFE5E5EA);

  return CupertinoTheme(
    data: t,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Title chip
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            sample.title,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          sample.subtitle,
          style: const TextStyle(
            fontSize: 11.0,
            color: Color(0xFF6C6C70),
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          width: 260.0,
          height: 500.0,
          decoration: BoxDecoration(
            color: t.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(28.0),
            border: Border.all(
                color: sample.isDark ? Colors.black : Colors.black12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 18.0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              // Status bar
              Container(
                height: 26.0,
                color: t.barBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '9:41',
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(CupertinoIcons.battery_full,
                        color: textPrimary, size: 14.0),
                  ],
                ),
              ),
              // Nav
              Container(
                height: 42.0,
                color: t.barBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(CupertinoIcons.back, color: accent, size: 22.0),
                    Text(
                      'Library',
                      style: t.textTheme.navTitleTextStyle.copyWith(
                        color: textPrimary,
                      ),
                    ),
                    Icon(CupertinoIcons.search, color: accent, size: 22.0),
                  ],
                ),
              ),
              Container(height: 1.0, color: sep),
              // Featured hero
              Container(
                margin: const EdgeInsets.all(12.0),
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      accent,
                      accent.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'NEW',
                          style: TextStyle(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 11.0,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Icon(
                          CupertinoIcons.star_fill,
                          color: t.primaryContrastingColor,
                          size: 18.0,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Featured Album',
                      style: TextStyle(
                        color: t.primaryContrastingColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Soothing tracks for focused work.',
                      style: TextStyle(
                        color:
                            t.primaryContrastingColor.withValues(alpha: 0.85),
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: t.primaryContrastingColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'Play',
                        style: TextStyle(
                          color: accent,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Grouped list
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: rowBg,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      _buildSwatchRow(
                          CupertinoIcons.music_note, 'Listen Now',
                          accent, textPrimary, sep, false),
                      _buildSwatchRow(
                          CupertinoIcons.radiowaves_right, 'Radio',
                          accent, textPrimary, sep, false),
                      _buildSwatchRow(
                          CupertinoIcons.cloud_download, 'Downloads',
                          accent, textPrimary, sep, false),
                      _buildSwatchRow(
                          CupertinoIcons.heart_fill, 'Favourites',
                          accent, textPrimary, sep, false),
                      _buildSwatchRow(
                          CupertinoIcons.square_list, 'Playlists',
                          accent, textPrimary, sep, true),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              // Tab bar
              Container(
                height: 56.0,
                decoration: BoxDecoration(
                  color: t.barBackgroundColor,
                  border: Border(
                    top: BorderSide(color: sep),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildTabIcon(
                        CupertinoIcons.music_note_2, 'Library', accent,
                        active: true),
                    _buildTabIcon(
                        CupertinoIcons.search, 'Search', textSecondary,
                        active: false),
                    _buildTabIcon(
                        CupertinoIcons.person_2, 'Friends', textSecondary,
                        active: false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSwatchRow(
  IconData icon,
  String label,
  Color accent,
  Color text,
  Color sep,
  bool isLast,
) {
  return Container(
    decoration: BoxDecoration(
      border: isLast
          ? null
          : Border(bottom: BorderSide(color: sep, width: 0.5)),
    ),
    padding:
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: accent, size: 16.0),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.0,
              color: text,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Icon(CupertinoIcons.right_chevron, color: accent, size: 14.0),
      ],
    ),
  );
}

Widget _buildTabIcon(
  IconData icon,
  String label,
  Color color, {
  required bool active,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Icon(icon, color: color, size: 22.0),
      const SizedBox(height: 3.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 9.0,
          color: color,
          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 7: Recipes
// ---------------------------------------------------------------------------

Widget _buildSection7Recipes(ColorScheme scheme) {
  print('=== Section 7: Cupertino theming recipes ===');

  final List<_Recipe> recipes = <_Recipe>[
    _Recipe(
      title: 'App-wide CupertinoTheme',
      summary:
          'Wrap the whole app in a CupertinoApp with a custom theme. Every '
          'descendant Cupertino widget reads from it.',
      code:
          'CupertinoApp(\n'
          '  theme: const CupertinoThemeData(\n'
          '    brightness: Brightness.light,\n'
          '    primaryColor: Color(0xFF0A84FF),\n'
          '    scaffoldBackgroundColor:\n'
          '        CupertinoColors.systemGroupedBackground,\n'
          '  ),\n'
          '  home: const RootPage(),\n'
          ');',
      accent: const Color(0xFF0A84FF),
      icon: CupertinoIcons.app,
    ),
    _Recipe(
      title: 'Local theme override',
      summary:
          'Override the theme for a subtree by wrapping it in a '
          'CupertinoTheme. Useful for branded sections.',
      code:
          'CupertinoTheme(\n'
          '  data: CupertinoTheme.of(context).copyWith(\n'
          '    primaryColor: const Color(0xFF166534),\n'
          '  ),\n'
          '  child: const GreenSection(),\n'
          ');',
      accent: const Color(0xFF30D158),
      icon: CupertinoIcons.layers,
    ),
    _Recipe(
      title: 'System-driven brightness',
      summary:
          'Read MediaQuery.platformBrightnessOf to pick a theme '
          'automatically per device setting.',
      code:
          'final brightness =\n'
          '    MediaQuery.platformBrightnessOf(context);\n'
          'final theme = CupertinoThemeData(\n'
          '  brightness: brightness,\n'
          '  primaryColor: const Color(0xFF0A84FF),\n'
          ');',
      accent: const Color(0xFFFFD60A),
      icon: CupertinoIcons.sun_max_fill,
    ),
    _Recipe(
      title: 'Custom CupertinoTextThemeData',
      summary:
          'Override individual text styles while keeping defaults for the '
          'rest. copyWith on the inherited theme keeps everything else.',
      code:
          'final base = CupertinoTheme.of(context).textTheme;\n'
          'final custom = base.copyWith(\n'
          '  navLargeTitleTextStyle:\n'
          '      base.navLargeTitleTextStyle.copyWith(\n'
          '    fontWeight: FontWeight.w900,\n'
          '    letterSpacing: -0.5,\n'
          '  ),\n'
          ');',
      accent: const Color(0xFFBF5AF2),
      icon: CupertinoIcons.textformat_alt,
    ),
    _Recipe(
      title: 'Mixing Material + Cupertino',
      summary:
          'Use applyThemeToAll: true to cascade the Cupertino theme into '
          'Material widgets that render inside Cupertino chrome.',
      code:
          'CupertinoThemeData(\n'
          '  brightness: Brightness.light,\n'
          '  primaryColor: const Color(0xFF0A84FF),\n'
          '  applyThemeToAll: true,\n'
          ');',
      accent: const Color(0xFFFF9F0A),
      icon: CupertinoIcons.rectangle_3_offgrid_fill,
    ),
    _Recipe(
      title: 'Branded primaryContrastingColor',
      summary:
          'Pair a saturated primaryColor with an accessible '
          'primaryContrastingColor so labels remain readable.',
      code:
          'const CupertinoThemeData(\n'
          '  primaryColor: Color(0xFFB91C1C),\n'
          '  primaryContrastingColor:\n'
          '      CupertinoColors.white,\n'
          ');',
      accent: const Color(0xFFFF453A),
      icon: CupertinoIcons.circle_lefthalf_fill,
    ),
  ];

  final List<Widget> rendered = <Widget>[];
  for (int i = 0; i < recipes.length; i++) {
    rendered.add(_renderRecipe(recipes[i], scheme));
    if (i != recipes.length - 1) rendered.add(const SizedBox(height: 14.0));
  }

  return _buildSectionShell(
    scheme: scheme,
    sectionNumber: 7,
    title: 'Theming recipes',
    subtitle:
        'Idiomatic CupertinoTheme patterns for everyday app development.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rendered,
    ),
  );
}

class _Recipe {
  const _Recipe({
    required this.title,
    required this.summary,
    required this.code,
    required this.accent,
    required this.icon,
  });
  final String title;
  final String summary;
  final String code;
  final Color accent;
  final IconData icon;
}

Widget _renderRecipe(_Recipe r, ColorScheme scheme) {
  return Container(
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: r.accent.withValues(alpha: 0.4),
        width: 1.3,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
          decoration: BoxDecoration(
            color: r.accent.withValues(alpha: 0.12),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: r.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(r.icon, color: r.accent, size: 20.0),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  r.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                    color: r.accent,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
          child: Text(
            r.summary,
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: scheme.onSurface.withValues(alpha: 0.78),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              r.code,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                height: 1.4,
                color: Colors.green.shade200,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8: Glossary
// ---------------------------------------------------------------------------

Widget _buildSection8Glossary(ColorScheme scheme) {
  print('=== Section 8: Glossary ===');

  final List<_GlossaryEntry> entries = <_GlossaryEntry>[
    _GlossaryEntry('applyThemeToAll', 'bool',
        'Propagate the Cupertino theme into descendant Material widgets.'),
    _GlossaryEntry('barBackgroundColor', 'Color',
        'Fill colour for CupertinoNavigationBar and CupertinoTabBar.'),
    _GlossaryEntry('brightness', 'Brightness?',
        'Root brightness for the subtree. Drives default colours.'),
    _GlossaryEntry('CupertinoTheme', 'InheritedWidget',
        'Widget that exposes a CupertinoThemeData to descendants.'),
    _GlossaryEntry('CupertinoThemeData', 'class',
        'Immutable bag of theming primitives consumed by Cupertino widgets.'),
    _GlossaryEntry('CupertinoTextThemeData', 'class',
        'Eight named text styles used by Cupertino widgets.'),
    _GlossaryEntry('primaryColor', 'Color',
        'Tint colour applied to interactive Cupertino widgets.'),
    _GlossaryEntry('primaryContrastingColor', 'Color',
        'Foreground colour on top of primaryColor surfaces.'),
    _GlossaryEntry('scaffoldBackgroundColor', 'Color',
        'Background of CupertinoPageScaffold and CupertinoTabScaffold.'),
    _GlossaryEntry('textTheme', 'CupertinoTextThemeData',
        'Aggregated Cupertino text styles for the subtree.'),
    _GlossaryEntry('textTheme.textStyle', 'TextStyle',
        'Default body text style. Size 17 on iOS.'),
    _GlossaryEntry('textTheme.actionTextStyle', 'TextStyle',
        'Default style for CupertinoButton text.'),
    _GlossaryEntry('textTheme.tabLabelTextStyle', 'TextStyle',
        'Caption-sized label under CupertinoTabBar icons.'),
    _GlossaryEntry('textTheme.navTitleTextStyle', 'TextStyle',
        'Title in CupertinoNavigationBar.'),
    _GlossaryEntry('textTheme.navLargeTitleTextStyle', 'TextStyle',
        'Large bold title used by CupertinoSliverNavigationBar.'),
    _GlossaryEntry('textTheme.navActionTextStyle', 'TextStyle',
        'Style for leading/trailing buttons in a Cupertino nav bar.'),
    _GlossaryEntry('textTheme.pickerTextStyle', 'TextStyle',
        'Style for CupertinoPicker entries.'),
    _GlossaryEntry('textTheme.dateTimePickerTextStyle', 'TextStyle',
        'Style for CupertinoDatePicker wheel entries.'),
    _GlossaryEntry('copyWith()', 'method',
        'Derive a new CupertinoThemeData by overriding selected fields.'),
    _GlossaryEntry('resolveFrom()', 'method',
        'Resolve CupertinoDynamicColor entries against a BuildContext.'),
  ];

  return _buildSectionShell(
    scheme: scheme,
    sectionNumber: 8,
    title: 'Glossary',
    subtitle:
        'Alphabetical reference of CupertinoTheme / CupertinoThemeData '
        'identifiers used by this demo.',
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: entries.map((_GlossaryEntry e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.only(top: 6.0),
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 230.0,
                  child: Text(
                    e.name,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: scheme.primary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 110.0,
                  child: Text(
                    e.type,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: scheme.tertiary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    e.body,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: scheme.onSurface.withValues(alpha: 0.78),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    ),
  );
}

class _GlossaryEntry {
  const _GlossaryEntry(this.name, this.type, this.body);
  final String name;
  final String type;
  final String body;
}

// ---------------------------------------------------------------------------
// Footer
// ---------------------------------------------------------------------------

Widget _buildFooter(ColorScheme scheme) {
  print('=== Footer: demo complete ===');
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          scheme.primaryContainer,
          scheme.secondaryContainer,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Row(
      children: <Widget>[
        Icon(
          CupertinoIcons.checkmark_seal_fill,
          color: scheme.onPrimaryContainer,
          size: 36.0,
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'CupertinoTheme deep demo complete',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  color: scheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Eight sections, every CupertinoThemeData property, the full '
                'CupertinoTextThemeData surface and five themed mini-phones.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: scheme.onSecondaryContainer,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section shell - shared chrome
// ---------------------------------------------------------------------------

Widget _buildSectionShell({
  required ColorScheme scheme,
  required int sectionNumber,
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(22.0),
      border: Border.all(color: scheme.outlineVariant),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 16.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(14.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '$sectionNumber',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: scheme.onPrimaryContainer,
                ),
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: scheme.onSurface.withValues(alpha: 0.65),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        child,
      ],
    ),
  );
}
