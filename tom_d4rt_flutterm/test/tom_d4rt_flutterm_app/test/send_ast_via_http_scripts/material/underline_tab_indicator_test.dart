// ignore_for_file: avoid_print
// D4rt test script: Deep demo of UnderlineTabIndicator for TabBar
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
      crossAxisAlignment: CrossAxisAlignment.start,
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

Widget buildTabBarDemo(
  String label,
  String description,
  Decoration indicator,
  Color indicatorColor,
  List<String> tabLabels,
) {
  print('Building TabBar demo: $label');
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
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        DefaultTabController(
          length: tabLabels.length,
          child: Container(
            decoration: BoxDecoration(
              color: indicatorColor.withAlpha(15),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: TabBar(
              indicator: indicator,
              labelColor: indicatorColor,
              unselectedLabelColor: Colors.grey.shade500,
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              unselectedLabelStyle: TextStyle(fontSize: 14),
              tabs: tabLabels.map((t) => Tab(text: t)).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildBorderSideWidthComparison() {
  print('Building border side width comparison');
  List<double> widths = [1.0, 2.0, 3.0, 4.0, 6.0, 8.0];
  List<Widget> items = [];

  for (int i = 0; i < widths.length; i = i + 1) {
    double w = widths[i];
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Width: ${w.toInt()}px',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.indigo.shade700,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    w <= 2.0 ? 'Subtle' : (w <= 4.0 ? 'Standard' : 'Bold'),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            DefaultTabController(
              length: 3,
              child: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.indigo, width: w),
                ),
                labelColor: Colors.indigo,
                unselectedLabelColor: Colors.grey.shade500,
                tabs: [
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                  Tab(text: 'Settings'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: items);
}

Widget buildBorderSideColorShowcase() {
  print('Building border side color showcase');
  List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.amber,
  ];
  List<String> colorNames = [
    'Red',
    'Orange',
    'Green',
    'Blue',
    'Purple',
    'Pink',
    'Teal',
    'Amber',
  ];

  List<Widget> rows = [];
  for (int i = 0; i < colors.length; i = i + 2) {
    List<Widget> rowItems = [];
    for (int j = i; j < i + 2 && j < colors.length; j = j + 1) {
      rowItems.add(
        Expanded(
          child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors[j].withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 6),
                  child: Row(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: colors[j],
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        colorNames[j],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                DefaultTabController(
                  length: 2,
                  child: TabBar(
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: colors[j], width: 3.0),
                    ),
                    labelColor: colors[j],
                    unselectedLabelColor: Colors.grey.shade400,
                    labelStyle: TextStyle(fontSize: 12),
                    tabs: [Tab(text: 'Tab 1'), Tab(text: 'Tab 2')],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    rows.add(Row(children: rowItems));
  }

  return Column(children: rows);
}

Widget buildBorderRadiusDemo() {
  print('Building border radius demo');
  List<double> radii = [0.0, 2.0, 4.0, 8.0, 16.0];
  List<String> radiusLabels = [
    'Sharp (0)',
    'Subtle (2)',
    'Rounded (4)',
    'Pill (8)',
    'Full (16)',
  ];
  List<Widget> items = [];

  for (int i = 0; i < radii.length; i = i + 1) {
    double r = radii[i];
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Row(
                children: [
                  Icon(Icons.rounded_corner, size: 18, color: Colors.teal),
                  SizedBox(width: 8),
                  Text(
                    radiusLabels[i],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'radius: ${r.toInt()}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DefaultTabController(
              length: 4,
              child: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.teal, width: 4.0),
                  borderRadius: BorderRadius.circular(r),
                ),
                labelColor: Colors.teal,
                unselectedLabelColor: Colors.grey.shade500,
                tabs: [
                  Tab(text: 'One'),
                  Tab(text: 'Two'),
                  Tab(text: 'Three'),
                  Tab(text: 'Four'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: items);
}

Widget buildInsetsDemo() {
  print('Building insets demo');
  List<EdgeInsets> insetsList = [
    EdgeInsets.zero,
    EdgeInsets.symmetric(horizontal: 8),
    EdgeInsets.symmetric(horizontal: 16),
    EdgeInsets.symmetric(horizontal: 24),
    EdgeInsets.symmetric(horizontal: 32),
  ];
  List<String> insetLabels = [
    'No insets (0)',
    'Minimal (8px)',
    'Standard (16px)',
    'Moderate (24px)',
    'Large (32px)',
  ];
  List<Widget> items = [];

  for (int i = 0; i < insetsList.length; i = i + 1) {
    EdgeInsets ins = insetsList[i];
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: Row(
                children: [
                  Icon(Icons.space_bar, size: 18, color: Colors.deepPurple),
                  SizedBox(width: 8),
                  Text(
                    insetLabels[i],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
            ),
            DefaultTabController(
              length: 3,
              child: TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 3.0,
                  ),
                  insets: ins,
                ),
                labelColor: Colors.deepPurple,
                unselectedLabelColor: Colors.grey.shade500,
                tabs: [
                  Tab(text: 'Overview'),
                  Tab(text: 'Details'),
                  Tab(text: 'Reviews'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 8, 12, 10),
              child: Text(
                'Horizontal inset: ${ins.left.toInt()}px each side',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Column(children: items);
}

Widget buildIndicatorComparison() {
  print('Building indicator comparison');
  List<Widget> items = [];

  items.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
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
              Icon(Icons.horizontal_rule, color: Colors.indigo),
              SizedBox(width: 8),
              Text(
                'UnderlineTabIndicator (Default)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.indigo.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'The default indicator for TabBar. A simple line under the selected tab.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.indigo, width: 3.0),
              ),
              labelColor: Colors.indigo,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [
                Tab(text: 'First'),
                Tab(text: 'Second'),
                Tab(text: 'Third'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  items.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.square_rounded, color: Colors.teal),
              SizedBox(width: 8),
              Text(
                'BoxDecoration (Rounded Container)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.teal.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'A filled rounded rectangle behind the selected tab.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: TabBar(
              indicator: BoxDecoration(
                color: Colors.teal.shade600,
                borderRadius: BorderRadius.circular(20),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade600,
              tabs: [
                Tab(text: 'First'),
                Tab(text: 'Second'),
                Tab(text: 'Third'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  items.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.crop_square, color: Colors.orange.shade700),
              SizedBox(width: 8),
              Text(
                'BoxDecoration (Border Only)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.orange.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'An outlined box around the selected tab without fill.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: TabBar(
              indicator: BoxDecoration(
                border: Border.all(color: Colors.orange.shade700, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              labelColor: Colors.orange.shade700,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [
                Tab(text: 'First'),
                Tab(text: 'Second'),
                Tab(text: 'Third'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  items.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, color: Colors.purple),
              SizedBox(width: 8),
              Text(
                'BoxDecoration (Gradient Fill)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.purple.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'A gradient-filled indicator for vibrant tab selection.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: TabBar(
              indicator: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade400, Colors.pink.shade400],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade600,
              tabs: [
                Tab(text: 'First'),
                Tab(text: 'Second'),
                Tab(text: 'Third'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  return Column(children: items);
}

Widget buildCustomIndicatorDecorations() {
  print('Building custom indicator decorations');
  List<Widget> items = [];

  items.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Semi-transparent Pill Indicator',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 6),
          Text(
            'Soft colored background with rounded edges',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                labelColor: Colors.indigo,
                unselectedLabelColor: Colors.grey.shade600,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: 'Day'),
                  Tab(text: 'Week'),
                  Tab(text: 'Month'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  items.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Border Indicator',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 6),
          Text(
            'Border on top instead of underline',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: TabBar(
              indicator: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.green.shade600, width: 3),
                ),
              ),
              labelColor: Colors.green.shade600,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [Tab(text: 'News'), Tab(text: 'Sports'), Tab(text: 'Tech')],
            ),
          ),
        ],
      ),
    ),
  );

  items.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Side Border Indicator',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 6),
          Text(
            'Left border accent for selected tab',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: TabBar(
              indicator: BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.red.shade600, width: 4),
                ),
              ),
              labelColor: Colors.red.shade600,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [
                Tab(text: 'Inbox'),
                Tab(text: 'Sent'),
                Tab(text: 'Draft'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  items.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dark Mode Tab Indicator',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'UnderlineTabIndicator on dark background',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.cyanAccent, width: 3),
                borderRadius: BorderRadius.circular(2),
              ),
              labelColor: Colors.cyanAccent,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [
                Tab(text: 'Music'),
                Tab(text: 'Videos'),
                Tab(text: 'Photos'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  items.add(
    Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Double Underline Effect',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 6),
          Text(
            'Stacked decoration for layered look',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          SizedBox(height: 10),
          DefaultTabController(
            length: 3,
            child: TabBar(
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.amber.shade600, width: 4),
                ),
                color: Colors.amber.shade50,
              ),
              labelColor: Colors.amber.shade800,
              unselectedLabelColor: Colors.grey.shade500,
              tabs: [
                Tab(text: 'Hot'),
                Tab(text: 'New'),
                Tab(text: 'Rising'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  return Column(children: items);
}

Widget buildIndicatorSizeComparison() {
  print('Building indicator size comparison');
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
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            'TabBarIndicatorSize Property',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.blue),
                    SizedBox(width: 6),
                    Text(
                      'TabBarIndicatorSize.tab',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Indicator spans the entire tab width',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.blue, width: 3),
            ),
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey.shade500,
            tabs: [
              Tab(text: 'Album'),
              Tab(text: 'Artist'),
              Tab(text: 'Playlist'),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.green),
                    SizedBox(width: 6),
                    Text(
                      'TabBarIndicatorSize.label',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Indicator matches the label width only',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.green, width: 3),
            ),
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey.shade500,
            tabs: [
              Tab(text: 'Album'),
              Tab(text: 'Artist'),
              Tab(text: 'Playlist'),
            ],
          ),
        ),
        SizedBox(height: 12),
      ],
    ),
  );
}

Widget buildUseCasesSection() {
  print('Building use cases section');
  List<Map<String, dynamic>> useCases = [
    {
      'title': 'E-commerce Product Pages',
      'icon': Icons.shopping_bag,
      'description':
          'Use tabs to show Description, Reviews, Specifications sections',
      'color': Colors.indigo,
    },
    {
      'title': 'Profile Screens',
      'icon': Icons.person,
      'description': 'Navigate between Posts, Photos, About, Friends',
      'color': Colors.teal,
    },
    {
      'title': 'Dashboard Views',
      'icon': Icons.dashboard,
      'description': 'Switch between Overview, Analytics, Reports tabs',
      'color': Colors.orange,
    },
    {
      'title': 'Settings Organization',
      'icon': Icons.settings,
      'description': 'Group settings into General, Privacy, Notifications',
      'color': Colors.purple,
    },
    {
      'title': 'Media Players',
      'icon': Icons.play_circle,
      'description': 'Tabs for Songs, Albums, Artists, Playlists',
      'color': Colors.pink,
    },
    {
      'title': 'News Applications',
      'icon': Icons.newspaper,
      'description': 'Category tabs: Headlines, Business, Tech, Sports',
      'color': Colors.cyan,
    },
  ];

  List<Widget> items = [];
  for (int i = 0; i < useCases.length; i = i + 1) {
    Map<String, dynamic> uc = useCases[i];
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (uc['color'] as Color).withAlpha(15),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: (uc['color'] as Color).withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: uc['color'] as Color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                uc['icon'] as IconData,
                color: Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uc['title'] as String,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(height: 2),
                  Text(
                    uc['description'] as String,
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

  return Column(children: items);
}

Widget buildApiSummary() {
  print('Building API summary');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
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
          'UnderlineTabIndicator Constructor',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'UnderlineTabIndicator(\n'
            '  borderSide: BorderSide,\n'
            '  borderRadius: BorderRadius?,\n'
            '  insets: EdgeInsetsGeometry,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'borderSide',
          'The stroke style of the underline. Default width is 2.0 with primary color.',
        ),
        buildInfoCard(
          'borderRadius',
          'Corner radius for the underline ends. Null means sharp corners.',
        ),
        buildInfoCard(
          'insets',
          'Horizontal insets from tab edges. Default is EdgeInsets.zero.',
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'UnderlineTabIndicator extends Decoration and can be used anywhere a Decoration is expected.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.amber.shade900,
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

dynamic build(BuildContext context) {
  print('UnderlineTabIndicator deep demo executing');

  UnderlineTabIndicator basicIndicator = UnderlineTabIndicator(
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
  );
  print('Created basic UnderlineTabIndicator: ${basicIndicator.runtimeType}');

  UnderlineTabIndicator styledIndicator = UnderlineTabIndicator(
    borderSide: BorderSide(color: Colors.indigo, width: 4.0),
    borderRadius: BorderRadius.circular(4.0),
    insets: EdgeInsets.symmetric(horizontal: 16.0),
  );
  print('Created styled UnderlineTabIndicator: ${styledIndicator.insets}');

  print('borderSide controls color, width, and style');
  print('borderRadius rounds the underline ends');
  print('insets shrinks indicator from tab edges');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('UnderlineTabIndicator Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. UnderlineTabIndicator Overview'),
            buildInfoCard(
              'Description',
              'A Decoration that paints a horizontal line under the selected tab in a TabBar',
            ),
            buildInfoCard(
              'Usage',
              'Set as TabBar.indicator property for custom underline styling',
            ),
            buildInfoCard(
              'Default Behavior',
              'TabBar uses UnderlineTabIndicator by default with primary color',
            ),

            buildSectionHeader('2. Basic TabBar Examples'),
            buildTabBarDemo(
              'Default Underline Indicator',
              'Standard 2px underline with theme primary color',
              UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.indigo, width: 2.0),
              ),
              Colors.indigo,
              ['Home', 'Search', 'Profile'],
            ),
            buildTabBarDemo(
              'Thick Underline Indicator',
              'Bold 4px underline for emphasis',
              UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.teal, width: 4.0),
              ),
              Colors.teal,
              ['Feed', 'Trending', 'Following'],
            ),
            buildTabBarDemo(
              'Rounded Underline Indicator',
              'Rounded ends with 4px border radius',
              UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.deepPurple, width: 3.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              Colors.deepPurple,
              ['All', 'Photos', 'Videos'],
            ),

            buildSectionHeader('3. BorderSide Width Variations'),
            buildBorderSideWidthComparison(),

            buildSectionHeader('4. BorderSide Color Showcase'),
            buildBorderSideColorShowcase(),

            buildSectionHeader('5. BorderRadius Customization'),
            buildBorderRadiusDemo(),

            buildSectionHeader('6. Insets Property'),
            buildInsetsDemo(),

            buildSectionHeader('7. Indicator Size Comparison'),
            buildIndicatorSizeComparison(),

            buildSectionHeader('8. Alternative Tab Indicators'),
            buildIndicatorComparison(),

            buildSectionHeader('9. Custom Indicator Decorations'),
            buildCustomIndicatorDecorations(),

            buildSectionHeader('10. Common Use Cases'),
            buildUseCasesSection(),

            buildSectionHeader('11. API Reference'),
            buildApiSummary(),

            buildSectionHeader('12. Best Practices'),
            buildInfoCard(
              'Tip 1',
              'Use indicatorSize: TabBarIndicatorSize.label for cleaner look with short labels',
            ),
            buildInfoCard(
              'Tip 2',
              'Match borderRadius with your app\'s border radius theme',
            ),
            buildInfoCard(
              'Tip 3',
              'Use insets to prevent indicator from touching container edges',
            ),
            buildInfoCard(
              'Tip 4',
              'For dark backgrounds, use bright contrasting indicator colors',
            ),
            buildInfoCard(
              'Tip 5',
              'Keep indicator width between 2-4px for most designs',
            ),
            buildInfoCard(
              'Tip 6',
              'Use BoxDecoration for more complex indicator styles',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('UnderlineTabIndicator deep demo completed');
  return result;
}
