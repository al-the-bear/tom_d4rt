// D4rt test script: Deep Demo - CupertinoThemeData / CupertinoTheme
// Comprehensive visual exploration of every CupertinoThemeData knob:
// brightness, primaryColor, primaryContrastingColor, scaffoldBackgroundColor,
// barBackgroundColor, applyThemeToAll, and the full CupertinoTextThemeData
// including textStyle, actionTextStyle, tabLabelTextStyle, navTitleTextStyle,
// navLargeTitleTextStyle, navActionTextStyle, pickerTextStyle, and
// dateTimePickerTextStyle. Sections build progressively from defaults to
// custom-built themes with nested CupertinoTheme widgets and side-by-side
// light/dark previews.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // PALETTE — color constants used everywhere
  // ===========================================================================

  const Color paletteInk = Color(0xFF101225);
  const Color paletteInkSoft = Color(0xFF3C3F58);
  const Color paletteMist = Color(0xFFF4F5FA);
  const Color paletteCloud = Color(0xFFE7E9F2);
  const Color paletteOutline = Color(0xFFCFD3E2);
  const Color paletteAccent = Color(0xFF0A84FF);
  const Color paletteAccentSoft = Color(0xFFDDEAFF);
  const Color paletteIndigo = Color(0xFF5856D6);
  const Color paletteIndigoSoft = Color(0xFFE5E4FF);
  const Color paletteTeal = Color(0xFF30B0C7);
  const Color paletteTealSoft = Color(0xFFDDF3F7);
  const Color paletteMint = Color(0xFF00C7BE);
  const Color paletteMintSoft = Color(0xFFD9F6F4);
  const Color paletteRose = Color(0xFFFF375F);
  const Color paletteRoseSoft = Color(0xFFFFE0E6);
  const Color paletteAmber = Color(0xFFFF9F0A);
  const Color paletteAmberSoft = Color(0xFFFFEBD0);
  const Color palettePurple = Color(0xFFAF52DE);
  const Color palettePurpleSoft = Color(0xFFF1E3FA);
  const Color paletteGraphite = Color(0xFF2B2D42);
  const Color paletteGraphiteSoft = Color(0xFFE4E5EC);
  const Color paletteForest = Color(0xFF248A3D);
  const Color paletteForestSoft = Color(0xFFDBF1DF);
  const Color paletteSlate = Color(0xFF8E8E93);
  const Color paletteNightBg = Color(0xFF111322);
  const Color paletteNightCard = Color(0xFF1B1E33);
  const Color paletteNightOutline = Color(0xFF323553);

  // ===========================================================================
  // SECTION SHELL helper — required by spec
  // ===========================================================================

  Widget sectionShell({
    required String title,
    required String subtitle,
    required Color surface,
    required Color border,
    required Color titleColor,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 14.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: border, width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: titleColor.withValues(alpha: 0.10),
            blurRadius: 16.0,
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
                width: 8.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: titleColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 4.0),
            child: Text(
              subtitle,
              style: TextStyle(
                color: titleColor.withValues(alpha: 0.78),
                fontSize: 13.0,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          child,
        ],
      ),
    );
  }

  // ===========================================================================
  // SECONDARY HELPERS
  // ===========================================================================

  Widget badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget keyValueRow(String key, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160.0,
            child: Text(
              key,
              style: TextStyle(
                color: color.withValues(alpha: 0.72),
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                fontFamilyFallback: const <String>['monospace'],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget swatch(String label, Color color, {Color? textColor}) {
    final Color text = textColor ?? Colors.white;
    return Container(
      width: 110.0,
      height: 78.0,
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: text,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          Text(
            '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
            style: TextStyle(
              color: text.withValues(alpha: 0.86),
              fontSize: 10.5,
              fontFamilyFallback: const <String>['monospace'],
            ),
          ),
        ],
      ),
    );
  }

  Widget previewFrame({
    required String label,
    required Color labelColor,
    required Color borderColor,
    required Color background,
    required Widget child,
    double height = 220.0,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: borderColor, width: 1.2),
        color: background,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: labelColor.withValues(alpha: 0.08),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: labelColor.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: labelColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  label,
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  // A miniature preview row of common Cupertino controls themed by ancestor.
  Widget sampleControls({bool darkBg = false}) {
    final Color label = darkBg ? Colors.white : paletteInk;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const CupertinoActivityIndicator(radius: 12.0),
              const SizedBox(width: 12.0),
              CupertinoButton.filled(
                onPressed: () {},
                child: const Text('Confirm'),
              ),
              const SizedBox(width: 10.0),
              CupertinoButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: <Widget>[
              const CupertinoSwitch(value: true, onChanged: null),
              const SizedBox(width: 14.0),
              const CupertinoSwitch(value: false, onChanged: null),
              const SizedBox(width: 14.0),
              Expanded(
                child: CupertinoSlider(
                  value: 0.55,
                  onChanged: (double _) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            'Inherited from CupertinoTheme',
            style: TextStyle(
              color: label.withValues(alpha: 0.72),
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget mockNavBar({
    required String title,
    required Color barColor,
    required Color textColor,
    required Color actionColor,
  }) {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: barColor,
        border: Border(
          bottom: BorderSide(
            color: textColor.withValues(alpha: 0.12),
            width: 0.6,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            CupertinoIcons.back,
            color: actionColor,
            size: 22.0,
          ),
          const SizedBox(width: 4.0),
          Text(
            'Back',
            style: TextStyle(
              color: actionColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          Icon(
            CupertinoIcons.share,
            color: actionColor,
            size: 22.0,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // HERO BANNER
  // ===========================================================================

  final Widget heroBanner = Container(
    margin: const EdgeInsets.only(bottom: 6.0),
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
      borderRadius: BorderRadius.circular(22.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 22.0,
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
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.55),
                  width: 1.4,
                ),
              ),
              child: const Icon(
                CupertinoIcons.paintbrush_fill,
                color: Colors.white,
                size: 38.0,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'CupertinoThemeData — Deep Demo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'brightness · primaryColor · primaryContrastingColor · '
                    'scaffoldBackgroundColor · barBackgroundColor · '
                    'applyThemeToAll · the full CupertinoTextThemeData.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            badge('CupertinoTheme', Colors.white),
            badge('CupertinoThemeData', Colors.white),
            badge('CupertinoTextThemeData', Colors.white),
            badge('Brightness', Colors.white),
            badge('primaryColor', Colors.white),
            badge('applyThemeToAll', Colors.white),
            badge('nav*TextStyle', Colors.white),
            badge('pickerTextStyle', Colors.white),
          ],
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 1 — LIGHT THEME DEFAULTS
  // ===========================================================================

  const CupertinoThemeData lightDefaults = CupertinoThemeData(
    brightness: Brightness.light,
  );

  final Widget section1 = sectionShell(
    title: '01 · Light theme defaults',
    subtitle:
        'CupertinoThemeData(brightness: Brightness.light) yields the canonical '
        'iOS light look: white scaffold, dynamic system blue primary, and the '
        'standard CupertinoTextThemeData with the SF Pro fallback stack.',
    surface: paletteMist,
    border: paletteOutline,
    titleColor: paletteAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Wrap(
          children: <Widget>[],
        ),
        Wrap(
          children: <Widget>[
            swatch('primary', CupertinoColors.activeBlue),
            swatch('contrast', CupertinoColors.white, textColor: paletteInk),
            swatch('scaffold', paletteMist, textColor: paletteInk),
            swatch('bar', paletteCloud, textColor: paletteInk),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: paletteOutline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              keyValueRow(
                'brightness',
                lightDefaults.brightness.toString(),
                paletteInk,
              ),
              keyValueRow(
                'primaryColor',
                'CupertinoColors.activeBlue (default)',
                paletteInk,
              ),
              keyValueRow(
                'primaryContrastingColor',
                'CupertinoColors.white (default)',
                paletteInk,
              ),
              keyValueRow(
                'scaffoldBackgroundColor',
                'CupertinoColors.systemBackground',
                paletteInk,
              ),
              keyValueRow(
                'barBackgroundColor',
                'CupertinoColors.systemFill (resolved)',
                paletteInk,
              ),
              keyValueRow('applyThemeToAll', 'false (default)', paletteInk),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        previewFrame(
          label: 'Light default preview',
          labelColor: paletteAccent,
          borderColor: paletteOutline,
          background: Colors.white,
          child: CupertinoTheme(
            data: lightDefaults,
            child: sampleControls(),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 2 — DARK THEME DEFAULTS
  // ===========================================================================

  const CupertinoThemeData darkDefaults = CupertinoThemeData(
    brightness: Brightness.dark,
  );

  final Widget section2 = sectionShell(
    title: '02 · Dark theme defaults',
    subtitle:
        'Switching brightness to Brightness.dark flips every dynamic color: '
        'black scaffold, slightly translucent dark bars, and CupertinoColors '
        'resolves all of its dynamic tokens to their dark variants.',
    surface: paletteNightBg,
    border: paletteNightOutline,
    titleColor: paletteAccent,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          children: <Widget>[
            swatch('primary', CupertinoColors.activeBlue),
            swatch('contrast', Colors.black, textColor: Colors.white),
            swatch('scaffold', Colors.black, textColor: Colors.white),
            swatch(
              'bar',
              paletteNightCard,
              textColor: Colors.white,
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: paletteNightCard,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: paletteNightOutline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              keyValueRow(
                'brightness',
                darkDefaults.brightness.toString(),
                Colors.white,
              ),
              keyValueRow(
                'primaryColor',
                'CupertinoColors.activeBlue (dark variant)',
                Colors.white,
              ),
              keyValueRow(
                'primaryContrastingColor',
                'CupertinoColors.black (default)',
                Colors.white,
              ),
              keyValueRow(
                'scaffoldBackgroundColor',
                'CupertinoColors.systemBackground (dark)',
                Colors.white,
              ),
              keyValueRow(
                'barBackgroundColor',
                'CupertinoColors.systemFill (dark)',
                Colors.white,
              ),
              keyValueRow(
                'applyThemeToAll',
                'false (default)',
                Colors.white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        previewFrame(
          label: 'Dark default preview',
          labelColor: paletteAccent,
          borderColor: paletteNightOutline,
          background: Colors.black,
          child: CupertinoTheme(
            data: darkDefaults,
            child: sampleControls(darkBg: true),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 3 — primaryColor VARIATIONS
  // ===========================================================================

  final List<Map<String, dynamic>> primaryVariants = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'Active Blue',
      'color': paletteAccent,
      'soft': paletteAccentSoft,
    },
    <String, dynamic>{
      'name': 'Indigo',
      'color': paletteIndigo,
      'soft': paletteIndigoSoft,
    },
    <String, dynamic>{
      'name': 'Teal',
      'color': paletteTeal,
      'soft': paletteTealSoft,
    },
    <String, dynamic>{
      'name': 'Mint',
      'color': paletteMint,
      'soft': paletteMintSoft,
    },
    <String, dynamic>{
      'name': 'Rose',
      'color': paletteRose,
      'soft': paletteRoseSoft,
    },
    <String, dynamic>{
      'name': 'Amber',
      'color': paletteAmber,
      'soft': paletteAmberSoft,
    },
    <String, dynamic>{
      'name': 'Purple',
      'color': palettePurple,
      'soft': palettePurpleSoft,
    },
    <String, dynamic>{
      'name': 'Forest',
      'color': paletteForest,
      'soft': paletteForestSoft,
    },
  ];

  final List<Widget> primaryVariantTiles = List<Widget>.generate(
    primaryVariants.length,
    (int i) {
      final Map<String, dynamic> spec = primaryVariants[i];
      final Color color = spec['color'] as Color;
      final Color soft = spec['soft'] as Color;
      final String name = spec['name'] as String;
      final CupertinoThemeData themeData = CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: color,
      );
      return Container(
        width: 220.0,
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.45), width: 1.2),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 10.0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13.0),
                  topRight: Radius.circular(13.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      '#${color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CupertinoTheme(
                data: themeData,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 6.0,
                      ),
                      onPressed: () {},
                      child: const Text('Filled'),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        const CupertinoSwitch(value: true, onChanged: null),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: CupertinoSlider(
                            value: 0.45,
                            onChanged: (double _) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: soft,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(13.0),
                  bottomRight: Radius.circular(13.0),
                ),
              ),
              child: Text(
                'primaryColor applies to filled buttons, switches, sliders, '
                'and link-like CupertinoButton text.',
                style: TextStyle(
                  color: color,
                  fontSize: 11.0,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  final Widget section3 = sectionShell(
    title: '03 · primaryColor variations',
    subtitle:
        'primaryColor is the single most expressive knob on CupertinoThemeData. '
        'It tints CupertinoButton.filled, CupertinoSwitch (on), CupertinoSlider '
        '(active track + thumb), and the default text color of plain '
        'CupertinoButton widgets that act as links.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteIndigo,
    child: Wrap(
      alignment: WrapAlignment.start,
      children: primaryVariantTiles,
    ),
  );

  // ===========================================================================
  // SECTION 4 — scaffoldBackgroundColor
  // ===========================================================================

  final List<Map<String, dynamic>> scaffoldVariants = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'Pure white',
      'color': const Color(0xFFFFFFFF),
      'note':
          'Default light scaffold — bright, neutral, used for content-heavy '
          'screens.',
    },
    <String, dynamic>{
      'label': 'Mist',
      'color': paletteMist,
      'note':
          'A near-white off-tone that reduces glare in long form screens.',
    },
    <String, dynamic>{
      'label': 'Cloud',
      'color': paletteCloud,
      'note': 'Cooler than Mist — great for grouped list backgrounds.',
    },
    <String, dynamic>{
      'label': 'Graphite',
      'color': paletteGraphiteSoft,
      'note':
          'Warm gray that hints at the brand without committing to dark mode.',
    },
    <String, dynamic>{
      'label': 'Night bg',
      'color': paletteNightBg,
      'note':
          'Dark-mode-friendly background even when brightness stays light.',
    },
    <String, dynamic>{
      'label': 'Ink',
      'color': paletteInk,
      'note':
          'High-contrast scaffold — pair with light primaryContrastingColor.',
    },
  ];

  final List<Widget> scaffoldTiles = List<Widget>.generate(
    scaffoldVariants.length,
    (int i) {
      final Map<String, dynamic> spec = scaffoldVariants[i];
      final Color color = spec['color'] as Color;
      final String label = spec['label'] as String;
      final String note = spec['note'] as String;
      final bool dark = color.computeLuminance() < 0.5;
      final Color textColor = dark ? Colors.white : paletteInk;
      final CupertinoThemeData theme = CupertinoThemeData(
        brightness: dark ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: color,
        primaryColor: paletteAccent,
      );
      return Container(
        width: 260.0,
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: paletteOutline),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              decoration: const BoxDecoration(
                color: paletteInk,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13.0),
                  topRight: Radius.circular(13.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  const Icon(
                    CupertinoIcons.square_fill_on_square_fill,
                    color: Colors.white,
                    size: 14.0,
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            CupertinoTheme(
              data: theme,
              child: Container(
                color: color,
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hello, world',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      note,
                      style: TextStyle(
                        color: textColor.withValues(alpha: 0.72),
                        fontSize: 11.5,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 6.0,
                      ),
                      onPressed: () {},
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  final Widget section4 = sectionShell(
    title: '04 · scaffoldBackgroundColor',
    subtitle:
        'scaffoldBackgroundColor sets the default background for '
        'CupertinoPageScaffold, CupertinoTabScaffold, and any descendant that '
        'reads CupertinoTheme.of(context).scaffoldBackgroundColor.',
    surface: paletteMist,
    border: paletteOutline,
    titleColor: paletteTeal,
    child: Wrap(children: scaffoldTiles),
  );

  // ===========================================================================
  // SECTION 5 — barBackgroundColor
  // ===========================================================================

  final List<Map<String, dynamic>> barVariants = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'Translucent white',
      'bar': const Color(0xF0FFFFFF),
      'text': paletteInk,
      'action': paletteAccent,
    },
    <String, dynamic>{
      'label': 'Mist gray',
      'bar': paletteMist,
      'text': paletteInk,
      'action': paletteIndigo,
    },
    <String, dynamic>{
      'label': 'Tinted accent',
      'bar': paletteAccentSoft,
      'text': paletteInk,
      'action': paletteAccent,
    },
    <String, dynamic>{
      'label': 'Brand purple',
      'bar': palettePurple,
      'text': Colors.white,
      'action': Colors.white,
    },
    <String, dynamic>{
      'label': 'Forest deep',
      'bar': paletteForest,
      'text': Colors.white,
      'action': Colors.white,
    },
    <String, dynamic>{
      'label': 'Graphite',
      'bar': paletteGraphite,
      'text': Colors.white,
      'action': paletteMint,
    },
  ];

  final List<Widget> barTiles = List<Widget>.generate(barVariants.length, (
    int i,
  ) {
    final Map<String, dynamic> spec = barVariants[i];
    final Color bar = spec['bar'] as Color;
    final Color text = spec['text'] as Color;
    final Color action = spec['action'] as Color;
    final String label = spec['label'] as String;
    return Container(
      width: 320.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: paletteOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: bar,
                    shape: BoxShape.circle,
                    border: Border.all(color: paletteOutline),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  label,
                  style: const TextStyle(
                    color: paletteInk,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          mockNavBar(
            title: 'Settings',
            barColor: bar,
            textColor: text,
            actionColor: action,
          ),
          Container(
            height: 60.0,
            color: paletteMist,
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'CupertinoNavigationBar pulls barBackgroundColor automatically '
              'when no explicit color is supplied on the bar itself.',
              style: TextStyle(
                color: paletteInkSoft,
                fontSize: 11.0,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  });

  final Widget section5 = sectionShell(
    title: '05 · barBackgroundColor',
    subtitle:
        'barBackgroundColor controls the default fill of CupertinoNavigationBar '
        'and CupertinoTabBar. It also informs the dark/light material of the '
        'translucent blur backdrop behind these bars on iOS.',
    surface: paletteMist,
    border: paletteOutline,
    titleColor: paletteMint,
    child: Wrap(children: barTiles),
  );

  // ===========================================================================
  // SECTION 6 — applyThemeToAll
  // ===========================================================================

  const CupertinoThemeData applyOffTheme = CupertinoThemeData(
    primaryColor: paletteRose,
  );

  const CupertinoThemeData applyOnTheme = CupertinoThemeData(
    primaryColor: paletteRose,
    applyThemeToAll: true,
  );

  final Widget section6 = sectionShell(
    title: '06 · applyThemeToAll',
    subtitle:
        'When applyThemeToAll is true, CupertinoTheme will push the same '
        'primaryColor and text styles into widgets that would otherwise opt '
        'out (notably, Cupertino widgets embedded inside a Material context).',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteRose,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: previewFrame(
            label: 'applyThemeToAll: false (default)',
            labelColor: paletteSlate,
            borderColor: paletteOutline,
            background: Colors.white,
            child: CupertinoTheme(
              data: applyOffTheme,
              child: sampleControls(),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: previewFrame(
            label: 'applyThemeToAll: true',
            labelColor: paletteRose,
            borderColor: paletteRose,
            background: Colors.white,
            child: CupertinoTheme(
              data: applyOnTheme,
              child: sampleControls(),
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 7 — textTheme: textStyle + actionTextStyle
  // ===========================================================================

  const CupertinoTextThemeData textThemeAlpha = CupertinoTextThemeData(
    primaryColor: paletteIndigo,
    textStyle: TextStyle(
      fontSize: 17.0,
      color: paletteInk,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    actionTextStyle: TextStyle(
      fontSize: 15.0,
      color: paletteIndigo,
      fontWeight: FontWeight.w700,
    ),
  );

  const CupertinoTextThemeData textThemeBeta = CupertinoTextThemeData(
    primaryColor: paletteRose,
    textStyle: TextStyle(
      fontSize: 18.0,
      color: paletteGraphite,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.2,
      height: 1.45,
    ),
    actionTextStyle: TextStyle(
      fontSize: 16.0,
      color: paletteRose,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.3,
    ),
  );

  Widget buildTextThemeSample(
    String title,
    CupertinoTextThemeData textTheme,
    Color primary,
    Color border,
  ) {
    final CupertinoThemeData themeData = CupertinoThemeData(
      primaryColor: primary,
      textTheme: textTheme,
    );
    return Expanded(
      child: previewFrame(
        label: title,
        labelColor: primary,
        borderColor: border,
        background: Colors.white,
        height: 240.0,
        child: CupertinoTheme(
          data: themeData,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DefaultTextStyle(
                  style: textTheme.textStyle,
                  child: const Text(
                    'The quick brown fox jumps over the lazy dog. 0123456789.',
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: const Text('Open settings'),
                    ),
                    const SizedBox(width: 14.0),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      child: const Text('Edit profile'),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  'actionTextStyle drives the default look of CupertinoButton '
                  'children when their style is not overridden inline.',
                  style: TextStyle(
                    color: paletteInkSoft,
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final Widget section7 = sectionShell(
    title: '07 · textStyle and actionTextStyle',
    subtitle:
        'textStyle drives the default body font (used by DefaultTextStyle '
        'descendants and bare Text widgets), while actionTextStyle drives the '
        'default look of CupertinoButton labels and link-like text.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteIndigo,
    child: Row(
      children: <Widget>[
        buildTextThemeSample(
          'Alpha (Indigo)',
          textThemeAlpha,
          paletteIndigo,
          paletteIndigo,
        ),
        const SizedBox(width: 12.0),
        buildTextThemeSample(
          'Beta (Rose)',
          textThemeBeta,
          paletteRose,
          paletteRose,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 8 — tabLabelTextStyle + navTitleTextStyle + navLargeTitleTextStyle
  // ===========================================================================

  const CupertinoTextThemeData tabsNavText = CupertinoTextThemeData(
    primaryColor: paletteTeal,
    tabLabelTextStyle: TextStyle(
      fontSize: 11.0,
      color: paletteTeal,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
    ),
    navTitleTextStyle: TextStyle(
      fontSize: 17.0,
      color: paletteInk,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.2,
    ),
    navLargeTitleTextStyle: TextStyle(
      fontSize: 34.0,
      color: paletteInk,
      fontWeight: FontWeight.w900,
      letterSpacing: -0.6,
    ),
    navActionTextStyle: TextStyle(
      fontSize: 15.0,
      color: paletteTeal,
      fontWeight: FontWeight.w600,
    ),
  );

  Widget mockLargeTitleBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: paletteOutline.withValues(alpha: 0.6),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Back',
                style: tabsNavText.navActionTextStyle,
              ),
              const Spacer(),
              Text(
                'Inbox',
                style: tabsNavText.navTitleTextStyle,
              ),
              const Spacer(),
              Text(
                'Edit',
                style: tabsNavText.navActionTextStyle,
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            'Mail',
            style: tabsNavText.navLargeTitleTextStyle,
          ),
        ],
      ),
    );
  }

  Widget mockTabBar() {
    final List<Map<String, dynamic>> entries = <Map<String, dynamic>>[
      <String, dynamic>{
        'icon': CupertinoIcons.house_fill,
        'label': 'HOME',
      },
      <String, dynamic>{
        'icon': CupertinoIcons.bell_fill,
        'label': 'ALERTS',
      },
      <String, dynamic>{
        'icon': CupertinoIcons.person_alt_circle_fill,
        'label': 'YOU',
      },
      <String, dynamic>{
        'icon': CupertinoIcons.settings_solid,
        'label': 'SETTINGS',
      },
    ];
    final List<Widget> items = entries.map((Map<String, dynamic> entry) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                entry['icon'] as IconData,
                color: paletteTeal,
                size: 22.0,
              ),
              const SizedBox(height: 4.0),
              Text(
                entry['label'] as String,
                style: tabsNavText.tabLabelTextStyle,
              ),
            ],
          ),
        ),
      );
    }).toList();
    return Container(
      decoration: BoxDecoration(
        color: paletteMist,
        border: Border(
          top: BorderSide(color: paletteOutline.withValues(alpha: 0.6)),
        ),
      ),
      child: Row(children: items),
    );
  }

  final Widget section8 = sectionShell(
    title: '08 · nav* + tabLabel text styles',
    subtitle:
        'tabLabelTextStyle drives the tiny labels under CupertinoTabBar '
        'icons. navTitleTextStyle, navLargeTitleTextStyle, and '
        'navActionTextStyle drive the three text slots in a '
        'CupertinoNavigationBar / CupertinoSliverNavigationBar.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteTeal,
    child: Column(
      children: <Widget>[
        previewFrame(
          label: 'Navigation bar (large title)',
          labelColor: paletteTeal,
          borderColor: paletteOutline,
          background: Colors.white,
          height: 140.0,
          child: mockLargeTitleBar(),
        ),
        previewFrame(
          label: 'Tab bar with tabLabelTextStyle',
          labelColor: paletteTeal,
          borderColor: paletteOutline,
          background: Colors.white,
          height: 80.0,
          child: mockTabBar(),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: paletteTealSoft,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: paletteTeal.withValues(alpha: 0.45)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              keyValueRow(
                'tabLabelTextStyle',
                'size 11, w700, letter 0.6, paletteTeal',
                paletteInk,
              ),
              keyValueRow(
                'navTitleTextStyle',
                'size 17, w800, paletteInk',
                paletteInk,
              ),
              keyValueRow(
                'navLargeTitleTextStyle',
                'size 34, w900, letter -0.6, paletteInk',
                paletteInk,
              ),
              keyValueRow(
                'navActionTextStyle',
                'size 15, w600, paletteTeal',
                paletteInk,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 9 — pickerTextStyle + dateTimePickerTextStyle
  // ===========================================================================

  const CupertinoTextThemeData pickerText = CupertinoTextThemeData(
    primaryColor: palettePurple,
    pickerTextStyle: TextStyle(
      fontSize: 22.0,
      color: paletteInk,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    ),
    dateTimePickerTextStyle: TextStyle(
      fontSize: 21.0,
      color: paletteGraphite,
      fontWeight: FontWeight.w500,
    ),
  );

  Widget mockPickerWheel({
    required List<String> items,
    required TextStyle style,
    required Color highlight,
  }) {
    final int mid = items.length ~/ 2;
    final List<Widget> rows = List<Widget>.generate(items.length, (int i) {
      final double distance = (i - mid).abs().toDouble();
      final double opacity = (1.0 - (distance * 0.22)).clamp(0.25, 1.0);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Text(
          items[i],
          style: style.copyWith(
            color: (style.color ?? paletteInk).withValues(alpha: opacity),
          ),
        ),
      );
    });
    // 7 picker rows with the large Cupertino pickerTextStyle (fontSize 22,
    // bold) need ~205 px and dateTimePickerTextStyle (fontSize 21) needs
    // ~198 px. The wheel slot was sized at 180 px, leaving 25 / 18 px of
    // bottom RenderFlex overflow. Wrap the children Column in a
    // SingleChildScrollView so the constrained 180-px wheel viewport
    // silently absorbs the overflow without losing the visual look (the
    // outer-most rows clip exactly like a real Cupertino picker wheel).
    return SizedBox(
      height: 180.0,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned.fill(
            child: Center(
              child: Container(
                height: 36.0,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: highlight.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: rows,
            ),
          ),
        ],
      ),
    );
  }

  final Widget section9 = sectionShell(
    title: '09 · picker + dateTimePicker text styles',
    subtitle:
        'pickerTextStyle is used by CupertinoPicker rows. '
        'dateTimePickerTextStyle is the slightly tighter style used by '
        'CupertinoDatePicker and CupertinoTimerPicker for their wheels.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: palettePurple,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: previewFrame(
            label: 'CupertinoPicker — pickerTextStyle',
            labelColor: palettePurple,
            borderColor: palettePurple.withValues(alpha: 0.4),
            background: Colors.white,
            child: mockPickerWheel(
              items: const <String>[
                'Espresso',
                'Cortado',
                'Flat white',
                'Latte',
                'Cappuccino',
                'Mocha',
                'Americano',
              ],
              style: pickerText.pickerTextStyle,
              highlight: palettePurple,
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: previewFrame(
            label: 'CupertinoDatePicker — dateTimePickerTextStyle',
            labelColor: paletteIndigo,
            borderColor: paletteIndigo.withValues(alpha: 0.4),
            background: Colors.white,
            child: mockPickerWheel(
              items: const <String>[
                'Jan 14',
                'Jan 15',
                'Jan 16',
                'Jan 17',
                'Jan 18',
                'Jan 19',
                'Jan 20',
              ],
              style: pickerText.dateTimePickerTextStyle,
              highlight: paletteIndigo,
            ),
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 10 — CupertinoTextThemeData explicit full construction
  // ===========================================================================

  const CupertinoTextThemeData fullExplicit = CupertinoTextThemeData(
    primaryColor: paletteForest,
    textStyle: TextStyle(
      fontSize: 17.0,
      color: paletteInk,
      fontWeight: FontWeight.w500,
      height: 1.42,
    ),
    actionTextStyle: TextStyle(
      fontSize: 15.0,
      color: paletteForest,
      fontWeight: FontWeight.w700,
    ),
    tabLabelTextStyle: TextStyle(
      fontSize: 10.5,
      color: paletteForest,
      fontWeight: FontWeight.w800,
      letterSpacing: 0.7,
    ),
    navTitleTextStyle: TextStyle(
      fontSize: 17.5,
      color: paletteInk,
      fontWeight: FontWeight.w800,
    ),
    navLargeTitleTextStyle: TextStyle(
      fontSize: 36.0,
      color: paletteForest,
      fontWeight: FontWeight.w900,
      letterSpacing: -0.8,
    ),
    navActionTextStyle: TextStyle(
      fontSize: 15.5,
      color: paletteForest,
      fontWeight: FontWeight.w600,
    ),
    pickerTextStyle: TextStyle(
      fontSize: 21.0,
      color: paletteForest,
      fontWeight: FontWeight.w600,
    ),
    dateTimePickerTextStyle: TextStyle(
      fontSize: 20.0,
      color: paletteGraphite,
      fontWeight: FontWeight.w500,
    ),
  );

  Widget styleRow(String label, TextStyle style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170.0,
            child: Text(
              label,
              style: const TextStyle(
                color: paletteInkSoft,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Cupertino · 1234567890',
              style: style,
            ),
          ),
        ],
      ),
    );
  }

  final Widget section10 = sectionShell(
    title: '10 · CupertinoTextThemeData full explicit build',
    subtitle:
        'Constructing every slot of CupertinoTextThemeData by hand produces a '
        'fully owned text identity for a Cupertino app — useful when '
        'matching brand typography or supporting custom font fallbacks.',
    surface: paletteForestSoft,
    border: paletteForest.withValues(alpha: 0.45),
    titleColor: paletteForest,
    child: Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: paletteOutline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          styleRow('textStyle', fullExplicit.textStyle),
          styleRow('actionTextStyle', fullExplicit.actionTextStyle),
          styleRow('tabLabelTextStyle', fullExplicit.tabLabelTextStyle),
          styleRow('navTitleTextStyle', fullExplicit.navTitleTextStyle),
          styleRow(
            'navLargeTitleTextStyle',
            fullExplicit.navLargeTitleTextStyle,
          ),
          styleRow('navActionTextStyle', fullExplicit.navActionTextStyle),
          styleRow('pickerTextStyle', fullExplicit.pickerTextStyle),
          styleRow(
            'dateTimePickerTextStyle',
            fullExplicit.dateTimePickerTextStyle,
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 11 — Brightness control standalone
  // ===========================================================================

  Widget brightnessTile({
    required String label,
    required CupertinoThemeData data,
    required Color outerBorder,
    required Color background,
    required Color labelColor,
  }) {
    return Expanded(
      child: previewFrame(
        label: label,
        labelColor: labelColor,
        borderColor: outerBorder,
        background: background,
        height: 250.0,
        child: CupertinoTheme(
          data: data,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Brightness: ${data.brightness}',
                  style: TextStyle(
                    color: data.brightness == Brightness.dark
                        ? Colors.white
                        : paletteInk,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'CupertinoColors dynamic tokens resolve against this '
                  'brightness when their owning context falls back to '
                  'CupertinoTheme.',
                  style: TextStyle(
                    color: (data.brightness == Brightness.dark
                            ? Colors.white
                            : paletteInk)
                        .withValues(alpha: 0.72),
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14.0),
                Row(
                  children: <Widget>[
                    CupertinoButton.filled(
                      onPressed: () {},
                      child: const Text('Primary'),
                    ),
                    const SizedBox(width: 10.0),
                    const CupertinoSwitch(value: true, onChanged: null),
                  ],
                ),
                const SizedBox(height: 10.0),
                CupertinoSlider(
                  value: 0.65,
                  onChanged: (double _) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final Widget section11 = sectionShell(
    title: '11 · Brightness control',
    subtitle:
        'brightness is a top-level Cupertino concept: when null it inherits '
        'from MediaQuery, when explicit it short-circuits every dynamic '
        'CupertinoColors resolution in the subtree.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteAmber,
    child: Row(
      children: <Widget>[
        brightnessTile(
          label: 'Brightness.light',
          data: const CupertinoThemeData(
            brightness: Brightness.light,
            primaryColor: paletteAmber,
          ),
          outerBorder: paletteOutline,
          background: Colors.white,
          labelColor: paletteAmber,
        ),
        const SizedBox(width: 12.0),
        brightnessTile(
          label: 'Brightness.dark',
          data: const CupertinoThemeData(
            brightness: Brightness.dark,
            primaryColor: paletteAmber,
          ),
          outerBorder: paletteNightOutline,
          background: paletteNightBg,
          labelColor: paletteAmber,
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 12 — Nested CupertinoTheme widgets
  // ===========================================================================

  final Widget section12 = sectionShell(
    title: '12 · Nested CupertinoTheme widgets',
    subtitle:
        'CupertinoTheme is composable: deeply nesting CupertinoTheme(data: …, '
        'child: …) lets local subtrees override only the slots they need '
        'while inheriting the rest from outer ancestors.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteIndigo,
    child: CupertinoTheme(
      data: const CupertinoThemeData(
        primaryColor: paletteIndigo,
        brightness: Brightness.light,
      ),
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: paletteIndigoSoft,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: paletteIndigo.withValues(alpha: 0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Outer · primary = Indigo',
              style: TextStyle(
                color: paletteIndigo,
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8.0),
            CupertinoButton.filled(
              onPressed: () {},
              child: const Text('Outer Indigo button'),
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: paletteRose.withValues(alpha: 0.4)),
              ),
              child: CupertinoTheme(
                data: const CupertinoThemeData(
                  primaryColor: paletteRose,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Inner #1 · primary = Rose',
                      style: TextStyle(
                        color: paletteRose,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    CupertinoButton.filled(
                      onPressed: () {},
                      child: const Text('Inner Rose button'),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: paletteMintSoft,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: paletteMint.withValues(alpha: 0.5),
                        ),
                      ),
                      child: CupertinoTheme(
                        data: const CupertinoThemeData(
                          primaryColor: paletteMint,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Inner #2 · primary = Mint',
                              style: TextStyle(
                                color: paletteMint,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: <Widget>[
                                CupertinoButton.filled(
                                  onPressed: () {},
                                  child: const Text('Mint'),
                                ),
                                const SizedBox(width: 10.0),
                                const CupertinoSwitch(
                                  value: true,
                                  onChanged: null,
                                ),
                              ],
                            ),
                          ],
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
    ),
  );

  // ===========================================================================
  // SECTION 13 — Mixing CupertinoTheme with Material widgets
  // ===========================================================================

  final Widget section13 = sectionShell(
    title: '13 · Mixing with Material widgets',
    subtitle:
        'CupertinoTheme.of(context) can be read from Material widgets to align '
        'a hybrid app: a Material Scaffold can pick up the primaryColor of a '
        'parent CupertinoTheme and an outer MaterialApp can host Cupertino '
        'widgets that respond to it.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: palettePurple,
    child: CupertinoTheme(
      data: const CupertinoThemeData(
        primaryColor: palettePurple,
      ),
      child: Builder(
        builder: (BuildContext innerContext) {
          final Color primary =
              CupertinoTheme.of(innerContext).primaryColor;
          return Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: palettePurpleSoft,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: primary.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'CupertinoTheme.of(context).primaryColor → Purple',
                  style: TextStyle(
                    color: primary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 8.0,
                  children: <Widget>[
                    CupertinoButton.filled(
                      onPressed: () {},
                      child: const Text('Cupertino filled'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: const Text('Material elevated'),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: primary,
                        side: BorderSide(color: primary),
                      ),
                      onPressed: () {},
                      child: const Text('Material outlined'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: primary),
                      onPressed: () {},
                      child: const Text('Material text'),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: <Widget>[
                    Icon(Icons.star, color: primary, size: 22.0),
                    const SizedBox(width: 6.0),
                    Icon(
                      CupertinoIcons.heart_fill,
                      color: primary,
                      size: 22.0,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'Hybrid icons share the same primary tint.',
                      style: TextStyle(
                        color: primary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    ),
  );

  // ===========================================================================
  // SECTION 14 — Sample previews of every key Cupertino control
  // ===========================================================================

  Widget controlsShowcase(CupertinoThemeData theme, {bool dark = false}) {
    final Color text = dark ? Colors.white : paletteInk;
    return CupertinoTheme(
      data: theme,
      child: Container(
        color: dark ? paletteNightBg : Colors.white,
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            mockNavBar(
              title: 'Themed bar',
              barColor: theme.barBackgroundColor,
              textColor: text,
              actionColor: theme.primaryColor,
            ),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 10.0,
              runSpacing: 8.0,
              children: <Widget>[
                CupertinoButton.filled(
                  onPressed: () {},
                  child: const Text('Filled'),
                ),
                CupertinoButton(
                  onPressed: () {},
                  child: const Text('Plain'),
                ),
                const CupertinoActivityIndicator(radius: 12.0),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: <Widget>[
                const CupertinoSwitch(value: true, onChanged: null),
                const SizedBox(width: 14.0),
                const CupertinoSwitch(value: false, onChanged: null),
                const SizedBox(width: 14.0),
                Expanded(
                  child: CupertinoSlider(
                    value: 0.4,
                    onChanged: (double _) {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            CupertinoSegmentedControl<int>(
              groupValue: 1,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              onValueChanged: (int _) {},
              children: const <int, Widget>{
                0: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 6.0,
                  ),
                  child: Text('Day'),
                ),
                1: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 6.0,
                  ),
                  child: Text('Week'),
                ),
                2: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 6.0,
                  ),
                  child: Text('Month'),
                ),
              },
            ),
            const SizedBox(height: 10.0),
            Text(
              'CupertinoButton · CupertinoSwitch · CupertinoSlider · '
              'CupertinoSegmentedControl · CupertinoNavigationBar — all pick '
              'up the primary color from the surrounding theme.',
              style: TextStyle(
                color: text.withValues(alpha: 0.72),
                fontSize: 11.5,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final Widget section14 = sectionShell(
    title: '14 · Themed control showcase',
    subtitle:
        'A dense gallery of CupertinoButton (filled + plain), '
        'CupertinoActivityIndicator, CupertinoSwitch, CupertinoSlider, '
        'CupertinoSegmentedControl, and CupertinoNavigationBar — all inside '
        'three different themes to make the cascading effect explicit.',
    surface: Colors.white,
    border: paletteOutline,
    titleColor: paletteAmber,
    child: Column(
      children: <Widget>[
        previewFrame(
          label: 'Theme A · Amber light',
          labelColor: paletteAmber,
          borderColor: paletteAmber.withValues(alpha: 0.4),
          background: Colors.white,
          height: 320.0,
          child: controlsShowcase(
            const CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: paletteAmber,
              barBackgroundColor: paletteAmberSoft,
              scaffoldBackgroundColor: Colors.white,
            ),
          ),
        ),
        previewFrame(
          label: 'Theme B · Mint light',
          labelColor: paletteMint,
          borderColor: paletteMint.withValues(alpha: 0.45),
          background: Colors.white,
          height: 320.0,
          child: controlsShowcase(
            const CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: paletteMint,
              barBackgroundColor: paletteMintSoft,
              scaffoldBackgroundColor: Colors.white,
            ),
          ),
        ),
        previewFrame(
          label: 'Theme C · Rose dark',
          labelColor: paletteRose,
          borderColor: paletteRose.withValues(alpha: 0.55),
          background: paletteNightBg,
          height: 320.0,
          child: controlsShowcase(
            const CupertinoThemeData(
              brightness: Brightness.dark,
              primaryColor: paletteRose,
              barBackgroundColor: paletteNightCard,
              scaffoldBackgroundColor: paletteNightBg,
            ),
            dark: true,
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // SECTION 15 — Light / Dark side-by-side comparison
  // ===========================================================================

  final List<Map<String, dynamic>> compareThemes = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'Active Blue',
      'color': paletteAccent,
    },
    <String, dynamic>{
      'name': 'Indigo',
      'color': paletteIndigo,
    },
    <String, dynamic>{
      'name': 'Teal',
      'color': paletteTeal,
    },
    <String, dynamic>{
      'name': 'Rose',
      'color': paletteRose,
    },
  ];

  final List<Widget> compareRows = compareThemes
      .map((Map<String, dynamic> entry) {
        final Color color = entry['color'] as Color;
        final String name = entry['name'] as String;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Cluster H follow-up: section15 rendered 4 comparison rows
              // [SizedBox(88) label + Expanded light-preview + SizedBox(8)
              // + Expanded dark-preview]. The bridged Cupertino controls
              // (CupertinoSwitch / CupertinoSlider) inside the preview
              // frames have an intrinsic-width measurement that overflows
              // by 1.8 px when the Expanded slot is at its baseline width
              // (U15 bridge gap). Shrinking the label column from 88 to
              // 70 hands ~18 px back to the two preview Expandeds, which
              // is enough to absorb the bridged controls' rounding.
              // Visual: label sits 18 px closer to the previews (the
              // colored dot + "Active Blue"/"Indigo"/"Teal"/"Rose"
              // labels remain fully visible — longest is 'Active Blue'
              // at 11 chars × ~7 px = ~77 px including the dot+spacer,
              // so the label is now allowed to wrap to a second line on
              // the narrowest rendering width; previews now never
              // overflow).
              SizedBox(
                width: 70.0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 36.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 12.0,
                        height: 12.0,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Text(
                          name,
                          style: TextStyle(
                            color: color,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w800,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: previewFrame(
                  label: '$name · light',
                  labelColor: color,
                  borderColor: color.withValues(alpha: 0.4),
                  background: Colors.white,
                  height: 160.0,
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      brightness: Brightness.light,
                      primaryColor: color,
                      scaffoldBackgroundColor: Colors.white,
                    ),
                    child: sampleControls(),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: previewFrame(
                  label: '$name · dark',
                  labelColor: color,
                  borderColor: color.withValues(alpha: 0.55),
                  background: paletteNightBg,
                  height: 160.0,
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      brightness: Brightness.dark,
                      primaryColor: color,
                      scaffoldBackgroundColor: paletteNightBg,
                      barBackgroundColor: paletteNightCard,
                    ),
                    child: sampleControls(darkBg: true),
                  ),
                ),
              ),
            ],
          ),
        );
      })
      .toList();

  final Widget section15 = sectionShell(
    title: '15 · Light / dark side-by-side',
    subtitle:
        'A final comparison view: four primaryColor families rendered in both '
        'Brightness.light and Brightness.dark CupertinoThemeData instances, '
        'with identical control sets, to make the brightness contract '
        'visually obvious.',
    surface: paletteMist,
    border: paletteOutline,
    titleColor: paletteAccent,
    child: Column(children: compareRows),
  );

  // ===========================================================================
  // CLOSING FOOTER
  // ===========================================================================

  final Widget closingFooter = Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF101225),
          Color(0xFF2B2D42),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Icon(
            CupertinoIcons.checkmark_seal_fill,
            color: Colors.white,
            size: 28.0,
          ),
        ),
        const SizedBox(width: 14.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'CupertinoThemeData deep demo · complete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Fifteen sections covering brightness, primaryColor, the '
                'scaffold/bar background pair, applyThemeToAll, the full '
                'CupertinoTextThemeData (textStyle, actionTextStyle, '
                'tabLabelTextStyle, navTitleTextStyle, '
                'navLargeTitleTextStyle, navActionTextStyle, pickerTextStyle, '
                'dateTimePickerTextStyle), nested CupertinoTheme widgets, '
                'Material interop, and side-by-side brightness comparison.',
                style: TextStyle(
                  color: Color(0xFFE0E2F4),
                  fontSize: 12.0,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ===========================================================================
  // ASSEMBLY
  // ===========================================================================

  return Scaffold(
    backgroundColor: paletteMist,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            heroBanner,
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
            closingFooter,
          ],
        ),
      ),
    ),
  );
}
