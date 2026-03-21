// D4rt test script: Tests ScaffoldPrelayoutGeometry from material
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

Widget buildGeometryPropertyCard(
  String propertyName,
  String description,
  String typeInfo,
  Color accentColor,
) {
  print('Building geometry property card: $propertyName');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accentColor.withAlpha(100), width: 2),
      boxShadow: [
        BoxShadow(
          color: accentColor.withAlpha(30),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                propertyName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                typeInfo,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
        ),
      ],
    ),
  );
}

Widget buildScaffoldDiagram() {
  print('Building scaffold diagram');
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
          'Visual Scaffold Pre-Layout Geometry',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Showing geometry areas before FAB positioning',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Center(
          child: Container(
            width: 280,
            height: 420,
            child: CustomPaint(
              painter: _ScaffoldGeometryPainter(),
              child: Container(),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildLegendItem(Colors.indigo.shade200, 'App Bar (affects contentTop)'),
        _buildLegendItem(Colors.green.shade200, 'Content Area'),
        _buildLegendItem(Colors.orange.shade200, 'Bottom Sheet (bottomSheetSize)'),
        _buildLegendItem(Colors.purple.shade400, 'FAB Position Zone'),
        _buildLegendItem(Colors.blue.shade300, 'Bottom Navigation'),
      ],
    ),
  );
}

Widget _buildLegendItem(Color color, String label) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade400),
          ),
        ),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget buildFloatingActionButtonSizeSection() {
  print('Building floatingActionButtonSize section');
  List<double> fabSizes = [40.0, 56.0, 72.0, 96.0];
  List<String> fabLabels = ['Mini', 'Default', 'Large', 'Extended'];
  List<Color> fabColors = [
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.deepPurple,
  ];

  List<Widget> fabCards = [];
  int i = 0;
  for (i = 0; i < fabSizes.length; i = i + 1) {
    fabCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: fabColors[i].withAlpha(80)),
        ),
        child: Row(
          children: [
            Container(
              width: fabSizes[i],
              height: fabSizes[i],
              decoration: BoxDecoration(
                color: fabColors[i],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: fabColors[i].withAlpha(60),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: fabSizes[i] * 0.5,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fabLabels[i],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: fabColors[i],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Size: ${fabSizes[i].toInt()} x ${fabSizes[i].toInt()} px',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'floatingActionButtonSize: Size(${fabSizes[i]}, ${fabSizes[i]})',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontFamily: 'monospace',
                    ),
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
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'floatingActionButtonSize Property',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Size of the FAB affecting layout calculations',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: fabCards),
      ],
    ),
  );
}

Widget buildBottomSheetSizeSection() {
  print('Building bottomSheetSize section');
  List<double> sheetHeights = [100.0, 200.0, 300.0, 400.0];
  List<String> sheetLabels = [
    'Collapsed',
    'Partial',
    'Half Screen',
    'Expanded',
  ];
  List<Color> sheetColors = [
    Colors.teal,
    Colors.cyan,
    Colors.lightBlue,
    Colors.blue,
  ];

  List<Widget> sheetCards = [];
  int s = 0;
  for (s = 0; s < sheetHeights.length; s = s + 1) {
    double ratio = sheetHeights[s] / 600.0;
    sheetCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: sheetColors[s].withAlpha(80)),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80 * ratio,
                      decoration: BoxDecoration(
                        color: sheetColors[s].withAlpha(150),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 20,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sheetLabels[s],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: sheetColors[s],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Height: ${sheetHeights[s].toInt()} px',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'bottomSheetSize: Size(width, ${sheetHeights[s]})',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontFamily: 'monospace',
                    ),
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
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'bottomSheetSize Property',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Size of the bottom sheet affecting FAB position',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: sheetCards),
      ],
    ),
  );
}

Widget buildContentBoundsSection() {
  print('Building content bounds section');
  List<Map<String, dynamic>> configs = [
    {
      'label': 'Full Screen',
      'contentTop': 0.0,
      'contentBottom': 600.0,
      'appBar': false,
      'bottomNav': false,
    },
    {
      'label': 'With AppBar',
      'contentTop': 56.0,
      'contentBottom': 600.0,
      'appBar': true,
      'bottomNav': false,
    },
    {
      'label': 'With Bottom Nav',
      'contentTop': 0.0,
      'contentBottom': 544.0,
      'appBar': false,
      'bottomNav': true,
    },
    {
      'label': 'AppBar + Bottom Nav',
      'contentTop': 56.0,
      'contentBottom': 544.0,
      'appBar': true,
      'bottomNav': true,
    },
  ];

  List<Widget> boundCards = [];
  int b = 0;
  for (b = 0; b < configs.length; b = b + 1) {
    Map<String, dynamic> cfg = configs[b];
    double top = cfg['contentTop'] as double;
    double bottom = cfg['contentBottom'] as double;
    double contentHeight = bottom - top;
    bool hasAppBar = cfg['appBar'] as bool;
    bool hasBottomNav = cfg['bottomNav'] as bool;

    boundCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green.withAlpha(80)),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Column(
                children: [
                  if (hasAppBar)
                    Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade300,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                    ),
                  Expanded(
                    child: Container(
                      color: Colors.green.shade100,
                    ),
                  ),
                  if (hasBottomNav)
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade300,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cfg['label'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      _buildBoundLabel('contentTop', top),
                      SizedBox(width: 12),
                      _buildBoundLabel('contentBottom', bottom),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Content Height: ${contentHeight.toInt()} px',
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
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'contentTop & contentBottom Properties',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Vertical bounds of the content area',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: boundCards),
      ],
    ),
  );
}

Widget _buildBoundLabel(String name, double value) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Text(
      '$name: ${value.toInt()}',
      style: TextStyle(
        fontSize: 11,
        fontFamily: 'monospace',
        color: Colors.green.shade800,
      ),
    ),
  );
}

Widget buildScaffoldSizeSection() {
  print('Building scaffoldSize section');
  List<Map<String, dynamic>> devices = [
    {'name': 'iPhone SE', 'width': 375.0, 'height': 667.0},
    {'name': 'iPhone 14', 'width': 390.0, 'height': 844.0},
    {'name': 'iPhone 14 Pro Max', 'width': 430.0, 'height': 932.0},
    {'name': 'Pixel 7', 'width': 412.0, 'height': 915.0},
    {'name': 'iPad Mini', 'width': 744.0, 'height': 1133.0},
    {'name': 'iPad Pro 12.9', 'width': 1024.0, 'height': 1366.0},
  ];

  List<Widget> deviceCards = [];
  int d = 0;
  for (d = 0; d < devices.length; d = d + 1) {
    Map<String, dynamic> device = devices[d];
    String name = device['name'] as String;
    double width = device['width'] as double;
    double height = device['height'] as double;
    double aspectRatio = width / height;
    double previewWidth = 40.0;
    double previewHeight = previewWidth / aspectRatio;
    if (previewHeight > 60) {
      previewHeight = 60.0;
      previewWidth = previewHeight * aspectRatio;
    }

    deviceCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (d % 2 == 0) ? Colors.indigo.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.indigo.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: previewWidth,
              height: previewHeight,
              decoration: BoxDecoration(
                color: Colors.indigo.shade200,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.indigo.shade400, width: 2),
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'scaffoldSize: Size(${width.toInt()}, ${height.toInt()})',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'monospace',
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${width.toInt()} x ${height.toInt()}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                Text(
                  'AR: ${aspectRatio.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
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
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'scaffoldSize Property',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Overall size of the Scaffold on different devices',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: deviceCards),
      ],
    ),
  );
}

Widget buildRelationshipsDiagram() {
  print('Building relationships diagram');
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
          'Property Relationships',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'How geometry values relate to each other',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Center(
          child: Container(
            width: 300,
            height: 280,
            child: CustomPaint(
              painter: _RelationshipsPainter(),
              child: Container(),
            ),
          ),
        ),
        SizedBox(height: 16),
        _buildRelationshipRow(
          'scaffoldSize',
          'Contains all other elements',
          Colors.indigo,
        ),
        _buildRelationshipRow(
          'contentTop',
          'Top boundary below app bar',
          Colors.green,
        ),
        _buildRelationshipRow(
          'contentBottom',
          'Bottom boundary above nav/sheet',
          Colors.green.shade700,
        ),
        _buildRelationshipRow(
          'bottomSheetSize',
          'Pushes content and FAB up',
          Colors.orange,
        ),
        _buildRelationshipRow(
          'floatingActionButtonSize',
          'Determines FAB collision area',
          Colors.purple,
        ),
      ],
    ),
  );
}

Widget _buildRelationshipRow(String prop, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prop,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildFabPositionExamples() {
  print('Building FAB position examples');
  List<Map<String, dynamic>> positions = [
    {'location': 'endFloat', 'icon': Icons.add, 'desc': 'Bottom right floating'},
    {'location': 'centerFloat', 'icon': Icons.sync, 'desc': 'Bottom center floating'},
    {'location': 'endDocked', 'icon': Icons.send, 'desc': 'Docked to bottom nav end'},
    {'location': 'centerDocked', 'icon': Icons.play_arrow, 'desc': 'Docked center notch'},
    {'location': 'startFloat', 'icon': Icons.menu, 'desc': 'Bottom left floating'},
    {'location': 'miniStartFloat', 'icon': Icons.chevron_left, 'desc': 'Mini FAB left'},
  ];

  List<Widget> posCards = [];
  int p = 0;
  for (p = 0; p < positions.length; p = p + 1) {
    Map<String, dynamic> pos = positions[p];
    String location = pos['location'] as String;
    IconData icon = pos['icon'] as IconData;
    String desc = pos['desc'] as String;

    posCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (p % 2 == 0) ? Colors.purple.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.purple.withAlpha(60)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withAlpha(60),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 22),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade800,
                    ),
                  ),
                  Text(
                    desc,
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
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FAB Position Locations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Positions computed using pre-layout geometry',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12),
        Column(children: posCards),
      ],
    ),
  );
}

Widget buildGeometryUsageExample() {
  print('Building geometry usage example');
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blueGrey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Custom FAB Position Calculation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Using ScaffoldPrelayoutGeometry in custom FloatingActionButtonLocation:',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeLine('Offset getOffset(ScaffoldPrelayoutGeometry geometry) {', Colors.blue.shade300),
              _buildCodeLine('  double fabX = geometry.scaffoldSize.width', Colors.white),
              _buildCodeLine('      - geometry.floatingActionButtonSize.width / 2', Colors.white),
              _buildCodeLine('      - 16.0;', Colors.white),
              _buildCodeLine('  double fabY = geometry.contentBottom', Colors.white),
              _buildCodeLine('      - geometry.bottomSheetSize.height', Colors.white),
              _buildCodeLine('      - geometry.floatingActionButtonSize.height', Colors.white),
              _buildCodeLine('      - 16.0;', Colors.white),
              _buildCodeLine('  return Offset(fabX, fabY);', Colors.green.shade300),
              _buildCodeLine('}', Colors.blue.shade300),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeLine(String code, Color color) {
  return Text(
    code,
    style: TextStyle(
      fontSize: 12,
      fontFamily: 'monospace',
      color: color,
      height: 1.5,
    ),
  );
}

Widget buildSnackBarInteraction() {
  print('Building snackbar interaction');
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
          'Snackbar Interaction Geometry',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'How snackbars affect FAB positioning via snackBarSize',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        SizedBox(height: 16),
        Center(
          child: Container(
            width: 240,
            height: 320,
            child: CustomPaint(
              painter: _SnackBarInteractionPainter(),
              child: Container(),
            ),
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'snackBarSize',
          'Size of current snackbar affecting FAB offset',
        ),
        buildInfoCard(
          'Behavior',
          'FAB moves up when snackbar appears to avoid overlap',
        ),
      ],
    ),
  );
}

Widget buildMiniVsRegularFab() {
  print('Building mini vs regular FAB');
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
          'Mini vs Regular FAB Size Impact',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFabSizeCard('Mini FAB', 40.0, Colors.teal),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildFabSizeCard('Regular FAB', 56.0, Colors.indigo),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFabSizeCard('Large FAB', 72.0, Colors.purple),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildFabSizeCard('Extended', 96.0, Colors.deepOrange),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFabSizeCard(String label, double size, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: size * 0.45,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          '${size.toInt()} x ${size.toInt()} px',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('ScaffoldPrelayoutGeometry deep demo test executing');

  Widget result = MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('ScaffoldPrelayoutGeometry Demo'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('1. Overview'),
            buildInfoCard('Class', 'ScaffoldPrelayoutGeometry'),
            buildInfoCard(
              'Purpose',
              'Pre-layout geometry info for computing FAB position',
            ),
            buildInfoCard(
              'Used By',
              'FloatingActionButtonLocation.getOffset()',
            ),
            buildInfoCard(
              'Package',
              'flutter/material.dart',
            ),

            buildSectionHeader('2. Visual Scaffold Geometry'),
            buildScaffoldDiagram(),

            buildSectionHeader('3. floatingActionButtonSize'),
            buildFloatingActionButtonSizeSection(),

            buildSectionHeader('4. bottomSheetSize'),
            buildBottomSheetSizeSection(),

            buildSectionHeader('5. contentTop & contentBottom'),
            buildContentBoundsSection(),

            buildSectionHeader('6. scaffoldSize'),
            buildScaffoldSizeSection(),

            buildSectionHeader('7. Property Relationships'),
            buildRelationshipsDiagram(),

            buildSectionHeader('8. FAB Position Locations'),
            buildFabPositionExamples(),

            buildSectionHeader('9. Custom FAB Positioning'),
            buildGeometryUsageExample(),

            buildSectionHeader('10. Snackbar Interaction'),
            buildSnackBarInteraction(),

            buildSectionHeader('11. FAB Size Comparison'),
            buildMiniVsRegularFab(),

            buildSectionHeader('12. Key Properties Table'),
            buildGeometryPropertyCard(
              'floatingActionButtonSize',
              'The size of the FAB to be positioned',
              'Size',
              Colors.purple,
            ),
            buildGeometryPropertyCard(
              'bottomSheetSize',
              'Size of the persistent/modal bottom sheet',
              'Size',
              Colors.orange,
            ),
            buildGeometryPropertyCard(
              'contentTop',
              'Y coordinate of content area top edge',
              'double',
              Colors.green,
            ),
            buildGeometryPropertyCard(
              'contentBottom',
              'Y coordinate of content area bottom edge',
              'double',
              Colors.green.shade700,
            ),
            buildGeometryPropertyCard(
              'scaffoldSize',
              'Total size of the Scaffold widget',
              'Size',
              Colors.indigo,
            ),
            buildGeometryPropertyCard(
              'snackBarSize',
              'Size of currently showing snackbar',
              'Size',
              Colors.red,
            ),
            buildGeometryPropertyCard(
              'minInsets',
              'Minimum safe area insets',
              'EdgeInsets',
              Colors.teal,
            ),
            buildGeometryPropertyCard(
              'textDirection',
              'Text direction for RTL/LTR layout',
              'TextDirection',
              Colors.blue,
            ),

            buildSectionHeader('13. Usage Tips'),
            buildInfoCard(
              'Tip 1',
              'Access pre-layout geometry in FloatingActionButtonLocation',
            ),
            buildInfoCard(
              'Tip 2',
              'Use scaffoldSize.width for horizontal positioning',
            ),
            buildInfoCard(
              'Tip 3',
              'Subtract bottomSheetSize.height when sheet is present',
            ),
            buildInfoCard(
              'Tip 4',
              'Account for snackBarSize to avoid FAB overlap',
            ),
            buildInfoCard(
              'Tip 5',
              'Check textDirection for RTL layout support',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );

  print('ScaffoldPrelayoutGeometry deep demo completed');
  return result;
}

class _ScaffoldGeometryPainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    Paint scaffoldPaint = Paint();
    scaffoldPaint.color = Colors.grey.shade300;
    scaffoldPaint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(12),
      ),
      scaffoldPaint,
    );

    Paint borderPaint = Paint();
    borderPaint.color = Colors.grey.shade500;
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(12),
      ),
      borderPaint,
    );

    Paint appBarPaint = Paint();
    appBarPaint.color = Colors.indigo.shade200;
    appBarPaint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(2, 2, size.width - 4, 50),
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      appBarPaint,
    );

    TextPainter appBarText = TextPainter(
      text: TextSpan(
        text: 'AppBar',
        style: TextStyle(fontSize: 12, color: Colors.indigo.shade800),
      ),
      textDirection: TextDirection.ltr,
    );
    appBarText.layout();
    appBarText.paint(canvas, Offset(size.width / 2 - 20, 20));

    Paint contentPaint = Paint();
    contentPaint.color = Colors.green.shade100;
    contentPaint.style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(2, 54, size.width - 4, size.height - 168),
      contentPaint,
    );

    TextPainter contentText = TextPainter(
      text: TextSpan(
        text: 'Content Area',
        style: TextStyle(fontSize: 14, color: Colors.green.shade800),
      ),
      textDirection: TextDirection.ltr,
    );
    contentText.layout();
    contentText.paint(canvas, Offset(size.width / 2 - 45, size.height / 2 - 40));

    Paint contentTopLine = Paint();
    contentTopLine.color = Colors.green.shade600;
    contentTopLine.strokeWidth = 2;
    canvas.drawLine(Offset(10, 54), Offset(size.width - 10, 54), contentTopLine);

    TextPainter topLabel = TextPainter(
      text: TextSpan(
        text: 'contentTop',
        style: TextStyle(fontSize: 10, color: Colors.green.shade700),
      ),
      textDirection: TextDirection.ltr,
    );
    topLabel.layout();
    topLabel.paint(canvas, Offset(10, 56));

    double contentBottomY = size.height - 114;
    canvas.drawLine(Offset(10, contentBottomY), Offset(size.width - 10, contentBottomY), contentTopLine);

    TextPainter bottomLabel = TextPainter(
      text: TextSpan(
        text: 'contentBottom',
        style: TextStyle(fontSize: 10, color: Colors.green.shade700),
      ),
      textDirection: TextDirection.ltr,
    );
    bottomLabel.layout();
    bottomLabel.paint(canvas, Offset(10, contentBottomY - 14));

    Paint bottomSheetPaint = Paint();
    bottomSheetPaint.color = Colors.orange.shade200;
    bottomSheetPaint.style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(2, size.height - 110, size.width - 4, 60),
      bottomSheetPaint,
    );

    TextPainter sheetText = TextPainter(
      text: TextSpan(
        text: 'Bottom Sheet',
        style: TextStyle(fontSize: 11, color: Colors.orange.shade900),
      ),
      textDirection: TextDirection.ltr,
    );
    sheetText.layout();
    sheetText.paint(canvas, Offset(size.width / 2 - 38, size.height - 90));

    Paint bottomNavPaint = Paint();
    bottomNavPaint.color = Colors.blue.shade200;
    bottomNavPaint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(2, size.height - 48, size.width - 4, 46),
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      bottomNavPaint,
    );

    TextPainter navText = TextPainter(
      text: TextSpan(
        text: 'Bottom Nav',
        style: TextStyle(fontSize: 11, color: Colors.blue.shade900),
      ),
      textDirection: TextDirection.ltr,
    );
    navText.layout();
    navText.paint(canvas, Offset(size.width / 2 - 32, size.height - 30));

    Paint fabPaint = Paint();
    fabPaint.color = Colors.purple.shade400;
    fabPaint.style = PaintingStyle.fill;
    double fabSize = 44;
    double fabX = size.width - fabSize - 20;
    double fabY = size.height - 130;
    canvas.drawCircle(Offset(fabX + fabSize / 2, fabY), fabSize / 2, fabPaint);

    Paint fabIconPaint = Paint();
    fabIconPaint.color = Colors.white;
    fabIconPaint.strokeWidth = 3;
    fabIconPaint.style = PaintingStyle.stroke;
    double cx = fabX + fabSize / 2;
    double cy = fabY;
    canvas.drawLine(Offset(cx - 10, cy), Offset(cx + 10, cy), fabIconPaint);
    canvas.drawLine(Offset(cx, cy - 10), Offset(cx, cy + 10), fabIconPaint);

    TextPainter fabLabel = TextPainter(
      text: TextSpan(
        text: 'FAB',
        style: TextStyle(fontSize: 10, color: Colors.purple.shade800),
      ),
      textDirection: TextDirection.ltr,
    );
    fabLabel.layout();
    fabLabel.paint(canvas, Offset(fabX + 12, fabY + 26));
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _RelationshipsPainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint();
    bgPaint.color = Colors.grey.shade100;
    bgPaint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(8),
      ),
      bgPaint,
    );

    Paint scaffoldBox = Paint();
    scaffoldBox.color = Colors.indigo.withAlpha(40);
    scaffoldBox.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(20, 20, size.width - 40, size.height - 40),
        Radius.circular(8),
      ),
      scaffoldBox,
    );

    Paint scaffoldBorder = Paint();
    scaffoldBorder.color = Colors.indigo;
    scaffoldBorder.style = PaintingStyle.stroke;
    scaffoldBorder.strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(20, 20, size.width - 40, size.height - 40),
        Radius.circular(8),
      ),
      scaffoldBorder,
    );

    TextPainter scaffoldLabel = TextPainter(
      text: TextSpan(
        text: 'scaffoldSize',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.indigo),
      ),
      textDirection: TextDirection.ltr,
    );
    scaffoldLabel.layout();
    scaffoldLabel.paint(canvas, Offset(24, 24));

    Paint contentBox = Paint();
    contentBox.color = Colors.green.withAlpha(60);
    contentBox.style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(30, 60, size.width - 60, size.height - 150),
      contentBox,
    );

    Paint topLine = Paint();
    topLine.color = Colors.green;
    topLine.strokeWidth = 3;
    canvas.drawLine(Offset(30, 60), Offset(size.width - 30, 60), topLine);

    TextPainter topText = TextPainter(
      text: TextSpan(
        text: 'contentTop',
        style: TextStyle(fontSize: 10, color: Colors.green.shade800),
      ),
      textDirection: TextDirection.ltr,
    );
    topText.layout();
    topText.paint(canvas, Offset(34, 63));

    double botY = size.height - 90;
    canvas.drawLine(Offset(30, botY), Offset(size.width - 30, botY), topLine);

    TextPainter bottomText = TextPainter(
      text: TextSpan(
        text: 'contentBottom',
        style: TextStyle(fontSize: 10, color: Colors.green.shade800),
      ),
      textDirection: TextDirection.ltr,
    );
    bottomText.layout();
    bottomText.paint(canvas, Offset(34, botY - 14));

    Paint sheetBox = Paint();
    sheetBox.color = Colors.orange.withAlpha(80);
    sheetBox.style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(30, size.height - 80, size.width - 60, 40),
      sheetBox,
    );

    TextPainter sheetLabel = TextPainter(
      text: TextSpan(
        text: 'bottomSheetSize',
        style: TextStyle(fontSize: 10, color: Colors.orange.shade900),
      ),
      textDirection: TextDirection.ltr,
    );
    sheetLabel.layout();
    sheetLabel.paint(canvas, Offset(size.width / 2 - 45, size.height - 65));

    Paint fabCircle = Paint();
    fabCircle.color = Colors.purple;
    fabCircle.style = PaintingStyle.fill;
    double fabCx = size.width - 60;
    double fabCy = size.height - 110;
    canvas.drawCircle(Offset(fabCx, fabCy), 18, fabCircle);

    Paint fabSizeRect = Paint();
    fabSizeRect.color = Colors.purple.withAlpha(40);
    fabSizeRect.style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(fabCx, fabCy), width: 40, height: 40),
      fabSizeRect,
    );

    Paint fabSizeBorder = Paint();
    fabSizeBorder.color = Colors.purple;
    fabSizeBorder.style = PaintingStyle.stroke;
    fabSizeBorder.strokeWidth = 1;
    canvas.drawRect(
      Rect.fromCenter(center: Offset(fabCx, fabCy), width: 40, height: 40),
      fabSizeBorder,
    );

    TextPainter fabText = TextPainter(
      text: TextSpan(
        text: 'fabSize',
        style: TextStyle(fontSize: 9, color: Colors.purple.shade800),
      ),
      textDirection: TextDirection.ltr,
    );
    fabText.layout();
    fabText.paint(canvas, Offset(fabCx - 18, fabCy + 24));
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _SnackBarInteractionPainter extends CustomPainter {
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint();
    bgPaint.color = Colors.grey.shade200;
    bgPaint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(10),
      ),
      bgPaint,
    );

    Paint borderPaint = Paint();
    borderPaint.color = Colors.grey.shade400;
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.strokeWidth = 2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(10),
      ),
      borderPaint,
    );

    Paint appBar = Paint();
    appBar.color = Colors.indigo.shade300;
    appBar.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(2, 2, size.width - 4, 36),
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
      appBar,
    );

    Paint contentArea = Paint();
    contentArea.color = Colors.white;
    contentArea.style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(2, 40, size.width - 4, size.height - 130),
      contentArea,
    );

    Paint bottomNav = Paint();
    bottomNav.color = Colors.blue.shade200;
    bottomNav.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(2, size.height - 42, size.width - 4, 40),
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      bottomNav,
    );

    Paint snackBar = Paint();
    snackBar.color = Colors.grey.shade800;
    snackBar.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(10, size.height - 90, size.width - 20, 44),
        Radius.circular(6),
      ),
      snackBar,
    );

    TextPainter snackText = TextPainter(
      text: TextSpan(
        text: 'SnackBar',
        style: TextStyle(fontSize: 11, color: Colors.white),
      ),
      textDirection: TextDirection.ltr,
    );
    snackText.layout();
    snackText.paint(canvas, Offset(size.width / 2 - 28, size.height - 75));

    Paint fab1 = Paint();
    fab1.color = Colors.purple.withAlpha(100);
    fab1.style = PaintingStyle.fill;
    double fab1Y = size.height - 65;
    canvas.drawCircle(Offset(size.width - 40, fab1Y), 20, fab1);

    Paint fab1Border = Paint();
    fab1Border.color = Colors.purple.withAlpha(150);
    fab1Border.style = PaintingStyle.stroke;
    fab1Border.strokeWidth = 2;
    canvas.drawCircle(Offset(size.width - 40, fab1Y), 20, fab1Border);

    TextPainter oldPos = TextPainter(
      text: TextSpan(
        text: 'Old',
        style: TextStyle(fontSize: 9, color: Colors.purple.shade300),
      ),
      textDirection: TextDirection.ltr,
    );
    oldPos.layout();
    oldPos.paint(canvas, Offset(size.width - 48, fab1Y + 24));

    Paint fab2 = Paint();
    fab2.color = Colors.purple;
    fab2.style = PaintingStyle.fill;
    double fab2Y = size.height - 120;
    canvas.drawCircle(Offset(size.width - 40, fab2Y), 20, fab2);

    Paint iconPaint = Paint();
    iconPaint.color = Colors.white;
    iconPaint.strokeWidth = 3;
    iconPaint.style = PaintingStyle.stroke;
    double cx = size.width - 40;
    canvas.drawLine(Offset(cx - 8, fab2Y), Offset(cx + 8, fab2Y), iconPaint);
    canvas.drawLine(Offset(cx, fab2Y - 8), Offset(cx, fab2Y + 8), iconPaint);

    TextPainter newPos = TextPainter(
      text: TextSpan(
        text: 'New',
        style: TextStyle(fontSize: 9, color: Colors.purple.shade800),
      ),
      textDirection: TextDirection.ltr,
    );
    newPos.layout();
    newPos.paint(canvas, Offset(size.width - 48, fab2Y - 34));

    Paint arrowPaint = Paint();
    arrowPaint.color = Colors.red;
    arrowPaint.strokeWidth = 2;
    arrowPaint.style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width - 70, fab1Y - 10), Offset(size.width - 70, fab2Y + 10), arrowPaint);

    Path arrowHead = Path();
    arrowHead.moveTo(size.width - 75, fab2Y + 18);
    arrowHead.lineTo(size.width - 70, fab2Y + 8);
    arrowHead.lineTo(size.width - 65, fab2Y + 18);
    Paint arrowFill = Paint();
    arrowFill.color = Colors.red;
    arrowFill.style = PaintingStyle.fill;
    canvas.drawPath(arrowHead, arrowFill);
  }

  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
