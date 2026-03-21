// D4rt test script: Tests NavigationIndicator from material
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

Widget buildIndicatorOverview() {
  print('Building indicator overview');
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
          'NavigationIndicator Overview',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'The NavigationIndicator is the pill-shaped visual element that appears '
          'behind selected navigation items in Material 3 design. It provides '
          'clear visual feedback for the currently selected destination.',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.indigo, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'Selection State',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Shows active item',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.stadium, color: Colors.teal, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'Stadium Shape',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Pill-shaped design',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.animation, color: Colors.orange, size: 32),
                    SizedBox(height: 8),
                    Text(
                      'Animated',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Smooth transitions',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildBasicIndicator(String label, Color indicatorColor, bool isSelected) {
  print('Building basic indicator: $label');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Container(
          width: 64,
          height: 32,
          decoration: BoxDecoration(
            color: isSelected ? indicatorColor : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Icon(
              Icons.home,
              size: 20,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                isSelected ? 'Selected state' : 'Unselected state',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green.shade100 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isSelected ? 'ON' : 'OFF',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.green.shade700 : Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildColorVariations() {
  print('Building indicator color variations');
  List<String> colorNames = [
    'Primary (Indigo)',
    'Secondary (Teal)',
    'Tertiary (Orange)',
    'Error (Red)',
    'Custom Purple',
    'Custom Cyan',
  ];
  List<Color> colors = [
    Colors.indigo,
    Colors.teal,
    Colors.orange,
    Colors.red,
    Colors.purple,
    Colors.cyan,
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < colorNames.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors[i].withAlpha(20),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors[i].withAlpha(100)),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 28,
              decoration: BoxDecoration(
                color: colors[i],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Icon(Icons.star, size: 16, color: Colors.white),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                colorNames[i],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colors[i].withAlpha(220),
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: colors[i],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
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
          'Indicator Color Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different color options for navigation indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildStadiumShapeDemo() {
  print('Building stadium shape demonstration');
  List<double> widths = [48.0, 56.0, 64.0, 72.0, 80.0];
  List<double> heights = [28.0, 32.0, 36.0, 32.0, 28.0];
  List<String> labels = ['Compact', 'Small', 'Standard', 'Wide', 'Extra Wide'];

  List<Widget> shapes = [];
  int i = 0;
  for (i = 0; i < widths.length; i = i + 1) {
    shapes.add(
      Column(
        children: [
          Container(
            width: widths[i],
            height: heights[i],
            decoration: BoxDecoration(
              color: Colors.indigo.shade400,
              borderRadius: BorderRadius.circular(heights[i] / 2),
            ),
            child: Center(
              child: Icon(
                Icons.circle,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            labels[i],
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
          Text(
            '${widths[i].toInt()}x${heights[i].toInt()}',
            style: TextStyle(
              fontSize: 10,
              color: Colors.indigo.shade400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
          'Stadium Shape (Pill Shape)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'The indicator uses a stadium (pill) shape with rounded ends',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: shapes,
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Stadium shape is achieved using borderRadius equal to height/2',
                  style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildDimensionsDemo() {
  print('Building indicator dimensions demo');
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
          'Indicator Dimensions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Width and height configurations for different contexts',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      'NavigationBar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.green.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 64,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '64 x 32',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    Text(
                      'Horizontal pill',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      'NavigationRail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 56,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '56 x 32',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    Text(
                      'Compact pill',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  children: [
                    Text(
                      'Extended Rail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 120,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.home, size: 16, color: Colors.white),
                            SizedBox(width: 4),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Flexible width',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                      ),
                    ),
                    Text(
                      'Text + icon',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildAnimatedIndicatorDemo() {
  print('Building animated indicator demonstration');
  List<int> positions = [0, 1, 2, 3];
  List<String> stages = ['Position 1', 'Position 2', 'Position 3', 'Position 4'];
  List<IconData> icons = [Icons.home, Icons.search, Icons.favorite, Icons.person];

  List<Widget> rows = [];
  int p = 0;
  for (p = 0; p < positions.length; p = p + 1) {
    List<Widget> navItems = [];
    int n = 0;
    for (n = 0; n < 4; n = n + 1) {
      navItems.add(
        Container(
          width: 56,
          height: 40,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: n == p ? Colors.indigo.shade100 : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icons[n],
            size: 22,
            color: n == p ? Colors.indigo : Colors.grey.shade500,
          ),
        ),
      );
    }

    rows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              child: Text(
                stages[p],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: navItems,
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
          'Animated Indicator Positions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'The indicator animates smoothly between navigation items',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: rows),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.animation, color: Colors.amber.shade700, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Animation duration is typically 200-300ms with ease curve',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildMultipleIndicatorsRow() {
  print('Building multiple indicators in a row');
  List<String> labels = ['Home', 'Search', 'Likes', 'Profile', 'Settings'];
  List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person,
    Icons.settings,
  ];
  List<bool> selected = [true, false, false, false, false];
  List<MaterialColor> colors = [
    Colors.indigo,
    Colors.teal,
    Colors.pink,
    Colors.orange,
    Colors.grey,
  ];

  List<Widget> indicators = [];
  int i = 0;
  for (i = 0; i < labels.length; i = i + 1) {
    indicators.add(
      Expanded(
        child: Column(
          children: [
            Container(
              width: 56,
              height: 32,
              decoration: BoxDecoration(
                color: selected[i] ? colors[i].shade200 : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  icons[i],
                  size: 20,
                  color: selected[i] ? colors[i].shade700 : Colors.grey.shade500,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              labels[i],
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected[i] ? FontWeight.bold : FontWeight.normal,
                color: selected[i] ? colors[i].shade700 : Colors.grey.shade600,
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
          'Multiple Indicators in Navigation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Only one indicator is active at a time in standard navigation',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(children: indicators),
        ),
      ],
    ),
  );
}

Widget buildNavigationBarWithIndicator() {
  print('Building NavigationBar with indicator');
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
          'NavigationBar with Indicator',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Material 3 bottom navigation component',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(20),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: 1,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                selectedIcon: Icon(Icons.explore),
                label: 'Explore',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark_outline),
                selectedIcon: Icon(Icons.bookmark),
                label: 'Saved',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onDestinationSelected: (int index) {
              print('NavigationBar destination selected: $index');
            },
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.info_outline, size: 16, color: Colors.indigo),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'indicatorColor controls the pill background color',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildNavigationRailWithIndicator() {
  print('Building NavigationRail with indicator');
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
          'NavigationRail with Indicator',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Vertical navigation for larger screens',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              NavigationRail(
                selectedIndex: 2,
                labelType: NavigationRailLabelType.all,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.inbox_outlined),
                    selectedIcon: Icon(Icons.inbox),
                    label: Text('Inbox'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.send_outlined),
                    selectedIcon: Icon(Icons.send),
                    label: Text('Sent'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.drafts_outlined),
                    selectedIcon: Icon(Icons.drafts),
                    label: Text('Drafts'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.delete_outline),
                    selectedIcon: Icon(Icons.delete),
                    label: Text('Trash'),
                  ),
                ],
                onDestinationSelected: (int index) {
                  print('NavigationRail destination selected: $index');
                },
              ),
              VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: Center(
                  child: Text(
                    'Content Area',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.info_outline, size: 16, color: Colors.purple),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'NavigationRail uses the same indicator system as NavigationBar',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildCustomIndicatorStyling() {
  print('Building custom indicator styling examples');
  List<String> styleNames = [
    'Default M3',
    'High Contrast',
    'Soft Pastel',
    'Brand Color',
    'Gradient Effect',
    'Outlined Style',
  ];
  List<Color> bgColors = [
    Colors.indigo.shade100,
    Colors.black,
    Colors.pink.shade50,
    Colors.deepOrange,
    Colors.purple.shade300,
    Colors.transparent,
  ];
  List<Color> iconColors = [
    Colors.indigo,
    Colors.white,
    Colors.pink.shade400,
    Colors.white,
    Colors.white,
    Colors.teal,
  ];
  List<Color> borderColors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
    Colors.teal,
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < styleNames.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 32,
              decoration: BoxDecoration(
                color: bgColors[i],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: borderColors[i],
                  width: borderColors[i] == Colors.transparent ? 0 : 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.star,
                  size: 18,
                  color: iconColors[i],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    styleNames[i],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Custom indicator variant ${i + 1}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: bgColors[i],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
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
          'Custom Indicator Styling',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Various styling approaches for navigation indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget buildIndicatorProperties() {
  print('Building indicator properties reference');
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
          'Indicator Configuration Properties',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Key properties for customizing navigation indicators',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Table(
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          border: TableBorder.all(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Property',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('indicatorColor', style: TextStyle(fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Background color of the pill indicator',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('indicatorShape', style: TextStyle(fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Shape of the indicator (default: StadiumBorder)',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('selectedIndex', style: TextStyle(fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Which destination shows the indicator',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('labelBehavior', style: TextStyle(fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Controls label visibility with indicator',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('NavigationIndicator deep demo test executing');

  Widget result = Scaffold(
    appBar: AppBar(
      title: Text('NavigationIndicator Demo'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
    body: Container(
      color: Colors.grey.shade200,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview of NavigationIndicator'),
            buildIndicatorOverview(),

            buildSectionHeader('2. Basic Indicator Appearance'),
            buildBasicIndicator('Selected Item', Colors.indigo, true),
            buildBasicIndicator('Unselected Item', Colors.indigo, false),
            buildBasicIndicator('Hover State', Colors.indigo.shade300, true),
            buildBasicIndicator('Pressed State', Colors.indigo.shade700, true),

            buildSectionHeader('3. Indicator Color Variations'),
            buildColorVariations(),

            buildSectionHeader('4. Indicator Shape (Stadium Shape)'),
            buildStadiumShapeDemo(),

            buildSectionHeader('5. Indicator Width/Height'),
            buildDimensionsDemo(),

            buildSectionHeader('6. Animated Indicator'),
            buildAnimatedIndicatorDemo(),

            buildSectionHeader('7. Multiple Indicators in a Row'),
            buildMultipleIndicatorsRow(),

            buildSectionHeader('8. Indicator Inside NavigationBar'),
            buildNavigationBarWithIndicator(),

            buildSectionHeader('9. Indicator Inside NavigationRail'),
            buildNavigationRailWithIndicator(),

            buildSectionHeader('10. Custom Indicator Styling'),
            buildCustomIndicatorStyling(),

            buildSectionHeader('11. Configuration Properties'),
            buildIndicatorProperties(),

            buildSectionHeader('12. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Use indicatorColor in NavigationBarThemeData for consistent styling',
            ),
            buildInfoCard(
              'Tip 2',
              'The indicator automatically animates between destinations',
            ),
            buildInfoCard(
              'Tip 3',
              'Pair with selectedIcon/icon for clear visual feedback',
            ),
            buildInfoCard(
              'Tip 4',
              'Stadium shape (pill) is the Material 3 default',
            ),
            buildInfoCard(
              'Tip 5',
              'Consider contrast ratios for accessibility',
            ),
            buildInfoCard(
              'Tip 6',
              'Use NavigationIndicator widget directly for custom layouts',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('NavigationIndicator deep demo completed');
  return result;
}
