// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NavigationDrawerTheme InheritedWidget
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.teal.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildDestinationItem(
  IconData icon,
  String label,
  bool selected,
  Color indicatorColor,
  Color iconColor,
) {
  return Container(
    height: 56,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    decoration: BoxDecoration(
      color: selected ? indicatorColor.withAlpha(50) : Colors.transparent,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Row(
      children: [
        SizedBox(width: 16),
        Icon(
          icon,
          size: 24,
          color: selected ? iconColor : Colors.grey.shade600,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              color: selected ? iconColor : Colors.grey.shade700,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildThemedDrawerPreview(
  String title,
  NavigationDrawerThemeData themeData,
  List<IconData> icons,
  List<String> labels,
  int selectedIndex,
) {
  print('Building themed drawer preview: $title');
  Color bgColor = themeData.backgroundColor ?? Colors.white;
  Color indicatorColor = themeData.indicatorColor ?? Colors.blue;
  Color iconColor =
      themeData.iconTheme?.resolve({WidgetState.selected})?.color ??
      Colors.blue;

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < labels.length; i = i + 1) {
    items.add(
      buildDestinationItem(
        icons[i],
        labels[i],
        i == selectedIndex,
        indicatorColor,
        iconColor,
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          child: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ),
              ...items,
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildThemeComparisonRow(
  String label,
  NavigationDrawerThemeData theme1,
  NavigationDrawerThemeData theme2,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme1.backgroundColor ?? Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Theme 1',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme2.backgroundColor ?? Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Theme 2',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11),
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

Widget buildNestedThemeDemo(
  String outerLabel,
  String innerLabel,
  NavigationDrawerThemeData outerTheme,
  NavigationDrawerThemeData innerTheme,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: outerTheme.backgroundColor ?? Colors.grey.shade100,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade400, width: 2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          outerLabel,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: innerTheme.backgroundColor ?? Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: innerTheme.indicatorColor ?? Colors.blue,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                innerLabel,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color:
                      innerTheme.indicatorColor?.withAlpha(50) ??
                      Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Selected Item', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildThemeSectionCard(
  String sectionTitle,
  String sectionDesc,
  Color headerColor,
  NavigationDrawerThemeData themeData,
  List<String> itemLabels,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sectionTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                sectionDesc,
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(12),
          color: themeData.backgroundColor ?? Colors.grey.shade50,
          child: Column(
            children: itemLabels.map((label) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade100,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: themeData.indicatorColor ?? Colors.grey,
                    ),
                    SizedBox(width: 12),
                    Text(label, style: TextStyle(fontSize: 13)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}

Widget buildInteractiveSection(
  String title,
  NavigationDrawerThemeData themeData,
  int currentIndex,
) {
  List<String> menuItems = [
    'Dashboard',
    'Analytics',
    'Settings',
    'Profile',
    'Help',
  ];
  List<IconData> menuIcons = [
    Icons.dashboard,
    Icons.analytics,
    Icons.settings,
    Icons.person,
    Icons.help,
  ];

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          child: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(height: 1),
        Container(
          width: double.infinity,
          color: themeData.backgroundColor ?? Colors.grey.shade50,
          child: Column(
            children: List.generate(menuItems.length, (idx) {
              bool isSelected = idx == currentIndex;
              return Container(
                height: 52,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (themeData.indicatorColor ?? Colors.blue).withAlpha(40)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16),
                    Icon(
                      menuIcons[idx],
                      color: isSelected
                          ? (themeData.indicatorColor ?? Colors.blue)
                          : Colors.grey.shade600,
                    ),
                    SizedBox(width: 12),
                    Text(
                      menuItems[idx],
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? Colors.black87
                            : Colors.grey.shade700,
                      ),
                    ),
                    Spacer(),
                    if (isSelected)
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: themeData.indicatorColor ?? Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Active',
                          style: TextStyle(color: Colors.white, fontSize: 10),
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
  );
}

dynamic build(BuildContext context) {
  print('NavigationDrawerTheme test executing');
  print('Testing NavigationDrawerTheme InheritedWidget');

  NavigationDrawerThemeData defaultTheme = NavigationDrawerThemeData();
  print('Default theme created: $defaultTheme');

  NavigationDrawerThemeData primaryTheme = NavigationDrawerThemeData(
    backgroundColor: Colors.blue.shade50,
    indicatorColor: Colors.blue.shade600,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28),
    ),
    tileHeight: 56,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(color: Colors.blue.shade700, size: 24);
      }
      return IconThemeData(color: Colors.grey.shade600, size: 24);
    }),
    labelTextStyle: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return TextStyle(
          color: Colors.blue.shade800,
          fontWeight: FontWeight.bold,
        );
      }
      return TextStyle(color: Colors.grey.shade700);
    }),
  );
  print('Primary theme configured');

  NavigationDrawerThemeData secondaryTheme = NavigationDrawerThemeData(
    backgroundColor: Colors.green.shade50,
    indicatorColor: Colors.green.shade600,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    tileHeight: 52,
    iconTheme: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return IconThemeData(color: Colors.green.shade700, size: 22);
      }
      return IconThemeData(color: Colors.grey.shade500, size: 22);
    }),
  );
  print('Secondary theme configured');

  NavigationDrawerThemeData accentTheme = NavigationDrawerThemeData(
    backgroundColor: Colors.purple.shade50,
    indicatorColor: Colors.purple.shade500,
    indicatorShape: StadiumBorder(),
    tileHeight: 48,
  );
  print('Accent theme configured');

  NavigationDrawerThemeData darkTheme = NavigationDrawerThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    indicatorColor: Colors.tealAccent.shade400,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
  print('Dark theme configured');

  List<IconData> navIcons = [
    Icons.home,
    Icons.explore,
    Icons.bookmark,
    Icons.settings,
  ];
  List<String> navLabels = ['Home', 'Explore', 'Bookmarks', 'Settings'];

  List<Widget> sections = [];

  sections.add(buildSectionHeader('1. Overview of NavigationDrawerTheme'));
  sections.add(buildInfoCard('Widget type', 'InheritedWidget'));
  sections.add(
    buildInfoCard(
      'Purpose',
      'Provides NavigationDrawerThemeData to descendants',
    ),
  );
  sections.add(buildInfoCard('Data class', 'NavigationDrawerThemeData'));
  sections.add(
    buildInfoCard('Access method', 'NavigationDrawerTheme.of(context)'),
  );
  sections.add(
    buildInfoCard('Merge behavior', 'Inherits from ancestor if not overridden'),
  );
  sections.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Text(
        'NavigationDrawerTheme is an InheritedWidget that makes NavigationDrawerThemeData '
        'available to NavigationDrawer widgets within its subtree.',
        style: TextStyle(fontSize: 13),
      ),
    ),
  );

  sections.add(buildSectionHeader('2. Theme Wrapping NavigationDrawer'));
  sections.add(
    buildThemedDrawerPreview(
      'Primary Theme Wrapper',
      primaryTheme,
      navIcons,
      navLabels,
      0,
    ),
  );
  sections.add(
    buildInfoCard(
      'Wrapper usage',
      'NavigationDrawerTheme(data: themeData, child: drawer)',
    ),
  );
  sections.add(
    buildInfoCard(
      'Effect',
      'All NavigationDrawer descendants receive the theme',
    ),
  );

  sections.add(buildSectionHeader('3. NavigationDrawerTheme.of(context)'));
  sections.add(
    buildInfoCard('Static method', 'NavigationDrawerTheme.of(context)'),
  );
  sections.add(
    buildInfoCard('Returns', 'NavigationDrawerThemeData from nearest ancestor'),
  );
  sections.add(
    buildInfoCard('Fallback', 'Returns default data if no ancestor found'),
  );
  sections.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Accessing theme in build method:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(8),
            color: Colors.grey.shade200,
            child: Text(
              'final theme = NavigationDrawerTheme.of(context);',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ],
      ),
    ),
  );

  sections.add(buildSectionHeader('4. Nested Theme Overrides'));
  sections.add(
    buildNestedThemeDemo(
      'Outer Theme (Blue)',
      'Inner Theme Override (Green)',
      primaryTheme,
      secondaryTheme,
    ),
  );
  sections.add(
    buildNestedThemeDemo(
      'Outer Theme (Purple)',
      'Inner Theme Override (Dark)',
      accentTheme,
      darkTheme,
    ),
  );
  sections.add(
    buildInfoCard('Behavior', 'Inner themes override outer themes completely'),
  );

  sections.add(buildSectionHeader('5. Multiple Themed Sections'));
  sections.add(
    buildThemeSectionCard(
      'Primary Section',
      'Using blue theme',
      Colors.blue.shade600,
      primaryTheme,
      ['Overview', 'Dashboard', 'Reports'],
    ),
  );
  sections.add(
    buildThemeSectionCard(
      'Secondary Section',
      'Using green theme',
      Colors.green.shade600,
      secondaryTheme,
      ['Inbox', 'Sent', 'Drafts'],
    ),
  );
  sections.add(
    buildThemeSectionCard(
      'Accent Section',
      'Using purple theme',
      Colors.purple.shade600,
      accentTheme,
      ['Profile', 'Settings'],
    ),
  );

  sections.add(buildSectionHeader('6. Theme Inheritance Demonstration'));
  sections.add(
    buildInfoCard(
      'Inheritance model',
      'Child widgets inherit from nearest ancestor',
    ),
  );
  sections.add(
    buildInfoCard('Specificity', 'Closer ancestors take precedence'),
  );
  sections.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inheritance Chain:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('Root Theme', style: TextStyle(fontSize: 11)),
              ),
              Icon(Icons.arrow_forward, size: 16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('Section Theme', style: TextStyle(fontSize: 11)),
              ),
              Icon(Icons.arrow_forward, size: 16),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('Widget', style: TextStyle(fontSize: 11)),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  sections.add(buildSectionHeader('7. Themed Destination Styling'));
  sections.add(
    buildThemedDrawerPreview(
      'Green Theme - Destination Styling',
      secondaryTheme,
      navIcons,
      navLabels,
      1,
    ),
  );
  sections.add(
    buildThemedDrawerPreview(
      'Purple Theme - Destination Styling',
      accentTheme,
      [Icons.dashboard, Icons.analytics, Icons.trending_up, Icons.pie_chart],
      ['Dashboard', 'Analytics', 'Trends', 'Charts'],
      2,
    ),
  );
  sections.add(
    buildInfoCard(
      'iconTheme',
      'WidgetStateProperty<IconThemeData> for state-based icons',
    ),
  );
  sections.add(
    buildInfoCard(
      'labelTextStyle',
      'WidgetStateProperty<TextStyle> for state-based labels',
    ),
  );

  sections.add(buildSectionHeader('8. Complete Drawer with Sections'));
  sections.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11),
                topRight: Radius.circular(11),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: primaryTheme.indicatorColor,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'user@example.com',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                buildDestinationItem(
                  Icons.home,
                  'Home',
                  true,
                  primaryTheme.indicatorColor ?? Colors.blue,
                  Colors.blue,
                ),
                buildDestinationItem(
                  Icons.explore,
                  'Explore',
                  false,
                  primaryTheme.indicatorColor ?? Colors.blue,
                  Colors.blue,
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'SETTINGS',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                buildDestinationItem(
                  Icons.settings,
                  'Settings',
                  false,
                  primaryTheme.indicatorColor ?? Colors.blue,
                  Colors.blue,
                ),
                buildDestinationItem(
                  Icons.help,
                  'Help',
                  false,
                  primaryTheme.indicatorColor ?? Colors.blue,
                  Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  sections.add(buildSectionHeader('9. Theme Comparison'));
  sections.add(
    buildThemeComparisonRow('Background', primaryTheme, secondaryTheme),
  );
  sections.add(buildThemeComparisonRow('Indicator', primaryTheme, accentTheme));
  sections.add(buildThemeComparisonRow('Tile Height', primaryTheme, darkTheme));
  sections.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryTheme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: primaryTheme.indicatorColor ?? Colors.blue,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Primary',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryTheme.indicatorColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: secondaryTheme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: secondaryTheme.indicatorColor ?? Colors.green,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Secondary',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: secondaryTheme.indicatorColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: accentTheme.backgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: accentTheme.indicatorColor ?? Colors.purple,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text('Accent', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: accentTheme.indicatorColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  sections.add(buildSectionHeader('10. Interactive Themed Drawer'));
  sections.add(
    buildInteractiveSection(
      'Interactive Menu - Primary Theme',
      primaryTheme,
      0,
    ),
  );
  sections.add(
    buildInteractiveSection(
      'Interactive Menu - Secondary Theme',
      secondaryTheme,
      2,
    ),
  );
  sections.add(
    buildInteractiveSection('Interactive Menu - Accent Theme', accentTheme, 4),
  );

  sections.add(
    Container(
      margin: EdgeInsets.only(top: 16, bottom: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'NavigationDrawerTheme is an InheritedWidget that provides NavigationDrawerThemeData '
            'to all NavigationDrawer widgets in its subtree. It supports nesting for localized '
            'theme overrides and can be accessed via NavigationDrawerTheme.of(context).',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    ),
  );

  print(
    'NavigationDrawerTheme test completed with ${sections.length} sections',
  );

  return Scaffold(
    appBar: AppBar(
      title: Text('NavigationDrawerTheme Demo'),
      backgroundColor: Colors.teal.shade600,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sections,
      ),
    ),
  );
}
