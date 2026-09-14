// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual test: Cupertino miscellaneous advanced field guide.
// Profiles colors, dynamic colors, icons, themes, text themes, localizations,
// activity indicator, list section, MediaQuery and assorted recipes.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ============================================================================
// PALETTE & SPACING TOKENS
// ============================================================================

const Color kBackground = Color(0xFFF2F2F7);
const Color kSurface = Color(0xFFFFFFFF);
const Color kSurfaceAlt = Color(0xFFF9F9FB);
const Color kBorder = Color(0xFFD1D1D6);
const Color kBorderStrong = Color(0xFFB0B0B5);
const Color kAccent = Color(0xFF007AFF);
const Color kAccentSoft = Color(0xFFE5F0FF);
const Color kDestructive = Color(0xFFFF3B30);
const Color kSuccess = Color(0xFF34C759);
const Color kWarning = Color(0xFFFF9500);
const Color kPurple = Color(0xFFAF52DE);
const Color kIndigo = Color(0xFF5856D6);
const Color kPink = Color(0xFFFF2D55);
const Color kTeal = Color(0xFF5AC8FA);
const Color kInk = Color(0xFF1C1C1E);
const Color kInkMuted = Color(0xFF3A3A3C);
const Color kInkSoft = Color(0xFF6E6E73);
const Color kInkFaint = Color(0xFFA0A0A5);
const Color kDarkBg = Color(0xFF000000);
const Color kDarkSurface = Color(0xFF1C1C1E);
const Color kDarkSurfaceAlt = Color(0xFF2C2C2E);

const double kPad = 16.0;
const double kPadLarge = 24.0;
const double kRadius = 14.0;
const double kRadiusLg = 20.0;

// ============================================================================
// PRIMITIVE BUILDERS
// ============================================================================

Widget gap(double h) => SizedBox(height: h);
Widget hgap(double w) => SizedBox(width: w);

Widget heading(String text, {double size = 22.0, Color color = kInk}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w700,
      color: color,
      letterSpacing: -0.4,
    ),
  );
}

Widget subheading(String text, {Color color = kInkMuted}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: color,
      letterSpacing: 0.2,
    ),
  );
}

Widget body(String text, {Color color = kInkMuted, double size = 13.0}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: size,
      color: color,
      height: 1.45,
    ),
  );
}

Widget mono(String text, {Color color = kAccent, double size = 12.0}) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'Menlo',
      fontSize: size,
      color: color,
      fontWeight: FontWeight.w500,
    ),
  );
}

Widget pill(String text, {Color color = kAccent, Color? bg}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg ?? color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(color: color.withOpacity(0.35), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        color: color,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ),
  );
}

Widget card({required Widget child, EdgeInsets? padding, Color? color, double radius = kRadius}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(kPad),
    decoration: BoxDecoration(
      color: color ?? kSurface,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: kBorder, width: 1.0),
    ),
    child: child,
  );
}

Widget sectionTitle(int n, String title, {String? note}) {
  return Padding(
    padding: const EdgeInsets.only(top: kPadLarge, bottom: kPad),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: kAccent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '$n',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
            ),
          ),
        ),
        hgap(12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading(title, size: 19.0),
              if (note != null) ...[
                gap(2.0),
                subheading(note),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

Widget kv(String k, String v, {Color valueColor = kInk}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160.0,
          child: Text(
            k,
            style: const TextStyle(
              fontSize: 12.5,
              color: kInkSoft,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            v,
            style: TextStyle(
              fontSize: 13.0,
              color: valueColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget divider() => Container(height: 1.0, color: kBorder, margin: const EdgeInsets.symmetric(vertical: 10.0));

// ============================================================================
// SECTION 1 — HERO HEADER
// ============================================================================

Widget heroHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(kPadLarge),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [kAccent, kIndigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(kRadiusLg),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'CUPERTINO FIELD GUIDE',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            hgap(8.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text(
                'iOS HIG',
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
        gap(14.0),
        const Text(
          'Cupertino miscellaneous',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.8,
            height: 1.1,
          ),
        ),
        gap(4.0),
        const Text(
          'colors • themes • localizations • indicators',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.white,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.2,
          ),
        ),
        gap(16.0),
        Text(
          'A hand-crafted catalog of the small but load-bearing pieces of the '
          'Cupertino library — the color tokens, dynamic colors, icon font, theme '
          'data slots, text theme, default localizations, activity indicator and '
          'list section. Each section profiles one concept with anatomy, specimens '
          'and recipes.',
          style: TextStyle(
            fontSize: 13.5,
            color: Colors.white.withOpacity(0.92),
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 2 — CUPERTINO VS MATERIAL OVERVIEW
// ============================================================================

Widget compareRow(String axis, String cupertino, String material) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: kBorder)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            axis,
            style: const TextStyle(
              fontSize: 12.0,
              color: kInkSoft,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            cupertino,
            style: const TextStyle(fontSize: 13.0, color: kInk, height: 1.4),
          ),
        ),
        hgap(12.0),
        Expanded(
          child: Text(
            material,
            style: const TextStyle(fontSize: 13.0, color: kInkMuted, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget overviewCard() {
  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pill('CONCEPT', color: kIndigo),
            hgap(8.0),
            pill('OVERVIEW', color: kAccent),
          ],
        ),
        gap(10.0),
        heading('Cupertino is the iOS design language for Flutter', size: 18.0),
        gap(6.0),
        body(
          'Where Material expresses Google\'s design language (elevation, '
          'rectangular ink ripples, large FABs), Cupertino expresses Apple\'s — '
          'translucent bars, large titles that collapse, sliding transitions and '
          'a tightly-curated palette. The widgets here mostly target rendering '
          'parity with iOS rather than introducing new interaction models.',
        ),
        gap(14.0),
        Row(
          children: const [
            SizedBox(width: 130.0),
            Expanded(
              child: Text(
                'Cupertino',
                style: TextStyle(
                  fontSize: 12.0,
                  color: kAccent,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Material',
                style: TextStyle(
                  fontSize: 12.0,
                  color: kInkMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        gap(4.0),
        compareRow('typography', 'SF Pro Display / Text, tight letter-spacing', 'Roboto, looser spacing'),
        compareRow('icons', 'CupertinoIcons font, line style', 'Icons, filled/outlined glyphs'),
        compareRow('navigation', 'CupertinoNavigationBar / SliverNavigationBar', 'AppBar / SliverAppBar'),
        compareRow('gestures', 'edge swipe back, sheet drag-to-dismiss', 'OS back button, slide-up sheets'),
        compareRow('colors', 'system* tokens that resolve to dynamic colors', 'ColorScheme tokens'),
        compareRow('controls', 'sliding segments, picker wheel, switch', 'segments, dropdown, switch'),
        compareRow('feedback', 'subtle, white-on-blur', 'ink ripple, elevation'),
        compareRow('motion', 'spring-based, slide-from-right route', 'fade-through, shared-axis'),
      ],
    ),
  );
}

// ============================================================================
// SECTION 3 — CUPERTINOCOLORS CATALOG
// ============================================================================

class Swatch {
  final String name;
  final Color color;
  final String hex;
  final String category;
  Swatch(this.name, this.color, this.hex, this.category);
}

List<Swatch> _allSwatches() {
  return [
    Swatch('systemBlue', CupertinoColors.systemBlue, '#007AFF', 'tint'),
    Swatch('systemRed', CupertinoColors.systemRed, '#FF3B30', 'tint'),
    Swatch('systemGreen', CupertinoColors.systemGreen, '#34C759', 'tint'),
    Swatch('systemIndigo', CupertinoColors.systemIndigo, '#5856D6', 'tint'),
    Swatch('systemOrange', CupertinoColors.systemOrange, '#FF9500', 'tint'),
    Swatch('systemPink', CupertinoColors.systemPink, '#FF2D55', 'tint'),
    Swatch('systemPurple', CupertinoColors.systemPurple, '#AF52DE', 'tint'),
    Swatch('systemTeal', CupertinoColors.systemTeal, '#5AC8FA', 'tint'),
    Swatch('systemYellow', CupertinoColors.systemYellow, '#FFCC00', 'tint'),
    Swatch('activeBlue', CupertinoColors.activeBlue, '#007AFF', 'legacy'),
    Swatch('activeGreen', CupertinoColors.activeGreen, '#4CD964', 'legacy'),
    Swatch('activeOrange', CupertinoColors.activeOrange, '#FF9500', 'legacy'),
    Swatch('destructiveRed', CupertinoColors.destructiveRed, '#FF3B30', 'legacy'),
    Swatch('label', CupertinoColors.label, '#000000', 'label'),
    Swatch('secondaryLabel', CupertinoColors.secondaryLabel, '#3C3C43.60', 'label'),
    Swatch('tertiaryLabel', CupertinoColors.tertiaryLabel, '#3C3C43.30', 'label'),
    Swatch('quaternaryLabel', CupertinoColors.quaternaryLabel, '#3C3C43.18', 'label'),
    Swatch('placeholderText', CupertinoColors.placeholderText, '#3C3C43.30', 'label'),
    Swatch('systemFill', CupertinoColors.systemFill, '#787880.20', 'fill'),
    Swatch('secondarySystemFill', CupertinoColors.secondarySystemFill, '#787880.16', 'fill'),
    Swatch('tertiarySystemFill', CupertinoColors.tertiarySystemFill, '#767680.12', 'fill'),
    Swatch('quaternarySystemFill', CupertinoColors.quaternarySystemFill, '#747480.08', 'fill'),
    Swatch('systemBackground', CupertinoColors.systemBackground, '#FFFFFF', 'background'),
    Swatch('secondarySystemBackground', CupertinoColors.secondarySystemBackground, '#F2F2F7', 'background'),
  ];
}

Widget swatchTile(Swatch s) {
  // Use a static representative color so the script renders without a CupertinoTheme context.
  final Color repr = _representative(s);
  return Container(
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: repr,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.name,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: kInk,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              gap(2.0),
              Text(
                s.hex,
                style: const TextStyle(
                  fontFamily: 'Menlo',
                  fontSize: 10.0,
                  color: kInkSoft,
                ),
              ),
              Text(
                s.category,
                style: const TextStyle(
                  fontSize: 9.5,
                  color: kInkFaint,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Color _representative(Swatch s) {
  switch (s.name) {
    case 'systemBlue':
    case 'activeBlue':
      return const Color(0xFF007AFF);
    case 'systemRed':
    case 'destructiveRed':
      return const Color(0xFFFF3B30);
    case 'systemGreen':
      return const Color(0xFF34C759);
    case 'activeGreen':
      return const Color(0xFF4CD964);
    case 'systemIndigo':
      return const Color(0xFF5856D6);
    case 'systemOrange':
    case 'activeOrange':
      return const Color(0xFFFF9500);
    case 'systemPink':
      return const Color(0xFFFF2D55);
    case 'systemPurple':
      return const Color(0xFFAF52DE);
    case 'systemTeal':
      return const Color(0xFF5AC8FA);
    case 'systemYellow':
      return const Color(0xFFFFCC00);
    case 'label':
      return const Color(0xFF000000);
    case 'secondaryLabel':
      return const Color(0x993C3C43);
    case 'tertiaryLabel':
      return const Color(0x4D3C3C43);
    case 'quaternaryLabel':
      return const Color(0x2E3C3C43);
    case 'placeholderText':
      return const Color(0x4D3C3C43);
    case 'systemFill':
      return const Color(0x33787880);
    case 'secondarySystemFill':
      return const Color(0x29787880);
    case 'tertiarySystemFill':
      return const Color(0x1F767680);
    case 'quaternarySystemFill':
      return const Color(0x14747480);
    case 'systemBackground':
      return const Color(0xFFFFFFFF);
    case 'secondarySystemBackground':
      return const Color(0xFFF2F2F7);
  }
  return kInkSoft;
}

Widget colorsCatalog() {
  final swatches = _allSwatches();
  final rows = <Widget>[];
  for (int i = 0; i < swatches.length; i += 4) {
    final r = swatches.skip(i).take(4).toList();
    rows.add(Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          for (int j = 0; j < r.length; j++) ...[
            Expanded(child: swatchTile(r[j])),
            if (j < r.length - 1) hgap(8.0),
          ],
          if (r.length < 4)
            for (int k = 0; k < 4 - r.length; k++) ...[
              hgap(8.0),
              const Expanded(child: SizedBox()),
            ],
        ],
      ),
    ));
  }
  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('CupertinoColors', color: kAccent), hgap(8.0), pill('TOKENS', color: kIndigo)]),
        gap(10.0),
        heading('Named system colors', size: 18.0),
        gap(4.0),
        body('Tints, legacy actives, labels (4 tiers), fills (4 tiers) and backgrounds. '
            'Static specimens below; dynamic resolution is shown in the next section.'),
        gap(14.0),
        ...rows,
        gap(6.0),
        body(
            'Usage: ${swatches.length} named tokens. Always prefer the system* tokens — '
            'they resolve to CupertinoDynamicColor under the hood and adapt to brightness, '
            'high-contrast and elevation.',
            color: kInkSoft),
      ],
    ),
  );
}

// ============================================================================
// SECTION 4 — CUPERTINODYNAMICCOLOR
// ============================================================================

class Trait {
  final String name;
  final Brightness brightness;
  final bool highContrast;
  final Color color;
  Trait(this.name, this.brightness, this.highContrast, this.color);
}

Widget dynamicColorTile(String name, Trait t) {
  return Container(
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(kRadius),
      border: Border.all(color: kBorder),
    ),
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70.0,
          decoration: BoxDecoration(
            color: t.color,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        gap(10.0),
        Text(name, style: const TextStyle(fontSize: 13.0, color: kInk, fontWeight: FontWeight.w700)),
        gap(2.0),
        Text(t.name, style: const TextStyle(fontSize: 11.5, color: kInkSoft)),
        gap(2.0),
        Row(
          children: [
            pill(t.brightness.name, color: t.brightness == Brightness.light ? kWarning : kIndigo),
            hgap(6.0),
            if (t.highContrast) pill('high-contrast', color: kPurple),
          ],
        ),
      ],
    ),
  );
}

Widget dynamicColorShowcase() {
  final blueLight = Trait('light, normal', Brightness.light, false, const Color(0xFF007AFF));
  final blueDark = Trait('dark, normal', Brightness.dark, false, const Color(0xFF0A84FF));
  final blueLightHC = Trait('light, high-contrast', Brightness.light, true, const Color(0xFF0040DD));
  final blueDarkHC = Trait('dark, high-contrast', Brightness.dark, true, const Color(0xFF409CFF));

  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('CupertinoDynamicColor', color: kPurple), hgap(8.0), pill('TRAIT-DEPENDENT', color: kInkSoft)]),
        gap(10.0),
        heading('Same name, four resolutions', size: 18.0),
        gap(4.0),
        body('CupertinoDynamicColor encodes up to six color variants that resolve via '
            'CupertinoTheme.brightness, MediaQuery.highContrast and the elevated trait. '
            'Below is systemBlue resolved against four common trait sets.'),
        gap(14.0),
        Row(
          children: [
            Expanded(child: dynamicColorTile('systemBlue', blueLight)),
            hgap(10.0),
            Expanded(child: dynamicColorTile('systemBlue', blueDark)),
          ],
        ),
        gap(10.0),
        Row(
          children: [
            Expanded(child: dynamicColorTile('systemBlue', blueLightHC)),
            hgap(10.0),
            Expanded(child: dynamicColorTile('systemBlue', blueDarkHC)),
          ],
        ),
        gap(14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kSurfaceAlt,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mono('color: CupertinoColors.systemBlue.resolveFrom(context)', color: kInk, size: 11.5),
              gap(4.0),
              body('Without resolveFrom you get the *light/normal* variant only. '
                  'Always pass a BuildContext that lives under a CupertinoTheme.', color: kInkSoft),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 5 — CUPERTINOICONS CATALOG
// ============================================================================

class IconEntry {
  final String name;
  final IconData icon;
  IconEntry(this.name, this.icon);
}

List<IconEntry> _iconCatalog() {
  return [
    IconEntry('back', CupertinoIcons.back),
    IconEntry('forward', CupertinoIcons.forward),
    IconEntry('settings', CupertinoIcons.settings),
    IconEntry('share', CupertinoIcons.share),
    IconEntry('search', CupertinoIcons.search),
    IconEntry('refresh', CupertinoIcons.refresh),
    IconEntry('plus', CupertinoIcons.plus),
    IconEntry('minus', CupertinoIcons.minus),
    IconEntry('check_mark', CupertinoIcons.check_mark),
    IconEntry('xmark', CupertinoIcons.xmark),
    IconEntry('heart', CupertinoIcons.heart),
    IconEntry('heart_fill', CupertinoIcons.heart_fill),
    IconEntry('star', CupertinoIcons.star),
    IconEntry('star_fill', CupertinoIcons.star_fill),
    IconEntry('bell', CupertinoIcons.bell),
    IconEntry('person', CupertinoIcons.person),
    IconEntry('person_fill', CupertinoIcons.person_fill),
    IconEntry('gear', CupertinoIcons.gear),
    IconEntry('home', CupertinoIcons.home),
    IconEntry('mail', CupertinoIcons.mail),
    IconEntry('phone', CupertinoIcons.phone),
    IconEntry('camera', CupertinoIcons.camera),
    IconEntry('photo', CupertinoIcons.photo),
    IconEntry('book', CupertinoIcons.book),
    IconEntry('bookmark', CupertinoIcons.bookmark),
    IconEntry('cloud', CupertinoIcons.cloud),
    IconEntry('moon', CupertinoIcons.moon),
    IconEntry('sun_max', CupertinoIcons.sun_max),
    IconEntry('trash', CupertinoIcons.trash),
    IconEntry('arrow_up', CupertinoIcons.arrow_up),
  ];
}

Widget iconTile(IconEntry e) {
  return Container(
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: kBorder),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(e.icon, size: 26.0, color: kAccent),
        gap(6.0),
        Text(
          e.name,
          style: const TextStyle(fontSize: 10.5, color: kInkMuted, fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget iconsCatalog() {
  final entries = _iconCatalog();
  final rows = <Widget>[];
  for (int i = 0; i < entries.length; i += 6) {
    final r = entries.skip(i).take(6).toList();
    rows.add(Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          for (int j = 0; j < r.length; j++) ...[
            Expanded(child: iconTile(r[j])),
            if (j < r.length - 1) hgap(6.0),
          ],
          if (r.length < 6)
            for (int k = 0; k < 6 - r.length; k++) ...[
              hgap(6.0),
              const Expanded(child: SizedBox()),
            ],
        ],
      ),
    ));
  }
  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('CupertinoIcons', color: kAccent), hgap(8.0), pill('FONT GLYPHS', color: kInkSoft)]),
        gap(10.0),
        heading('Thirty representative glyphs', size: 18.0),
        gap(4.0),
        body('CupertinoIcons is a static class of IconData constants backed by the '
            'CupertinoIcons font (packages/cupertino_icons/assets). The icons render via '
            'the regular Icon widget but use this dedicated font.'),
        gap(14.0),
        ...rows,
      ],
    ),
  );
}

// ============================================================================
// SECTION 6 — CUPERTINOTHEME / CUPERTINOTHEMEDATA ANATOMY
// ============================================================================

Widget themeAnatomy() {
  final slots = <List<String>>[
    ['brightness', 'Brightness?', 'Drives all dynamic-color resolution downstream.'],
    ['primaryColor', 'Color', 'Tint for active controls (buttons, switches, links).'],
    ['primaryContrastingColor', 'Color', 'Foreground color when placed atop primaryColor.'],
    ['scaffoldBackgroundColor', 'Color', 'Default page background for CupertinoPageScaffold.'],
    ['barBackgroundColor', 'Color', 'Background of nav/tab bars; blurred behind in iOS.'],
    ['textTheme', 'CupertinoTextThemeData', 'Family of typed text styles (see section 7).'],
    ['applyThemeToAll', 'bool', 'When true, descendant Material widgets adopt these slots too.'],
  ];

  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('CupertinoTheme', color: kAccent), hgap(8.0), pill('CupertinoThemeData', color: kIndigo)]),
        gap(10.0),
        heading('Theme anatomy — every slot in CupertinoThemeData', size: 18.0),
        gap(6.0),
        body('CupertinoTheme is an InheritedWidget exposing a CupertinoThemeData. '
            'Children look up slots via CupertinoTheme.of(context). Nested CupertinoTheme '
            'widgets override individual slots for their subtree.'),
        gap(14.0),
        for (final s in slots) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s[0], style: const TextStyle(fontSize: 13.5, color: kInk, fontWeight: FontWeight.w700)),
                    Text(s[1], style: const TextStyle(fontFamily: 'Menlo', fontSize: 11.0, color: kAccent)),
                  ],
                ),
              ),
              Expanded(child: body(s[2])),
            ],
          ),
          divider(),
        ],
        gap(6.0),
        heading('Nested theme override specimen', size: 15.0),
        gap(8.0),
        Builder(builder: (ctx) {
          // Static visual approximation — render two cards with different "primary" tints.
          return Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: kSurfaceAlt,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: kBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      body('outer theme', color: kInkSoft),
                      gap(6.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: kAccent,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Text(
                          'Outer button',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              hgap(10.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: kSurfaceAlt,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: kBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      body('nested CupertinoTheme primaryColor: systemPurple', color: kInkSoft),
                      gap(6.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: kPurple,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Text(
                          'Inner button',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    ),
  );
}

// ============================================================================
// SECTION 7 — CUPERTINOTEXTTHEMEDATA SPECIMENS
// ============================================================================

class TextSlot {
  final String name;
  final String description;
  final TextStyle style;
  final String sample;
  TextSlot(this.name, this.description, this.style, this.sample);
}

List<TextSlot> _textSlots() {
  return [
    TextSlot('textStyle', 'Default body text', const TextStyle(fontSize: 17.0, color: kInk), 'Brevity is the soul of wit.'),
    TextSlot('actionTextStyle', 'Tappable links / actions', const TextStyle(fontSize: 17.0, color: kAccent), 'Open settings'),
    TextSlot('tabLabelTextStyle', 'Tab bar labels', const TextStyle(fontSize: 10.0, color: kInkSoft, letterSpacing: -0.24), 'Library'),
    TextSlot('navTitleTextStyle', 'Standard nav bar title', const TextStyle(fontSize: 17.0, color: kInk, fontWeight: FontWeight.w600, letterSpacing: -0.41), 'Mail'),
    TextSlot('navLargeTitleTextStyle', 'Large title (collapsing)', const TextStyle(fontSize: 34.0, color: kInk, fontWeight: FontWeight.w700, letterSpacing: 0.41), 'Inbox'),
    TextSlot('navActionTextStyle', 'Nav bar action button', const TextStyle(fontSize: 17.0, color: kAccent), 'Done'),
    TextSlot('pickerTextStyle', 'CupertinoPicker wheel item', const TextStyle(fontSize: 21.0, color: kInk, letterSpacing: -0.41), 'Tuesday'),
    TextSlot('dateTimePickerTextStyle', 'Date/time picker columns', const TextStyle(fontSize: 21.0, color: kInk, letterSpacing: -0.6), '14 : 32'),
  ];
}

Widget textSlotCard(TextSlot s) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(kRadius),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(s.name, style: const TextStyle(fontSize: 13.0, color: kInk, fontWeight: FontWeight.w700)),
            const Spacer(),
            pill('${s.style.fontSize?.toStringAsFixed(0)}pt', color: kAccent),
          ],
        ),
        gap(4.0),
        body(s.description, color: kInkSoft),
        gap(12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: kSurfaceAlt,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(s.sample, style: s.style),
        ),
      ],
    ),
  );
}

Widget textThemeSpecimens() {
  final slots = _textSlots();
  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('CupertinoTextThemeData', color: kIndigo), hgap(8.0), pill('TYPOGRAPHY', color: kAccent)]),
        gap(10.0),
        heading('Eight named text styles', size: 18.0),
        gap(4.0),
        body('CupertinoTextThemeData groups the typography slots Cupertino widgets pick up. '
            'Each specimen below shows the slot name, an iOS-like sample, and the resolved point size.'),
        gap(14.0),
        for (int i = 0; i < slots.length; i += 2) ...[
          Row(
            children: [
              Expanded(child: textSlotCard(slots[i])),
              hgap(10.0),
              Expanded(
                child: i + 1 < slots.length
                    ? textSlotCard(slots[i + 1])
                    : const SizedBox(),
              ),
            ],
          ),
          gap(10.0),
        ],
      ],
    ),
  );
}

// ============================================================================
// SECTION 8 — LIGHT VS DARK COMPARISON MOCKUP
// ============================================================================

Widget mockupNavBar({required Color bg, required Color fg, required Color tint, required String title}) {
  return Container(
    height: 44.0,
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    decoration: BoxDecoration(
      color: bg,
      border: Border(bottom: BorderSide(color: tint.withOpacity(0.12))),
    ),
    child: Row(
      children: [
        Icon(CupertinoIcons.back, color: tint, size: 22.0),
        const Spacer(),
        Text(title, style: TextStyle(fontSize: 17.0, color: fg, fontWeight: FontWeight.w600)),
        const Spacer(),
        Text('Done', style: TextStyle(fontSize: 17.0, color: tint, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

Widget mockupListTile({required Color bg, required Color fg, required Color sub, required Color tint, required IconData icon, required String title, required String value}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 11.0),
    decoration: BoxDecoration(
      color: bg,
      border: Border(bottom: BorderSide(color: tint.withOpacity(0.08))),
    ),
    child: Row(
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Icon(icon, color: Colors.white, size: 16.0),
        ),
        hgap(10.0),
        Expanded(child: Text(title, style: TextStyle(fontSize: 15.0, color: fg))),
        Text(value, style: TextStyle(fontSize: 14.0, color: sub)),
        hgap(4.0),
        Icon(CupertinoIcons.forward, color: sub, size: 16.0),
      ],
    ),
  );
}

Widget mockupCard({required bool dark}) {
  final bg = dark ? kDarkBg : kBackground;
  final surface = dark ? kDarkSurface : kSurface;
  final fg = dark ? Colors.white : kInk;
  final sub = dark ? const Color(0xFF8E8E93) : kInkSoft;
  final tint = dark ? const Color(0xFF0A84FF) : kAccent;
  return Container(
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(kRadius),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      children: [
        mockupNavBar(bg: surface, fg: fg, tint: tint, title: 'Settings'),
        mockupListTile(bg: surface, fg: fg, sub: sub, tint: tint, icon: CupertinoIcons.bell, title: 'Notifications', value: 'On'),
        mockupListTile(bg: surface, fg: fg, sub: sub, tint: const Color(0xFF34C759), icon: CupertinoIcons.wifi, title: 'Wi-Fi', value: 'Home'),
        mockupListTile(bg: surface, fg: fg, sub: sub, tint: const Color(0xFFFF9500), icon: CupertinoIcons.sun_max, title: 'Display', value: 'Auto'),
        mockupListTile(bg: surface, fg: fg, sub: sub, tint: const Color(0xFFAF52DE), icon: CupertinoIcons.person, title: 'Account', value: ''),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget brightnessComparison() {
  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('Brightness', color: kIndigo), hgap(8.0), pill('LIGHT vs DARK', color: kAccent)]),
        gap(10.0),
        heading('Same UI, two brightnesses', size: 18.0),
        gap(4.0),
        body('A mocked Settings page rendered under Brightness.light then Brightness.dark. '
            'Note how systemBlue shifts from #007AFF to #0A84FF and surface tones invert.'),
        gap(14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [pill('light', color: kWarning), hgap(6.0), subheading('Brightness.light')]),
                  gap(8.0),
                  mockupCard(dark: false),
                ],
              ),
            ),
            hgap(12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [pill('dark', color: kIndigo), hgap(6.0), subheading('Brightness.dark')]),
                  gap(8.0),
                  mockupCard(dark: true),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 9 — CUPERTINOLOCALIZATIONS ANATOMY
// ============================================================================

Widget localizationsAnatomy() {
  final loc = DefaultCupertinoLocalizations();
  final entries = <List<String>>[
    ['anteMeridiemAbbreviation', loc.anteMeridiemAbbreviation, 'AM marker'],
    ['postMeridiemAbbreviation', loc.postMeridiemAbbreviation, 'PM marker'],
    ['alertDialogLabel', loc.alertDialogLabel, 'Semantic label for CupertinoAlertDialog'],
    ['modalBarrierDismissLabel', loc.modalBarrierDismissLabel, 'Semantic label for tapping the modal barrier'],
    ['datePickerHourSemanticsLabel(14)', loc.datePickerHourSemanticsLabel(14), 'Semantic readout for picker hour'],
    ['datePickerMinuteSemanticsLabel(7)', loc.datePickerMinuteSemanticsLabel(7), 'Semantic readout for picker minute'],
    ['datePickerMediumDate(now)', loc.datePickerMediumDate(DateTime(2026, 1, 1)), 'Formatted medium date for picker'],
    ['datePickerDateOrder', loc.datePickerDateOrder.name, 'Order of month/day/year columns'],
    ['datePickerDateTimeOrder', loc.datePickerDateTimeOrder.name, 'Order of date/time blocks'],
    ['timerPickerHour(2)', loc.timerPickerHour(2), 'Timer hour column label'],
    ['timerPickerMinute(15)', loc.timerPickerMinute(15), 'Timer minute column label'],
    ['timerPickerSecond(30)', loc.timerPickerSecond(30), 'Timer second column label'],
    ['cutButtonLabel', loc.cutButtonLabel, 'Selection toolbar — cut'],
    ['copyButtonLabel', loc.copyButtonLabel, 'Selection toolbar — copy'],
    ['pasteButtonLabel', loc.pasteButtonLabel, 'Selection toolbar — paste'],
    ['selectAllButtonLabel', loc.selectAllButtonLabel, 'Selection toolbar — select all'],
  ];

  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('CupertinoLocalizations', color: kPurple), hgap(8.0), pill('DEFAULTS', color: kInkSoft)]),
        gap(10.0),
        heading('Default English values', size: 18.0),
        gap(4.0),
        body('DefaultCupertinoLocalizations is the en-US fallback. For other locales add '
            'GlobalCupertinoLocalizations.delegate to CupertinoApp.localizationsDelegates.'),
        gap(14.0),
        for (final e in entries) ...[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: kBorder)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 220.0,
                  child: Text(e[0], style: const TextStyle(fontFamily: 'Menlo', fontSize: 12.0, color: kAccent)),
                ),
                SizedBox(
                  width: 140.0,
                  child: Text(e[1], style: const TextStyle(fontSize: 13.0, color: kInk, fontWeight: FontWeight.w600)),
                ),
                Expanded(child: body(e[2], color: kInkSoft)),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}

// ============================================================================
// SECTION 10 — CUPERTINOACTIVITYINDICATOR SHOWCASE
// ============================================================================

Widget indicatorSpec(String label, Widget indicator, List<String> params) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(kRadius),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13.0, color: kInk, fontWeight: FontWeight.w700)),
        gap(12.0),
        Center(child: SizedBox(height: 60.0, child: indicator)),
        gap(12.0),
        for (final p in params)
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: mono(p, color: kInkMuted, size: 11.0),
          ),
      ],
    ),
  );
}

Widget activityIndicatorShowcase() {
  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('CupertinoActivityIndicator', color: kAccent), hgap(8.0), pill('SPINNER', color: kInkSoft)]),
        gap(10.0),
        heading('Static snapshots of four configurations', size: 18.0),
        gap(4.0),
        body('CupertinoActivityIndicator renders a rotating spoke spinner. '
            'partiallyRevealed: true + progress: 0..1 freezes it as a progress indicator.'),
        gap(14.0),
        Row(
          children: [
            Expanded(
              child: indicatorSpec(
                'Default',
                const CupertinoActivityIndicator(),
                ['radius: 10.0 (default)', 'animating: true (default)'],
              ),
            ),
            hgap(10.0),
            Expanded(
              child: indicatorSpec(
                'Larger radius',
                const CupertinoActivityIndicator(radius: 18.0),
                ['radius: 18.0'],
              ),
            ),
          ],
        ),
        gap(10.0),
        Row(
          children: [
            Expanded(
              child: indicatorSpec(
                'Tinted',
                const CupertinoActivityIndicator(color: kDestructive),
                ['color: systemRed'],
              ),
            ),
            hgap(10.0),
            Expanded(
              child: indicatorSpec(
                'Partially revealed',
                const CupertinoActivityIndicator.partiallyRevealed(progress: 0.5),
                ['partiallyRevealed: true', 'progress: 0.5'],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 11 — CUPERTINOLISTSECTION DEMO
// ============================================================================

Widget listSectionDemo() {
  Widget tile({required IconData icon, required Color tint, required String title, required String subtitle, String? trailing}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: kBorder))),
      child: Row(
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(color: tint, borderRadius: BorderRadius.circular(7.0)),
            child: Icon(icon, color: Colors.white, size: 17.0),
          ),
          hgap(12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15.5, color: kInk)),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: const TextStyle(fontSize: 12.0, color: kInkSoft)),
              ],
            ),
          ),
          if (trailing != null) Text(trailing, style: const TextStyle(fontSize: 14.0, color: kInkSoft)),
          hgap(6.0),
          const Icon(CupertinoIcons.forward, color: kInkFaint, size: 16.0),
        ],
      ),
    );
  }

  Widget sectionBlock({required String header, required String footer, required List<Widget> tiles, required bool insetGrouped}) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: kSurfaceAlt,
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              pill(insetGrouped ? 'INSET GROUPED' : 'BASE', color: insetGrouped ? kAccent : kInkSoft),
            ],
          ),
          gap(10.0),
          Text(header.toUpperCase(), style: const TextStyle(fontSize: 12.0, color: kInkSoft, letterSpacing: 0.5)),
          gap(6.0),
          Container(
            decoration: BoxDecoration(
              color: kSurface,
              borderRadius: BorderRadius.circular(insetGrouped ? 10.0 : 0.0),
              border: Border.all(color: kBorder),
            ),
            child: Column(children: tiles),
          ),
          gap(6.0),
          Text(footer, style: const TextStyle(fontSize: 11.5, color: kInkSoft)),
        ],
      ),
    );
  }

  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('CupertinoListSection', color: kAccent), hgap(8.0), pill('CupertinoListTile', color: kIndigo)]),
        gap(10.0),
        heading('Two styles of grouped lists', size: 18.0),
        gap(4.0),
        body('CupertinoListSection has two flavours — base (full-bleed) and insetGrouped '
            '(rounded inset card). Each contains CupertinoListTile children with the usual '
            'leading/title/subtitle/trailing/additionalInfo slots.'),
        gap(14.0),
        sectionBlock(
          insetGrouped: true,
          header: 'Connectivity',
          footer: 'Inset grouped style with rounded children, used on Settings-style screens.',
          tiles: [
            tile(icon: CupertinoIcons.wifi, tint: kAccent, title: 'Wi-Fi', subtitle: 'Home network', trailing: 'On'),
            tile(icon: CupertinoIcons.bluetooth, tint: kIndigo, title: 'Bluetooth', subtitle: '2 paired devices', trailing: 'On'),
            tile(icon: CupertinoIcons.antenna_radiowaves_left_right, tint: kSuccess, title: 'Cellular', subtitle: 'LTE', trailing: '4 bars'),
          ],
        ),
        gap(14.0),
        sectionBlock(
          insetGrouped: false,
          header: 'Devices',
          footer: 'Base style with full-bleed children, common in master lists.',
          tiles: [
            tile(icon: CupertinoIcons.device_phone_portrait, tint: kPurple, title: 'iPhone', subtitle: 'iOS 18.0', trailing: 'This device'),
            tile(icon: CupertinoIcons.device_laptop, tint: kTeal, title: 'MacBook Pro', subtitle: 'macOS 15', trailing: 'Active'),
            tile(icon: CupertinoIcons.tv, tint: kWarning, title: 'Apple TV', subtitle: 'tvOS 18', trailing: 'Idle'),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 12 — MEDIAQUERYDATA iOS CONTEXT
// ============================================================================

Widget mediaQueryCard(BuildContext context) {
  final mq = MediaQuery.maybeOf(context);
  final size = mq?.size;
  final scaler = mq?.textScaler ?? const TextScaler.linear(1.0);
  final brightness = mq?.platformBrightness ?? Brightness.light;

  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('MediaQueryData', color: kPurple), hgap(8.0), pill('iOS TRAITS', color: kInkSoft)]),
        gap(10.0),
        heading('Cupertino-relevant MediaQuery slots', size: 18.0),
        gap(4.0),
        body('Cupertino widgets read several MediaQuery slots to adapt — '
            'platformBrightness drives dynamic colors, alwaysUse24HourFormat changes the '
            'time picker, textScaler scales nav titles, accessibleNavigation flips behaviour.'),
        gap(14.0),
        kv('size', size == null ? 'unknown' : '${size.width.toStringAsFixed(1)} × ${size.height.toStringAsFixed(1)}'),
        kv('platformBrightness', brightness.name),
        kv('alwaysUse24HourFormat', '${mq?.alwaysUse24HourFormat ?? false}'),
        kv('textScaler.scale(17)', scaler.scale(17.0).toStringAsFixed(2)),
        kv('accessibleNavigation', '${mq?.accessibleNavigation ?? false}'),
        kv('boldText', '${mq?.boldText ?? false}'),
        kv('disableAnimations', '${mq?.disableAnimations ?? false}'),
        kv('highContrast', '${mq?.highContrast ?? false}'),
        kv('invertColors', '${mq?.invertColors ?? false}'),
        kv('navigationMode', mq?.navigationMode.name ?? 'traditional'),
        kv('viewPadding.top', mq?.viewPadding.top.toStringAsFixed(1) ?? '0.0'),
        kv('viewInsets.bottom', mq?.viewInsets.bottom.toStringAsFixed(1) ?? '0.0'),
      ],
    ),
  );
}

// ============================================================================
// SECTION 13 — RECIPE CARDS
// ============================================================================

Widget recipeCard(String title, String tagline, List<String> steps, {Color accent = kAccent}) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(kRadius),
      border: Border.all(color: kBorder),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('RECIPE', color: accent)]),
        gap(8.0),
        Text(title, style: const TextStyle(fontSize: 15.0, color: kInk, fontWeight: FontWeight.w700)),
        gap(4.0),
        body(tagline, color: kInkSoft),
        gap(10.0),
        for (int i = 0; i < steps.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4.0, right: 8.0),
                  width: 6.0,
                  height: 6.0,
                  decoration: BoxDecoration(color: accent, borderRadius: BorderRadius.circular(3.0)),
                ),
                Expanded(child: body(steps[i])),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget recipesGrid() {
  final recipes = <Widget>[
    recipeCard(
      'Themed nav bar',
      'Tint nav-bar title + back chevron using a CupertinoTheme.',
      [
        'Wrap subtree in CupertinoTheme with primaryColor: systemBlue.',
        'Use CupertinoNavigationBar; it reads primaryColor for the chevron.',
        'Provide middle: Text(title) — picks up navTitleTextStyle.',
      ],
    ),
    recipeCard(
      'Dark mode toggle',
      'Provide a per-screen brightness without changing the OS theme.',
      [
        'Add CupertinoTheme with brightness: Brightness.dark at the root.',
        'Wrap MediaQuery with platformBrightness override if you need dynamic colors to follow.',
        'Avoid hardcoded white/black — use CupertinoColors.label.resolveFrom(context).',
      ],
      accent: kIndigo,
    ),
    recipeCard(
      'Localized date picker label',
      'Override DefaultCupertinoLocalizations for non-English builds.',
      [
        'Add GlobalCupertinoLocalizations.delegate to CupertinoApp delegates.',
        'Supply supportedLocales including the target locale.',
        'CupertinoDatePicker will localise month/day strings automatically.',
      ],
      accent: kPurple,
    ),
    recipeCard(
      'Tap-to-dismiss modal',
      'Use modalBarrierDismissLabel for accessibility.',
      [
        'showCupertinoModalPopup(... barrierDismissible: true).',
        'The barrier announces CupertinoLocalizations.modalBarrierDismissLabel.',
        'Provide your own delegate if you need a custom label.',
      ],
      accent: kWarning,
    ),
    recipeCard(
      'iOS-styled segmented control wrapper',
      'Compose CupertinoSlidingSegmentedControl with theme tokens.',
      [
        'Wrap children Map<int, Widget> with Padding for legible labels.',
        'Use CupertinoTheme.of(context).primaryColor as thumbColor.',
        'Lift state to a controller-less parent so groupValue stays stable.',
      ],
      accent: kSuccess,
    ),
    recipeCard(
      'Icon button with destructive color',
      'Compose CupertinoButton with destructiveRed.',
      [
        'CupertinoButton(child: Icon(CupertinoIcons.trash, color: systemRed.resolveFrom(ctx))).',
        'For dialogs use CupertinoDialogAction(isDestructiveAction: true).',
        'Always pair with a confirmation modal — destructive actions need a second tap.',
      ],
      accent: kDestructive,
    ),
  ];
  final out = <Widget>[];
  for (int i = 0; i < recipes.length; i += 2) {
    out.add(Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: recipes[i]),
          hgap(10.0),
          Expanded(child: i + 1 < recipes.length ? recipes[i + 1] : const SizedBox()),
        ],
      ),
    ));
  }
  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('RECIPES', color: kAccent), hgap(8.0), pill('SIX SNIPPETS', color: kInkSoft)]),
        gap(10.0),
        heading('Six small recipes', size: 18.0),
        gap(4.0),
        body('Each recipe pairs a one-line tagline with three concrete steps. '
            'They cover the most-asked iOS theming and localisation questions.'),
        gap(14.0),
        ...out,
      ],
    ),
  );
}

// ============================================================================
// SECTION 14 — COMPARISON TABLE
// ============================================================================

Widget comparisonTable() {
  final rows = <List<String>>[
    ['CupertinoColors', 'ColorScheme', 'Cupertino exposes named dynamic colors that resolve from context; Material composes them into a scheme.'],
    ['CupertinoDynamicColor', 'MaterialStateColor', 'Both encode trait-dependent variants; CupertinoDynamicColor keys on brightness/contrast/elevation, MaterialStateColor on widget states.'],
    ['CupertinoIcons', 'Icons', 'Different icon font; CupertinoIcons is line-style at one weight, Icons supports filled/outlined/rounded.'],
    ['CupertinoTheme', 'Theme', 'CupertinoTheme is leaner — no MaterialState plumbing, no elevation overlay, no implicit ColorScheme.'],
    ['CupertinoThemeData', 'ThemeData', 'CupertinoThemeData has ~7 slots vs ThemeData\'s ~50; applyThemeToAll bridges to Material.'],
    ['CupertinoTextThemeData', 'TextTheme', 'Cupertino names slots by *use* (navTitle, picker) rather than by *size* (headlineLarge).'],
    ['CupertinoLocalizations', 'MaterialLocalizations', 'Same idea; Cupertino adds picker semantics labels.'],
    ['CupertinoActivityIndicator', 'CircularProgressIndicator', 'Cupertino renders spokes, Material renders an arc; partiallyRevealed gives Cupertino a determinate mode.'],
    ['CupertinoListSection', 'ListView / Card', 'CupertinoListSection bakes in header/footer/grouped style; Material composes separately.'],
  ];
  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('CROSS-WALK', color: kIndigo), hgap(8.0), pill('CUPERTINO × MATERIAL', color: kAccent)]),
        gap(10.0),
        heading('Cupertino concept ↔ Material counterpart', size: 18.0),
        gap(14.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
          decoration: BoxDecoration(color: kSurfaceAlt, borderRadius: BorderRadius.circular(8.0)),
          child: Row(
            children: const [
              SizedBox(width: 200.0, child: Text('Cupertino', style: TextStyle(fontSize: 12.0, color: kAccent, fontWeight: FontWeight.w700))),
              SizedBox(width: 200.0, child: Text('Material', style: TextStyle(fontSize: 12.0, color: kInkMuted, fontWeight: FontWeight.w700))),
              Expanded(child: Text('Key difference', style: TextStyle(fontSize: 12.0, color: kInkSoft, fontWeight: FontWeight.w700))),
            ],
          ),
        ),
        for (final r in rows) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 200.0, child: Text(r[0], style: const TextStyle(fontSize: 12.5, color: kInk, fontWeight: FontWeight.w600))),
                SizedBox(width: 200.0, child: Text(r[1], style: const TextStyle(fontSize: 12.5, color: kInkMuted))),
                Expanded(child: body(r[2])),
              ],
            ),
          ),
          divider(),
        ],
      ],
    ),
  );
}

// ============================================================================
// SECTION 15 — PITFALLS
// ============================================================================

Widget pitfall(String title, String body_, String fix) {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kSurface,
      borderRadius: BorderRadius.circular(kRadius),
      border: Border.all(color: kDestructive.withOpacity(0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(CupertinoIcons.exclamationmark_triangle_fill, color: kWarning, size: 18.0),
            hgap(8.0),
            Expanded(child: Text(title, style: const TextStyle(fontSize: 14.0, color: kInk, fontWeight: FontWeight.w700))),
          ],
        ),
        gap(8.0),
        body(body_),
        gap(8.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(color: kAccentSoft, borderRadius: BorderRadius.circular(8.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(CupertinoIcons.checkmark_alt_circle_fill, color: kAccent, size: 16.0),
              hgap(8.0),
              Expanded(child: Text(fix, style: const TextStyle(fontSize: 12.5, color: kInk, height: 1.4))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget pitfallsCard() {
  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('PITFALLS', color: kDestructive), hgap(8.0), pill('GOTCHAS', color: kWarning)]),
        gap(10.0),
        heading('Common mistakes and fixes', size: 18.0),
        gap(14.0),
        pitfall(
          'Using CupertinoColors.systemBlue as a raw Color',
          'systemBlue is a CupertinoDynamicColor — the raw value is only its light/normal variant. '
          'In dark mode you get the wrong shade and high-contrast traits are ignored.',
          'Always call .resolveFrom(context) before passing to Color slots that don\'t auto-resolve, '
          'or place the widget under a CupertinoTheme that owns the resolution.',
        ),
        gap(10.0),
        pitfall(
          'Reading CupertinoTheme.of(context) without a CupertinoTheme ancestor',
          'CupertinoTheme.of(context) returns a fallback CupertinoThemeData if no ancestor exists. '
          'You will not get a runtime error, but your nav-bar tint won\'t match what you set elsewhere.',
          'Always wrap your subtree in either CupertinoApp (which inserts a CupertinoTheme) or a manual CupertinoTheme.',
        ),
        gap(10.0),
        pitfall(
          'Forgetting the cupertino_icons font asset',
          'CupertinoIcons constants reference glyphs in the cupertino_icons font. If the font isn\'t '
          'included as a Flutter package + asset, every CupertinoIcons.* renders as the Unicode replacement glyph.',
          'Add cupertino_icons to pubspec.yaml dependencies. The default flutter create template already does this.',
        ),
        gap(10.0),
        pitfall(
          'Building CupertinoDatePicker without a CupertinoLocalizations',
          'Without a localizations ancestor the picker uses DefaultCupertinoLocalizations (en-US only). '
          'Month names and date order will be wrong for other locales.',
          'Add GlobalCupertinoLocalizations.delegate to your CupertinoApp.localizationsDelegates list '
          'and include the target locale in supportedLocales.',
        ),
        gap(10.0),
        pitfall(
          'Animating CupertinoActivityIndicator with a controller',
          'The indicator already animates internally when animating: true. Wrapping it in an AnimatedBuilder '
          'or driving it from a controller does nothing useful and can confuse the framework.',
          'Use the default constructor and let it manage its own ticker; use .partiallyRevealed for static progress instead.',
        ),
      ],
    ),
  );
}

// ============================================================================
// SECTION 16 — GLOSSARY
// ============================================================================

Widget glossaryEntry(String term, String def) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(color: kAccent, borderRadius: BorderRadius.circular(3.0)),
            ),
            hgap(8.0),
            Text(term, style: const TextStyle(fontSize: 14.0, color: kInk, fontWeight: FontWeight.w700)),
          ],
        ),
        gap(2.0),
        Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: body(def, color: kInkMuted),
        ),
      ],
    ),
  );
}

Widget glossaryCard() {
  return card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [pill('GLOSSARY', color: kIndigo), hgap(8.0), pill('SIXTEEN TERMS', color: kInkSoft)]),
        gap(10.0),
        heading('Vocabulary you\'ll see in the Cupertino library', size: 18.0),
        gap(14.0),
        glossaryEntry('CupertinoColors', 'Static class of named iOS color tokens; most are CupertinoDynamicColor.'),
        glossaryEntry('CupertinoDynamicColor', 'Color that resolves to a different value based on brightness, accessibility-contrast and elevation traits.'),
        glossaryEntry('CupertinoIcons', 'Static class of IconData glyphs from the cupertino_icons font.'),
        glossaryEntry('CupertinoTheme', 'InheritedWidget exposing a CupertinoThemeData; analogous to Theme for Material.'),
        glossaryEntry('CupertinoThemeData', 'Immutable struct of theme slots (primaryColor, barBackgroundColor, textTheme, etc.).'),
        glossaryEntry('CupertinoTextThemeData', 'Group of TextStyles used by Cupertino widgets for nav, picker and selection text.'),
        glossaryEntry('CupertinoLocalizations', 'Abstract class of localised strings/getters used by Cupertino widgets.'),
        glossaryEntry('DefaultCupertinoLocalizations', 'Concrete en-US implementation of CupertinoLocalizations used as a fallback.'),
        glossaryEntry('CupertinoActivityIndicator', 'iOS-style spinner with optional partiallyRevealed determinate mode.'),
        glossaryEntry('CupertinoListSection', 'Grouped list container with header, footer and rounded corners (insetGrouped variant).'),
        glossaryEntry('CupertinoListTile', 'Row used inside CupertinoListSection — leading/title/subtitle/trailing/additionalInfo slots.'),
        glossaryEntry('CupertinoDatePicker', 'Rotating-wheel date and time picker; reads from CupertinoLocalizations.'),
        glossaryEntry('CupertinoTimerPicker', 'Hour/minute/second wheel picker used for countdowns.'),
        glossaryEntry('CupertinoPicker', 'Generic wheel picker; CupertinoDatePicker and CupertinoTimerPicker are built on top.'),
        glossaryEntry('MediaQuery', 'InheritedWidget exposing screen and accessibility metrics; Cupertino reads platformBrightness and textScaler.'),
        glossaryEntry('Brightness', 'Enum (light, dark); drives CupertinoDynamicColor resolution and most colour decisions.'),
      ],
    ),
  );
}

// ============================================================================
// SECTION 17 — EPILOGUE
// ============================================================================

Widget epilogueCard() {
  return Container(
    padding: const EdgeInsets.all(kPadLarge),
    decoration: BoxDecoration(
      color: kInk,
      borderRadius: BorderRadius.circular(kRadiusLg),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text('END', style: TextStyle(fontSize: 11.0, color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
            ),
            hgap(8.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: kAccent,
                borderRadius: BorderRadius.circular(999.0),
              ),
              child: const Text('17/17', style: TextStyle(fontSize: 11.0, color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 1.2)),
            ),
          ],
        ),
        gap(14.0),
        const Text(
          'Cupertino is small but precise',
          style: TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: -0.6),
        ),
        gap(6.0),
        Text(
          'You\'ve walked the named colors, the trait-dependent dynamic colors, the icon font, '
          'the theme slots, the eight text styles, the default localizations, the activity '
          'indicator and the list section. Combined they give you the visual vocabulary to '
          'build an iOS-faithful screen with no Material leakage. Reach for system* tokens, '
          'wrap in CupertinoTheme, add the localizations delegate, and let the picker wheels '
          'do the heavy lifting.',
          style: TextStyle(fontSize: 13.5, color: Colors.white.withOpacity(0.85), height: 1.55),
        ),
        gap(16.0),
        Row(
          children: [
            const Icon(CupertinoIcons.checkmark_seal_fill, color: kSuccess, size: 18.0),
            hgap(8.0),
            const Text('Field guide complete', style: TextStyle(fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    ),
  );
}

// ============================================================================
// MAIN BUILD
// ============================================================================

dynamic build(BuildContext context) {
  print('Cupertino misc advanced field guide rendering');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kPad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1
              heroHeader(),

              // Section 2
              sectionTitle(2, 'Cupertino vs Material', note: 'Where the two design languages diverge'),
              overviewCard(),

              // Section 3
              sectionTitle(3, 'CupertinoColors catalog', note: 'Twenty-four named tokens with hex values'),
              colorsCatalog(),

              // Section 4
              sectionTitle(4, 'CupertinoDynamicColor', note: 'One name, four trait-dependent resolutions'),
              dynamicColorShowcase(),

              // Section 5
              sectionTitle(5, 'CupertinoIcons catalog', note: 'Thirty representative glyphs from the iOS icon font'),
              iconsCatalog(),

              // Section 6
              sectionTitle(6, 'CupertinoTheme & CupertinoThemeData', note: 'Every slot, plus a nested override specimen'),
              themeAnatomy(),

              // Section 7
              sectionTitle(7, 'CupertinoTextThemeData', note: 'Eight typography slots with rendered samples'),
              textThemeSpecimens(),

              // Section 8
              sectionTitle(8, 'Brightness comparison', note: 'Light vs dark renderings of the same screen'),
              brightnessComparison(),

              // Section 9
              sectionTitle(9, 'CupertinoLocalizations', note: 'DefaultCupertinoLocalizations getters and their resolved values'),
              localizationsAnatomy(),

              // Section 10
              sectionTitle(10, 'CupertinoActivityIndicator', note: 'Four static configurations of the iOS spinner'),
              activityIndicatorShowcase(),

              // Section 11
              sectionTitle(11, 'CupertinoListSection', note: 'Inset-grouped and base flavours with CupertinoListTile children'),
              listSectionDemo(),

              // Section 12
              sectionTitle(12, 'MediaQuery iOS context', note: 'Slots Cupertino widgets read to adapt'),
              Builder(builder: (ctx) => mediaQueryCard(ctx)),

              // Section 13
              sectionTitle(13, 'Recipes', note: 'Six small, copy-pasteable patterns'),
              recipesGrid(),

              // Section 14
              sectionTitle(14, 'Cross-walk to Material', note: 'Each Cupertino concept aligned with its Material counterpart'),
              comparisonTable(),

              // Section 15
              sectionTitle(15, 'Pitfalls', note: 'Mistakes that compile but render wrong'),
              pitfallsCard(),

              // Section 16
              sectionTitle(16, 'Glossary', note: 'Sixteen terms you\'ll see in the cupertino.dart library'),
              glossaryCard(),

              // Section 17
              gap(kPadLarge),
              epilogueCard(),
              gap(kPad),
            ],
          ),
        ),
      ),
    ),
  );
}
