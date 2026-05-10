// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// BackButton visual deep demo.
import 'package:flutter/material.dart';

// Design tokens.

const Color kBgDeep = Color(0xFF0F1115);
const Color kBgPanel = Color(0xFF161A22);
const Color kBgPanelAlt = Color(0xFF1B2030);
const Color kBgCard = Color(0xFF1F2533);
const Color kBgCardAlt = Color(0xFF252C3D);
const Color kBorder = Color(0xFF2D3548);
const Color kBorderSoft = Color(0xFF394056);
const Color kAccent = Color(0xFF5BA8FF);
const Color kAccentDeep = Color(0xFF2F77D8);
const Color kAccentSoft = Color(0xFF8FC0FF);
const Color kSuccess = Color(0xFF4CD471);
const Color kWarn = Color(0xFFE8B23A);
const Color kDanger = Color(0xFFE36366);
const Color kInfo = Color(0xFF7BD7E8);
const Color kIos = Color(0xFFB6B6BC);
const Color kAndroid = Color(0xFFA4C639);
const Color kFuchsia = Color(0xFFE765D6);
const Color kTextHi = Color(0xFFEDF1F8);
const Color kTextMid = Color(0xFFB6BDCC);
const Color kTextLo = Color(0xFF7C8497);
const Color kCode = Color(0xFFDFD6FF);
const Color kCodeBg = Color(0xFF11131A);

const double kHeroHeight = 280.0;
const double kSectionGap = 24.0;
const double kCardGap = 16.0;
const double kRadius = 14.0;
const double kRadiusSmall = 8.0;

// =====================================================================
//                             HELPERS
// =====================================================================

/// A tiny helper that wraps a child in a panel with a header row.
Widget panel({
  required String title,
  required String subtitle,
  required Widget child,
  Color background = kBgPanel,
  Color accent = kAccent,
}) {
  return Container(
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(kRadius),
      border: Border.all(color: kBorder),
    ),
    padding: EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 22.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: kTextHi,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Text(
            subtitle,
            style: TextStyle(
              color: kTextLo,
              fontSize: 12.5,
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        child,
      ],
    ),
  );
}

/// Renders a small caption row (label + value).
Widget kvRow(String label, String value, {Color? color}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130.0,
          child: Text(
            label,
            style: TextStyle(
              color: kTextLo,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: color ?? kTextHi,
              fontSize: 12.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

/// Renders a code listing block with monospace styling.
Widget codeBlock(String code, {String? caption}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: kCodeBg,
      borderRadius: BorderRadius.circular(kRadiusSmall),
      border: Border.all(color: kBorder),
    ),
    padding: EdgeInsets.all(14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (caption != null) ...[
          Text(
            caption,
            style: TextStyle(
              color: kAccentSoft,
              fontSize: 11.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 8.0),
        ],
        Text(
          code,
          style: TextStyle(
            color: kCode,
            fontSize: 12.0,
            fontFamily: 'monospace',
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

/// Renders a tag pill.
Widget pill(String text, {Color color = kAccent, IconData? icon}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Color.alphaBlend(color.withAlpha(40), kBgPanel),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 12.0, color: color),
          SizedBox(width: 5.0),
        ],
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

/// A bullet line, used inside lists.
Widget bullet(String text, {Color color = kTextMid, IconData? icon}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon ?? Icons.chevron_right,
          size: 14.0,
          color: kAccentSoft,
        ),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Section header used between major demo blocks.
Widget sectionHeader(String number, String title, String subtitle) {
  return Padding(
    padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: kAccentDeep,
            borderRadius: BorderRadius.circular(8.0),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: kTextHi,
              fontWeight: FontWeight.w800,
              fontSize: 14.0,
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: kTextHi,
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: kTextLo,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Returns a soft divider line.
Widget softDivider() {
  return Container(
    height: 1.0,
    margin: EdgeInsets.symmetric(vertical: 12.0),
    color: kBorderSoft,
  );
}

// =====================================================================
//                       SECTION 1 - HERO BANNER
// =====================================================================

Widget buildHeroBanner() {
  return Container(
    height: kHeroHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(kRadius),
      gradient: LinearGradient(
        colors: [Color(0xFF1B2A4E), Color(0xFF24365B), Color(0xFF13182A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: kBorderSoft),
    ),
    padding: EdgeInsets.all(28.0),
    child: Row(
      children: [
        // Left: title block.
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  pill('material', color: kAccent, icon: Icons.layers),
                  SizedBox(width: 8.0),
                  pill('navigation', color: kInfo, icon: Icons.navigation),
                  SizedBox(width: 8.0),
                  pill('icon button', color: kSuccess, icon: Icons.touch_app),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'BackButton',
                style: TextStyle(
                  color: kTextHi,
                  fontSize: 38.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Platform-aware Material back-arrow that pops the\n'
                'enclosing Navigator via Navigator.maybePop.',
                style: TextStyle(
                  color: kTextMid,
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  pill('Navigator.maybePop', color: kAccentSoft),
                  SizedBox(width: 8.0),
                  pill('AppBar.leading', color: kFuchsia),
                  SizedBox(width: 8.0),
                  pill('iOS chevron', color: kIos),
                  SizedBox(width: 8.0),
                  pill('Android arrow', color: kAndroid),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 24.0),
        // Right: stylized icon graphic.
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              color: kBgPanel,
              borderRadius: BorderRadius.circular(kRadius),
              border: Border.all(color: kBorder),
            ),
            padding: EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _heroIconTile(Icons.arrow_back, 'Android', kAndroid),
                    _heroIconTile(Icons.arrow_back_ios_new, 'iOS', kIos),
                    _heroIconTile(
                      Icons.arrow_back_rounded,
                      'fuchsia',
                      kFuchsia,
                    ),
                  ],
                ),
                SizedBox(height: 14.0),
                Text(
                  'BackButtonIcon adapts to the host platform',
                  style: TextStyle(color: kTextMid, fontSize: 12.0),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _heroIconTile(IconData icon, String label, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          color: kBgCardAlt,
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(color: color),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: color, size: 26.0),
      ),
      SizedBox(height: 6.0),
      Text(
        label,
        style: TextStyle(color: kTextMid, fontSize: 11.0),
      ),
    ],
  );
}

// =====================================================================
//                  SECTION 2 - BACKBUTTON ANATOMY
// =====================================================================

Widget buildAnatomySection() {
  return panel(
    title: 'Anatomy of a BackButton',
    subtitle:
        'BackButton is a thin wrapper around IconButton. It draws a '
        'BackButtonIcon, applies the standard 48x48 hit target, and '
        'invokes Navigator.maybePop on tap when no onPressed is given.',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                height: 220.0,
                decoration: BoxDecoration(
                  color: kBgCard,
                  borderRadius: BorderRadius.circular(kRadiusSmall),
                  border: Border.all(color: kBorderSoft),
                ),
                alignment: Alignment.center,
                child: BackButton(
                  color: kAccent,
                  onPressed: () {},
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kvRow('widget', 'BackButton', color: kAccent),
                  kvRow('extends', 'StatelessWidget'),
                  kvRow('renders', 'IconButton(icon: BackButtonIcon())'),
                  kvRow('hit target', '48.0 x 48.0 logical px'),
                  kvRow('default tooltip', 'MaterialLocalizations.backButtonTooltip'),
                  kvRow('default onPressed', 'Navigator.maybePop(context)'),
                  kvRow('color param', 'Color? - icon color'),
                  kvRow('style param', 'ButtonStyle? - merged with theme'),
                  kvRow('onPressed param', 'VoidCallback? - tap handler'),
                ],
              ),
            ),
          ],
        ),
        softDivider(),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            pill('icon: BackButtonIcon', color: kAccent),
            pill('ripple: InkResponse', color: kInfo),
            pill('padding: 8.0', color: kSuccess),
            pill('constraints: 48x48', color: kWarn),
            pill('tooltip: localised', color: kFuchsia),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'The widget itself is fewer than 30 lines in '
          'flutter/lib/src/material/back_button.dart - it forwards everything '
          'to IconButton with sensible defaults so calling sites stay terse.',
          style: TextStyle(color: kTextMid, fontSize: 12.5, height: 1.45),
        ),
      ],
    ),
  );
}

// =====================================================================
//             SECTION 3 - PLATFORM ICON COMPARISON PANEL
// =====================================================================

Widget buildPlatformIconPanel() {
  return panel(
    title: 'Platform icon resolution',
    subtitle:
        'BackButtonIcon picks a platform-appropriate glyph based on '
        'Theme.of(context).platform. The mapping below is the one used '
        'by the framework in back_button.dart.',
    child: Column(
      children: [
        Row(
          children: [
            Expanded(child: _platformTile(
              platform: 'Android',
              color: kAndroid,
              icon: Icons.arrow_back,
              tokenName: 'Icons.arrow_back',
              note: 'Default Material arrow.',
            )),
            SizedBox(width: 10.0),
            Expanded(child: _platformTile(
              platform: 'iOS',
              color: kIos,
              icon: Icons.arrow_back_ios_new,
              tokenName: 'Icons.arrow_back_ios_new',
              note: 'Thin chevron, matches UINavigationBar.',
            )),
            SizedBox(width: 10.0),
            Expanded(child: _platformTile(
              platform: 'macOS',
              color: kIos,
              icon: Icons.arrow_back_ios_new,
              tokenName: 'Icons.arrow_back_ios_new',
              note: 'Same chevron as iOS.',
            )),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(child: _platformTile(
              platform: 'Linux',
              color: kAccent,
              icon: Icons.arrow_back,
              tokenName: 'Icons.arrow_back',
              note: 'Falls back to Android arrow.',
            )),
            SizedBox(width: 10.0),
            Expanded(child: _platformTile(
              platform: 'Windows',
              color: kAccent,
              icon: Icons.arrow_back,
              tokenName: 'Icons.arrow_back',
              note: 'Falls back to Android arrow.',
            )),
            SizedBox(width: 10.0),
            Expanded(child: _platformTile(
              platform: 'Fuchsia',
              color: kFuchsia,
              icon: Icons.arrow_back,
              tokenName: 'Icons.arrow_back',
              note: 'Falls back to Android arrow.',
            )),
          ],
        ),
        SizedBox(height: 14.0),
        codeBlock(
          'switch (Theme.of(context).platform) {\n'
          '  case TargetPlatform.android:\n'
          '  case TargetPlatform.fuchsia:\n'
          '  case TargetPlatform.linux:\n'
          '  case TargetPlatform.windows:\n'
          '    return const Icon(Icons.arrow_back);\n'
          '  case TargetPlatform.iOS:\n'
          '  case TargetPlatform.macOS:\n'
          '    return const Icon(Icons.arrow_back_ios_new);\n'
          '}',
          caption: 'BackButtonIcon.build (paraphrased)',
        ),
      ],
    ),
  );
}

Widget _platformTile({
  required String platform,
  required Color color,
  required IconData icon,
  required String tokenName,
  required String note,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(kRadiusSmall),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: kBgCardAlt,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: color),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: color, size: 18.0),
            ),
            SizedBox(width: 8.0),
            Text(
              platform,
              style: TextStyle(
                color: color,
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          tokenName,
          style: TextStyle(
            color: kCode,
            fontSize: 11.0,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          note,
          style: TextStyle(color: kTextLo, fontSize: 11.0),
        ),
      ],
    ),
  );
}

// =====================================================================
//             SECTION 4 - APPBAR + BACKBUTTON GALLERY
// =====================================================================

Widget buildAppBarGallery() {
  return panel(
    title: 'AppBar + BackButton gallery',
    subtitle:
        'Four typical AppBar configurations. Each card embeds a real '
        'AppBar with BackButton acting as `leading`.',
    accent: kFuchsia,
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _appBarCard(
              label: 'Default',
              description: 'BackButton with framework defaults.',
              appBar: AppBar(
                backgroundColor: kBgCard,
                foregroundColor: kTextHi,
                leading: BackButton(onPressed: () {}),
                title: Text('Inbox'),
              ),
            )),
            SizedBox(width: kCardGap),
            Expanded(child: _appBarCard(
              label: 'Custom color',
              description: 'BackButton(color: Color(0xFFE8B23A))',
              appBar: AppBar(
                backgroundColor: kBgCard,
                foregroundColor: kTextHi,
                leading: BackButton(
                  color: kWarn,
                  onPressed: () {},
                ),
                title: Text('Settings'),
              ),
            )),
          ],
        ),
        SizedBox(height: kCardGap),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _appBarCard(
              label: 'Custom onPressed',
              description: 'Override pop behaviour with a callback.',
              appBar: AppBar(
                backgroundColor: kBgCard,
                foregroundColor: kTextHi,
                leading: BackButton(onPressed: () {}),
                title: Text('Compose'),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send, color: kAccent),
                  ),
                ],
              ),
            )),
            SizedBox(width: kCardGap),
            Expanded(child: _appBarCard(
              label: 'Hero-tag context',
              description: 'BackButton inside a Hero-decorated AppBar.',
              appBar: AppBar(
                backgroundColor: kAccentDeep,
                foregroundColor: kTextHi,
                leading: BackButton(
                  color: kTextHi,
                  onPressed: () {},
                ),
                title: Text('Detail'),
                elevation: 4.0,
              ),
            )),
          ],
        ),
        SizedBox(height: kCardGap),
        codeBlock(
          'Scaffold(\n'
          '  appBar: AppBar(\n'
          '    leading: BackButton(\n'
          '      color: Colors.amber,\n'
          '      onPressed: () => Navigator.of(context).maybePop(),\n'
          '    ),\n'
          '    title: const Text(\'Settings\'),\n'
          '  ),\n'
          '  body: const SizedBox.expand(),\n'
          ');',
          caption: 'Recipe: AppBar with custom-coloured BackButton',
        ),
      ],
    ),
  );
}

Widget _appBarCard({
  required String label,
  required String description,
  required PreferredSizeWidget appBar,
}) {
  return Container(
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(kRadiusSmall),
      border: Border.all(color: kBorderSoft),
    ),
    padding: EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            pill(label, color: kAccent),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(color: kTextLo, fontSize: 11.5),
        ),
        SizedBox(height: 10.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: SizedBox(
            height: 56.0,
            child: appBar,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: kBgCardAlt,
            borderRadius: BorderRadius.circular(6.0),
          ),
          alignment: Alignment.center,
          child: Text(
            'page body',
            style: TextStyle(color: kTextLo, fontSize: 11.0),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
//          SECTION 5 - BACKBUTTONICON STANDALONE USAGE
// =====================================================================

Widget buildBackButtonIconCard() {
  return panel(
    title: 'BackButtonIcon - standalone usage',
    subtitle:
        'BackButtonIcon is a stateless widget you can drop into your '
        'own controls when you only need the platform-aware glyph '
        'without IconButton wrapping or pop behaviour.',
    accent: kInfo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: kBgCard,
                  borderRadius: BorderRadius.circular(kRadiusSmall),
                  border: Border.all(color: kBorderSoft),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            BackButtonIcon(),
                            SizedBox(height: 6.0),
                            Text(
                              'default',
                              style: TextStyle(color: kTextLo, fontSize: 11.0),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.arrow_back, color: kAccent, size: 24.0),
                            SizedBox(height: 6.0),
                            Text(
                              'arrow',
                              style: TextStyle(color: kTextLo, fontSize: 11.0),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new,
                              color: kAccent,
                              size: 22.0,
                            ),
                            SizedBox(height: 6.0),
                            Text(
                              'chevron',
                              style: TextStyle(color: kTextLo, fontSize: 11.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bullet('It is a Widget, not just an IconData.'),
                  bullet(
                    'Reads platform from the surrounding Theme - so '
                    'wrapping in a custom Theme can force a glyph.',
                  ),
                  bullet(
                    'Use inside custom buttons, GestureDetectors or '
                    'any place an Icon would normally go.',
                  ),
                  bullet(
                    'No tap behaviour - you wire your own onTap.',
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        codeBlock(
          'GestureDetector(\n'
          '  onTap: () => Navigator.of(context).maybePop(),\n'
          '  child: Padding(\n'
          '    padding: const EdgeInsets.all(8.0),\n'
          '    child: const BackButtonIcon(),\n'
          '  ),\n'
          ');',
          caption: 'Recipe: BackButtonIcon inside a custom tap region',
        ),
      ],
    ),
  );
}

// =====================================================================
//                  SECTION 6 - CLOSE BUTTON PANEL
// =====================================================================

Widget buildCloseButtonPanel() {
  return panel(
    title: 'CloseButton - the X sibling',
    subtitle:
        'CloseButton is structurally identical to BackButton but '
        'renders Icons.close instead of BackButtonIcon. It is the '
        'idiomatic way to dismiss a full-screen dialog or modal page.',
    accent: kDanger,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                height: 200.0,
                decoration: BoxDecoration(
                  color: kBgCard,
                  borderRadius: BorderRadius.circular(kRadiusSmall),
                  border: Border.all(color: kBorderSoft),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CloseButton(
                      color: kDanger,
                      onPressed: () {},
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'CloseButton',
                      style: TextStyle(color: kTextHi, fontSize: 12.0),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kvRow('widget', 'CloseButton', color: kDanger),
                  kvRow('icon', 'Icons.close'),
                  kvRow('tooltip', 'MaterialLocalizations.closeButtonTooltip'),
                  kvRow(
                    'default onPressed',
                    'Navigator.maybePop(context)',
                  ),
                  kvRow('typical use', 'fullscreen dialogs / modal sheets'),
                  kvRow('color param', 'Color? icon tint'),
                  kvRow('style param', 'ButtonStyle? merged with theme'),
                ],
              ),
            ),
          ],
        ),
        softDivider(),
        codeBlock(
          'Scaffold(\n'
          '  appBar: AppBar(\n'
          '    leading: const CloseButton(),\n'
          '    title: const Text(\'New message\'),\n'
          '  ),\n'
          '  body: ...,\n'
          ');',
          caption: 'Recipe: fullscreenDialog dismissal with CloseButton',
        ),
        SizedBox(height: 10.0),
        bullet(
          'When AppBar has fullscreenDialog: true, Flutter automatically '
          'inserts CloseButton instead of BackButton as the leading.',
          color: kTextMid,
        ),
        bullet(
          'Both buttons go through the same Navigator.maybePop path - '
          'so both also respect WillPopScope / PopScope guards.',
          color: kTextMid,
        ),
      ],
    ),
  );
}

// =====================================================================
//          SECTION 7 - BACKBUTTONLISTENER EXPLAINER PANEL
// =====================================================================

Widget buildBackButtonListenerPanel() {
  return panel(
    title: 'BackButtonListener - intercept the system back',
    subtitle:
        'BackButtonListener is part of the Router (Navigator 2.0) API. '
        'It registers a callback with the nearest BackButtonDispatcher '
        'so a child widget can claim the system back button.',
    accent: kSuccess,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bullet(
                    'onBackButtonPressed returns Future<bool>.',
                    color: kTextMid,
                  ),
                  bullet(
                    'Return true to claim the event - the Router will '
                    'NOT pop a route.',
                    color: kTextMid,
                  ),
                  bullet(
                    'Return false to let the next listener (or the '
                    'Router) handle the event.',
                    color: kTextMid,
                  ),
                  bullet(
                    'Multiple listeners stack: nearest in the tree '
                    'wins first.',
                    color: kTextMid,
                  ),
                  bullet(
                    'Requires a Router ancestor - it does NOT work in '
                    'pure Navigator 1.0 apps.',
                    color: kTextMid,
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              flex: 6,
              child: codeBlock(
                'BackButtonListener(\n'
                '  onBackButtonPressed: () async {\n'
                '    if (hasUnsavedDraft) {\n'
                '      await showSavePrompt(context);\n'
                '      return true;  // claimed\n'
                '    }\n'
                '    return false;  // bubble up\n'
                '  },\n'
                '  child: editorPage,\n'
                ');',
                caption: 'BackButtonListener typical wiring',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// =====================================================================
//        SECTION 8 - WILLPOPSCOPE -> POPSCOPE MIGRATION
// =====================================================================

Widget buildWillPopMigrationPanel() {
  return panel(
    title: 'WillPopScope (deprecated) -> PopScope migration',
    subtitle:
        'WillPopScope was deprecated in Flutter 3.12 in favour of '
        'PopScope. The new API plays nicely with Android predictive '
        'back gestures and the new Router-aware pop semantics.',
    accent: kWarn,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: codeBlock(
                'WillPopScope(\n'
                '  onWillPop: () async {\n'
                '    if (form.isDirty) {\n'
                '      final ok = await confirm();\n'
                '      return ok;\n'
                '    }\n'
                '    return true;\n'
                '  },\n'
                '  child: page,\n'
                ');',
                caption: 'BEFORE - WillPopScope (deprecated)',
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: codeBlock(
                'PopScope(\n'
                '  canPop: !form.isDirty,\n'
                '  onPopInvoked: (didPop) async {\n'
                '    if (didPop) return;\n'
                '    final ok = await confirm();\n'
                '    if (ok && context.mounted) {\n'
                '      Navigator.of(context).pop();\n'
                '    }\n'
                '  },\n'
                '  child: page,\n'
                ');',
                caption: 'AFTER - PopScope (Flutter 3.12+)',
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color.alphaBlend(kWarn.withAlpha(30), kBgCard),
            borderRadius: BorderRadius.circular(kRadiusSmall),
            border: Border.all(color: kWarn),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber, color: kWarn, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'WillPopScope is still functional but emits a '
                  'deprecation warning. New code should always use '
                  'PopScope. The two cannot be mixed safely on the '
                  'same subtree.',
                  style: TextStyle(color: kTextHi, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        bullet(
          'canPop is checked synchronously - a guard that always says '
          'no will block the predictive back gesture entirely.',
          color: kTextMid,
        ),
        bullet(
          'onPopInvoked fires even when the pop was vetoed; inspect '
          'didPop to know whether the route actually popped.',
          color: kTextMid,
        ),
        bullet(
          'BackButton (and the system back gesture) both go through '
          'this guard - so a single PopScope covers all entry points.',
          color: kTextMid,
        ),
      ],
    ),
  );
}

// =====================================================================
//             SECTION 9 - RECIPE LISTING (CODE FOCUS)
// =====================================================================

Widget buildRecipeListing() {
  return panel(
    title: 'Recipe: Scaffold + AppBar + BackButton',
    subtitle:
        'A complete, copy-paste-ready snippet showing the canonical '
        'BackButton wiring. Read top-down.',
    accent: kAccentSoft,
    child: codeBlock(
      'class DetailPage extends StatelessWidget {\n'
      '  const DetailPage({super.key, required this.title});\n'
      '  final String title;\n\n'
      '  @override\n'
      '  Widget build(BuildContext context) {\n'
      '    return Scaffold(\n'
      '      appBar: AppBar(\n'
      '        leading: BackButton(\n'
      '          color: Theme.of(context).colorScheme.primary,\n'
      '          onPressed: () {\n'
      '            // Custom analytics, then default pop.\n'
      '            // analytics.logBackTap();\n'
      '            Navigator.of(context).maybePop();\n'
      '          },\n'
      '        ),\n'
      '        title: Text(title),\n'
      '      ),\n'
      '      body: const SizedBox.expand(),\n'
      '    );\n'
      '  }\n'
      '}',
      caption: 'lib/pages/detail_page.dart',
    ),
  );
}

// =====================================================================
//   SECTION 10 - BEHAVIOUR ON ROOT NAVIGATOR (NO ROUTE TO POP)
// =====================================================================

Widget buildRootNavigatorPanel() {
  return panel(
    title: 'Behaviour at the root of the Navigator stack',
    subtitle:
        'When BackButton is rendered on the very first route, '
        'Navigator.maybePop has nothing to pop. The framework leaves '
        'the screen exactly as-is - no exception, no animation.',
    accent: kInfo,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _stateTile(
                title: 'canPop == true',
                detail: 'BackButton invokes Navigator.pop and the route '
                    'animates out.',
                icon: Icons.check_circle,
                color: kSuccess,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _stateTile(
                title: 'canPop == false',
                detail: 'BackButton renders normally but maybePop becomes '
                    'a no-op. The visible state is unchanged.',
                icon: Icons.do_not_disturb_on,
                color: kWarn,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _stateTile(
                title: 'fullscreenDialog',
                detail: 'CloseButton replaces BackButton automatically; '
                    'the same maybePop logic applies.',
                icon: Icons.close,
                color: kDanger,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        codeBlock(
          'final canPop = Navigator.of(context).canPop();\n'
          'if (canPop) {\n'
          '  Navigator.of(context).pop();\n'
          '} else {\n'
          '  // Root route - nothing to do.\n'
          '}',
          caption: 'Equivalent of BackButton.onPressed default',
        ),
      ],
    ),
  );
}

Widget _stateTile({
  required String title,
  required String detail,
  required IconData icon,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(kRadiusSmall),
      border: Border.all(color: kBorderSoft),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          detail,
          style: TextStyle(color: kTextMid, fontSize: 11.5, height: 1.4),
        ),
      ],
    ),
  );
}

// =====================================================================
//                    SECTION 11 - PITFALLS PANEL
// =====================================================================

Widget buildPitfallsPanel() {
  return panel(
    title: 'Pitfalls and gotchas',
    subtitle:
        'A collection of common mistakes when working with BackButton '
        'and its relatives. Each item is paired with the recommended '
        'fix.',
    accent: kDanger,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _pitfall(
          title: 'BackButton on root route',
          problem: 'Tapping does nothing because there is nothing to pop.',
          fix: 'Hide the leading widget when Navigator.canPop() == false, '
              'or override onPressed to exit the app.',
        ),
        _pitfall(
          title: 'Custom onPressed forgetting to pop',
          problem: 'Providing onPressed replaces the default behaviour - '
              'Navigator.maybePop is no longer called.',
          fix: 'In the callback, call Navigator.of(context).maybePop() '
              'after performing the side effect.',
        ),
        _pitfall(
          title: 'WillPopScope drift',
          problem: 'WillPopScope is deprecated since Flutter 3.12 and '
              'misbehaves with Android predictive back gesture.',
          fix: 'Migrate to PopScope; canPop + onPopInvoked replace '
              'onWillPop.',
        ),
        _pitfall(
          title: 'BackButtonListener without Router',
          problem: 'BackButtonListener throws if no Router ancestor is '
              'present - common when used in a vanilla MaterialApp.',
          fix: 'Switch to PopScope, or use MaterialApp.router with a '
              'RouterDelegate.',
        ),
        _pitfall(
          title: 'Nested Navigators confusion',
          problem: 'BackButton always pops the nearest Navigator. With '
              'nested Navigators this might pop the inner stack only.',
          fix: 'Pass a custom onPressed that calls '
              'Navigator.of(context, rootNavigator: true).maybePop().',
        ),
        _pitfall(
          title: 'Localised tooltip overridden',
          problem: 'Setting style or wrapping the BackButton in a Tooltip '
              'replaces the built-in localised "Back" text.',
          fix: 'Prefer leaving the default tooltip in place; if you must '
              'override, supply a localised string from your own ARB.',
        ),
      ],
    ),
  );
}

Widget _pitfall({
  required String title,
  required String problem,
  required String fix,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kBgCard,
        borderRadius: BorderRadius.circular(kRadiusSmall),
        border: Border.all(color: kBorderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: kDanger, size: 16.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: kDanger,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            'Problem: $problem',
            style: TextStyle(color: kTextMid, fontSize: 12.0, height: 1.4),
          ),
          SizedBox(height: 4.0),
          Text(
            'Fix: $fix',
            style: TextStyle(color: kSuccess, fontSize: 12.0, height: 1.4),
          ),
        ],
      ),
    ),
  );
}

// =====================================================================
//                    SECTION 12 - REFERENCE TABLE
// =====================================================================

Widget buildReferenceTable() {
  return panel(
    title: 'Reference - BackButton family at a glance',
    subtitle:
        'Quick comparison table covering the five widgets in this demo.',
    accent: kAccent,
    child: Column(
      children: [
        _refRow(
          name: 'BackButton',
          purpose: 'Material back-arrow icon button',
          location: 'flutter/material',
          deprecated: false,
        ),
        _refRow(
          name: 'BackButtonIcon',
          purpose: 'Platform-aware icon used by BackButton',
          location: 'flutter/material',
          deprecated: false,
        ),
        _refRow(
          name: 'CloseButton',
          purpose: 'Material X-icon button (modal dismiss)',
          location: 'flutter/material',
          deprecated: false,
        ),
        _refRow(
          name: 'BackButtonListener',
          purpose: 'Intercepts system back via Router',
          location: 'flutter/widgets',
          deprecated: false,
        ),
        _refRow(
          name: 'WillPopScope',
          purpose: 'Legacy pop guard (use PopScope instead)',
          location: 'flutter/widgets',
          deprecated: true,
        ),
        _refRow(
          name: 'PopScope',
          purpose: 'Modern pop guard (Flutter 3.12+)',
          location: 'flutter/widgets',
          deprecated: false,
        ),
      ],
    ),
  );
}

Widget _refRow({
  required String name,
  required String purpose,
  required String location,
  required bool deprecated,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: kBgCard,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: kBorderSoft),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 160.0,
          child: Text(
            name,
            style: TextStyle(
              color: deprecated ? kDanger : kAccent,
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            purpose,
            style: TextStyle(color: kTextMid, fontSize: 12.0),
          ),
        ),
        SizedBox(
          width: 130.0,
          child: Text(
            location,
            style: TextStyle(
              color: kTextLo,
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 100.0,
          child: deprecated
              ? pill('DEPRECATED', color: kDanger)
              : pill('current', color: kSuccess),
        ),
      ],
    ),
  );
}

// =====================================================================
//                          FOOTER
// =====================================================================

Widget buildFooter() {
  return Container(
    margin: EdgeInsets.only(top: 24.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: kBgPanelAlt,
      borderRadius: BorderRadius.circular(kRadius),
      border: Border.all(color: kBorderSoft),
    ),
    child: Row(
      children: [
        Icon(Icons.arrow_back, color: kAccent, size: 20.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'BackButton visual demo - covers BackButton, BackButtonIcon, '
            'CloseButton, BackButtonListener, WillPopScope (deprecated) '
            'and PopScope migration. Single static build entry, no '
            'state, no async.',
            style: TextStyle(color: kTextMid, fontSize: 12.0, height: 1.45),
          ),
        ),
        SizedBox(width: 10.0),
        pill('flutter/material', color: kAccent),
        SizedBox(width: 6.0),
        pill('static demo', color: kSuccess),
      ],
    ),
  );
}

// =====================================================================
//                    BUILD - SINGLE STATIC ENTRY
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: kBgDeep,
      colorScheme: ColorScheme.dark(
        primary: kAccent,
        secondary: kAccentSoft,
        surface: kBgPanel,
      ),
    ),
    home: Scaffold(
      backgroundColor: kBgDeep,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Section 1.
              buildHeroBanner(),
              SizedBox(height: kSectionGap),

              // Section 2.
              sectionHeader(
                '01',
                'Anatomy',
                'BackButton internals - icon, ripple, padding, '
                    'constraints, tooltip.',
              ),
              buildAnatomySection(),
              SizedBox(height: kSectionGap),

              // Section 3.
              sectionHeader(
                '02',
                'Platform icon resolution',
                'How BackButtonIcon picks an icon per TargetPlatform.',
              ),
              buildPlatformIconPanel(),
              SizedBox(height: kSectionGap),

              // Section 4.
              sectionHeader(
                '03',
                'AppBar gallery',
                'Four real AppBar configurations using BackButton as '
                    'leading.',
              ),
              buildAppBarGallery(),
              SizedBox(height: kSectionGap),

              // Section 5.
              sectionHeader(
                '04',
                'BackButtonIcon standalone',
                'Use the platform glyph in your own controls.',
              ),
              buildBackButtonIconCard(),
              SizedBox(height: kSectionGap),

              // Section 6.
              sectionHeader(
                '05',
                'CloseButton',
                'The X sibling - same wiring, different glyph.',
              ),
              buildCloseButtonPanel(),
              SizedBox(height: kSectionGap),

              // Section 7.
              sectionHeader(
                '06',
                'BackButtonListener',
                'Intercept the system back inside Router-based apps.',
              ),
              buildBackButtonListenerPanel(),
              SizedBox(height: kSectionGap),

              // Section 8.
              sectionHeader(
                '07',
                'WillPopScope -> PopScope',
                'Migration path for the deprecated pop guard.',
              ),
              buildWillPopMigrationPanel(),
              SizedBox(height: kSectionGap),

              // Section 9.
              sectionHeader(
                '08',
                'Recipe',
                'Full Scaffold + AppBar + BackButton snippet.',
              ),
              buildRecipeListing(),
              SizedBox(height: kSectionGap),

              // Section 10.
              sectionHeader(
                '09',
                'Root navigator behaviour',
                'What happens when there is nothing left to pop.',
              ),
              buildRootNavigatorPanel(),
              SizedBox(height: kSectionGap),

              // Section 11.
              sectionHeader(
                '10',
                'Pitfalls',
                'Six common mistakes and how to avoid them.',
              ),
              buildPitfallsPanel(),
              SizedBox(height: kSectionGap),

              // Section 12.
              sectionHeader(
                '11',
                'Reference',
                'BackButton family side-by-side comparison.',
              ),
              buildReferenceTable(),

              // Footer.
              buildFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}
