// ignore_for_file: avoid_print
// D4rt test script: Tests RefreshIndicatorState from material
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.blue.shade700,
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

Widget buildRefreshableListView(
  String title,
  Color indicatorColor,
  Color backgroundColor,
  double displacement,
  double strokeWidth,
  int itemCount,
) {
  print('Building refreshable ListView: $title');
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
          decoration: BoxDecoration(
            color: indicatorColor.withAlpha(30),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.refresh, color: indicatorColor, size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: indicatorColor,
                      ),
                    ),
                    Text(
                      'Displacement: ${displacement.toInt()}px | Stroke: ${strokeWidth}px',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 200,
          child: RefreshIndicator(
            color: indicatorColor,
            backgroundColor: backgroundColor,
            displacement: displacement,
            strokeWidth: strokeWidth,
            onRefresh: () async {
              print('Refreshing $title list...');
              await Future.delayed(Duration(milliseconds: 500));
              print('Refresh complete for $title');
            },
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (BuildContext ctx, int index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: indicatorColor.withAlpha(40),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: indicatorColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Item ${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Pull down to refresh this list',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildCustomScrollViewDemo(
  String title,
  Color primaryColor,
  double edgeOffset,
  int gridCount,
) {
  print('Building CustomScrollView demo: $title');
  List<Widget> gridItems = [];
  int i = 0;
  for (i = 0; i < gridCount; i = i + 1) {
    gridItems.add(
      Container(
        decoration: BoxDecoration(
          color: primaryColor.withAlpha(30 + (i * 15) % 100),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryColor.withAlpha(80)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.grid_view,
                color: primaryColor,
                size: 28,
              ),
              SizedBox(height: 4),
              Text(
                'Grid ${i + 1}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
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
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primaryColor.withAlpha(20),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.view_quilt, color: primaryColor, size: 24),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Edge Offset: ${edgeOffset.toInt()}px | CustomScrollView',
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 220,
          child: RefreshIndicator(
            color: primaryColor,
            backgroundColor: Colors.white,
            edgeOffset: edgeOffset,
            onRefresh: () async {
              print('Refreshing CustomScrollView: $title');
              await Future.delayed(Duration(milliseconds: 600));
            },
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(12),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.0,
                    ),
                    delegate: SliverChildListDelegate(gridItems),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildColorConfigurationDemo() {
  print('Building color configuration demo');
  List<String> colorNames = [
    'Default Blue',
    'Vibrant Pink',
    'Forest Green',
    'Sunset Orange',
    'Deep Purple',
    'Ocean Teal',
  ];
  List<Color> indicatorColors = [
    Colors.blue,
    Colors.pink,
    Colors.green.shade700,
    Colors.orange,
    Colors.deepPurple,
    Colors.teal,
  ];
  List<Color> bgColors = [
    Colors.white,
    Colors.pink.shade50,
    Colors.green.shade50,
    Colors.orange.shade50,
    Colors.deepPurple.shade50,
    Colors.teal.shade50,
  ];

  List<Widget> colorCards = [];
  int c = 0;
  for (c = 0; c < colorNames.length; c = c + 1) {
    colorCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColors[c],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: indicatorColors[c].withAlpha(80)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: indicatorColors[c], width: 3),
              ),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: indicatorColors[c],
                    strokeWidth: 3,
                    value: 0.7,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    colorNames[c],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: indicatorColors[c],
                    ),
                  ),
                  Text(
                    'Indicator + Background combination',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: indicatorColors[c],
                borderRadius: BorderRadius.circular(4),
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
          'Color Configurations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Various indicator and background color combinations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: colorCards),
      ],
    ),
  );
}

Widget buildDisplacementOptionsDemo() {
  print('Building displacement options demo');
  List<double> displacements = [20.0, 40.0, 60.0, 80.0, 100.0];
  List<String> labels = [
    'Minimal (20px)',
    'Small (40px)',
    'Default (60px)',
    'Large (80px)',
    'Extra Large (100px)',
  ];
  List<IconData> icons = [
    Icons.vertical_align_top,
    Icons.arrow_upward,
    Icons.swap_vert,
    Icons.arrow_downward,
    Icons.vertical_align_bottom,
  ];

  List<Widget> displacementCards = [];
  int d = 0;
  for (d = 0; d < displacements.length; d = d + 1) {
    double displacement = displacements[d];
    double fillRatio = displacement / 100.0;
    displacementCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icons[d], color: Colors.blue.shade700, size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labels[d],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      widthFactor: fillRatio,
                      alignment: Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Text(
              '${displacement.toInt()}px',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
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
          'Displacement Options',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Distance the indicator travels from the top edge',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: displacementCards),
      ],
    ),
  );
}

Widget buildStrokeWidthVariations() {
  print('Building stroke width variations');
  List<double> strokeWidths = [1.5, 2.0, 2.5, 3.0, 4.0, 5.0];
  List<MaterialColor> strokeColors = [
    Colors.grey,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.purple,
  ];

  List<Widget> strokeCards = [];
  int s = 0;
  for (s = 0; s < strokeWidths.length; s = s + 1) {
    strokeCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: strokeColors[s].shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: strokeColors[s].shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: strokeColors[s].withAlpha(40),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    color: strokeColors[s],
                    strokeWidth: strokeWidths[s],
                    value: 0.6,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Stroke Width: ${strokeWidths[s]}px',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: strokeColors[s].shade800,
                    ),
                  ),
                  Text(
                    'Thickness of the circular indicator',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              width: strokeWidths[s] * 8,
              height: 24,
              decoration: BoxDecoration(
                color: strokeColors[s],
                borderRadius: BorderRadius.circular(4),
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
          'Stroke Width Variations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Different thicknesses for the circular progress indicator',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: strokeCards),
      ],
    ),
  );
}

Widget buildSemanticPropertiesDemo() {
  print('Building semantic properties demo');
  List<Map<String, String>> semanticProps = [
    {
      'property': 'semanticLabel',
      'description': 'Custom accessibility label for screen readers',
      'example': '"Refreshing content"',
    },
    {
      'property': 'semanticValue',
      'description': 'Current progress value for accessibility',
      'example': '"50 percent complete"',
    },
    {
      'property': 'notificationPredicate',
      'description': 'Predicate to determine notification listening',
      'example': 'ScrollNotification predicate',
    },
    {
      'property': 'triggerMode',
      'description': 'How the indicator is triggered',
      'example': 'onEdge or anywhere',
    },
  ];

  List<Widget> propCards = [];
  int p = 0;
  for (p = 0; p < semanticProps.length; p = p + 1) {
    Map<String, String> prop = semanticProps[p];
    propCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
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
                Icon(Icons.accessibility, color: Colors.indigo, size: 20),
                SizedBox(width: 8),
                Text(
                  prop['property'] ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              prop['description'] ?? '',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                prop['example'] ?? '',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.indigo.shade900,
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
        Row(
          children: [
            Icon(Icons.accessibility_new, color: Colors.indigo, size: 22),
            SizedBox(width: 8),
            Text(
              'Semantic Properties',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Accessibility and behavior configuration options',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: propCards),
      ],
    ),
  );
}

Widget buildRefreshIndicatorStates() {
  print('Building refresh indicator states');
  List<String> stateNames = [
    'Idle',
    'Drag',
    'Armed',
    'Refresh',
    'Done',
    'Canceled',
  ];
  List<IconData> stateIcons = [
    Icons.hourglass_empty,
    Icons.touch_app,
    Icons.sports_handball,
    Icons.refresh,
    Icons.check_circle,
    Icons.cancel,
  ];
  List<Color> stateColors = [
    Colors.grey,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.teal,
    Colors.red,
  ];
  List<String> stateDescriptions = [
    'No refresh activity in progress',
    'User is pulling down the scrollable',
    'Pull threshold reached, ready to refresh',
    'Refresh callback is being executed',
    'Refresh completed successfully',
    'User released before threshold',
  ];

  List<Widget> stateCards = [];
  int st = 0;
  for (st = 0; st < stateNames.length; st = st + 1) {
    stateCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: stateColors[st].withAlpha(20),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: stateColors[st].withAlpha(80)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: stateColors[st].withAlpha(40),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(stateIcons[st], color: stateColors[st], size: 24),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stateNames[st],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: stateColors[st],
                    ),
                  ),
                  Text(
                    stateDescriptions[st],
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: stateColors[st],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${st + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
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
          'RefreshIndicator States',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'The various states the indicator can be in',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: stateCards),
      ],
    ),
  );
}

Widget buildTriggerModeComparison() {
  print('Building trigger mode comparison');
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
          'Trigger Mode Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.vertical_align_top, color: Colors.green.shade700, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'onEdge (Default)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    Text(
                      'Triggered only when scrolled to the top edge',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.purple.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.swap_vert, color: Colors.purple.shade700, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'anywhere',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade800,
                      ),
                    ),
                    Text(
                      'Can be triggered from any scroll position',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildStateMethodsReference() {
  print('Building state methods reference');
  List<Map<String, String>> methods = [
    {
      'name': 'show()',
      'return': 'Future<void>',
      'desc': 'Programmatically triggers the refresh indicator',
    },
    {
      'name': 'didChangeDependencies()',
      'return': 'void',
      'desc': 'Called when dependencies change',
    },
    {
      'name': 'dispose()',
      'return': 'void',
      'desc': 'Releases resources held by the state',
    },
    {
      'name': 'build()',
      'return': 'Widget',
      'desc': 'Describes the UI representation',
    },
  ];

  List<Widget> methodCards = [];
  int m = 0;
  for (m = 0; m < methods.length; m = m + 1) {
    Map<String, String> method = methods[m];
    methodCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.cyan.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade700,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    method['name'] ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  '-> ${method['return']}',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: Colors.cyan.shade800,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              method['desc'] ?? '',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade700, size: 22),
            SizedBox(width: 8),
            Text(
              'RefreshIndicatorState Methods',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          'Public methods available on RefreshIndicatorState',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: methodCards),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('RefreshIndicatorState deep demo test executing');
  print('Testing RefreshIndicatorState - State class for RefreshIndicator widget');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      useMaterial3: true,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('RefreshIndicatorState Demo'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'RefreshIndicatorState'),
            buildInfoCard(
              'Purpose',
              'State class managing the RefreshIndicator widget lifecycle',
            ),
            buildInfoCard(
              'Key Method',
              'show() - Programmatically trigger refresh',
            ),
            buildInfoCard(
              'Widget Type',
              'StatefulWidget with GlobalKey access',
            ),

            buildSectionHeader('2. ListView with RefreshIndicator'),
            buildRefreshableListView(
              'Default Configuration',
              Colors.blue,
              Colors.white,
              40.0,
              2.5,
              5,
            ),
            buildRefreshableListView(
              'Pink Theme with Large Displacement',
              Colors.pink,
              Colors.pink.shade50,
              80.0,
              3.0,
              4,
            ),
            buildRefreshableListView(
              'Green Theme with Thin Stroke',
              Colors.green.shade700,
              Colors.green.shade50,
              30.0,
              1.5,
              6,
            ),

            buildSectionHeader('3. CustomScrollView Demos'),
            buildCustomScrollViewDemo(
              'Grid with RefreshIndicator',
              Colors.deepPurple,
              0.0,
              9,
            ),
            buildCustomScrollViewDemo(
              'Grid with Edge Offset',
              Colors.teal,
              16.0,
              6,
            ),

            buildSectionHeader('4. Color Configurations'),
            buildColorConfigurationDemo(),

            buildSectionHeader('5. Displacement Options'),
            buildDisplacementOptionsDemo(),

            buildSectionHeader('6. Stroke Width Variations'),
            buildStrokeWidthVariations(),

            buildSectionHeader('7. RefreshIndicator States'),
            buildRefreshIndicatorStates(),

            buildSectionHeader('8. Semantic Properties'),
            buildSemanticPropertiesDemo(),

            buildSectionHeader('9. Trigger Mode'),
            buildTriggerModeComparison(),

            buildSectionHeader('10. State Methods'),
            buildStateMethodsReference(),

            buildSectionHeader('11. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Use GlobalKey<RefreshIndicatorState> for programmatic access',
            ),
            buildInfoCard(
              'Tip 2',
              'onRefresh callback must return a Future',
            ),
            buildInfoCard(
              'Tip 3',
              'Customize displacement for different visual effects',
            ),
            buildInfoCard(
              'Tip 4',
              'strokeWidth affects the circular indicator thickness',
            ),
            buildInfoCard(
              'Tip 5',
              'Works best with scrollable children like ListView',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('RefreshIndicatorState deep demo completed');
  return result;
}
