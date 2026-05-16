// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - ListTile Atelier (Material list components)
// Comprehensive demonstration of ListTile, its kin (Checkbox/Radio/Switch tiles),
// ExpansionTile, ListTileTheme, alignment/affinity/style enums, and real-world recipes.
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// HELPER BUILDERS - top-level functions only (no Stateless/Stateful subclasses).
// -----------------------------------------------------------------------------

Widget _sectionHeader(String number, String title, String subtitle,
    Color background, Color border, Color accent) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            number,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF555555),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _sectionBody(Color background, Color border, List<Widget> children) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(12.0),
        bottomRight: Radius.circular(12.0),
      ),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    ),
  );
}

Widget _captionLabel(String text, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w600,
        color: color,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _tileCard(Widget tile, Color tint) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: tint, width: 1.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: tile,
    ),
  );
}

Widget _recipeCard(String title, String description, Color accent,
    List<Widget> tiles) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 12.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF666666),
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
          ),
          child: Column(
            children: tiles,
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(String key, String left, String right, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            key,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.18),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              left,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Color(0xFF222222),
              ),
            ),
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.32),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              right,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Color(0xFF111111),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _glossaryEntry(String term, String definition, Color tint) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 4.0),
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF333333),
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: '$term — ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tint,
                  ),
                ),
                TextSpan(text: definition),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ListTile Atelier deep demo executing');

  // ==========================================================================
  // SECTION 1: LISTTILE BASICS (title only, title+subtitle, leading, trailing)
  // ==========================================================================
  // Palette: Indigo
  final Color s1Bg = Color(0xFFE8EAF6);
  final Color s1Border = Color(0xFF9FA8DA);
  final Color s1Accent = Color(0xFF3949AB);

  final basicTitleOnly = ListTile(
    title: Text('Title only'),
  );

  final basicTitleSubtitle = ListTile(
    title: Text('Title with subtitle'),
    subtitle: Text('A short helper line gives more context.'),
  );

  final basicWithLeading = ListTile(
    leading: Icon(Icons.person, color: s1Accent),
    title: Text('With leading icon'),
  );

  final basicWithTrailing = ListTile(
    title: Text('With trailing chevron'),
    trailing: Icon(Icons.chevron_right, color: s1Accent),
  );

  final basicComplete = ListTile(
    leading: CircleAvatar(
      backgroundColor: s1Accent,
      child: Text('A',
          style: TextStyle(color: Color(0xFFFFFFFF))),
    ),
    title: Text('All four slots'),
    subtitle: Text('leading + title + subtitle + trailing'),
    trailing: Icon(Icons.info_outline, color: s1Accent),
  );

  // ==========================================================================
  // SECTION 2: ISTHREELINE - multi-line subtitles
  // ==========================================================================
  // Palette: Teal
  final Color s2Bg = Color(0xFFE0F2F1);
  final Color s2Border = Color(0xFF80CBC4);
  final Color s2Accent = Color(0xFF00796B);

  final twoLineTile = ListTile(
    isThreeLine: false,
    leading: Icon(Icons.email_outlined, color: s2Accent),
    title: Text('Two-line tile'),
    subtitle: Text('Short subtitle that fits on one row.'),
  );

  final threeLineTile = ListTile(
    isThreeLine: true,
    leading: Icon(Icons.email, color: s2Accent),
    title: Text('Three-line tile'),
    subtitle: Text(
      'A longer subtitle that intentionally wraps to two lines so the tile '
      'reserves enough vertical space for richer descriptions.',
    ),
    trailing: Icon(Icons.more_vert, color: s2Accent),
  );

  final threeLineWithRich = ListTile(
    isThreeLine: true,
    leading: CircleAvatar(
      backgroundColor: s2Accent,
      child: Icon(Icons.notifications, color: Color(0xFFFFFFFF)),
    ),
    title: Text('Build finished'),
    subtitle: Text(
      'Pipeline #428 completed in 4m 12s\n'
      'All 1,204 tests passed across 8 packages.',
    ),
    trailing: Text(
      '4m',
      style: TextStyle(color: s2Accent, fontWeight: FontWeight.bold),
    ),
  );

  // ==========================================================================
  // SECTION 3: DENSE VS DEFAULT (and VisualDensity snapshots)
  // ==========================================================================
  // Palette: Orange
  final Color s3Bg = Color(0xFFFFF3E0);
  final Color s3Border = Color(0xFFFFB74D);
  final Color s3Accent = Color(0xFFE65100);

  final defaultDensityTile = ListTile(
    leading: Icon(Icons.density_medium, color: s3Accent),
    title: Text('Default density'),
    subtitle: Text('Standard tile heights & paddings'),
  );

  final denseTile = ListTile(
    dense: true,
    leading: Icon(Icons.density_small, color: s3Accent),
    title: Text('dense: true'),
    subtitle: Text('Smaller text & tighter padding'),
  );

  final compactDensityTile = ListTile(
    visualDensity: VisualDensity.compact,
    leading: Icon(Icons.compress, color: s3Accent),
    title: Text('VisualDensity.compact'),
    subtitle: Text('Tightens both axes by 2 units'),
  );

  final comfortableDensityTile = ListTile(
    visualDensity: VisualDensity.comfortable,
    leading: Icon(Icons.open_in_full, color: s3Accent),
    title: Text('VisualDensity.comfortable'),
    subtitle: Text('Loosens both axes by 1 unit'),
  );

  final adaptivePlatformDensityTile = ListTile(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    leading: Icon(Icons.devices, color: s3Accent),
    title: Text('VisualDensity.adaptivePlatformDensity'),
    subtitle: Text('Per-platform automatic density'),
  );

  // ==========================================================================
  // SECTION 4: CONTENTPADDING VARIANTS
  // ==========================================================================
  // Palette: Pink
  final Color s4Bg = Color(0xFFFCE4EC);
  final Color s4Border = Color(0xFFF48FB1);
  final Color s4Accent = Color(0xFFC2185B);

  final paddingZero = ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text('EdgeInsets.zero'),
    subtitle: Text('Edge-to-edge, no internal padding'),
    leading: Icon(Icons.crop_square, color: s4Accent),
  );

  final paddingDefaultEquivalent = ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
    title: Text('symmetric(h: 16)'),
    subtitle: Text('Matches Material default horizontal padding'),
    leading: Icon(Icons.straighten, color: s4Accent),
  );

  final paddingWide = ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
    title: Text('symmetric(h: 32, v: 12)'),
    subtitle: Text('Wider gutters, taller tile'),
    leading: Icon(Icons.fullscreen, color: s4Accent),
  );

  final paddingAsymmetric = ListTile(
    contentPadding: EdgeInsets.fromLTRB(40.0, 8.0, 8.0, 8.0),
    title: Text('fromLTRB(40, 8, 8, 8)'),
    subtitle: Text('Hanging indent feel'),
    leading: Icon(Icons.format_indent_increase, color: s4Accent),
  );

  // ==========================================================================
  // SECTION 5: ENABLED / DISABLED
  // ==========================================================================
  // Palette: Blue Grey
  final Color s5Bg = Color(0xFFECEFF1);
  final Color s5Border = Color(0xFF90A4AE);
  final Color s5Accent = Color(0xFF455A64);

  final enabledTile = ListTile(
    enabled: true,
    leading: Icon(Icons.toggle_on, color: s5Accent),
    title: Text('Enabled tile'),
    subtitle: Text('Reacts to taps and long-press'),
    onTap: () {},
  );

  final disabledTile = ListTile(
    enabled: false,
    leading: Icon(Icons.toggle_off),
    title: Text('Disabled tile'),
    subtitle: Text('Greyed out, ignores onTap'),
    onTap: () {},
  );

  final disabledWithTrailing = ListTile(
    enabled: false,
    leading: Icon(Icons.lock_outline),
    title: Text('Disabled with trailing'),
    trailing: Icon(Icons.chevron_right),
  );

  // ==========================================================================
  // SECTION 6: SELECTED HIGHLIGHTS
  // ==========================================================================
  // Palette: Light Blue
  final Color s6Bg = Color(0xFFE1F5FE);
  final Color s6Border = Color(0xFF4FC3F7);
  final Color s6Accent = Color(0xFF0277BD);

  final unselectedTile = ListTile(
    selected: false,
    leading: Icon(Icons.radio_button_unchecked),
    title: Text('Unselected'),
    subtitle: Text('Default colors'),
  );

  final selectedTile = ListTile(
    selected: true,
    selectedColor: s6Accent,
    selectedTileColor: Color(0xFFB3E5FC),
    leading: Icon(Icons.radio_button_checked),
    title: Text('Selected tile'),
    subtitle: Text('selectedTileColor + selectedColor applied'),
  );

  final selectedWithTrailing = ListTile(
    selected: true,
    selectedColor: Color(0xFF006064),
    selectedTileColor: Color(0xFFB2EBF2),
    leading: Icon(Icons.bookmark),
    title: Text('Pinned conversation'),
    subtitle: Text('Persistently highlighted'),
    trailing: Icon(Icons.push_pin),
  );

  // ==========================================================================
  // SECTION 7: LISTTILETITLEALIGNMENT VALUES
  // ==========================================================================
  // Palette: Purple
  final Color s7Bg = Color(0xFFF3E5F5);
  final Color s7Border = Color(0xFFCE93D8);
  final Color s7Accent = Color(0xFF7B1FA2);

  final alignmentThreeLine = ListTile(
    isThreeLine: true,
    titleAlignment: ListTileTitleAlignment.threeLine,
    leading: CircleAvatar(child: Text('3')),
    title: Text('threeLine alignment'),
    subtitle: Text(
      'Leading/trailing align relative to the title baseline.\n'
      'Useful when isThreeLine is true.',
    ),
  );

  final alignmentTitleHeight = ListTile(
    titleAlignment: ListTileTitleAlignment.titleHeight,
    leading: CircleAvatar(child: Text('T')),
    title: Text('titleHeight alignment'),
    subtitle: Text('Center within the title height'),
  );

  final alignmentTop = ListTile(
    titleAlignment: ListTileTitleAlignment.top,
    leading: CircleAvatar(child: Text('^')),
    title: Text('top alignment'),
    subtitle: Text('Leading/trailing pinned to the top'),
  );

  final alignmentCenter = ListTile(
    titleAlignment: ListTileTitleAlignment.center,
    leading: CircleAvatar(child: Text('=')),
    title: Text('center alignment'),
    subtitle: Text('Vertically centered in the tile'),
  );

  final alignmentBottom = ListTile(
    titleAlignment: ListTileTitleAlignment.bottom,
    leading: CircleAvatar(child: Text('v')),
    title: Text('bottom alignment'),
    subtitle: Text('Leading/trailing pinned to the bottom'),
  );

  // ==========================================================================
  // SECTION 8: LISTTILESTYLE - drawer vs list
  // ==========================================================================
  // Palette: Green
  final Color s8Bg = Color(0xFFE8F5E9);
  final Color s8Border = Color(0xFF81C784);
  final Color s8Accent = Color(0xFF2E7D32);

  final styleList = ListTile(
    style: ListTileStyle.list,
    leading: Icon(Icons.list_alt, color: s8Accent),
    title: Text('ListTileStyle.list'),
    subtitle: Text('Default text styles & weights'),
  );

  final styleDrawer = ListTile(
    style: ListTileStyle.drawer,
    leading: Icon(Icons.menu_open, color: s8Accent),
    title: Text('ListTileStyle.drawer'),
    subtitle: Text('Bolder body for drawer destinations'),
  );

  final styleDrawerHome = ListTile(
    style: ListTileStyle.drawer,
    leading: Icon(Icons.home, color: s8Accent),
    title: Text('Home'),
  );

  final styleDrawerProfile = ListTile(
    style: ListTileStyle.drawer,
    leading: Icon(Icons.person, color: s8Accent),
    title: Text('Profile'),
  );

  final styleDrawerSettings = ListTile(
    style: ListTileStyle.drawer,
    leading: Icon(Icons.settings, color: s8Accent),
    title: Text('Settings'),
  );

  // ==========================================================================
  // SECTION 9: LISTTILETHEME WRAPPING
  // ==========================================================================
  // Palette: Deep Purple
  final Color s9Bg = Color(0xFFEDE7F6);
  final Color s9Border = Color(0xFFB39DDB);
  final Color s9Accent = Color(0xFF512DA8);

  final themedSection = ListTileTheme(
    data: ListTileThemeData(
      iconColor: s9Accent,
      textColor: s9Accent,
      tileColor: Color(0xFFFFFFFF),
      selectedColor: Color(0xFF311B92),
      selectedTileColor: Color(0xFFD1C4E9),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
      dense: false,
      style: ListTileStyle.list,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.brush),
          title: Text('Themed tile A'),
          subtitle: Text('Inherits iconColor + textColor'),
        ),
        SizedBox(height: 6.0),
        ListTile(
          leading: Icon(Icons.format_paint),
          title: Text('Themed tile B'),
          subtitle: Text('Same theme, different content'),
        ),
        SizedBox(height: 6.0),
        ListTile(
          selected: true,
          leading: Icon(Icons.star),
          title: Text('Themed + selected'),
          subtitle: Text('Picks up selectedTileColor & selectedColor'),
        ),
      ],
    ),
  );

  // ==========================================================================
  // SECTION 10: LISTTILECONTROLAFFINITY (platform / leading / trailing)
  // ==========================================================================
  // Palette: Amber
  final Color s10Bg = Color(0xFFFFF8E1);
  final Color s10Border = Color(0xFFFFD54F);
  final Color s10Accent = Color(0xFFFF8F00);

  final affinityPlatform = CheckboxListTile(
    controlAffinity: ListTileControlAffinity.platform,
    value: true,
    onChanged: (v) {},
    title: Text('platform affinity'),
    subtitle: Text('Trailing on Android, leading on iOS conventions'),
  );

  final affinityLeading = CheckboxListTile(
    controlAffinity: ListTileControlAffinity.leading,
    value: false,
    onChanged: (v) {},
    title: Text('leading affinity'),
    subtitle: Text('Checkbox forced to the leading slot'),
  );

  final affinityTrailing = CheckboxListTile(
    controlAffinity: ListTileControlAffinity.trailing,
    value: true,
    onChanged: (v) {},
    title: Text('trailing affinity'),
    subtitle: Text('Checkbox forced to the trailing slot'),
  );

  // ==========================================================================
  // SECTION 11: CHECKBOXLISTTILE
  // ==========================================================================
  // Palette: Cyan
  final Color s11Bg = Color(0xFFE0F7FA);
  final Color s11Border = Color(0xFF4DD0E1);
  final Color s11Accent = Color(0xFF00838F);

  final checkboxOn = CheckboxListTile(
    value: true,
    onChanged: (v) {},
    title: Text('Notifications enabled'),
    subtitle: Text('value: true'),
    activeColor: s11Accent,
  );

  final checkboxOff = CheckboxListTile(
    value: false,
    onChanged: (v) {},
    title: Text('Daily digest'),
    subtitle: Text('value: false'),
    activeColor: s11Accent,
  );

  final checkboxTristate = CheckboxListTile(
    value: null,
    tristate: true,
    onChanged: (v) {},
    title: Text('Partially selected'),
    subtitle: Text('tristate: true, value: null'),
    activeColor: s11Accent,
  );

  final checkboxDense = CheckboxListTile(
    dense: true,
    value: true,
    onChanged: (v) {},
    title: Text('Compact checkbox tile'),
    activeColor: s11Accent,
  );

  // ==========================================================================
  // SECTION 12: RADIOLISTTILE
  // ==========================================================================
  // Palette: Lime
  final Color s12Bg = Color(0xFFF9FBE7);
  final Color s12Border = Color(0xFFDCE775);
  final Color s12Accent = Color(0xFF827717);

  final radioOptionA = RadioListTile<String>(
    value: 'a',
    groupValue: 'a',
    onChanged: (v) {},
    title: Text('Option A'),
    subtitle: Text('Currently selected'),
    activeColor: s12Accent,
  );

  final radioOptionB = RadioListTile<String>(
    value: 'b',
    groupValue: 'a',
    onChanged: (v) {},
    title: Text('Option B'),
    activeColor: s12Accent,
  );

  final radioOptionC = RadioListTile<String>(
    value: 'c',
    groupValue: 'a',
    onChanged: (v) {},
    title: Text('Option C'),
    activeColor: s12Accent,
  );

  final radioDense = RadioListTile<int>(
    value: 1,
    groupValue: 1,
    onChanged: (v) {},
    dense: true,
    title: Text('Dense radio tile'),
    subtitle: Text('dense: true'),
    activeColor: s12Accent,
  );

  // ==========================================================================
  // SECTION 13: SWITCHLISTTILE
  // ==========================================================================
  // Palette: Red
  final Color s13Bg = Color(0xFFFFEBEE);
  final Color s13Border = Color(0xFFEF9A9A);
  final Color s13Accent = Color(0xFFC62828);

  final switchOn = SwitchListTile(
    value: true,
    onChanged: (v) {},
    title: Text('Airplane mode'),
    subtitle: Text('value: true'),
    activeColor: s13Accent,
  );

  final switchOff = SwitchListTile(
    value: false,
    onChanged: (v) {},
    title: Text('Bluetooth'),
    subtitle: Text('value: false'),
    activeColor: s13Accent,
  );

  final switchWithSecondary = SwitchListTile(
    value: true,
    onChanged: (v) {},
    title: Text('Location services'),
    subtitle: Text('secondary icon supplied'),
    secondary: Icon(Icons.location_on, color: s13Accent),
    activeColor: s13Accent,
  );

  final switchAdaptive = SwitchListTile.adaptive(
    value: false,
    onChanged: (v) {},
    title: Text('Adaptive switch tile'),
    subtitle: Text('Cupertino on iOS/macOS'),
    activeColor: s13Accent,
  );

  // ==========================================================================
  // SECTION 14: EXPANSIONTILE (closed snapshot)
  // ==========================================================================
  // Palette: Brown
  final Color s14Bg = Color(0xFFEFEBE9);
  final Color s14Border = Color(0xFFA1887F);
  final Color s14Accent = Color(0xFF5D4037);

  final expansionClosed = ExpansionTile(
    initiallyExpanded: false,
    leading: Icon(Icons.folder, color: s14Accent),
    title: Text('Closed by default'),
    subtitle: Text('initiallyExpanded: false'),
    children: [
      ListTile(title: Text('Hidden child 1')),
      ListTile(title: Text('Hidden child 2')),
    ],
  );

  final expansionOpen = ExpansionTile(
    initiallyExpanded: true,
    leading: Icon(Icons.folder_open, color: s14Accent),
    title: Text('Open by default'),
    subtitle: Text('initiallyExpanded: true'),
    children: [
      ListTile(
        leading: Icon(Icons.insert_drive_file, color: s14Accent),
        title: Text('readme.md'),
      ),
      ListTile(
        leading: Icon(Icons.insert_drive_file, color: s14Accent),
        title: Text('LICENSE'),
      ),
      ListTile(
        leading: Icon(Icons.insert_drive_file, color: s14Accent),
        title: Text('pubspec.yaml'),
      ),
    ],
  );

  final expansionCustom = ExpansionTile(
    initiallyExpanded: true,
    backgroundColor: Color(0xFFD7CCC8),
    collapsedBackgroundColor: Color(0xFFEFEBE9),
    iconColor: s14Accent,
    collapsedIconColor: s14Accent,
    textColor: s14Accent,
    collapsedTextColor: s14Accent,
    leading: Icon(Icons.tune),
    title: Text('Custom colors'),
    subtitle: Text('Background/text/icon colors per state'),
    children: [
      ListTile(title: Text('Custom palette child')),
    ],
  );

  // ==========================================================================
  // SECTION 15: REAL-WORLD RECIPE - CONTACT CARD LIST
  // ==========================================================================
  // Palette: Indigo darker
  final Color s15Bg = Color(0xFFE8EAF6);
  final Color s15Border = Color(0xFF7986CB);
  final Color s15Accent = Color(0xFF283593);

  final contactAda = ListTile(
    leading: CircleAvatar(
      backgroundColor: Color(0xFFFFCDD2),
      child: Text('AL', style: TextStyle(color: Color(0xFFB71C1C))),
    ),
    title: Text('Ada Lovelace'),
    subtitle: Text('ada@analytical.engine'),
    trailing: Icon(Icons.message_outlined, color: s15Accent),
    onTap: () {},
  );

  final contactAlan = ListTile(
    leading: CircleAvatar(
      backgroundColor: Color(0xFFC8E6C9),
      child: Text('AT', style: TextStyle(color: Color(0xFF1B5E20))),
    ),
    title: Text('Alan Turing'),
    subtitle: Text('alan@bletchley.uk'),
    trailing: Icon(Icons.message_outlined, color: s15Accent),
    onTap: () {},
  );

  final contactGrace = ListTile(
    leading: CircleAvatar(
      backgroundColor: Color(0xFFBBDEFB),
      child: Text('GH', style: TextStyle(color: Color(0xFF0D47A1))),
    ),
    title: Text('Grace Hopper'),
    subtitle: Text('grace@cobol.mil'),
    trailing: Icon(Icons.message_outlined, color: s15Accent),
    onTap: () {},
  );

  final contactLinus = ListTile(
    leading: CircleAvatar(
      backgroundColor: Color(0xFFFFE0B2),
      child: Text('LT', style: TextStyle(color: Color(0xFFE65100))),
    ),
    title: Text('Linus Torvalds'),
    subtitle: Text('linus@kernel.org'),
    trailing: Icon(Icons.message_outlined, color: s15Accent),
    onTap: () {},
  );

  // ==========================================================================
  // SECTION 16: REAL-WORLD RECIPE - SETTINGS LIST
  // ==========================================================================
  // Palette: Teal darker
  final Color s16Bg = Color(0xFFE0F2F1);
  final Color s16Border = Color(0xFF4DB6AC);
  final Color s16Accent = Color(0xFF00695C);

  final settingsAccount = ListTile(
    leading: Icon(Icons.account_circle, color: s16Accent),
    title: Text('Account'),
    subtitle: Text('Profile, email, password'),
    trailing: Icon(Icons.chevron_right, color: s16Accent),
    onTap: () {},
  );

  final settingsNotifications = SwitchListTile(
    secondary: Icon(Icons.notifications, color: s16Accent),
    title: Text('Notifications'),
    subtitle: Text('Push, email, in-app'),
    value: true,
    onChanged: (v) {},
    activeColor: s16Accent,
  );

  final settingsDarkMode = SwitchListTile(
    secondary: Icon(Icons.dark_mode, color: s16Accent),
    title: Text('Dark mode'),
    subtitle: Text('Use system theme'),
    value: false,
    onChanged: (v) {},
    activeColor: s16Accent,
  );

  final settingsLanguage = ListTile(
    leading: Icon(Icons.language, color: s16Accent),
    title: Text('Language'),
    subtitle: Text('English (United States)'),
    trailing: Icon(Icons.chevron_right, color: s16Accent),
    onTap: () {},
  );

  final settingsAbout = ListTile(
    leading: Icon(Icons.info_outline, color: s16Accent),
    title: Text('About'),
    subtitle: Text('Version 1.2.3 (build 4567)'),
    trailing: Icon(Icons.chevron_right, color: s16Accent),
    onTap: () {},
  );

  final settingsSignOut = ListTile(
    leading: Icon(Icons.logout, color: Color(0xFFC62828)),
    title: Text(
      'Sign out',
      style: TextStyle(color: Color(0xFFC62828)),
    ),
    onTap: () {},
  );

  // ==========================================================================
  // SECTION 17: REAL-WORLD RECIPE - CHAT PREVIEW LIST
  // ==========================================================================
  // Palette: Pink darker
  final Color s17Bg = Color(0xFFFCE4EC);
  final Color s17Border = Color(0xFFEC407A);
  final Color s17Accent = Color(0xFFAD1457);

  final chatPreviewOne = ListTile(
    isThreeLine: true,
    leading: CircleAvatar(
      backgroundColor: s17Accent,
      child: Text('M', style: TextStyle(color: Color(0xFFFFFFFF))),
    ),
    title: Row(
      children: [
        Expanded(child: Text('Margaux')),
        Text('09:14',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF777777),
            )),
      ],
    ),
    subtitle: Text(
      'Heading to the cafe — order me the usual?\n'
      'Also, did you remember the tickets?',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: Container(
      width: 20.0,
      height: 20.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: s17Accent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        '3',
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    onTap: () {},
  );

  final chatPreviewTwo = ListTile(
    isThreeLine: true,
    leading: CircleAvatar(
      backgroundColor: Color(0xFF6A1B9A),
      child: Text('R', style: TextStyle(color: Color(0xFFFFFFFF))),
    ),
    title: Row(
      children: [
        Expanded(child: Text('Renzo')),
        Text('Yesterday',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF777777),
            )),
      ],
    ),
    subtitle: Text(
      'Pushed the new branch. Mind reviewing when you have a minute?\n'
      'CI is already green.',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: Icon(Icons.check, color: Color(0xFF999999)),
    onTap: () {},
  );

  final chatPreviewThree = ListTile(
    isThreeLine: true,
    leading: CircleAvatar(
      backgroundColor: Color(0xFF00838F),
      child: Text('K', style: TextStyle(color: Color(0xFFFFFFFF))),
    ),
    title: Row(
      children: [
        Expanded(child: Text('Klara')),
        Text('Mon',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF777777),
            )),
      ],
    ),
    subtitle: Text(
      'Sent the slides for tomorrow.\n'
      'Let me know if section 3 needs a rework.',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: Icon(Icons.done_all, color: s17Accent),
    onTap: () {},
  );

  // ==========================================================================
  // BUILD THE PAGE
  // ==========================================================================

  print('Building ListTile Atelier visual page');

  return MaterialApp(
    title: 'List Item Atelier',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ============================================================
            // HERO HEADER
            // ============================================================
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20.0, 32.0, 20.0, 28.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1A237E),
                    Color(0xFF3949AB),
                    Color(0xFF5E35B1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Material - ListTile family deep demo',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 11.0,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    'List Item Atelier',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    'A guided tour of ListTile anatomy, theming,\n'
                    'control affinities, and tile-family recipes.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Color(0xFFD1C4E9),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Color(0x22FFFFFF),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'ListTile',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Color(0x22FFFFFF),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'CheckboxListTile',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Color(0x22FFFFFF),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'RadioListTile',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Color(0x22FFFFFF),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'SwitchListTile',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Color(0x22FFFFFF),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'ExpansionTile',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Color(0x22FFFFFF),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'ListTileTheme',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // CONCEPT OVERVIEW
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF3949AB),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(Icons.menu_book,
                              color: Color(0xFFFFFFFF), size: 20.0),
                        ),
                        SizedBox(width: 12.0),
                        Text(
                          'What this demo covers',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      'ListTile is the workhorse of Material list views. It owns a fixed '
                      '4-slot anatomy (leading, title, subtitle, trailing) plus a host of '
                      'visual knobs (density, padding, color, shape, selection state). '
                      'This atelier explores every meaningful knob and shows the same primitive '
                      'wired into three real-world patterns.',
                      style: TextStyle(fontSize: 13.0, height: 1.6),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Reading map',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: Color(0xFF1A237E),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text('• 1-7  Core ListTile knobs',
                        style: TextStyle(fontSize: 12.0, height: 1.5)),
                    Text('• 8-9  Style + Theme propagation',
                        style: TextStyle(fontSize: 12.0, height: 1.5)),
                    Text('• 10-13 Tile family (Checkbox / Radio / Switch)',
                        style: TextStyle(fontSize: 12.0, height: 1.5)),
                    Text('• 14   ExpansionTile (open & closed snapshots)',
                        style: TextStyle(fontSize: 12.0, height: 1.5)),
                    Text('• 15-17 Real-world recipes',
                        style: TextStyle(fontSize: 12.0, height: 1.5)),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.0),

            // ============================================================
            // SECTION 1: BASICS
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('1', 'Anatomy basics',
                      'Title, subtitle, leading and trailing slots',
                      s1Bg, s1Border, s1Accent),
                  _sectionBody(Color(0xFFFFFFFF), s1Border, [
                    _captionLabel('TITLE ONLY', s1Accent),
                    _tileCard(basicTitleOnly, s1Border),
                    _captionLabel('TITLE + SUBTITLE', s1Accent),
                    _tileCard(basicTitleSubtitle, s1Border),
                    _captionLabel('LEADING ICON', s1Accent),
                    _tileCard(basicWithLeading, s1Border),
                    _captionLabel('TRAILING CHEVRON', s1Accent),
                    _tileCard(basicWithTrailing, s1Border),
                    _captionLabel('ALL FOUR SLOTS', s1Accent),
                    _tileCard(basicComplete, s1Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 2: isThreeLine
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('2', 'isThreeLine',
                      'Reserve space for multi-line subtitles',
                      s2Bg, s2Border, s2Accent),
                  _sectionBody(Color(0xFFFFFFFF), s2Border, [
                    _captionLabel('isThreeLine: false (default)', s2Accent),
                    _tileCard(twoLineTile, s2Border),
                    _captionLabel('isThreeLine: true', s2Accent),
                    _tileCard(threeLineTile, s2Border),
                    _captionLabel('THREE-LINE NOTIFICATION CARD', s2Accent),
                    _tileCard(threeLineWithRich, s2Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 3: density
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('3', 'Dense vs default',
                      'dense + VisualDensity snapshots',
                      s3Bg, s3Border, s3Accent),
                  _sectionBody(Color(0xFFFFFFFF), s3Border, [
                    _captionLabel('DEFAULT', s3Accent),
                    _tileCard(defaultDensityTile, s3Border),
                    _captionLabel('dense: true', s3Accent),
                    _tileCard(denseTile, s3Border),
                    _captionLabel('VisualDensity.compact', s3Accent),
                    _tileCard(compactDensityTile, s3Border),
                    _captionLabel('VisualDensity.comfortable', s3Accent),
                    _tileCard(comfortableDensityTile, s3Border),
                    _captionLabel('VisualDensity.adaptivePlatformDensity',
                        s3Accent),
                    _tileCard(adaptivePlatformDensityTile, s3Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 4: contentPadding
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('4', 'contentPadding',
                      'Tune the gutters and vertical bleed',
                      s4Bg, s4Border, s4Accent),
                  _sectionBody(Color(0xFFFFFFFF), s4Border, [
                    _captionLabel('EdgeInsets.zero', s4Accent),
                    _tileCard(paddingZero, s4Border),
                    _captionLabel('symmetric(h: 16) (default)', s4Accent),
                    _tileCard(paddingDefaultEquivalent, s4Border),
                    _captionLabel('symmetric(h: 32, v: 12)', s4Accent),
                    _tileCard(paddingWide, s4Border),
                    _captionLabel('fromLTRB(40, 8, 8, 8)', s4Accent),
                    _tileCard(paddingAsymmetric, s4Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 5: enabled
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('5', 'enabled vs disabled',
                      'Greyed-out, non-interactive tiles',
                      s5Bg, s5Border, s5Accent),
                  _sectionBody(Color(0xFFFFFFFF), s5Border, [
                    _captionLabel('enabled: true', s5Accent),
                    _tileCard(enabledTile, s5Border),
                    _captionLabel('enabled: false', s5Accent),
                    _tileCard(disabledTile, s5Border),
                    _captionLabel('enabled: false + trailing', s5Accent),
                    _tileCard(disabledWithTrailing, s5Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 6: selected
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('6', 'selected highlights',
                      'selectedColor + selectedTileColor',
                      s6Bg, s6Border, s6Accent),
                  _sectionBody(Color(0xFFFFFFFF), s6Border, [
                    _captionLabel('selected: false', s6Accent),
                    _tileCard(unselectedTile, s6Border),
                    _captionLabel('selected: true', s6Accent),
                    _tileCard(selectedTile, s6Border),
                    _captionLabel('PINNED CONVERSATION', s6Accent),
                    _tileCard(selectedWithTrailing, s6Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 7: ListTileTitleAlignment
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('7', 'ListTileTitleAlignment',
                      'How leading/trailing align to the title',
                      s7Bg, s7Border, s7Accent),
                  _sectionBody(Color(0xFFFFFFFF), s7Border, [
                    _captionLabel('threeLine', s7Accent),
                    _tileCard(alignmentThreeLine, s7Border),
                    _captionLabel('titleHeight', s7Accent),
                    _tileCard(alignmentTitleHeight, s7Border),
                    _captionLabel('top', s7Accent),
                    _tileCard(alignmentTop, s7Border),
                    _captionLabel('center', s7Accent),
                    _tileCard(alignmentCenter, s7Border),
                    _captionLabel('bottom', s7Accent),
                    _tileCard(alignmentBottom, s7Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 8: ListTileStyle
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('8', 'ListTileStyle',
                      'list vs drawer text weights',
                      s8Bg, s8Border, s8Accent),
                  _sectionBody(Color(0xFFFFFFFF), s8Border, [
                    _captionLabel('ListTileStyle.list', s8Accent),
                    _tileCard(styleList, s8Border),
                    _captionLabel('ListTileStyle.drawer', s8Accent),
                    _tileCard(styleDrawer, s8Border),
                    _captionLabel('DRAWER DESTINATION GROUP', s8Accent),
                    _tileCard(
                      Column(
                        children: [
                          styleDrawerHome,
                          Divider(height: 1.0),
                          styleDrawerProfile,
                          Divider(height: 1.0),
                          styleDrawerSettings,
                        ],
                      ),
                      s8Border,
                    ),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 9: ListTileTheme
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('9', 'ListTileTheme',
                      'Cascade colors, padding, and shape down a subtree',
                      s9Bg, s9Border, s9Accent),
                  _sectionBody(Color(0xFFFFFFFF), s9Border, [
                    _captionLabel('THREE TILES UNDER ONE LISTTILETHEME',
                        s9Accent),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF3E5F5),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: s9Border),
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: themedSection,
                    ),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 10: ListTileControlAffinity
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('10', 'ListTileControlAffinity',
                      'platform / leading / trailing slots',
                      s10Bg, s10Border, s10Accent),
                  _sectionBody(Color(0xFFFFFFFF), s10Border, [
                    _captionLabel('platform', s10Accent),
                    _tileCard(affinityPlatform, s10Border),
                    _captionLabel('leading', s10Accent),
                    _tileCard(affinityLeading, s10Border),
                    _captionLabel('trailing', s10Accent),
                    _tileCard(affinityTrailing, s10Border),
                    SizedBox(height: 6.0),
                    _comparisonRow(
                        'platform', 'iOS: leading', 'Android: trailing',
                        s10Accent),
                    _comparisonRow(
                        'leading', 'control: leading', 'secondary: trailing',
                        s10Accent),
                    _comparisonRow(
                        'trailing', 'control: trailing', 'secondary: leading',
                        s10Accent),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 11: CheckboxListTile
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('11', 'CheckboxListTile',
                      'Boolean + tristate selection',
                      s11Bg, s11Border, s11Accent),
                  _sectionBody(Color(0xFFFFFFFF), s11Border, [
                    _captionLabel('value: true', s11Accent),
                    _tileCard(checkboxOn, s11Border),
                    _captionLabel('value: false', s11Accent),
                    _tileCard(checkboxOff, s11Border),
                    _captionLabel('tristate + value: null', s11Accent),
                    _tileCard(checkboxTristate, s11Border),
                    _captionLabel('dense', s11Accent),
                    _tileCard(checkboxDense, s11Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 12: RadioListTile
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('12', 'RadioListTile',
                      'Mutually exclusive choice within a group',
                      s12Bg, s12Border, s12Accent),
                  _sectionBody(Color(0xFFFFFFFF), s12Border, [
                    _captionLabel('GROUP (groupValue: a)', s12Accent),
                    _tileCard(
                      Column(
                        children: [
                          radioOptionA,
                          Divider(height: 1.0),
                          radioOptionB,
                          Divider(height: 1.0),
                          radioOptionC,
                        ],
                      ),
                      s12Border,
                    ),
                    _captionLabel('DENSE RADIO', s12Accent),
                    _tileCard(radioDense, s12Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 13: SwitchListTile
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('13', 'SwitchListTile',
                      'Toggleable preferences with optional secondary slot',
                      s13Bg, s13Border, s13Accent),
                  _sectionBody(Color(0xFFFFFFFF), s13Border, [
                    _captionLabel('value: true', s13Accent),
                    _tileCard(switchOn, s13Border),
                    _captionLabel('value: false', s13Accent),
                    _tileCard(switchOff, s13Border),
                    _captionLabel('secondary icon', s13Accent),
                    _tileCard(switchWithSecondary, s13Border),
                    _captionLabel('SwitchListTile.adaptive', s13Accent),
                    _tileCard(switchAdaptive, s13Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 14: ExpansionTile
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('14', 'ExpansionTile',
                      'Disclosure tile with collapsible children',
                      s14Bg, s14Border, s14Accent),
                  _sectionBody(Color(0xFFFFFFFF), s14Border, [
                    _captionLabel('CLOSED SNAPSHOT', s14Accent),
                    _tileCard(expansionClosed, s14Border),
                    _captionLabel('OPEN SNAPSHOT', s14Accent),
                    _tileCard(expansionOpen, s14Border),
                    _captionLabel('CUSTOM COLORS', s14Accent),
                    _tileCard(expansionCustom, s14Border),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 15: Contact card recipe
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('15', 'Recipe: contact card list',
                      'Avatar + name + email + chat affordance',
                      s15Bg, s15Border, s15Accent),
                  _sectionBody(Color(0xFFFFFFFF), s15Border, [
                    _recipeCard(
                      'Address book - "Pioneers" group',
                      'A two-line ListTile per contact: avatar in the leading slot, '
                          'name in the title, email in the subtitle, and a quick-action '
                          'icon in the trailing slot.',
                      s15Accent,
                      [
                        contactAda,
                        Divider(height: 1.0),
                        contactAlan,
                        Divider(height: 1.0),
                        contactGrace,
                        Divider(height: 1.0),
                        contactLinus,
                      ],
                    ),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 16: Settings recipe
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('16', 'Recipe: settings list',
                      'Mixed ListTile + SwitchListTile preferences',
                      s16Bg, s16Border, s16Accent),
                  _sectionBody(Color(0xFFFFFFFF), s16Border, [
                    _recipeCard(
                      'App settings',
                      'Combine ListTile (with chevron) for navigational rows and '
                          'SwitchListTile for inline toggles. The destructive sign-out '
                          'action uses the error color on both leading icon and title.',
                      s16Accent,
                      [
                        settingsAccount,
                        Divider(height: 1.0),
                        settingsNotifications,
                        Divider(height: 1.0),
                        settingsDarkMode,
                        Divider(height: 1.0),
                        settingsLanguage,
                        Divider(height: 1.0),
                        settingsAbout,
                        Divider(height: 1.0),
                        settingsSignOut,
                      ],
                    ),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 20.0),

            // ============================================================
            // SECTION 17: Chat preview recipe
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _sectionHeader('17', 'Recipe: chat preview list',
                      'Three-line tiles with timestamp and unread badge',
                      s17Bg, s17Border, s17Accent),
                  _sectionBody(Color(0xFFFFFFFF), s17Border, [
                    _recipeCard(
                      'Inbox',
                      'Use isThreeLine and a Row inside the title to lay out '
                          'sender + timestamp. The trailing slot doubles as an unread '
                          'badge or read-receipt indicator.',
                      s17Accent,
                      [
                        chatPreviewOne,
                        Divider(height: 1.0),
                        chatPreviewTwo,
                        Divider(height: 1.0),
                        chatPreviewThree,
                      ],
                    ),
                  ]),
                ],
              ),
            ),

            SizedBox(height: 24.0),

            // ============================================================
            // GLOSSARY
            // ============================================================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFDE7),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFFFF59D), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.local_library,
                            color: Color(0xFFF57F17), size: 22.0),
                        SizedBox(width: 10.0),
                        Text(
                          'Glossary',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF57F17),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    _glossaryEntry('leading',
                        'Widget shown before the title (often an Icon or CircleAvatar).',
                        Color(0xFF3949AB)),
                    _glossaryEntry('title',
                        'Primary line of text. Required slot in practice.',
                        Color(0xFF00796B)),
                    _glossaryEntry('subtitle',
                        'Secondary line under the title. May wrap when isThreeLine is true.',
                        Color(0xFFE65100)),
                    _glossaryEntry('trailing',
                        'Widget shown after the title (chevron, badge, switch, icon).',
                        Color(0xFFC2185B)),
                    _glossaryEntry('isThreeLine',
                        'Reserves vertical space for a two-line subtitle.',
                        Color(0xFF455A64)),
                    _glossaryEntry('dense',
                        'Tighter text style and reduced padding.',
                        Color(0xFF0277BD)),
                    _glossaryEntry('selected',
                        'Toggles selectedColor / selectedTileColor on the tile.',
                        Color(0xFF7B1FA2)),
                    _glossaryEntry('enabled',
                        'When false, the tile is greyed out and onTap is ignored.',
                        Color(0xFF2E7D32)),
                    _glossaryEntry('contentPadding',
                        'EdgeInsets applied inside the tile around the content row.',
                        Color(0xFF512DA8)),
                    _glossaryEntry('ListTileStyle',
                        'list (default body weight) or drawer (heavier for navigation).',
                        Color(0xFFFF8F00)),
                    _glossaryEntry('ListTileTheme',
                        'InheritedWidget that supplies defaults to descendant tiles.',
                        Color(0xFF00838F)),
                    _glossaryEntry('ListTileTitleAlignment',
                        'Enum: threeLine / titleHeight / top / center / bottom.',
                        Color(0xFF827717)),
                    _glossaryEntry('ListTileControlAffinity',
                        'Enum: platform / leading / trailing for the embedded control.',
                        Color(0xFFC62828)),
                    _glossaryEntry('ExpansionTile',
                        'ListTile that toggles a column of children open/closed.',
                        Color(0xFF5D4037)),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.0),

            // ============================================================
            // EPILOGUE
            // ============================================================
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF1A237E),
                    Color(0xFF5E35B1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.flag,
                          color: Color(0xFFFFFFFF), size: 22.0),
                      SizedBox(width: 10.0),
                      Text(
                        'Closing notes',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'ListTile is deceptively powerful: nearly every Material list view in '
                    'production is some flavor of the patterns above. Lock onto the four-slot '
                    'anatomy, lean on ListTileTheme for cohesion across screens, and reach for '
                    'the Checkbox/Radio/Switch variants whenever the row needs an embedded '
                    'control.',
                    style: TextStyle(
                      color: Color(0xFFE8EAF6),
                      fontSize: 13.0,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 14.0),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: Color(0x33FFFFFF),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'End of demo - 17 sections covered',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 11.0,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.0),
          ],
        ),
      ),
    ),
  );
}
