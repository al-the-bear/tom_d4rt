// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NavigationDrawerThemeData from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
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

Widget buildDrawerDestination(
  IconData icon,
  String label,
  bool selected,
  Color indicatorColor,
  Color iconColor,
  double tileHeight,
) {
  return Container(
    height: tileHeight,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    decoration: BoxDecoration(
      color: selected ? indicatorColor.withAlpha(40) : Colors.transparent,
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

Widget buildMiniDrawerPreview(
  String title,
  Color backgroundColor,
  Color indicatorColor,
  Color iconColor,
  List<String> labels,
  List<IconData> icons,
  int selectedIndex,
) {
  print('Building mini drawer preview: $title');
  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < labels.length; i = i + 1) {
    items.add(
      buildDrawerDestination(
        icons[i],
        labels[i],
        i == selectedIndex,
        indicatorColor,
        iconColor,
        48.0,
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
          height: 280,
          decoration: BoxDecoration(
            color: backgroundColor,
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
                  'Navigation',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Column(children: items),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildDefaultDrawerDemo() {
  print('Building default drawer demo');
  List<String> destLabels = ['Home', 'Messages', 'Profile', 'Settings'];
  List<IconData> destIcons = [
    Icons.home,
    Icons.message,
    Icons.person,
    Icons.settings,
  ];

  return buildMiniDrawerPreview(
    'Default NavigationDrawer Appearance',
    Colors.grey.shade50,
    Colors.indigo,
    Colors.indigo,
    destLabels,
    destIcons,
    0,
  );
}

Widget buildThemedBackgroundDemo() {
  print('Building themed background demo');
  List<String> bgLabels = [
    'Light Blue BG',
    'Light Green BG',
    'Light Purple BG',
    'Light Amber BG',
  ];
  List<Color> bgColors = [
    Colors.blue.shade50,
    Colors.green.shade50,
    Colors.purple.shade50,
    Colors.amber.shade50,
  ];
  List<MaterialColor> indicatorColors = [
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.amber,
  ];

  List<Widget> demos = [];
  int b = 0;
  for (b = 0; b < 2; b = b + 1) {
    demos.add(
      Expanded(
        child: Container(
          margin: EdgeInsets.all(4),
          height: 220,
          decoration: BoxDecoration(
            color: bgColors[b],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: indicatorColors[b].withAlpha(100)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  bgLabels[b],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: indicatorColors[b].shade700,
                  ),
                ),
              ),
              buildDrawerDestination(
                Icons.dashboard,
                'Dashboard',
                true,
                indicatorColors[b],
                indicatorColors[b].shade700,
                44.0,
              ),
              buildDrawerDestination(
                Icons.inbox,
                'Inbox',
                false,
                indicatorColors[b],
                indicatorColors[b].shade700,
                44.0,
              ),
              buildDrawerDestination(
                Icons.star,
                'Favorites',
                false,
                indicatorColors[b],
                indicatorColors[b].shade700,
                44.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> demos2 = [];
  for (b = 2; b < 4; b = b + 1) {
    demos2.add(
      Expanded(
        child: Container(
          margin: EdgeInsets.all(4),
          height: 220,
          decoration: BoxDecoration(
            color: bgColors[b],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: indicatorColors[b].withAlpha(100)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  bgLabels[b],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: indicatorColors[b].shade700,
                  ),
                ),
              ),
              buildDrawerDestination(
                Icons.dashboard,
                'Dashboard',
                true,
                indicatorColors[b],
                indicatorColors[b].shade700,
                44.0,
              ),
              buildDrawerDestination(
                Icons.inbox,
                'Inbox',
                false,
                indicatorColors[b],
                indicatorColors[b].shade700,
                44.0,
              ),
              buildDrawerDestination(
                Icons.star,
                'Favorites',
                false,
                indicatorColors[b],
                indicatorColors[b].shade700,
                44.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Themed Background Colors',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'backgroundColor property customizes drawer background',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Row(children: demos),
        SizedBox(height: 8),
        Row(children: demos2),
      ],
    ),
  );
}

Widget buildIndicatorShapesDemo() {
  print('Building indicator shapes demo');
  List<String> shapeLabels = [
    'Stadium (Default)',
    'Rounded Rectangle',
    'Circle Highlight',
    'Sharp Rectangle',
  ];
  List<double> borderRadii = [28.0, 12.0, 50.0, 4.0];
  List<Color> indicatorColors = [
    Colors.indigo,
    Colors.teal,
    Colors.pink,
    Colors.deepOrange,
  ];

  List<Widget> shapeCards = [];
  int s = 0;
  for (s = 0; s < shapeLabels.length; s = s + 1) {
    shapeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              shapeLabels[s],
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              height: 48,
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: indicatorColors[s].withAlpha(40),
                borderRadius: BorderRadius.circular(borderRadii[s]),
              ),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.folder, color: indicatorColors[s], size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Documents',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: indicatorColors[s],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Border radius: ${borderRadii[s].toInt()}',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Indicator Shape Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'indicatorShape property defines selection indicator',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: shapeCards),
      ],
    ),
  );
}

Widget buildLabelTextStyleDemo() {
  print('Building label text style demo');
  List<String> styleLabels = [
    'Default Style',
    'Bold Uppercase',
    'Italic Smaller',
    'Colored & Spaced',
  ];
  List<TextStyle> selectedStyles = [
    TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.indigo),
    TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.teal),
    TextStyle(
      fontSize: 12,
      fontStyle: FontStyle.italic,
      color: Colors.pink.shade700,
    ),
    TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
      color: Colors.deepOrange,
    ),
  ];
  List<TextStyle> unselectedStyles = [
    TextStyle(fontSize: 14, color: Colors.grey.shade600),
    TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
    TextStyle(
      fontSize: 12,
      fontStyle: FontStyle.italic,
      color: Colors.grey.shade500,
    ),
    TextStyle(fontSize: 14, letterSpacing: 1.2, color: Colors.grey.shade600),
  ];
  List<Color> accentColors = [
    Colors.indigo,
    Colors.teal,
    Colors.pink,
    Colors.deepOrange,
  ];

  List<Widget> styleRows = [];
  int t = 0;
  for (t = 0; t < styleLabels.length; t = t + 1) {
    styleRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: accentColors[t].withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: accentColors[t].withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              styleLabels[t],
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: accentColors[t],
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: accentColors[t].withAlpha(40),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.home, size: 18, color: accentColors[t]),
                      SizedBox(width: 8),
                      Text('Home', style: selectedStyles[t]),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Row(
                  children: [
                    Icon(Icons.settings, size: 18, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Settings', style: unselectedStyles[t]),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Label Text Styles',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'labelTextStyle for selected and unselected states',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: styleRows),
      ],
    ),
  );
}

Widget buildTileHeightDemo() {
  print('Building tile height demo');
  List<String> heightLabels = [
    'Compact (40px)',
    'Default (56px)',
    'Spacious (72px)',
  ];
  List<double> heights = [40.0, 56.0, 72.0];
  List<Color> colors = [Colors.green, Colors.indigo, Colors.purple];

  List<Widget> heightCards = [];
  int h = 0;
  for (h = 0; h < heightLabels.length; h = h + 1) {
    heightCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors[h].withAlpha(15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors[h].withAlpha(60)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heightLabels[h],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: colors[h],
              ),
            ),
            SizedBox(height: 8),
            buildDrawerDestination(
              Icons.dashboard,
              'Dashboard',
              true,
              colors[h],
              colors[h],
              heights[h],
            ),
            buildDrawerDestination(
              Icons.analytics,
              'Analytics',
              false,
              colors[h],
              colors[h],
              heights[h],
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tile Height Customization',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'tileHeight property controls destination item height',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: heightCards),
      ],
    ),
  );
}

Widget buildIconThemingDemo() {
  print('Building icon theming demo');
  List<String> themeNames = [
    'Default Icons',
    'Large Icons',
    'Colored Icons',
    'Outlined Style',
  ];
  List<double> iconSizes = [24.0, 32.0, 24.0, 24.0];
  List<Color> selectedIconColors = [
    Colors.indigo,
    Colors.teal,
    Colors.pink,
    Colors.deepOrange,
  ];
  List<Color> unselectedIconColors = [
    Colors.grey.shade600,
    Colors.grey.shade500,
    Colors.grey.shade600,
    Colors.grey.shade500,
  ];
  List<IconData> filledIcons = [
    Icons.home,
    Icons.folder,
    Icons.favorite,
    Icons.star,
  ];
  List<IconData> outlinedIcons = [
    Icons.home_outlined,
    Icons.folder_outlined,
    Icons.favorite_border,
    Icons.star_border,
  ];

  List<Widget> iconRows = [];
  int i = 0;
  for (i = 0; i < themeNames.length; i = i + 1) {
    IconData selectedIcon = filledIcons[i];
    IconData unselectedIcon = (i == 3) ? outlinedIcons[i] : filledIcons[i];
    iconRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              child: Text(
                themeNames[i],
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: selectedIconColors[i].withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                selectedIcon,
                size: iconSizes[i],
                color: selectedIconColors[i],
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Selected',
              style: TextStyle(fontSize: 11, color: selectedIconColors[i]),
            ),
            SizedBox(width: 16),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                unselectedIcon,
                size: iconSizes[i],
                color: unselectedIconColors[i],
              ),
            ),
            SizedBox(width: 8),
            Text(
              'Unselected',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icon Theming',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'iconTheme for selected and unselected icon states',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: iconRows),
      ],
    ),
  );
}

Widget buildMultipleThemedDrawersDemo() {
  print('Building multiple themed drawers demo');
  List<String> drawerNames = [
    'Admin Panel',
    'User Dashboard',
    'Settings Hub',
    'Analytics Center',
  ];
  List<Color> bgColors = [
    Colors.indigo.shade50,
    Colors.teal.shade50,
    Colors.orange.shade50,
    Colors.purple.shade50,
  ];
  List<Color> indicatorColors = [
    Colors.indigo,
    Colors.teal,
    Colors.orange,
    Colors.purple,
  ];
  List<List<IconData>> drawerIcons = [
    [Icons.admin_panel_settings, Icons.people, Icons.security],
    [Icons.dashboard, Icons.notifications, Icons.account_circle],
    [Icons.settings, Icons.tune, Icons.build],
    [Icons.analytics, Icons.bar_chart, Icons.trending_up],
  ];
  List<List<String>> drawerLabels = [
    ['Admin', 'Users', 'Security'],
    ['Dashboard', 'Alerts', 'Profile'],
    ['General', 'Advanced', 'System'],
    ['Overview', 'Charts', 'Trends'],
  ];

  List<Widget> drawerCards = [];
  int d = 0;
  for (d = 0; d < drawerNames.length; d = d + 1) {
    List<Widget> destItems = [];
    int j = 0;
    for (j = 0; j < 3; j = j + 1) {
      destItems.add(
        buildDrawerDestination(
          drawerIcons[d][j],
          drawerLabels[d][j],
          j == 0,
          indicatorColors[d],
          indicatorColors[d],
          44.0,
        ),
      );
    }

    drawerCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: indicatorColors[d].withAlpha(80)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: indicatorColors[d].withAlpha(20),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
              ),
              child: Text(
                drawerNames[d],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: indicatorColors[d],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: bgColors[d],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(9),
                  bottomRight: Radius.circular(9),
                ),
              ),
              child: Column(children: destItems),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multiple Themed Drawers',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different NavigationDrawerThemeData for different contexts',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: drawerCards),
      ],
    ),
  );
}

Widget buildThemeInheritanceDemo() {
  print('Building theme inheritance demo');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme Inheritance Hierarchy',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.layers, size: 20, color: Colors.indigo),
                  SizedBox(width: 8),
                  Text(
                    'ThemeData',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.only(left: 16),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.style, size: 18, color: Colors.teal),
                        SizedBox(width: 8),
                        Text(
                          'NavigationDrawerThemeData',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.widgets, size: 16, color: Colors.orange),
                          SizedBox(width: 8),
                          Text(
                            'NavigationDrawer Widget',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade700,
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
        ),
        SizedBox(height: 16),
        buildInfoCard('Access', 'NavigationDrawerTheme.of(context)'),
        buildInfoCard('Override', 'Wrap with NavigationDrawerTheme widget'),
        buildInfoCard(
          'Fallback',
          'Uses defaults from NavigationDrawerThemeData()',
        ),
      ],
    ),
  );
}

Widget buildPropertyReferenceGrid() {
  print('Building property reference grid');
  List<String> propNames = [
    'backgroundColor',
    'elevation',
    'shadowColor',
    'surfaceTintColor',
    'indicatorColor',
    'indicatorShape',
    'indicatorSize',
    'labelTextStyle',
    'iconTheme',
    'tileHeight',
  ];
  List<String> propTypes = [
    'Color?',
    'double?',
    'Color?',
    'Color?',
    'Color?',
    'ShapeBorder?',
    'Size?',
    'WidgetStateProperty<TextStyle?>?',
    'WidgetStateProperty<IconThemeData?>?',
    'double?',
  ];
  List<String> propDescs = [
    'Background color of the drawer surface',
    'Elevation shadow depth of the drawer',
    'Color of the drawer shadow',
    'Surface tint color for Material 3',
    'Color of the selection indicator',
    'Shape of the selection indicator',
    'Size of the selection indicator',
    'Text style for destination labels',
    'Icon theme for destination icons',
    'Height of each destination tile',
  ];

  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color bg = (p % 2 == 0) ? Colors.indigo.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: bg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              child: Text(
                propNames[p],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                propTypes[p],
                style: TextStyle(fontSize: 11, color: Colors.teal.shade700),
              ),
            ),
            Expanded(
              child: Text(
                propDescs[p],
                style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
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
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade700,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Property',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 90),
              Text(
                'Type',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 70),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('NavigationDrawerThemeData deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('NavigationDrawerThemeData Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'NavigationDrawerThemeData'),
            buildInfoCard(
              'Purpose',
              'Defines visual properties for NavigationDrawer widgets',
            ),
            buildInfoCard(
              'Used With',
              'NavigationDrawer, NavigationDrawerTheme',
            ),
            buildInfoCard(
              'Material Design',
              'Material 3 navigation drawer component theming',
            ),

            buildSectionHeader('2. Default Appearance'),
            buildDefaultDrawerDemo(),

            buildSectionHeader('3. Background Color'),
            buildThemedBackgroundDemo(),

            buildSectionHeader('4. Indicator Shape & Color'),
            buildIndicatorShapesDemo(),

            buildSectionHeader('5. Label Text Styles'),
            buildLabelTextStyleDemo(),

            buildSectionHeader('6. Tile Height'),
            buildTileHeightDemo(),

            buildSectionHeader('7. Icon Theming'),
            buildIconThemingDemo(),

            buildSectionHeader('8. Multiple Themed Drawers'),
            buildMultipleThemedDrawersDemo(),

            buildSectionHeader('9. Theme Inheritance'),
            buildThemeInheritanceDemo(),

            buildSectionHeader('10. Property Reference'),
            buildPropertyReferenceGrid(),

            buildSectionHeader('11. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Set theme in ThemeData.navigationDrawerTheme',
            ),
            buildInfoCard(
              'Tip 2',
              'Use WidgetStateProperty for state-based styles',
            ),
            buildInfoCard('Tip 3', 'indicatorShape defaults to StadiumBorder'),
            buildInfoCard(
              'Tip 4',
              'Combine with NavigationRail for responsive layouts',
            ),
            buildInfoCard(
              'Tip 5',
              'Use NavigationDrawerTheme.of(context) to access',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('NavigationDrawerThemeData deep demo completed');
  return result;
}
