// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ============================================================================
// CupertinoApp / Cupertino chrome — deep visual demo (D4rt analyzer-free)
//
// This file demonstrates Apple's Human-Interface-Guidelines-flavoured Flutter
// chrome:
//
//   * CupertinoApp configuration (rendered as a mocked settings sheet, NOT as
//     the actual root widget — the host test app already owns the real root).
//   * CupertinoTheme + CupertinoThemeData, light and dark, side by side.
//   * CupertinoColors palette swatches.
//   * CupertinoTextThemeData typography ramp.
//   * CupertinoNavigationBar variants (default / leading / trailing).
//   * CupertinoPageScaffold combo (nav bar + content body).
//   * Material AppBar vs CupertinoNavigationBar comparison card.
//   * Primary color cascade through CupertinoTheme to CupertinoButton.
//   * Light/dark switching strategy explanation.
//   * iOS-style components catalogue: CupertinoButton, CupertinoSwitch,
//     CupertinoSlider, CupertinoSegmentedControl.
//
// All sub-widgets are produced by hand-written top-level helper FUNCTIONS.
// No StatefulWidget / StatelessWidget subclasses, no controllers, no setState.
// ============================================================================

dynamic build(BuildContext context) {
  print('CupertinoApp deep visual demo executing');

  return Container(
    color: const Color(0xFFF2F2F7),
    padding: const EdgeInsets.all(20.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildHeaderCard(),
          const SizedBox(height: 24.0),
          _buildAnatomyCard(),
          const SizedBox(height: 24.0),
          _buildLightDarkPairCard(),
          const SizedBox(height: 24.0),
          _buildColorsPaletteCard(),
          const SizedBox(height: 24.0),
          _buildTextThemeRampCard(),
          const SizedBox(height: 24.0),
          _buildNavBarVariantsCard(),
          const SizedBox(height: 24.0),
          _buildPageScaffoldCard(),
          const SizedBox(height: 24.0),
          _buildAppBarComparisonCard(),
          const SizedBox(height: 24.0),
          _buildPrimaryCascadeCard(),
          const SizedBox(height: 24.0),
          _buildCupertinoAppConfigCard(),
          const SizedBox(height: 24.0),
          _buildLightDarkStrategyCard(),
          const SizedBox(height: 24.0),
          _buildComponentsCatalogCard(),
          const SizedBox(height: 24.0),
          _buildFooterCard(),
        ],
      ),
    ),
  );
}

// ============================================================================
// 1. Header
// ============================================================================

Widget _buildHeaderCard() {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF0A84FF),
          Color(0xFF5856D6),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    padding: const EdgeInsets.all(24.0),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'CupertinoApp — visual deep dive',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'CupertinoApp is Flutter\'s iOS-flavoured top-level chrome. It '
          'mirrors what MaterialApp does for Material 3, but with Apple HIG '
          'styling: SF-style typography, system colors, sliding page routes, '
          'iOS-style scroll physics, and Cupertino localizations.',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 15.0,
            height: 1.45,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Below: anatomy, theming, colors, typography, nav bars, '
          'scaffolds, comparisons, cascades, configuration, and a mini '
          'components catalogue.',
          style: TextStyle(
            color: Color(0xFFE5E5EA),
            fontSize: 13.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// 2. Anatomy diagram — Cupertino page composition
// ============================================================================

Widget _buildAnatomyCard() {
  return _section(
    title: '1. Anatomy of a Cupertino page',
    subtitle: 'CupertinoApp → CupertinoPageScaffold → '
        '(CupertinoNavigationBar + child + CupertinoTabBar)',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _phoneFrame(
          width: 200.0,
          height: 380.0,
          child: Column(
            children: <Widget>[
              _diagramBand(
                label: 'CupertinoNavigationBar',
                color: const Color(0xFFD1D1D6),
                height: 44.0,
              ),
              Expanded(
                child: Container(
                  color: CupertinoColors.white,
                  alignment: Alignment.center,
                  child: const Text(
                    'CupertinoPageScaffold\nchild\n(your content)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Color(0xFF3A3A3C),
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              _diagramBand(
                label: 'CupertinoTabBar (optional)',
                color: const Color(0xFFC7C7CC),
                height: 49.0,
              ),
            ],
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Each band is a layer of the Cupertino chrome.',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10.0),
              Text(
                '• Top band — the navigation bar. 44 logical pixels on '
                'iPhone; sits above the safe area inset.',
                style: TextStyle(fontSize: 13.0, height: 1.5),
              ),
              SizedBox(height: 6.0),
              Text(
                '• Middle band — the page body. Provided as the `child` of '
                'CupertinoPageScaffold; usually scrollable.',
                style: TextStyle(fontSize: 13.0, height: 1.5),
              ),
              SizedBox(height: 6.0),
              Text(
                '• Bottom band — an optional CupertinoTabBar (49 logical '
                'pixels). Shown when the scaffold sits inside '
                'CupertinoTabScaffold.',
                style: TextStyle(fontSize: 13.0, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _diagramBand({
  required String label,
  required Color color,
  required double height,
}) {
  return Container(
    height: height,
    color: color,
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1C1C1E),
      ),
    ),
  );
}

// ============================================================================
// 3. Light vs Dark CupertinoThemeData
// ============================================================================

Widget _buildLightDarkPairCard() {
  return _section(
    title: '2. Light vs dark CupertinoThemeData',
    subtitle:
        'CupertinoTheme(data: CupertinoThemeData(brightness: …), child: …)',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'The two phones below render identical content under opposite '
          'brightnesses. Brightness.light yields a near-white page with dark '
          'text; Brightness.dark yields a near-black page with light text. '
          'CupertinoColors knows how to invert itself when the parent theme '
          'switches.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _themedPhone(brightness: Brightness.light, label: 'Brightness.light'),
            _themedPhone(brightness: Brightness.dark, label: 'Brightness.dark'),
          ],
        ),
      ],
    ),
  );
}

Widget _themedPhone({
  required Brightness brightness,
  required String label,
}) {
  final bool isDark = brightness == Brightness.dark;
  final Color pageColor = isDark
      ? const Color(0xFF000000)
      : const Color(0xFFFFFFFF);
  final Color navBgColor = isDark
      ? const Color(0xCC1C1C1E)
      : const Color(0xCCF2F2F7);
  final Color textColor = isDark
      ? CupertinoColors.white
      : CupertinoColors.black;
  final Color secondaryText = isDark
      ? const Color(0xFFAEAEB2)
      : const Color(0xFF6E6E73);
  final Color accent =
      isDark ? const Color(0xFF0A84FF) : const Color(0xFF007AFF);

  return Column(
    children: <Widget>[
      _phoneFrame(
        width: 220.0,
        height: 400.0,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            brightness: brightness,
            primaryColor: accent,
          ),
          child: Container(
            color: pageColor,
            child: Column(
              children: <Widget>[
                Container(
                  height: 44.0,
                  color: navBgColor,
                  alignment: Alignment.center,
                  child: Text(
                    'Mail',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Inbox',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w700,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          'Today',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: secondaryText,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        _mailRow(
                          sender: 'Tim Cook',
                          subject: 'Welcome aboard',
                          textColor: textColor,
                          secondaryColor: secondaryText,
                          accent: accent,
                        ),
                        const SizedBox(height: 6.0),
                        _mailRow(
                          sender: 'Craig Federighi',
                          subject: 'New Cupertino widgets',
                          textColor: textColor,
                          secondaryColor: secondaryText,
                          accent: accent,
                        ),
                        const SizedBox(height: 6.0),
                        _mailRow(
                          sender: 'Steve Jobs',
                          subject: 'Stay hungry',
                          textColor: textColor,
                          secondaryColor: secondaryText,
                          accent: accent,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 8.0),
      Text(
        label,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: Color(0xFF3A3A3C),
        ),
      ),
    ],
  );
}

Widget _mailRow({
  required String sender,
  required String subject,
  required Color textColor,
  required Color secondaryColor,
  required Color accent,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 6.0, right: 8.0),
        width: 8.0,
        height: 8.0,
        decoration: BoxDecoration(
          color: accent,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              sender,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            Text(
              subject,
              style: TextStyle(
                fontSize: 12.5,
                color: secondaryColor,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ============================================================================
// 4. CupertinoColors palette
// ============================================================================

Widget _buildColorsPaletteCard() {
  final List<_Swatch> systemColors = <_Swatch>[
    _Swatch('systemBlue', CupertinoColors.systemBlue),
    _Swatch('systemRed', CupertinoColors.systemRed),
    _Swatch('systemGreen', CupertinoColors.systemGreen),
    _Swatch('systemYellow', CupertinoColors.systemYellow),
    _Swatch('systemPink', CupertinoColors.systemPink),
    _Swatch('systemTeal', CupertinoColors.systemTeal),
    _Swatch('systemIndigo', CupertinoColors.systemIndigo),
    _Swatch('systemOrange', CupertinoColors.systemOrange),
    _Swatch('systemPurple', CupertinoColors.systemPurple),
    _Swatch('systemGrey', CupertinoColors.systemGrey),
  ];

  final List<_Swatch> semanticColors = <_Swatch>[
    _Swatch('label', CupertinoColors.label),
    _Swatch('secondaryLabel', CupertinoColors.secondaryLabel),
    _Swatch('tertiaryLabel', CupertinoColors.tertiaryLabel),
    _Swatch('quaternaryLabel', CupertinoColors.quaternaryLabel),
    _Swatch('separator', CupertinoColors.separator),
    _Swatch('opaqueSeparator', CupertinoColors.opaqueSeparator),
    _Swatch('placeholderText', CupertinoColors.placeholderText),
    _Swatch('systemBackground', CupertinoColors.systemBackground),
    _Swatch(
      'secondarySystemBackground',
      CupertinoColors.secondarySystemBackground,
    ),
    _Swatch('link', CupertinoColors.link),
  ];

  return _section(
    title: '3. CupertinoColors palette',
    subtitle: 'System rainbow + semantic UI colors',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'CupertinoColors splits its palette into two families. System '
          'colors (systemBlue, systemRed, …) are the iOS rainbow used for '
          'accents and tints. Semantic colors (label, separator, '
          'systemBackground, …) are dynamic and resolve differently under '
          'light and dark mode.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'System rainbow',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
        ),
        const SizedBox(height: 8.0),
        _swatchGrid(systemColors),
        const SizedBox(height: 18.0),
        const Text(
          'Semantic / UI colors',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
        ),
        const SizedBox(height: 8.0),
        _swatchGrid(semanticColors),
      ],
    ),
  );
}

Widget _swatchGrid(List<_Swatch> swatches) {
  return Wrap(
    spacing: 10.0,
    runSpacing: 10.0,
    children: <Widget>[
      for (final _Swatch s in swatches) _swatchTile(s),
    ],
  );
}

Widget _swatchTile(_Swatch s) {
  return Container(
    width: 140.0,
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0xFFE5E5EA)),
    ),
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: s.color,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: const Color(0xFFD1D1D6)),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            s.name,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

class _Swatch {
  final String name;
  final Color color;
  const _Swatch(this.name, this.color);
}

// ============================================================================
// 5. CupertinoTextThemeData typography ramp
// ============================================================================

Widget _buildTextThemeRampCard() {
  return _section(
    title: '4. CupertinoTextThemeData typography ramp',
    subtitle: 'Every named text style with its sample sentence',
    child: CupertinoTheme(
      data: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.systemBlue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'CupertinoTextThemeData groups the seven canonical iOS text '
            'styles. Each one targets a specific UI surface — picker rows, '
            'tab labels, nav titles, page bodies, and modal actions.',
            style: TextStyle(fontSize: 13.5, height: 1.5),
          ),
          const SizedBox(height: 14.0),
          _typographyRow(
            name: 'navLargeTitleTextStyle',
            sample: 'Settings',
            style: const TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              color: CupertinoColors.black,
            ),
            note: '34pt — used for large nav-bar titles when scrolled top.',
          ),
          _typographyRow(
            name: 'navTitleTextStyle',
            sample: 'Settings',
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.black,
            ),
            note: '17pt semibold — collapsed nav-bar centre title.',
          ),
          _typographyRow(
            name: 'navActionTextStyle',
            sample: 'Done',
            style: const TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
              color: CupertinoColors.activeBlue,
            ),
            note: '17pt regular tinted — nav-bar leading/trailing actions.',
          ),
          _typographyRow(
            name: 'textStyle',
            sample: 'Body — quick brown fox jumps over the lazy dog.',
            style: const TextStyle(
              fontSize: 17.0,
              color: CupertinoColors.label,
            ),
            note: '17pt — the default body style for inline content.',
          ),
          _typographyRow(
            name: 'tabLabelTextStyle',
            sample: 'Inbox',
            style: const TextStyle(
              fontSize: 10.0,
              letterSpacing: -0.2,
              color: CupertinoColors.inactiveGray,
            ),
            note: '10pt — tab-bar labels under SF-style icons.',
          ),
          _typographyRow(
            name: 'actionTextStyle',
            sample: 'Cancel',
            style: const TextStyle(
              fontSize: 17.0,
              color: CupertinoColors.activeBlue,
            ),
            note: '17pt — alert / action sheet button text.',
          ),
          _typographyRow(
            name: 'pickerTextStyle',
            sample: 'Tuesday',
            style: const TextStyle(
              fontSize: 21.0,
              letterSpacing: -0.5,
              color: CupertinoColors.label,
            ),
            note: '21pt — wheel-picker row text.',
          ),
          _typographyRow(
            name: 'dateTimePickerTextStyle',
            sample: '14:32',
            style: const TextStyle(
              fontSize: 21.0,
              letterSpacing: -0.6,
              color: CupertinoColors.label,
            ),
            note: '21pt — date/time picker numeric rows.',
          ),
        ],
      ),
    ),
  );
}

Widget _typographyRow({
  required String name,
  required String sample,
  required TextStyle style,
  required String note,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5856D6),
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(sample, style: style),
              const SizedBox(height: 2.0),
              Text(
                note,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF6E6E73),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// 6. CupertinoNavigationBar variants
// ============================================================================

Widget _buildNavBarVariantsCard() {
  return _section(
    title: '5. CupertinoNavigationBar — three variants',
    subtitle: 'default · with leading · with trailing actions',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'CupertinoNavigationBar is the iOS-style top chrome. It always '
          'sits above the safe-area inset, defaults to translucent blur, '
          'and accepts up to three slots: leading, middle, trailing.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _navBarPhone(
              caption: 'Default (middle only)',
              leading: null,
              middle: 'Photos',
              trailing: null,
            ),
            _navBarPhone(
              caption: 'With leading back button',
              leading: '< Albums',
              middle: 'Recents',
              trailing: null,
            ),
            _navBarPhone(
              caption: 'With trailing action',
              leading: null,
              middle: 'Notes',
              trailing: 'Edit',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _navBarPhone({
  required String caption,
  required String? leading,
  required String middle,
  required String? trailing,
}) {
  return Column(
    children: <Widget>[
      _phoneFrame(
        width: 180.0,
        height: 320.0,
        child: Column(
          children: <Widget>[
            Container(
              height: 44.0,
              color: const Color(0xCCF2F2F7),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 60.0,
                    child: Text(
                      leading ?? '',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      middle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60.0,
                    child: Text(
                      trailing ?? '',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: CupertinoColors.white,
                alignment: Alignment.center,
                child: const Text(
                  'page body',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Color(0xFF8E8E93),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8.0),
      SizedBox(
        width: 180.0,
        child: Text(
          caption,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}

// ============================================================================
// 7. CupertinoPageScaffold mockup
// ============================================================================

Widget _buildPageScaffoldCard() {
  return _section(
    title: '6. CupertinoPageScaffold combo',
    subtitle: 'navigationBar + child = a full Cupertino page',
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _phoneFrame(
          width: 240.0,
          height: 440.0,
          child: Container(
            color: CupertinoColors.systemBackground,
            child: Column(
              children: <Widget>[
                Container(
                  height: 44.0,
                  color: const Color(0xCCF2F2F7),
                  alignment: Alignment.center,
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 72.0,
                          height: 72.0,
                          decoration: const BoxDecoration(
                            color: CupertinoColors.systemBlue,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'AK',
                            style: TextStyle(
                              fontSize: 28.0,
                              color: CupertinoColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        const Text(
                          'Alexis Kyaw',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'alexis.kyaw@gmail.com',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFF6E6E73),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        _settingRow('Account', '>'),
                        _settingRow('Notifications', '>'),
                        _settingRow('Privacy', '>'),
                        _settingRow('Sign out', ''),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Composition:',
                style:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
              ),
              SizedBox(height: 6.0),
              Text(
                '  CupertinoPageScaffold(\n'
                '    navigationBar: CupertinoNavigationBar(\n'
                '      middle: Text("Profile"),\n'
                '    ),\n'
                '    child: SafeArea(child: …),\n'
                '  )',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
              SizedBox(height: 14.0),
              Text(
                'Why scaffold and nav bar are separate widgets:\n'
                '• Scrolling under a translucent nav bar requires the '
                'scaffold to know about the bar\'s height so the body can '
                'inset itself.\n'
                '• You can swap the nav bar for a CupertinoSliverNavigationBar '
                'without changing the scaffold.',
                style: TextStyle(fontSize: 13.0, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _settingRow(String label, String trailing) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFFE5E5EA)),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 15.0),
          ),
        ),
        Text(
          trailing,
          style: const TextStyle(
            fontSize: 16.0,
            color: Color(0xFFC7C7CC),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// 8. Material AppBar vs Cupertino NavigationBar
// ============================================================================

Widget _buildAppBarComparisonCard() {
  return _section(
    title: '7. Cupertino vs Material chrome',
    subtitle: 'CupertinoNavigationBar vs Material AppBar — side by side',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                _phoneFrame(
                  width: 200.0,
                  height: 320.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 44.0,
                        color: const Color(0xCCF2F2F7),
                        alignment: Alignment.center,
                        child: const Text(
                          'Messages',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w600,
                            color: CupertinoColors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: CupertinoColors.white,
                          alignment: Alignment.center,
                          child: const Text('Cupertino body'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'CupertinoNavigationBar',
                  style:
                      TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                _phoneFrame(
                  width: 200.0,
                  height: 320.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 56.0,
                        color: const Color(0xFF6750A4),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: const <Widget>[
                            Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 22.0,
                            ),
                            SizedBox(width: 16.0),
                            Text(
                              'Messages',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 22.0,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: const Color(0xFFFFFBFE),
                          alignment: Alignment.center,
                          child: const Text('Material body'),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'Material AppBar',
                  style:
                      TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        _diffRow(
          property: 'Height',
          cupertino: '44 logical px',
          material: '56 logical px',
        ),
        _diffRow(
          property: 'Title alignment',
          cupertino: 'centered by default',
          material: 'leading-aligned by default',
        ),
        _diffRow(
          property: 'Title weight',
          cupertino: 'semibold (w600)',
          material: 'medium (w500)',
        ),
        _diffRow(
          property: 'Background',
          cupertino: 'translucent blur',
          material: 'opaque primary container',
        ),
        _diffRow(
          property: 'Elevation',
          cupertino: 'flat — uses a 1px hairline',
          material: 'tonal — uses a Material 3 surface tint',
        ),
        _diffRow(
          property: 'Action color',
          cupertino: 'theme primaryColor (e.g. systemBlue)',
          material: 'onPrimary (text on the primary container)',
        ),
      ],
    ),
  );
}

Widget _diffRow({
  required String property,
  required String cupertino,
  required String material,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Color(0xFFE5E5EA)),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130.0,
          child: Text(
            property,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            cupertino,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF0A84FF),
            ),
          ),
        ),
        Expanded(
          child: Text(
            material,
            style: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF6750A4),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// 9. Primary color cascade
// ============================================================================

Widget _buildPrimaryCascadeCard() {
  return _section(
    title: '8. Primary color cascade',
    subtitle:
        'CupertinoTheme primaryColor flows down to CupertinoButton tints',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Wrap a subtree in CupertinoTheme and every CupertinoButton inside '
          'inherits the new primaryColor and primaryContrastingColor. Below: '
          'three subtrees with three different tint colors — note how the '
          'filled buttons match their parent theme automatically without '
          'any explicit `color:` argument.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _cascadeColumn(
              CupertinoColors.systemBlue,
              CupertinoColors.white,
              'systemBlue',
            ),
            _cascadeColumn(
              CupertinoColors.systemRed,
              CupertinoColors.white,
              'systemRed',
            ),
            _cascadeColumn(
              CupertinoColors.systemGreen,
              CupertinoColors.black,
              'systemGreen',
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _cascadeColumn(Color primary, Color contrast, String label) {
  return CupertinoTheme(
    data: CupertinoThemeData(
      primaryColor: primary,
      primaryContrastingColor: contrast,
    ),
    child: SizedBox(
      width: 180.0,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 18.0,
            ),
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'Continue',
              style: TextStyle(
                color: contrast,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 18.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0x00000000),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: primary),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3A3A3C),
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// 10. CupertinoApp configuration sheet
// ============================================================================

Widget _buildCupertinoAppConfigCard() {
  // Note: we describe CupertinoApp configuration without rendering one as the
  // actual root widget. The "settings sheet" below visually documents each
  // constructor parameter.
  return _section(
    title: '9. CupertinoApp configuration sheet',
    subtitle: 'Every constructor parameter, rendered as a row',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'CupertinoApp is normally the topmost widget in your app. Here we '
          'document each of its key parameters as a row. The host test app '
          'already provides its own root, so we mock the configuration '
          'instead of attaching a real CupertinoApp.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        Container(
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFE5E5EA)),
          ),
          child: Column(
            children: <Widget>[
              _configRow(
                key: 'title',
                value: '\'CupertinoApp deep visual demo\'',
                hint: 'Used by the OS task switcher and assistive tech.',
              ),
              _configRow(
                key: 'theme',
                value: 'CupertinoThemeData(brightness: Brightness.light)',
                hint: 'Cascades brightness + primary color to descendants.',
              ),
              _configRow(
                key: 'color',
                value: 'CupertinoColors.systemBlue',
                hint:
                    'Primary color seen in the OS task-switcher card border.',
              ),
              _configRow(
                key: 'locale',
                value: 'Locale("en", "US")',
                hint:
                    'Pin the app locale; null delegates to system locale.',
              ),
              _configRow(
                key: 'supportedLocales',
                value: '[Locale("en"), Locale("es"), Locale("ja")]',
                hint: 'Which locales your strings are translated for.',
              ),
              _configRow(
                key: 'localizationsDelegates',
                value: '[DefaultCupertinoLocalizations.delegate]',
                hint:
                    'Provides the localized strings for built-in widgets.',
              ),
              _configRow(
                key: 'debugShowCheckedModeBanner',
                value: 'false',
                hint:
                    'Hides the "DEBUG" ribbon on debug builds (demo only).',
              ),
              _configRow(
                key: 'home',
                value: 'CupertinoPageScaffold(…)',
                hint: 'The widget shown when no routes are provided.',
              ),
              _configRow(
                key: 'routes',
                value: '{ "/settings": (ctx) => SettingsPage() }',
                hint: 'Static route table — keyed by string path.',
              ),
              _configRow(
                key: 'initialRoute',
                value: '\'/\'',
                hint: 'Which route to push first on app start.',
              ),
              _configRow(
                key: 'onGenerateRoute',
                value: '(settings) => CupertinoPageRoute(builder: …)',
                hint: 'Dynamic routing for parameterised paths.',
              ),
              _configRow(
                key: 'onUnknownRoute',
                value: '(settings) => CupertinoPageRoute(builder: …)',
                hint: 'Fallback when no matching route exists.',
              ),
              _configRow(
                key: 'navigatorKey',
                value: 'GlobalKey<NavigatorState>()',
                hint: 'Imperative navigation from outside the tree.',
              ),
              _configRow(
                key: 'navigatorObservers',
                value: '[MyAnalyticsObserver()]',
                hint: 'Hooks for push/pop events; analytics friendly.',
              ),
              _configRow(
                key: 'builder',
                value: '(context, child) => MediaQuery(data: …, child!)',
                hint:
                    'Wrap the entire navigator subtree with a custom layer.',
              ),
              _configRow(
                key: 'scrollBehavior',
                value: 'CupertinoScrollBehavior()',
                hint: 'iOS-style overscroll glow + bouncy physics.',
              ),
              _configRow(
                key: 'showSemanticsDebugger',
                value: 'false',
                hint: 'Overlay accessibility node tree for inspection.',
              ),
              _configRow(
                key: 'showPerformanceOverlay',
                value: 'false',
                hint: 'Display raster + GPU frame-time graphs.',
                last: true,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _configRow({
  required String key,
  required String value,
  required String hint,
  bool last = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: last ? const Color(0x00000000) : const Color(0xFFE5E5EA),
        ),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200.0,
          child: Text(
            key,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF5856D6),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: Color(0xFF1C1C1E),
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                hint,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: Color(0xFF6E6E73),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// 11. Light / dark switching strategy
// ============================================================================

Widget _buildLightDarkStrategyCard() {
  return _section(
    title: '10. Light / dark switching strategy',
    subtitle:
        'How CupertinoApp picks a brightness — and how to override it',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'There are three layers that decide which brightness a Cupertino '
          'subtree renders under:',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 10.0),
        const Text(
          '1. The OS — MediaQuery.platformBrightnessOf(context). Reflects '
          'the user\'s system-wide light/dark preference.',
          style: TextStyle(fontSize: 13.0, height: 1.5),
        ),
        const SizedBox(height: 6.0),
        const Text(
          '2. The CupertinoApp `theme` — if you set CupertinoThemeData('
          'brightness: Brightness.dark), the entire app forces dark.',
          style: TextStyle(fontSize: 13.0, height: 1.5),
        ),
        const SizedBox(height: 6.0),
        const Text(
          '3. A nested CupertinoTheme — lets a subtree opt out of the '
          'top-level brightness. Useful for in-app preview cards.',
          style: TextStyle(fontSize: 13.0, height: 1.5),
        ),
        const SizedBox(height: 18.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _strategyCard(
              brightness: Brightness.light,
              title: 'Before',
              body:
                  'OS is light → CupertinoApp inherits light → child renders '
                  'light without doing anything.',
            ),
            _strategyCard(
              brightness: Brightness.dark,
              title: 'After',
              body:
                  'OS is dark → CupertinoApp inherits dark → labels, '
                  'separators, and backgrounds invert automatically.',
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9E6),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: const Color(0xFFFFE69C)),
          ),
          child: const Text(
            'Recommended: leave CupertinoApp.theme null in production so the '
            'app follows the OS, and only set brightness explicitly inside '
            'specific previews (in-app themed sheets, marketing screens).',
            style: TextStyle(fontSize: 12.5, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _strategyCard({
  required Brightness brightness,
  required String title,
  required String body,
}) {
  final bool isDark = brightness == Brightness.dark;
  final Color bg =
      isDark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  final Color fg =
      isDark ? const Color(0xFFFFFFFF) : const Color(0xFF1C1C1E);
  final Color sub =
      isDark ? const Color(0xFFAEAEB2) : const Color(0xFF6E6E73);

  return _phoneFrame(
    width: 220.0,
    height: 230.0,
    child: Container(
      color: bg,
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: fg,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            body,
            style: TextStyle(
              fontSize: 12.5,
              color: sub,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// 12. Cupertino components catalogue (mini)
// ============================================================================

Widget _buildComponentsCatalogCard() {
  return _section(
    title: '11. iOS components catalogue',
    subtitle:
        'CupertinoButton · CupertinoSwitch · CupertinoSlider · '
        'CupertinoSegmentedControl',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A sampler of the day-to-day Cupertino input widgets. All shown '
          'with static values — the demo never mutates state.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        _catalogRow(
          name: 'CupertinoButton',
          example: CupertinoButton(
            color: CupertinoColors.systemBlue,
            padding: const EdgeInsets.symmetric(
              horizontal: 22.0,
              vertical: 10.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
            onPressed: _noop,
            child: const Text(
              'Continue',
              style: TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          note:
              'Filled and borderless variants exist. Borderless looks like '
              'a tinted text label.',
        ),
        _catalogRow(
          name: 'CupertinoSwitch',
          example: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CupertinoSwitch(value: true, onChanged: _noopBool),
              const SizedBox(width: 8.0),
              CupertinoSwitch(value: false, onChanged: _noopBool),
            ],
          ),
          note:
              'iOS-style toggle with a moving knob. Reads `value: bool` and '
              'fires `onChanged: (bool) {}`.',
        ),
        _catalogRow(
          name: 'CupertinoSlider',
          example: SizedBox(
            width: 200.0,
            child: CupertinoSlider(value: 0.5, onChanged: _noopDouble),
          ),
          note:
              'Floating-point slider 0..1. Theme primary color tints the '
              'filled bar.',
        ),
        _catalogRow(
          name: 'CupertinoSegmentedControl',
          example: CupertinoSegmentedControl<int>(
            groupValue: 1,
            onValueChanged: _noopInt,
            children: const <int, Widget>{
              0: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Day'),
              ),
              1: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Week'),
              ),
              2: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text('Month'),
              ),
            },
          ),
          note:
              'Mutually exclusive picker. Highlights the active segment '
              'with the theme primaryColor.',
        ),
      ],
    ),
  );
}

void _noop() {}
void _noopBool(bool _) {}
void _noopDouble(double _) {}
void _noopInt(int _) {}

Widget _catalogRow({
  required String name,
  required Widget example,
  required String note,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFE5E5EA)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 220.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5856D6),
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                note,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF6E6E73),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: example,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// 13. Footer
// ============================================================================

Widget _buildFooterCard() {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: const Color(0xFF1C1C1E),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Recap',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'CupertinoApp gives a Flutter app iOS chrome: HIG-aligned '
          'typography, system colors, sliding routes, and dynamic dark '
          'mode. Most apps only configure 4–5 fields (title, theme, home, '
          'routes, supportedLocales) and let the OS drive the rest.',
          style: TextStyle(
            color: Color(0xFFE5E5EA),
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Shared helpers
// ============================================================================

Widget _section({
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: CupertinoColors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: const Color(0xFFE5E5EA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF6E6E73),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        child,
      ],
    ),
  );
}

Widget _phoneFrame({
  required double width,
  required double height,
  required Widget child,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: const Color(0xFF000000),
      borderRadius: BorderRadius.circular(28.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    padding: const EdgeInsets.all(6.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(22.0),
      child: child,
    ),
  );
}
