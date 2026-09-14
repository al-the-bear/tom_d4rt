// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ScaffoldGeometry from material
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

Widget buildScaffoldLayoutDiagram() {
  print('Building scaffold layout diagram');
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
          'Scaffold Layout Visualization',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo.shade400, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Body area
              Positioned.fill(
                child: Container(
                  margin: EdgeInsets.only(top: 56, bottom: 80),
                  color: Colors.grey.shade100,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.web_asset, size: 48, color: Colors.grey.shade400),
                        SizedBox(height: 8),
                        Text(
                          'Body Content Area',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Main content goes here',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // AppBar area
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 56,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 12),
                      Icon(Icons.menu, color: Colors.white, size: 22),
                      SizedBox(width: 16),
                      Text(
                        'AppBar Top Area',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search, color: Colors.white, size: 22),
                      SizedBox(width: 12),
                      Icon(Icons.more_vert, color: Colors.white, size: 22),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
              // Bottom Navigation Bar area
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 80,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 24,
                        color: Colors.amber.shade100,
                        child: Center(
                          child: Text(
                            'bottomNavigationBarTop line',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.amber.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.home, color: Colors.indigo),
                                Text('Home', style: TextStyle(fontSize: 10)),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.explore, color: Colors.grey),
                                Text('Explore', style: TextStyle(fontSize: 10)),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.person, color: Colors.grey),
                                Text('Profile', style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // FAB position indicator
              Positioned(
                right: 16,
                bottom: 96,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withAlpha(100),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 28),
                ),
              ),
              // FAB area indicator
              Positioned(
                right: 8,
                bottom: 88,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink.shade200, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 2,
                        left: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.pink.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'FAB Area',
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.pink.shade700,
                            ),
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
        SizedBox(height: 12),
        buildInfoCard('Scaffold', 'Main visual structure for Material Design layouts'),
        buildInfoCard('ScaffoldGeometry', 'Contains geometry info for layout calculations'),
      ],
    ),
  );
}

Widget buildBottomNavBarTopSection() {
  print('Building bottomNavigationBarTop section');
  List<double> topPositions = [500.0, 520.0, 540.0, 480.0, 460.0];
  List<String> descriptions = [
    'Standard 80px nav bar',
    'Extended nav bar with labels',
    'Safe area adjusted position',
    'Compact navigation mode',
    'Large device layout',
  ];

  List<Widget> items = [];
  int i = 0;
  for (i = 0; i < topPositions.length; i = i + 1) {
    items.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 18,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'bottomNavigationBarTop: ${topPositions[i]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    descriptions[i],
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.blue.shade300),
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
            Icon(Icons.vertical_align_top, color: Colors.blue.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'bottomNavigationBarTop Property',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'The y-coordinate of the top edge of the bottom navigation bar, relative to the scaffold. Returns null if there is no bottom navigation bar.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade800, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Position is measured from scaffold top. null if no bottom nav bar.',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildFabAreaVisualization() {
  print('Building FAB area visualization');

  List<String> fabPositions = [
    'FloatingActionButtonLocation.endFloat',
    'FloatingActionButtonLocation.centerFloat',
    'FloatingActionButtonLocation.endDocked',
    'FloatingActionButtonLocation.centerDocked',
    'FloatingActionButtonLocation.startFloat',
    'FloatingActionButtonLocation.miniStartFloat',
  ];

  List<Alignment> fabAlignments = [
    Alignment.bottomRight,
    Alignment.bottomCenter,
    Alignment.bottomRight,
    Alignment.bottomCenter,
    Alignment.bottomLeft,
    Alignment.bottomLeft,
  ];

  List<bool> isDocked = [false, false, true, true, false, false];

  List<Widget> positionCards = [];
  int i = 0;
  for (i = 0; i < fabPositions.length; i = i + 1) {
    positionCards.add(
      Container(
        margin: EdgeInsets.only(right: 12, bottom: 8),
        width: 140,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.pink.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.pink.shade200),
        ),
        child: Column(
          children: [
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: Colors.pink.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
              ),
              child: Center(
                child: Text(
                  'Position ${i + 1}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade700,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Stack(
                  children: [
                    // AppBar mini
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade300,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    // Bottom nav mini
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: isDocked[i] ? 24 : 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(3),
                            bottomRight: Radius.circular(3),
                          ),
                        ),
                      ),
                    ),
                    // FAB indicator
                    Positioned(
                      left: fabAlignments[i] == Alignment.bottomLeft ? 4 : null,
                      right: fabAlignments[i] == Alignment.bottomRight ? 4 : null,
                      bottom: isDocked[i] ? 12 : 26,
                      child: fabAlignments[i] == Alignment.bottomCenter
                          ? Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add, color: Colors.white, size: 12),
                              ),
                            )
                          : Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.add, color: Colors.white, size: 12),
                            ),
                    ),
                    // FAB area rectangle
                    Positioned(
                      left: fabAlignments[i] == Alignment.bottomLeft ? 2 : null,
                      right: fabAlignments[i] == Alignment.bottomRight ? 2 : null,
                      bottom: isDocked[i] ? 8 : 22,
                      child: fabAlignments[i] == Alignment.bottomCenter
                          ? Container()
                          : Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.pink.shade300,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Text(
                fabPositions[i].split('.').last,
                style: TextStyle(fontSize: 9, color: Colors.pink.shade700),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
            Icon(Icons.crop_free, color: Colors.pink.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'floatingActionButtonArea Property',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'The bounding rectangle of the floating action button relative to the scaffold. Returns null if there is no floating action button.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: positionCards),
        ),
        SizedBox(height: 12),
        buildInfoCard('Type', 'Rect? - nullable rectangle'),
        buildInfoCard('Coordinates', 'Contains left, top, right, bottom values'),
        buildInfoCard('Usage', 'Used by BottomAppBar to create notch around FAB'),
      ],
    ),
  );
}

Widget buildGeometryRelationships() {
  print('Building geometry relationships section');

  List<Map<String, String>> relationships = [
    {
      'from': 'ScaffoldGeometry',
      'to': 'Scaffold',
      'type': 'Provided by',
      'desc': 'Scaffold exposes geometry via ScaffoldGeometry',
    },
    {
      'from': 'floatingActionButtonArea',
      'to': 'FloatingActionButton',
      'type': 'Describes',
      'desc': 'Rectangle bounds of the FAB widget',
    },
    {
      'from': 'bottomNavigationBarTop',
      'to': 'BottomNavigationBar',
      'type': 'References',
      'desc': 'Y-position of bottom nav top edge',
    },
    {
      'from': 'ScaffoldGeometry',
      'to': 'BottomAppBar',
      'type': 'Used by',
      'desc': 'For notch shape calculations',
    },
    {
      'from': 'ScaffoldGeometry',
      'to': 'FloatingActionButtonLocation',
      'type': 'Informs',
      'desc': 'Provides layout constraints for FAB positioning',
    },
  ];

  List<Widget> relationCards = [];
  int i = 0;
  for (i = 0; i < relationships.length; i = i + 1) {
    Map<String, String> rel = relationships[i];
    relationCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade50, Colors.purple.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.indigo.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                rel['from']!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 8),
            Column(
              children: [
                Icon(Icons.arrow_forward, size: 16, color: Colors.purple.shade400),
                Text(
                  rel['type']!,
                  style: TextStyle(fontSize: 8, color: Colors.purple.shade600),
                ),
              ],
            ),
            SizedBox(width: 8),
            Container(
              width: 80,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                rel['to']!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                rel['desc']!,
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
            Icon(Icons.account_tree, color: Colors.indigo.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'Geometry Relationships',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'How ScaffoldGeometry relates to other Scaffold components and layout systems.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        Column(children: relationCards),
      ],
    ),
  );
}

Widget buildGeometryPropertiesTable() {
  print('Building geometry properties table');

  List<List<String>> properties = [
    ['bottomNavigationBarTop', 'double?', 'Top y-coordinate of bottom nav bar'],
    ['floatingActionButtonArea', 'Rect?', 'Bounding rectangle of FAB'],
  ];

  List<Widget> propertyRows = [];
  int i = 0;
  for (i = 0; i < properties.length; i = i + 1) {
    propertyRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: i % 2 == 0 ? Colors.grey.shade50 : Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                properties[i][0],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.indigo.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                properties[i][1],
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Colors.orange.shade700,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                properties[i][2],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
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
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(11),
              topRight: Radius.circular(11),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.list_alt, color: Colors.indigo.shade700, size: 24),
              SizedBox(width: 8),
              Text(
                'ScaffoldGeometry Properties',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Property',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Type',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Column(children: propertyRows),
        SizedBox(height: 8),
      ],
    ),
  );
}

Widget buildCodeExampleSection() {
  print('Building code example section');

  String exampleCode = '''
// Access geometry via ScaffoldGeometry.of(context)
Widget build(BuildContext context) {
  return Scaffold(
    body: Builder(
      builder: (BuildContext ctx) {
        ScaffoldGeometry? geometry;
        // Geometry accessed during layout
        return LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Scaffold Layout Info'),
                  // bottomNavigationBarTop
                  // floatingActionButtonArea
                ],
              ),
            );
          },
        );
      },
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
    ),
  );
}''';

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
            Icon(Icons.code, color: Colors.teal.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'Usage Example',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SelectableText(
            exampleCode,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFFD4D4D4),
              height: 1.4,
            ),
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Note', 'ScaffoldGeometry is typically accessed during layout via callbacks'),
      ],
    ),
  );
}

Widget buildNotchInteractionSection() {
  print('Building notch interaction section');

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
            Icon(Icons.rounded_corner, color: Colors.orange.shade700, size: 24),
            SizedBox(width: 8),
            Text(
              'BottomAppBar Notch Interaction',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'ScaffoldGeometry provides FAB position data for BottomAppBar notch calculations.',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // BottomAppBar with notch visualization
              Positioned(
                bottom: 0,
                left: 40,
                right: 40,
                child: CustomPaint(
                  size: Size(200, 60),
                  painter: NotchPainter(),
                ),
              ),
              // FAB in notch
              Positioned(
                bottom: 30,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withAlpha(80),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 28),
                ),
              ),
              // Label
              Positioned(
                top: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'floatingActionButtonArea defines notch shape',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green.shade600, size: 20),
                    SizedBox(height: 4),
                    Text(
                      'With FAB Area',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    Text(
                      'Notch created',
                      style: TextStyle(fontSize: 10, color: Colors.green.shade600),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.cancel, color: Colors.red.shade600, size: 20),
                    SizedBox(height: 4),
                    Text(
                      'No FAB Area',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade700,
                      ),
                    ),
                    Text(
                      'Flat bar edge',
                      style: TextStyle(fontSize: 10, color: Colors.red.shade600),
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

class NotchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blueGrey.shade700
      ..style = PaintingStyle.fill;

    Path path = Path();
    double notchWidth = 70;
    double notchDepth = 25;
    double centerX = size.width / 2;

    path.moveTo(0, 0);
    path.lineTo(centerX - notchWidth / 2 - 10, 0);

    path.quadraticBezierTo(
      centerX - notchWidth / 2,
      0,
      centerX - notchWidth / 2 + 5,
      notchDepth / 2,
    );

    path.arcToPoint(
      Offset(centerX + notchWidth / 2 - 5, notchDepth / 2),
      radius: Radius.circular(30),
      clockwise: false,
    );

    path.quadraticBezierTo(
      centerX + notchWidth / 2,
      0,
      centerX + notchWidth / 2 + 10,
      0,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(NotchPainter oldDelegate) {
    return false;
  }
}

Widget buildGeometryClassInfo() {
  print('Building geometry class info');

  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FlutterLogo(size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ScaffoldGeometry',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  Text(
                    'package:flutter/material.dart',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Geometry information for Scaffold components. This class provides layout information about the Scaffold\'s floating action button and bottom navigation bar to support features like the notch in BottomAppBar.',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Immutable',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Material Design',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Layout',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ScaffoldGeometry deep demo executing');
  print('Class: ScaffoldGeometry');
  print('Package: material');
  print('Description: Geometry information for Scaffold layout calculations');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildGeometryClassInfo(),
        buildSectionHeader('1. Visual Scaffold Layout'),
        buildScaffoldLayoutDiagram(),
        buildSectionHeader('2. bottomNavigationBarTop Position'),
        buildBottomNavBarTopSection(),
        buildSectionHeader('3. floatingActionButtonArea Visualization'),
        buildFabAreaVisualization(),
        buildSectionHeader('4. Geometry Relationships'),
        buildGeometryRelationships(),
        buildGeometryPropertiesTable(),
        buildSectionHeader('5. Notch Interaction'),
        buildNotchInteractionSection(),
        buildSectionHeader('6. Code Example'),
        buildCodeExampleSection(),
        SizedBox(height: 24),
        Center(
          child: Text(
            'ScaffoldGeometry Deep Demo Complete',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
