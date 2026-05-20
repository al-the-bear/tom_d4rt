// D4rt test script: Deep visual demo of the Cupertino theme system.
// Showcases CupertinoTheme, CupertinoThemeData, CupertinoTextThemeData,
// CupertinoIconThemeData, NoDefaultCupertinoThemeData, CupertinoDynamicColor,
// CupertinoColors (system + resolved variants), CupertinoApp propagation,
// light/dark variants, theme.resolveFrom, primaryColor / barBackgroundColor /
// scaffoldBackgroundColor / applyThemeToAll, and brightness overrides.
//
// The script is interpreted by D4rt (not compiled). All lists of widgets are
// built via List.generate to avoid for-loop closure variable capture.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ============================================================================
// PALETTE DEFINITIONS
// ============================================================================
// A small declarative palette used to render named swatches.  Each palette
// entry is a 3-tuple of (label, color, hex-string).  Colors are taken from
// CupertinoColors so they round-trip through CupertinoDynamicColor when used.

const Color kInkBackground = Color(0xFFF5F5F7);
const Color kInkSurface = Color(0xFFFFFFFF);
const Color kInkLine = Color(0xFFD2D2D7);
const Color kInkText = Color(0xFF1D1D1F);
const Color kInkMuted = Color(0xFF6E6E73);

const Color kDarkBackground = Color(0xFF000000);
const Color kDarkSurface = Color(0xFF1C1C1E);
const Color kDarkLine = Color(0xFF3A3A3C);
const Color kDarkText = Color(0xFFF2F2F7);
const Color kDarkMuted = Color(0xFF8E8E93);

// ============================================================================
// SECTION BUILDERS (top-level for clarity)
// ============================================================================

Widget _sectionHeader(String index, String title, String subtitle, Color accent) {
  return Container(
    margin: const EdgeInsets.only(top: 32.0, bottom: 12.0),
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          accent.withValues(alpha: 0.92),
          accent.withValues(alpha: 0.55),
        ],
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.30),
          blurRadius: 14.0,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.45),
              width: 1.4,
            ),
          ),
          child: Text(
            index,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 18.0,
              letterSpacing: 0.5,
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
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 17.0,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 3.0),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _narrative(String text, {Color background = kInkSurface, Color border = kInkLine}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(CupertinoIcons.info_circle_fill, size: 18.0, color: Color(0xFF0A84FF)),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: kInkText,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _swatch(String label, Color color, {String? hint}) {
  final double luminance = color.computeLuminance();
  final Color textColor = luminance > 0.55 ? kInkText : Colors.white;
  return Container(
    width: 132.0,
    margin: const EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kInkLine, width: 1.0),
      color: kInkSurface,
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 64.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(11.0)),
          ),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _hex(color),
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: kInkText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (hint != null) ...<Widget>[
                const SizedBox(height: 2.0),
                Text(
                  hint,
                  style: const TextStyle(fontSize: 10.0, color: kInkMuted),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

String _hex(Color color) {
  final int r = (color.r * 255.0).round() & 0xFF;
  final int g = (color.g * 255.0).round() & 0xFF;
  final int b = (color.b * 255.0).round() & 0xFF;
  final String rs = r.toRadixString(16).padLeft(2, '0').toUpperCase();
  final String gs = g.toRadixString(16).padLeft(2, '0').toUpperCase();
  final String bs = b.toRadixString(16).padLeft(2, '0').toUpperCase();
  return '#$rs$gs$bs';
}

// ============================================================================
// MINI iOS FRAME
// ============================================================================
// Renders a small phone-shaped preview which embeds a CupertinoTheme around a
// faux iOS UI.  We render the chrome ourselves (nav bar, tab bar, content)
// so the preview can resolve CupertinoTheme.of() against the provided data
// without spinning up a full CupertinoApp inside the parent MaterialApp.

Widget _iosFrame({
  required String title,
  required String subtitle,
  required CupertinoThemeData data,
  required Brightness brightness,
  String accent = 'Tinted',
}) {
  final Color background = data.scaffoldBackgroundColor;
  final Color bar = data.barBackgroundColor;
  final Color primary = data.primaryColor;
  final Color textColor = brightness == Brightness.dark ? kDarkText : kInkText;
  final Color mutedColor = brightness == Brightness.dark ? kDarkMuted : kInkMuted;
  final Color outline = brightness == Brightness.dark ? kDarkLine : kInkLine;

  return Container(
    width: 220.0,
    margin: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: brightness == Brightness.dark ? kDarkBackground : Colors.white,
      borderRadius: BorderRadius.circular(28.0),
      border: Border.all(
        color: brightness == Brightness.dark ? kDarkLine : kInkLine,
        width: 1.4,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 14.0,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    padding: const EdgeInsets.all(6.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(22.0),
      child: CupertinoTheme(
        data: data,
        child: Container(
          color: background,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Status bar
              Container(
                height: 22.0,
                color: background,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '9:41',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Icon(CupertinoIcons.wifi, size: 11.0, color: textColor),
                    const SizedBox(width: 4.0),
                    Icon(CupertinoIcons.battery_full, size: 13.0, color: textColor),
                  ],
                ),
              ),
              // Nav bar
              Container(
                height: 38.0,
                decoration: BoxDecoration(
                  color: bar,
                  border: Border(
                    bottom: BorderSide(color: outline, width: 0.5),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: <Widget>[
                    Icon(CupertinoIcons.back, size: 18.0, color: primary),
                    const SizedBox(width: 4.0),
                    Text(
                      'Back',
                      style: TextStyle(
                        color: primary,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          title,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Icon(CupertinoIcons.add, size: 18.0, color: primary),
                  ],
                ),
              ),
              // Content
              SizedBox(
                height: 200.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        '$accent · ${brightness == Brightness.dark ? 'Dark' : 'Light'} mode',
                        style: TextStyle(
                          color: mutedColor,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      // List rows
                      Container(
                        decoration: BoxDecoration(
                          color: brightness == Brightness.dark ? kDarkSurface : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: outline, width: 0.6),
                        ),
                        child: Column(
                          children: List<Widget>.generate(3, (int rowIndex) {
                            final List<IconData> icons = <IconData>[
                              CupertinoIcons.bell_fill,
                              CupertinoIcons.lock_fill,
                              CupertinoIcons.cloud_fill,
                            ];
                            final List<String> labels = <String>[
                              'Notifications',
                              'Privacy',
                              'iCloud',
                            ];
                            final bool last = rowIndex == 2;
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 8.0,
                              ),
                              decoration: BoxDecoration(
                                border: last
                                    ? null
                                    : Border(
                                        bottom: BorderSide(color: outline, width: 0.5),
                                      ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 22.0,
                                    height: 22.0,
                                    decoration: BoxDecoration(
                                      color: primary.withValues(alpha: 0.18),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(icons[rowIndex], size: 13.0, color: primary),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      labels[rowIndex],
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.chevron_forward,
                                    size: 12.0,
                                    color: mutedColor,
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                      const Spacer(),
                      // Pill button row
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              height: 30.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Text(
                                'Confirm',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            height: 30.0,
                            width: 60.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: primary,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Tab bar
              Container(
                height: 34.0,
                decoration: BoxDecoration(
                  color: bar,
                  border: Border(
                    top: BorderSide(color: outline, width: 0.5),
                  ),
                ),
                child: Row(
                  children: List<Widget>.generate(4, (int tabIndex) {
                    final List<IconData> tabIcons = <IconData>[
                      CupertinoIcons.house_fill,
                      CupertinoIcons.search,
                      CupertinoIcons.heart_fill,
                      CupertinoIcons.person_fill,
                    ];
                    final List<String> tabLabels = <String>[
                      'Home',
                      'Search',
                      'Likes',
                      'Me',
                    ];
                    final bool active = tabIndex == 0;
                    final Color tabColor = active ? primary : mutedColor;
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(tabIcons[tabIndex], size: 14.0, color: tabColor),
                          Text(
                            tabLabels[tabIndex],
                            style: TextStyle(
                              fontSize: 9.0,
                              color: tabColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================================
// MAIN BUILD
// ============================================================================

dynamic build(BuildContext context) {
  // -------------------------------------------------------------------------
  // SECTION 1 · The Cupertino theme system
  // -------------------------------------------------------------------------
  final Widget section1Header = _sectionHeader(
    '01',
    'The Cupertino theme system',
    'CupertinoTheme, CupertinoThemeData and friends',
    const Color(0xFF0A84FF),
  );

  final Widget section1Narrative = _narrative(
    'CupertinoThemeData is the immutable bundle of colors, brightness, text styles '
    'and icon styles consumed by Cupertino widgets. CupertinoTheme is the inherited '
    'widget that exposes it. CupertinoApp creates a default theme automatically; '
    'wrapping a subtree in CupertinoTheme(data: ...) overrides it for that subtree '
    'only. The default constructor leaves every field nullable - missing fields are '
    'resolved through the standard iOS defaults when read via CupertinoTheme.of().',
  );

  // Build a small reference table of the main CupertinoThemeData fields.
  final List<List<String>> fieldRows = <List<String>>[
    <String>['brightness', 'Brightness?', 'Light / dark / inherit (null)'],
    <String>['primaryColor', 'Color?', 'Default tint for buttons, links, icons'],
    <String>['primaryContrastingColor', 'Color?', 'On-top color when primary is BG'],
    <String>['barBackgroundColor', 'Color?', 'Nav + tab bar background'],
    <String>['scaffoldBackgroundColor', 'Color?', 'Page background'],
    <String>['textTheme', 'CupertinoTextThemeData?', 'Typography bundle'],
    <String>['applyThemeToAll', 'bool', 'Cascade theme into MaterialApp shell'],
  ];

  final Widget section1Table = Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    decoration: BoxDecoration(
      color: kInkSurface,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kInkLine, width: 1.0),
    ),
    child: Column(
      children: List<Widget>.generate(fieldRows.length, (int rowIndex) {
        final List<String> row = fieldRows[rowIndex];
        final bool isLast = rowIndex == fieldRows.length - 1;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: rowIndex.isEven ? const Color(0xFFFAFAFB) : kInkSurface,
            border: isLast
                ? null
                : const Border(bottom: BorderSide(color: kInkLine, width: 0.6)),
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 150.0,
                child: Text(
                  row[0],
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0A84FF),
                    fontSize: 12.5,
                  ),
                ),
              ),
              SizedBox(
                width: 170.0,
                child: Text(
                  row[1],
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: kInkMuted,
                    fontSize: 12.0,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  row[2],
                  style: const TextStyle(fontSize: 12.0, color: kInkText),
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 2 · CupertinoColors palette
  // -------------------------------------------------------------------------
  final Widget section2Header = _sectionHeader(
    '02',
    'CupertinoColors palette',
    'System colors and their resolved variants',
    const Color(0xFFFF3B30),
  );

  final Widget section2Narrative = _narrative(
    'Every CupertinoColors.systemXxx entry is a CupertinoDynamicColor. It carries up '
    'to six concrete colors (light/dark x normal/elevated x normal/high-contrast) and '
    'resolves to one of them through CupertinoDynamicColor.resolve(color, context). '
    'Below: a swatch grid built from the most common system colors.',
  );

  final List<List<dynamic>> systemColors = <List<dynamic>>[
    <dynamic>['systemRed', CupertinoColors.systemRed],
    <dynamic>['systemOrange', CupertinoColors.systemOrange],
    <dynamic>['systemYellow', CupertinoColors.systemYellow],
    <dynamic>['systemGreen', CupertinoColors.systemGreen],
    <dynamic>['systemMint', CupertinoColors.systemMint],
    <dynamic>['systemTeal', CupertinoColors.systemTeal],
    <dynamic>['systemCyan', CupertinoColors.systemCyan],
    <dynamic>['systemBlue', CupertinoColors.systemBlue],
    <dynamic>['systemIndigo', CupertinoColors.systemIndigo],
    <dynamic>['systemPurple', CupertinoColors.systemPurple],
    <dynamic>['systemPink', CupertinoColors.systemPink],
    <dynamic>['systemBrown', CupertinoColors.systemBrown],
    <dynamic>['systemGrey', CupertinoColors.systemGrey],
    <dynamic>['systemGrey2', CupertinoColors.systemGrey2],
    <dynamic>['systemGrey3', CupertinoColors.systemGrey3],
    <dynamic>['systemGrey4', CupertinoColors.systemGrey4],
    <dynamic>['systemGrey5', CupertinoColors.systemGrey5],
    <dynamic>['systemGrey6', CupertinoColors.systemGrey6],
  ];

  final Widget section2Swatches = Wrap(
    children: List<Widget>.generate(systemColors.length, (int swatchIndex) {
      final List<dynamic> entry = systemColors[swatchIndex];
      final String label = entry[0] as String;
      final Color color = (entry[1] as CupertinoDynamicColor).resolveFrom(context);
      return _swatch(label, color, hint: 'dynamic');
    }),
  );

  // Specific accent / activity colors that aren't part of the system numbered set.
  final List<List<dynamic>> accentColors = <List<dynamic>>[
    <dynamic>['activeBlue', CupertinoColors.activeBlue, 'links'],
    <dynamic>['activeGreen', CupertinoColors.activeGreen, 'success'],
    <dynamic>['activeOrange', CupertinoColors.activeOrange, 'warning'],
    <dynamic>['destructiveRed', CupertinoColors.destructiveRed, 'destructive'],
    <dynamic>['link', CupertinoColors.link, 'hyperlink'],
    <dynamic>['placeholderText', CupertinoColors.placeholderText, 'inputs'],
    <dynamic>['systemBackground', CupertinoColors.systemBackground, 'page'],
    <dynamic>['secondarySystemBackground', CupertinoColors.secondarySystemBackground, 'card'],
    <dynamic>['tertiarySystemBackground', CupertinoColors.tertiarySystemBackground, 'tier 3'],
    <dynamic>['systemGroupedBackground', CupertinoColors.systemGroupedBackground, 'grouped'],
    <dynamic>['secondarySystemGroupedBackground', CupertinoColors.secondarySystemGroupedBackground, 'grouped 2'],
    <dynamic>['tertiarySystemGroupedBackground', CupertinoColors.tertiarySystemGroupedBackground, 'grouped 3'],
    <dynamic>['separator', CupertinoColors.separator, 'lines'],
    <dynamic>['opaqueSeparator', CupertinoColors.opaqueSeparator, 'opaque lines'],
  ];

  final Widget section2AccentSwatches = Wrap(
    children: List<Widget>.generate(accentColors.length, (int idx) {
      final List<dynamic> entry = accentColors[idx];
      final String label = entry[0] as String;
      final dynamic raw = entry[1];
      final Color color =
          raw is CupertinoDynamicColor ? raw.resolveFrom(context) : raw as Color;
      final String hint = entry[2] as String;
      return _swatch(label, color, hint: hint);
    }),
  );

  // -------------------------------------------------------------------------
  // SECTION 3 · CupertinoDynamicColor under the hood
  // -------------------------------------------------------------------------
  final Widget section3Header = _sectionHeader(
    '03',
    'CupertinoDynamicColor',
    'Six concrete colors, one logical token',
    const Color(0xFF34C759),
  );

  final Widget section3Narrative = _narrative(
    'CupertinoDynamicColor stores the full matrix of (brightness × elevation × contrast). '
    'Calling .resolveFrom(context) picks the right concrete color based on the ambient '
    'CupertinoTheme and MediaQuery.  Below we render the matrix for a few representative '
    'tokens so the structure is visible.',
  );

  // Define the matrix manually because the live runtime can only expose
  // .resolveFrom; building a side-by-side display lets us show what would
  // happen under each environment without changing the surrounding context.
  final List<Map<String, dynamic>> dynamicSamples = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'systemBlue',
      'light': const Color(0xFF007AFF),
      'dark': const Color(0xFF0A84FF),
      'lightHighContrast': const Color(0xFF0040DD),
      'darkHighContrast': const Color(0xFF409CFF),
    },
    <String, dynamic>{
      'name': 'systemRed',
      'light': const Color(0xFFFF3B30),
      'dark': const Color(0xFFFF453A),
      'lightHighContrast': const Color(0xFFD70015),
      'darkHighContrast': const Color(0xFFFF6961),
    },
    <String, dynamic>{
      'name': 'systemGreen',
      'light': const Color(0xFF34C759),
      'dark': const Color(0xFF30D158),
      'lightHighContrast': const Color(0xFF248A3D),
      'darkHighContrast': const Color(0xFF30DB5B),
    },
    <String, dynamic>{
      'name': 'systemBackground',
      'light': const Color(0xFFFFFFFF),
      'dark': const Color(0xFF000000),
      'lightHighContrast': const Color(0xFFFFFFFF),
      'darkHighContrast': const Color(0xFF000000),
    },
    <String, dynamic>{
      'name': 'label',
      'light': const Color(0xFF000000),
      'dark': const Color(0xFFFFFFFF),
      'lightHighContrast': const Color(0xFF000000),
      'darkHighContrast': const Color(0xFFFFFFFF),
    },
  ];

  final Widget section3Matrix = Column(
    children: List<Widget>.generate(dynamicSamples.length, (int sampleIndex) {
      final Map<String, dynamic> sample = dynamicSamples[sampleIndex];
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: kInkSurface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: kInkLine, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sample['name'] as String,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 13.0,
                color: kInkText,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                _matrixCell('Light', sample['light'] as Color),
                _matrixCell('Dark', sample['dark'] as Color),
                _matrixCell('Light HC', sample['lightHighContrast'] as Color),
                _matrixCell('Dark HC', sample['darkHighContrast'] as Color),
              ],
            ),
          ],
        ),
      );
    }),
  );

  // -------------------------------------------------------------------------
  // SECTION 4 · Theme variation gallery
  // -------------------------------------------------------------------------
  final Widget section4Header = _sectionHeader(
    '04',
    'Theme variation gallery',
    'A spectrum of CupertinoThemeData configurations',
    const Color(0xFFAF52DE),
  );

  final Widget section4Narrative = _narrative(
    'Each card below constructs a distinct CupertinoThemeData and inspects the resolved '
    'fields.  These themes are then reused in the next section to drive complete iOS '
    'preview frames.',
  );

  // Define a list of themes.  Each entry holds a name, the data, an accent
  // color, and a one-line description.
  final List<Map<String, dynamic>> themes = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'Ocean Blue',
      'desc': 'Classic iOS blue tint',
      'data': const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
        scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
        barBackgroundColor: CupertinoColors.systemBackground,
      ),
      'accent': CupertinoColors.systemBlue,
    },
    <String, dynamic>{
      'name': 'Sunset Coral',
      'desc': 'Warm orange / red palette',
      'data': const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemOrange,
        scaffoldBackgroundColor: Color(0xFFFFF7F0),
        barBackgroundColor: Color(0xFFFFFFFF),
      ),
      'accent': CupertinoColors.systemOrange,
    },
    <String, dynamic>{
      'name': 'Forest Mint',
      'desc': 'Calm greens, light surface',
      'data': const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemGreen,
        scaffoldBackgroundColor: Color(0xFFF1FBF4),
        barBackgroundColor: Color(0xFFFFFFFF),
      ),
      'accent': CupertinoColors.systemGreen,
    },
    <String, dynamic>{
      'name': 'Royal Indigo',
      'desc': 'Deep indigo on neutral grey',
      'data': const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemIndigo,
        scaffoldBackgroundColor: Color(0xFFF2F2F7),
        barBackgroundColor: Color(0xFFFAFAFC),
      ),
      'accent': CupertinoColors.systemIndigo,
    },
    <String, dynamic>{
      'name': 'Midnight Pro',
      'desc': 'Dark mode with blue tint',
      'data': const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemBlue,
        scaffoldBackgroundColor: Color(0xFF000000),
        barBackgroundColor: Color(0xFF1C1C1E),
      ),
      'accent': CupertinoColors.systemBlue,
    },
    <String, dynamic>{
      'name': 'Crimson Night',
      'desc': 'Dark with destructive red',
      'data': const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemRed,
        scaffoldBackgroundColor: Color(0xFF000000),
        barBackgroundColor: Color(0xFF1C1C1E),
      ),
      'accent': CupertinoColors.systemRed,
    },
    <String, dynamic>{
      'name': 'Neon Mint',
      'desc': 'Dark mode mint accent',
      'data': const CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.systemMint,
        scaffoldBackgroundColor: Color(0xFF0B0F0E),
        barBackgroundColor: Color(0xFF13201C),
      ),
      'accent': CupertinoColors.systemMint,
    },
    <String, dynamic>{
      'name': 'Lilac Glow',
      'desc': 'Pastel purple, light',
      'data': const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemPurple,
        scaffoldBackgroundColor: Color(0xFFFBF6FF),
        barBackgroundColor: Color(0xFFFFFFFF),
      ),
      'accent': CupertinoColors.systemPurple,
    },
  ];

  final Widget section4Cards = Wrap(
    children: List<Widget>.generate(themes.length, (int themeIndex) {
      return _themeCard(context, themes[themeIndex]);
    }),
  );

  // -------------------------------------------------------------------------
  // SECTION 5 · iOS mini frames
  // -------------------------------------------------------------------------
  final Widget section5Header = _sectionHeader(
    '05',
    'iOS preview frames',
    'Themes applied to a complete embedded UI',
    const Color(0xFFFF9500),
  );

  final Widget section5Narrative = _narrative(
    'Each phone-shaped frame embeds a CupertinoTheme around a hand-rolled iOS UI '
    '(status bar, nav bar, settings list, action buttons, tab bar).  The same widget '
    'tree changes appearance entirely based on the supplied CupertinoThemeData.',
  );

  final Widget section5Frames = Wrap(
    alignment: WrapAlignment.center,
    children: List<Widget>.generate(themes.length, (int themeIndex) {
      final Map<String, dynamic> entry = themes[themeIndex];
      final CupertinoThemeData data = entry['data'] as CupertinoThemeData;
      return _iosFrame(
        title: entry['name'] as String,
        subtitle: 'Settings',
        data: data,
        brightness: data.brightness ?? Brightness.light,
        accent: entry['desc'] as String,
      );
    }),
  );

  // -------------------------------------------------------------------------
  // SECTION 6 · CupertinoTextThemeData
  // -------------------------------------------------------------------------
  final Widget section6Header = _sectionHeader(
    '06',
    'CupertinoTextThemeData',
    'Typography bundle: nav titles, large titles, tabs, actions',
    const Color(0xFF5856D6),
  );

  final Widget section6Narrative = _narrative(
    'CupertinoTextThemeData is the typography bundle inside CupertinoThemeData. It '
    'contains textStyle (body), navTitleTextStyle, navLargeTitleTextStyle, '
    'navActionTextStyle, pickerTextStyle, dateTimePickerTextStyle, tabLabelTextStyle, '
    'and actionTextStyle. Each can be overridden independently.',
  );

  final List<Map<String, dynamic>> textSamples = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'textStyle (body)',
      'style': const TextStyle(fontSize: 17.0, color: kInkText),
      'sample': 'The quick brown fox jumps over the lazy dog.',
    },
    <String, dynamic>{
      'name': 'navTitleTextStyle',
      'style': const TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
        color: kInkText,
      ),
      'sample': 'Navigation Title',
    },
    <String, dynamic>{
      'name': 'navLargeTitleTextStyle',
      'style': const TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w800,
        color: kInkText,
        letterSpacing: -0.5,
      ),
      'sample': 'Large Title',
    },
    <String, dynamic>{
      'name': 'navActionTextStyle',
      'style': const TextStyle(
        fontSize: 17.0,
        color: Color(0xFF0A84FF),
      ),
      'sample': 'Edit  Done  Save',
    },
    <String, dynamic>{
      'name': 'pickerTextStyle',
      'style': const TextStyle(
        fontSize: 21.0,
        color: kInkText,
        letterSpacing: -0.4,
      ),
      'sample': 'Picker value · 42',
    },
    <String, dynamic>{
      'name': 'tabLabelTextStyle',
      'style': const TextStyle(
        fontSize: 10.0,
        color: kInkMuted,
        fontWeight: FontWeight.w500,
      ),
      'sample': 'HOME · SEARCH · ME',
    },
    <String, dynamic>{
      'name': 'actionTextStyle',
      'style': const TextStyle(
        fontSize: 17.0,
        color: Color(0xFF0A84FF),
        fontWeight: FontWeight.w400,
      ),
      'sample': 'Tap me to act',
    },
  ];

  final Widget section6List = Column(
    children: List<Widget>.generate(textSamples.length, (int sampleIndex) {
      final Map<String, dynamic> sample = textSamples[sampleIndex];
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: kInkSurface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: kInkLine, width: 1.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 180.0,
              child: Text(
                sample['name'] as String,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Color(0xFF5856D6),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Text(
                sample['sample'] as String,
                style: sample['style'] as TextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }),
  );

  // -------------------------------------------------------------------------
  // SECTION 7 · CupertinoIconThemeData
  // -------------------------------------------------------------------------
  final Widget section7Header = _sectionHeader(
    '07',
    'CupertinoIconThemeData',
    'Default icon size, color and opacity',
    const Color(0xFF00C7BE),
  );

  final Widget section7Narrative = _narrative(
    'IconThemeData (used by Cupertino as well) sets default size / color / opacity / '
    'shadows / fill for icons inside a subtree. Pair it with CupertinoTheme to keep the '
    'tint consistent with the primary color of the surrounding theme.',
  );

  final List<Map<String, dynamic>> iconRows = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'Small · blue',
      'data': const IconThemeData(size: 18.0, color: Color(0xFF0A84FF)),
    },
    <String, dynamic>{
      'label': 'Medium · indigo',
      'data': const IconThemeData(size: 24.0, color: Color(0xFF5856D6)),
    },
    <String, dynamic>{
      'label': 'Large · purple',
      'data': const IconThemeData(size: 30.0, color: Color(0xFFAF52DE)),
    },
    <String, dynamic>{
      'label': 'XL · pink, 70% alpha',
      'data': IconThemeData(size: 38.0, color: const Color(0xFFFF2D55).withValues(alpha: 0.7)),
    },
    <String, dynamic>{
      'label': 'XXL · green',
      'data': const IconThemeData(size: 48.0, color: Color(0xFF34C759)),
    },
  ];

  final List<IconData> iconSet = <IconData>[
    CupertinoIcons.heart_fill,
    CupertinoIcons.star_fill,
    CupertinoIcons.bell_fill,
    CupertinoIcons.bookmark_fill,
    CupertinoIcons.cloud_fill,
    CupertinoIcons.bolt_fill,
  ];

  final Widget section7Grid = Column(
    children: List<Widget>.generate(iconRows.length, (int rowIndex) {
      final Map<String, dynamic> row = iconRows[rowIndex];
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: kInkSurface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: kInkLine, width: 1.0),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 180.0,
              child: Text(
                row['label'] as String,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: kInkText,
                ),
              ),
            ),
            Expanded(
              child: IconTheme(
                data: row['data'] as IconThemeData,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List<Widget>.generate(iconSet.length, (int iconIndex) {
                    return Icon(iconSet[iconIndex]);
                  }),
                ),
              ),
            ),
          ],
        ),
      );
    }),
  );

  // -------------------------------------------------------------------------
  // SECTION 8 · NoDefaultCupertinoThemeData
  // -------------------------------------------------------------------------
  final Widget section8Header = _sectionHeader(
    '08',
    'NoDefaultCupertinoThemeData',
    'The raw, no-fallback variant',
    const Color(0xFF8E8E93),
  );

  final Widget section8Narrative = _narrative(
    'NoDefaultCupertinoThemeData is the underlying record that does NOT substitute iOS '
    'defaults when a field is null. CupertinoThemeData composes one and adds default '
    'resolution. You almost never instantiate it directly - it surfaces when reading '
    'theme.noDefault for property forwarding (e.g. CupertinoApp -> MaterialApp adapter).',
  );

  const NoDefaultCupertinoThemeData rawNoDefault = NoDefaultCupertinoThemeData(
    primaryColor: CupertinoColors.systemPink,
  );

  final Widget section8Card = Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kInkSurface,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kInkLine, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'const NoDefaultCupertinoThemeData(primaryColor: CupertinoColors.systemPink)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: kInkText,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            _kvChip('brightness', '${rawNoDefault.brightness}'),
            _kvChip('primaryColor', _hex(rawNoDefault.primaryColor ?? CupertinoColors.systemPink)),
            _kvChip(
              'barBackgroundColor',
              rawNoDefault.barBackgroundColor == null ? 'null' : _hex(rawNoDefault.barBackgroundColor!),
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 9 · resolveFrom and brightness override
  // -------------------------------------------------------------------------
  final Widget section9Header = _sectionHeader(
    '09',
    'theme.resolveFrom & brightness override',
    'Force-resolving themes against an explicit context',
    const Color(0xFFFF9500),
  );

  final Widget section9Narrative = _narrative(
    'CupertinoThemeData.resolveFrom(context) walks every field, asking each '
    'CupertinoDynamicColor to resolve against the ambient brightness, elevation and '
    'contrast.  Wrapping a subtree in a MediaQuery with a custom platformBrightness '
    'flips the resolution result without touching the rest of the tree.',
  );

  final Widget section9LightVsDark = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: _resolveDemoCard(
          context: context,
          label: 'platformBrightness: light',
          brightness: Brightness.light,
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: _resolveDemoCard(
          context: context,
          label: 'platformBrightness: dark',
          brightness: Brightness.dark,
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 10 · applyThemeToAll
  // -------------------------------------------------------------------------
  final Widget section10Header = _sectionHeader(
    '10',
    'CupertinoApp.applyThemeToAll',
    'Cascading Cupertino styling into adapter widgets',
    const Color(0xFF30B0C7),
  );

  final Widget section10Narrative = _narrative(
    'CupertinoApp(applyThemeToAll: true) instructs Cupertino widgets that internally use '
    'a Material adapter (notably navigation transitions and dialogs) to honor the '
    'Cupertino theme too. The default is false to preserve historical behavior. Toggle '
    'this when you want a fully iOS-tinted look even for fall-through Material chrome.',
  );

  final Widget section10Comparison = Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: _applyToAllCard(
          flag: false,
          label: 'applyThemeToAll: false',
          description:
              'Material adapters keep their own theme; Cupertino primary may not '
              'tint dialog buttons or transition affordances.',
        ),
      ),
      const SizedBox(width: 12.0),
      Expanded(
        child: _applyToAllCard(
          flag: true,
          label: 'applyThemeToAll: true',
          description:
              'Material adapters re-resolve against the Cupertino theme; primary '
              'color cascades everywhere for a consistent iOS look.',
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 11 · CupertinoTheme.of vs maybeOf
  // -------------------------------------------------------------------------
  final Widget section11Header = _sectionHeader(
    '11',
    'CupertinoTheme.of(context)',
    'Reading the theme from descendants',
    const Color(0xFFBF5AF2),
  );

  final Widget section11Narrative = _narrative(
    'Inside a Cupertino subtree, CupertinoTheme.of(context) returns the active '
    'CupertinoThemeData with all defaults resolved. CupertinoTheme.brightnessOf reads '
    'only the brightness, falling back to MediaQuery.platformBrightnessOf when the '
    'theme leaves it null.  Below, three nested CupertinoTheme widgets demonstrate '
    'how the closest ancestor wins.',
  );

  final Widget section11Demo = Column(
    children: <Widget>[
      CupertinoTheme(
        data: const CupertinoThemeData(primaryColor: CupertinoColors.systemBlue),
        child: _themeReader('Outer · blue'),
      ),
      CupertinoTheme(
        data: const CupertinoThemeData(primaryColor: CupertinoColors.systemBlue),
        child: CupertinoTheme(
          data: const CupertinoThemeData(primaryColor: CupertinoColors.systemGreen),
          child: _themeReader('Inner · green overrides blue'),
        ),
      ),
      CupertinoTheme(
        data: const CupertinoThemeData(primaryColor: CupertinoColors.systemBlue),
        child: CupertinoTheme(
          data: const CupertinoThemeData(primaryColor: CupertinoColors.systemGreen),
          child: CupertinoTheme(
            data: const CupertinoThemeData(primaryColor: CupertinoColors.systemPink),
            child: _themeReader('Deeper · pink overrides all'),
          ),
        ),
      ),
    ],
  );

  // -------------------------------------------------------------------------
  // SECTION 12 · CopyWith chains
  // -------------------------------------------------------------------------
  final Widget section12Header = _sectionHeader(
    '12',
    'CupertinoThemeData.copyWith chains',
    'Incremental theme refinement',
    const Color(0xFFFFCC00),
  );

  final Widget section12Narrative = _narrative(
    'copyWith returns a new CupertinoThemeData with selected overrides applied. Below: '
    'a base theme is progressively refined through five copyWith calls; only the changed '
    'fields are highlighted in each step.',
  );

  const CupertinoThemeData copyBase = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemBlue,
  );
  final CupertinoThemeData copyStep1 = copyBase.copyWith(
    primaryColor: CupertinoColors.systemRed,
  );
  final CupertinoThemeData copyStep2 = copyStep1.copyWith(
    brightness: Brightness.dark,
  );
  final CupertinoThemeData copyStep3 = copyStep2.copyWith(
    scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
  );
  final CupertinoThemeData copyStep4 = copyStep3.copyWith(
    barBackgroundColor: const Color(0xFF1C1C1E),
  );
  final CupertinoThemeData copyStep5 = copyStep4.copyWith(
    primaryContrastingColor: const Color(0xFFFFFFFF),
  );

  final List<Map<String, dynamic>> copySteps = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'base',
      'data': copyBase,
      'highlight': 'primary=systemBlue, brightness=light',
    },
    <String, dynamic>{
      'label': '+ primaryColor=red',
      'data': copyStep1,
      'highlight': 'primary became systemRed',
    },
    <String, dynamic>{
      'label': '+ brightness=dark',
      'data': copyStep2,
      'highlight': 'brightness flipped to dark',
    },
    <String, dynamic>{
      'label': '+ scaffoldBg=darkGray',
      'data': copyStep3,
      'highlight': 'page background updated',
    },
    <String, dynamic>{
      'label': '+ barBg=#1C1C1E',
      'data': copyStep4,
      'highlight': 'bar background tweaked',
    },
    <String, dynamic>{
      'label': '+ primaryContrast=white',
      'data': copyStep5,
      'highlight': 'contrast text override',
    },
  ];

  final Widget section12Chain = Column(
    children: List<Widget>.generate(copySteps.length, (int stepIndex) {
      final Map<String, dynamic> step = copySteps[stepIndex];
      final CupertinoThemeData data = step['data'] as CupertinoThemeData;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: kInkSurface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: kInkLine, width: 1.0),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00).withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                '${stepIndex + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12.0,
                  color: Color(0xFF8A6D00),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    step['label'] as String,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: kInkText,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    step['highlight'] as String,
                    style: const TextStyle(fontSize: 11.5, color: kInkMuted),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                _swatchDot(data.primaryColor),
                const SizedBox(width: 4.0),
                _swatchDot(data.scaffoldBackgroundColor),
                const SizedBox(width: 4.0),
                _swatchDot(data.barBackgroundColor),
              ],
            ),
          ],
        ),
      );
    }),
  );

  // -------------------------------------------------------------------------
  // SECTION 13 · Live themed widgets row
  // -------------------------------------------------------------------------
  final Widget section13Header = _sectionHeader(
    '13',
    'Live themed widgets',
    'Buttons, switches and indicators reacting to themes',
    const Color(0xFF64D2FF),
  );

  final Widget section13Narrative = _narrative(
    'Each row wraps the same Cupertino widget set in a different theme. Notice how '
    'CupertinoButton.filled, CupertinoSwitch and CupertinoActivityIndicator pick up '
    'the primary color automatically.',
  );

  final Widget section13Rows = Column(
    children: List<Widget>.generate(themes.length, (int themeIndex) {
      final Map<String, dynamic> entry = themes[themeIndex];
      final CupertinoThemeData data = entry['data'] as CupertinoThemeData;
      final String name = entry['name'] as String;
      final bool dark = (data.brightness ?? Brightness.light) == Brightness.dark;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: dark ? kDarkSurface : kInkSurface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: dark ? kDarkLine : kInkLine, width: 1.0),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 150.0,
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  color: dark ? kDarkText : kInkText,
                ),
              ),
            ),
            Expanded(
              child: CupertinoTheme(
                data: data,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CupertinoButton.filled(
                      onPressed: () {},
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: const Text('Confirm'),
                    ),
                    CupertinoSwitch(value: true, onChanged: (bool v) {}),
                    const CupertinoActivityIndicator(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }),
  );

  // -------------------------------------------------------------------------
  // SECTION 14 · Theme summary card
  // -------------------------------------------------------------------------
  final Widget section14Header = _sectionHeader(
    '14',
    'Summary',
    'What this script covered',
    const Color(0xFF0A84FF),
  );

  final List<String> summaryBullets = <String>[
    'CupertinoTheme + CupertinoThemeData fundamentals',
    'CupertinoColors palette (18 system colors, 14 accent/background tokens)',
    'CupertinoDynamicColor resolution matrix',
    '8 hand-crafted CupertinoThemeData configurations',
    'iOS mini-frames rendering each theme on a full faux-iOS UI',
    'CupertinoTextThemeData typography roles',
    'CupertinoIconThemeData / IconTheme cascading',
    'NoDefaultCupertinoThemeData (raw, defaults disabled)',
    'theme.resolveFrom(context) + brightness override via MediaQuery',
    'CupertinoApp.applyThemeToAll comparison',
    'CupertinoTheme.of nested-ancestor resolution',
    'CupertinoThemeData.copyWith refinement chain (6 steps)',
    'Live Cupertino widgets reacting to theme changes',
  ];

  final Widget section14Summary = Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[Color(0xFFEAF4FF), Color(0xFFE6F7EF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: const Color(0xFF0A84FF).withValues(alpha: 0.25), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(summaryBullets.length, (int bulletIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 22.0,
                height: 22.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF34C759).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: const Icon(
                  CupertinoIcons.check_mark,
                  size: 13.0,
                  color: Color(0xFF248A3D),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  summaryBullets[bulletIndex],
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: kInkText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );

  // Compose the final tree.  We use a Material Scaffold (simpler under D4rt)
  // and embed Cupertino content inside, which is exactly what the script
  // requirements call for.
  return Scaffold(
    backgroundColor: kInkBackground,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _heroBanner(),
            section1Header,
            section1Narrative,
            section1Table,
            section2Header,
            section2Narrative,
            _subheading('System colors'),
            section2Swatches,
            const SizedBox(height: 12.0),
            _subheading('Accents · backgrounds · separators'),
            section2AccentSwatches,
            section3Header,
            section3Narrative,
            section3Matrix,
            section4Header,
            section4Narrative,
            section4Cards,
            section5Header,
            section5Narrative,
            section5Frames,
            section6Header,
            section6Narrative,
            section6List,
            section7Header,
            section7Narrative,
            section7Grid,
            section8Header,
            section8Narrative,
            section8Card,
            section9Header,
            section9Narrative,
            section9LightVsDark,
            section10Header,
            section10Narrative,
            section10Comparison,
            section11Header,
            section11Narrative,
            section11Demo,
            section12Header,
            section12Narrative,
            section12Chain,
            section13Header,
            section13Narrative,
            section13Rows,
            section14Header,
            section14Summary,
            const SizedBox(height: 24.0),
            _footer(),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// HELPERS used by the build above
// ============================================================================

Widget _matrixCell(String label, Color color) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: kInkLine, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(7.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            child: Column(
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: kInkText,
                  ),
                ),
                Text(
                  _hex(color),
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9.5,
                    color: kInkMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _themeCard(BuildContext context, Map<String, dynamic> theme) {
  final CupertinoThemeData data = theme['data'] as CupertinoThemeData;
  final String name = theme['name'] as String;
  final String desc = theme['desc'] as String;
  final Color accent = data.primaryColor;
  final bool dark = (data.brightness ?? Brightness.light) == Brightness.dark;
  return Container(
    width: 250.0,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: dark ? kDarkSurface : kInkSurface,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(
        color: accent.withValues(alpha: 0.35),
        width: 1.4,
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Icon(
                dark ? CupertinoIcons.moon_fill : CupertinoIcons.sun_max_fill,
                color: Colors.white,
                size: 16.0,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.0,
                      color: dark ? kDarkText : kInkText,
                    ),
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: dark ? kDarkMuted : kInkMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _fieldRow('brightness', dark ? 'dark' : 'light', dark),
        _fieldRow('primaryColor', _hex(accent), dark, accent: accent),
        _fieldRow('scaffoldBg', _hex(data.scaffoldBackgroundColor), dark, accent: data.scaffoldBackgroundColor),
        _fieldRow('barBg', _hex(data.barBackgroundColor), dark, accent: data.barBackgroundColor),
      ],
    ),
  );
}

Widget _fieldRow(String key, String value, bool dark, {Color? accent}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: <Widget>[
        if (accent != null) ...<Widget>[
          Container(
            width: 14.0,
            height: 14.0,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: dark ? kDarkLine : kInkLine, width: 1.0),
            ),
          ),
          const SizedBox(width: 8.0),
        ],
        SizedBox(
          width: accent == null ? 110.0 : 96.0,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: dark ? kDarkMuted : kInkMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: dark ? kDarkText : kInkText,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _kvChip(String key, String value) {
  return Container(
    margin: const EdgeInsets.only(right: 8.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: kInkBackground,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: kInkLine, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$key: ',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: kInkMuted,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: kInkText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _resolveDemoCard({
  required BuildContext context,
  required String label,
  required Brightness brightness,
}) {
  // Build a synthetic MediaQuery to force resolution.  Note this is for
  // illustration only - we render the resolved values rather than re-rendering
  // every CupertinoColors lookup which would require the live MediaQuery.
  final List<Map<String, Color>> resolvedSamples = brightness == Brightness.light
      ? <Map<String, Color>>[
          <String, Color>{'systemBlue': const Color(0xFF007AFF)},
          <String, Color>{'label': const Color(0xFF000000)},
          <String, Color>{'systemBackground': const Color(0xFFFFFFFF)},
          <String, Color>{'separator': const Color(0x4C3C3C43)},
        ]
      : <Map<String, Color>>[
          <String, Color>{'systemBlue': const Color(0xFF0A84FF)},
          <String, Color>{'label': const Color(0xFFFFFFFF)},
          <String, Color>{'systemBackground': const Color(0xFF000000)},
          <String, Color>{'separator': const Color(0x99545458)},
        ];
  final bool dark = brightness == Brightness.dark;
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: dark ? kDarkSurface : kInkSurface,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: dark ? kDarkLine : kInkLine,
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              dark ? CupertinoIcons.moon_stars_fill : CupertinoIcons.sun_max_fill,
              size: 18.0,
              color: dark ? kDarkText : const Color(0xFFFF9500),
            ),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13.0,
                color: dark ? kDarkText : kInkText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Column(
          children: List<Widget>.generate(resolvedSamples.length, (int sampleIndex) {
            final Map<String, Color> entry = resolvedSamples[sampleIndex];
            final String name = entry.keys.first;
            final Color color = entry.values.first;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 22.0,
                    height: 22.0,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: dark ? kDarkLine : kInkLine,
                        width: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12.0,
                        color: dark ? kDarkText : kInkText,
                      ),
                    ),
                  ),
                  Text(
                    _hex(color),
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      color: dark ? kDarkMuted : kInkMuted,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget _applyToAllCard({
  required bool flag,
  required String label,
  required String description,
}) {
  final Color accent = flag ? const Color(0xFF34C759) : const Color(0xFFFF9500);
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kInkSurface,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.2),
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
                color: accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: Icon(
                flag ? CupertinoIcons.checkmark_seal_fill : CupertinoIcons.exclamationmark_circle_fill,
                size: 18.0,
                color: accent,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5,
                  color: kInkText,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12.0,
            color: kInkText,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 12.0),
        // A simplified visual of the cascade
        Row(
          children: List<Widget>.generate(4, (int badgeIndex) {
            final List<String> names = <String>['Buttons', 'NavBar', 'Dialogs', 'Trans.'];
            final bool tinted = flag || badgeIndex < 2;
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: tinted
                      ? accent.withValues(alpha: 0.18)
                      : kInkBackground,
                  borderRadius: BorderRadius.circular(7.0),
                ),
                alignment: Alignment.center,
                child: Text(
                  names[badgeIndex],
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: tinted ? accent : kInkMuted,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget _themeReader(String label) {
  return Builder(
    builder: (BuildContext ctx) {
      final CupertinoThemeData theme = CupertinoTheme.of(ctx);
      final Color primary = theme.primaryColor;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: kInkSurface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: kInkLine, width: 1.0),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: const Icon(CupertinoIcons.paintbrush_fill, color: Colors.white, size: 16.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                      color: kInkText,
                    ),
                  ),
                  Text(
                    'CupertinoTheme.of(context).primaryColor = ${_hex(primary)}',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: kInkMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget _swatchDot(Color color) {
  return Container(
    width: 18.0,
    height: 18.0,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(color: kInkLine, width: 1.0),
    ),
  );
}

Widget _subheading(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0, bottom: 4.0, left: 4.0),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 13.5,
        color: kInkText,
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget _heroBanner() {
  return Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF0A84FF),
          Color(0xFF5856D6),
          Color(0xFFAF52DE),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0xFF0A84FF).withValues(alpha: 0.35),
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
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.5),
                  width: 1.4,
                ),
              ),
              alignment: Alignment.center,
              child: const Icon(
                CupertinoIcons.paintbrush_fill,
                color: Colors.white,
                size: 28.0,
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Cupertino Themes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.6,
                    ),
                  ),
                  Text(
                    'Deep visual demo · D4rt interpreted script',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.88),
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: List<Widget>.generate(6, (int chipIndex) {
            final List<String> chips = <String>[
              'CupertinoThemeData',
              'TextThemeData',
              'IconThemeData',
              'DynamicColor',
              'resolveFrom',
              'applyThemeToAll',
            ];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.0,
                ),
              ),
              child: Text(
                chips[chipIndex],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget _footer() {
  return Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kInkSurface,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kInkLine, width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF34C759), Color(0xFF30D158)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: Alignment.center,
          child: const Icon(
            CupertinoIcons.checkmark_seal_fill,
            color: Colors.white,
            size: 22.0,
          ),
        ),
        const SizedBox(width: 12.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Cupertino theme batch 2 · complete',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w800,
                  color: kInkText,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                'Rendered through the D4rt interpreter via SendTestRunner.',
                style: TextStyle(fontSize: 12.0, color: kInkMuted),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: const Color(0xFF0A84FF).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'D4RT',
            style: TextStyle(
              fontFamily: 'monospace',
              color: Color(0xFF0A84FF),
              fontWeight: FontWeight.w900,
              fontSize: 11.5,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    ),
  );
}

// Reserve a math reference so the import is used (used for any future numeric
// helpers like angle-based gradients). A trivial constant keeps the analyzer
// happy without affecting output.
final double kFullTurnReserved = 2.0 * math.pi;
