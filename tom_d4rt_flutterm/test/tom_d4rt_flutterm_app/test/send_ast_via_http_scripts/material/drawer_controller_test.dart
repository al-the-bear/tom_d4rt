// ignore_for_file: avoid_print
// D4rt test script: Tests DrawerController from material
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

Widget buildDrawerItem(IconData icon, String title, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    child: ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(fontSize: 15)),
      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
    ),
  );
}

Widget buildColoredDrawerHeader(String title, String subtitle, Color bgColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(color: bgColor),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 36, color: bgColor),
        ),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.white70)),
      ],
    ),
  );
}

Widget buildDrawerPreview(
  String label,
  Color headerColor,
  List<String> items,
  List<IconData> icons,
) {
  print('Building drawer preview: $label');
  List<Widget> children = [];
  children.add(buildColoredDrawerHeader(label, 'Drawer Preview', headerColor));
  children.add(SizedBox(height: 8));
  int i = 0;
  for (i = 0; i < items.length; i = i + 1) {
    IconData ico = Icons.circle;
    if (i < icons.length) {
      ico = icons[i];
    }
    children.add(buildDrawerItem(ico, items[i], headerColor));
  }
  children.add(Divider());
  children.add(
    buildDrawerItem(Icons.settings, 'Settings', Colors.grey.shade600),
  );
  children.add(
    buildDrawerItem(Icons.help_outline, 'Help', Colors.grey.shade600),
  );

  return Container(
    width: 280,
    height: 480,
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300, width: 1),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 2)),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    ),
  );
}

Widget buildEndDrawerPreview(String label, Color accentColor) {
  print('Building end drawer preview: $label');
  List<Widget> settingsItems = [];
  List<String> settingLabels = [
    'Notifications',
    'Dark Mode',
    'Auto-sync',
    'Location Services',
    'Data Saver',
  ];
  int j = 0;
  for (j = 0; j < settingLabels.length; j = j + 1) {
    settingsItems.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(settingLabels[j], style: TextStyle(fontSize: 15)),
            ),
            Container(
              width: 48,
              height: 28,
              decoration: BoxDecoration(
                color: (j % 2 == 0) ? accentColor : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Align(
                alignment: (j % 2 == 0)
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 22,
                  height: 22,
                  margin: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    width: 280,
    height: 480,
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300, width: 1),
      boxShadow: [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 2)),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: accentColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'End Drawer Settings',
                  style: TextStyle(fontSize: 13, color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: settingsItems),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildScaffoldDiagram(String title, bool hasEndDrawer, Color primary) {
  print('Building scaffold diagram: $title');
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
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: primary, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                color: primary.withAlpha(50),
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      'DRAWER',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.grey.shade50,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.phone_android,
                          size: 40,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Main Content',
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (hasEndDrawer)
                Container(
                  width: 60,
                  color: Colors.orange.shade50,
                  child: Center(
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        'END DRAWER',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.swipe_right, size: 16, color: primary),
            SizedBox(width: 4),
            Text(
              'Swipe right to open drawer',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        if (hasEndDrawer)
          Row(
            children: [
              Icon(Icons.swipe_left, size: 16, color: Colors.orange.shade700),
              SizedBox(width: 4),
              Text(
                'Swipe left to open end drawer',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
      ],
    ),
  );
}

Widget buildDrawerWidthComparison() {
  print('Building drawer width comparison');
  List<int> widths = [200, 256, 304, 360];
  List<Color> colors = [
    Colors.blue.shade600,
    Colors.teal.shade600,
    Colors.purple.shade600,
    Colors.red.shade600,
  ];
  List<Widget> bars = [];
  int k = 0;
  for (k = 0; k < widths.length; k = k + 1) {
    double fraction = widths[k] / 400.0;
    bars.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Width: ${widths[k]}px',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            FractionallySizedBox(
              widthFactor: fraction,
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: colors[k],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    '${widths[k]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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
          'Drawer Width Options',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Column(children: bars),
      ],
    ),
  );
}

Widget buildDrawerShapeShowcase() {
  print('Building drawer shape showcase');
  List<String> shapeNames = [
    'Default Rectangle',
    'Rounded Right',
    'Stadium Right',
    'Custom Radius',
  ];
  List<BorderRadius> radii = [
    BorderRadius.zero,
    BorderRadius.only(
      topRight: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
    BorderRadius.only(
      topRight: Radius.circular(32),
      bottomRight: Radius.circular(32),
    ),
    BorderRadius.only(
      topRight: Radius.circular(8),
      bottomRight: Radius.circular(24),
    ),
  ];
  List<Color> shapeBgColors = [
    Colors.blue.shade50,
    Colors.teal.shade50,
    Colors.amber.shade50,
    Colors.pink.shade50,
  ];
  List<Color> shapeEdgeColors = [
    Colors.blue.shade400,
    Colors.teal.shade400,
    Colors.amber.shade600,
    Colors.pink.shade400,
  ];
  List<Widget> shapeWidgets = [];
  int s = 0;
  for (s = 0; s < shapeNames.length; s = s + 1) {
    shapeWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                color: shapeBgColors[s],
                borderRadius: radii[s],
                border: Border.all(color: shapeEdgeColors[s], width: 2),
              ),
              child: Center(child: Icon(Icons.menu, color: shapeEdgeColors[s])),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shapeNames[s],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Shape variant ${s + 1}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
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
          'Drawer Shape Variants',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Column(children: shapeWidgets),
      ],
    ),
  );
}

Widget buildDrawerContentPatterns() {
  print('Building drawer content patterns');
  List<Widget> group1 = [];
  List<String> navLabels = ['Home', 'Profile', 'Messages', 'Calendar', 'Tasks'];
  List<IconData> navIcons = [
    Icons.home,
    Icons.person,
    Icons.message,
    Icons.calendar_today,
    Icons.task_alt,
  ];
  List<MaterialColor> navColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];
  int n = 0;
  for (n = 0; n < navLabels.length; n = n + 1) {
    group1.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: (n == 0) ? navColors[n].shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(navIcons[n], color: navColors[n], size: 22),
            SizedBox(width: 12),
            Text(
              navLabels[n],
              style: TextStyle(
                fontSize: 14,
                fontWeight: (n == 0) ? FontWeight.bold : FontWeight.normal,
              ),
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
          'Navigation Drawer Pattern',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Standard Material navigation items',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: group1),
      ],
    ),
  );
}

Widget buildDrawerSectionedContent() {
  print('Building sectioned drawer content');
  List<Widget> sections = [];
  List<String> sectionTitles = ['Account', 'Content', 'Communication'];
  List<List<String>> sectionItems = [
    ['My Profile', 'Subscription', 'Storage'],
    ['Documents', 'Photos', 'Videos'],
    ['Chat', 'Email', 'Notifications'],
  ];
  List<List<IconData>> sectionIcons = [
    [Icons.account_circle, Icons.card_membership, Icons.storage],
    [Icons.description, Icons.photo_library, Icons.video_library],
    [Icons.chat, Icons.email, Icons.notifications],
  ];
  int sec = 0;
  for (sec = 0; sec < sectionTitles.length; sec = sec + 1) {
    sections.add(
      Container(
        margin: EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                sectionTitles[sec],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade700,
                ),
              ),
            ),
            Column(
              children: _buildSectionItems(
                sectionItems[sec],
                sectionIcons[sec],
              ),
            ),
            if (sec < sectionTitles.length - 1) Divider(),
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
          'Sectioned Drawer Content',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Grouped items with section headers',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8),
        Column(children: sections),
      ],
    ),
  );
}

List<Widget> _buildSectionItems(List<String> labels, List<IconData> icons) {
  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < labels.length; i = i + 1) {
    items.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icons[i], size: 20, color: Colors.grey.shade600),
            SizedBox(width: 12),
            Text(labels[i], style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
  return items;
}

Widget buildDrawerAnimationStages() {
  print('Building drawer animation stages');
  List<double> openFractions = [0.0, 0.25, 0.5, 0.75, 1.0];
  List<String> stageLabels = [
    'Closed',
    'Opening 25%',
    'Halfway',
    'Opening 75%',
    'Fully Open',
  ];
  List<Widget> stages = [];
  int a = 0;
  for (a = 0; a < openFractions.length; a = a + 1) {
    double drawerWidth = 60 * openFractions[a];
    int alphaVal = (255 * openFractions[a] * 0.5).toInt();
    stages.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  Container(color: Color.fromARGB(alphaVal, 0, 0, 0)),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: drawerWidth,
                      color: Colors.teal.shade300,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stageLabels[a],
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Progress: ${(openFractions[a] * 100).toInt()}%',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
          'Drawer Animation Stages',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Visual progression of DrawerController animation',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: stages),
      ],
    ),
  );
}

Widget buildControllerProperties() {
  print('Building controller properties table');
  List<String> propNames = [
    'alignment',
    'drawerCallback',
    'dragStartBehavior',
    'scrimColor',
    'edgeDragWidth',
    'isDrawerOpen',
    'enableOpenDragGesture',
  ];
  List<String> propDescs = [
    'Controls which side the drawer appears on',
    'Callback when drawer open/close state changes',
    'Determines how drag start is detected',
    'Color of the overlay behind the drawer',
    'Width of the edge area that responds to drag',
    'Whether the drawer is currently open',
    'Whether drag gesture can open the drawer',
  ];
  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < propNames.length; p = p + 1) {
    Color rowBg = (p % 2 == 0) ? Colors.grey.shade50 : Colors.white;
    rows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: rowBg,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140,
              child: Text(
                propNames[p],
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                propDescs[p],
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
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
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            'DrawerController Properties',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Column(children: rows),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('DrawerController deep demo test executing');

  List<String> mainDrawerItems = [
    'Dashboard',
    'Analytics',
    'Reports',
    'Team',
    'Projects',
  ];
  List<IconData> mainDrawerIcons = [
    Icons.dashboard,
    Icons.analytics,
    Icons.assessment,
    Icons.people,
    Icons.folder,
  ];

  List<String> endDrawerItems = [
    'Quick Note',
    'Bookmarks',
    'Recent',
    'Downloads',
  ];
  List<IconData> endDrawerIcons = [
    Icons.note_add,
    Icons.bookmark,
    Icons.history,
    Icons.download,
  ];

  print('Building main layout');

  Widget mainDrawer = buildDrawerPreview(
    'Main Navigation',
    Colors.teal.shade700,
    mainDrawerItems,
    mainDrawerIcons,
  );
  Widget endDrawer = buildEndDrawerPreview(
    'Settings Panel',
    Colors.deepOrange.shade600,
  );
  Widget altDrawer = buildDrawerPreview(
    'Alt Theme Drawer',
    Colors.indigo.shade700,
    endDrawerItems,
    endDrawerIcons,
  );

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DrawerController Deep Demo'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. DrawerController Overview'),
            buildInfoCard('Class', 'DrawerController'),
            buildInfoCard(
              'Purpose',
              'Provides the ability to open and close a drawer via animation controller',
            ),
            buildInfoCard('Inherited From', 'StatefulWidget'),
            buildInfoCard(
              'Key Feature',
              'Controls drawer open/close animations and gestures',
            ),

            buildSectionHeader('2. Main Drawer Preview'),
            Center(child: mainDrawer),

            buildSectionHeader('3. End Drawer Preview'),
            Center(child: endDrawer),

            buildSectionHeader('4. Alternative Theme Drawer'),
            Center(child: altDrawer),

            buildSectionHeader('5. Scaffold Layout Diagrams'),
            buildScaffoldDiagram(
              'Single Drawer Layout',
              false,
              Colors.teal.shade700,
            ),
            buildScaffoldDiagram(
              'Dual Drawer Layout',
              true,
              Colors.indigo.shade700,
            ),

            buildSectionHeader('6. Drawer Width Comparison'),
            buildDrawerWidthComparison(),

            buildSectionHeader('7. Drawer Shape Variants'),
            buildDrawerShapeShowcase(),

            buildSectionHeader('8. Drawer Animation Stages'),
            buildDrawerAnimationStages(),

            buildSectionHeader('9. Navigation Drawer Pattern'),
            buildDrawerContentPatterns(),

            buildSectionHeader('10. Sectioned Drawer Content'),
            buildDrawerSectionedContent(),

            buildSectionHeader('11. DrawerController Properties'),
            buildControllerProperties(),

            buildSectionHeader('12. Usage Summary'),
            buildInfoCard(
              'Tip 1',
              'Use DrawerController for custom drawer animations',
            ),
            buildInfoCard(
              'Tip 2',
              'Scaffold provides built-in drawer and endDrawer slots',
            ),
            buildInfoCard(
              'Tip 3',
              'Set scrimColor to customize the overlay behind drawers',
            ),
            buildInfoCard(
              'Tip 4',
              'Use edgeDragWidth to control swipe sensitivity',
            ),
            buildInfoCard(
              'Tip 5',
              'DrawerController.of(context) accesses the nearest controller',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('DrawerController deep demo completed');
  return result;
}
