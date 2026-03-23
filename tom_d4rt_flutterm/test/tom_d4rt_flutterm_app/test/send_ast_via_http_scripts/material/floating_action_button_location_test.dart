// ignore_for_file: avoid_print
// D4rt test script: Tests FloatingActionButtonLocation from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FloatingActionButtonLocation Visual Demo ===');
  print('Demonstrating all FAB location values and positioning');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FloatingActionButtonLocation Demo'),
        backgroundColor: Color(0xFF01579B),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('FloatingActionButtonLocation Overview'),
            SizedBox(height: 8),
            _buildOverview(),
            SizedBox(height: 24),
            buildSectionHeader('End Float Positions'),
            SizedBox(height: 8),
            _buildEndFloatPositions(),
            SizedBox(height: 24),
            buildSectionHeader('Center Float Positions'),
            SizedBox(height: 8),
            _buildCenterFloatPositions(),
            SizedBox(height: 24),
            buildSectionHeader('Start Float Positions'),
            SizedBox(height: 8),
            _buildStartFloatPositions(),
            SizedBox(height: 24),
            buildSectionHeader('Docked Positions'),
            SizedBox(height: 8),
            _buildDockedPositions(),
            SizedBox(height: 24),
            buildSectionHeader('Top Positions'),
            SizedBox(height: 8),
            _buildTopPositions(),
            SizedBox(height: 24),
            buildSectionHeader('Mini Positions'),
            SizedBox(height: 8),
            _buildMiniPositions(),
            SizedBox(height: 24),
            buildSectionHeader('All Locations Grid'),
            SizedBox(height: 8),
            _buildAllLocationsGrid(),
            SizedBox(height: 24),
            buildSectionHeader('Float vs Docked Comparison'),
            SizedBox(height: 8),
            _buildFloatVsDockedComparison(),
            SizedBox(height: 24),
            buildSectionHeader('Location Categories'),
            SizedBox(height: 8),
            _buildLocationCategories(),
            SizedBox(height: 24),
            buildSectionHeader('Properties Reference'),
            SizedBox(height: 8),
            _buildPropertiesReference(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Color(0xFF01579B),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
    child: Row(children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      SizedBox(width: 8),
      Expanded(child: Text(value, style: TextStyle(fontSize: 14, color: Colors.grey.shade700))),
    ]),
  );
}

Widget _buildOverview() {
  print('Building overview section');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FloatingActionButtonLocation determines where the Scaffold positions the FAB. '
            'Multiple predefined locations are available covering float, docked, and top positions.',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(top: 0, left: 0, right: 0, height: 32,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF01579B),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7)),
                  ),
                  child: Center(child: Text('AppBar', style: TextStyle(color: Colors.white, fontSize: 10))),
                ),
              ),
              Positioned(bottom: 0, left: 0, right: 0, height: 36,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                  ),
                  child: Center(child: Text('BottomNavigationBar', style: TextStyle(fontSize: 9))),
                ),
              ),
              Positioned(top: 36, left: 4, right: 4, bottom: 40,
                child: Container(
                  color: Color(0xFFFAFAFA),
                  child: Center(child: Text('Body', style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)))),
                ),
              ),
              _buildFabDot(6, 108, 'endFloat', Color(0xFFD32F2F)),
              _buildFabDot(6, 72, 'centerFloat', Color(0xFF2E7D32)),
              _buildFabDot(6, 24, 'startFloat', Color(0xFF1565C0)),
              _buildFabDot(112, 108, 'endDocked', Color(0xFFE65100)),
              _buildFabDot(112, 72, 'centerDocked', Color(0xFF6A1B9A)),
              _buildFabDot(40, 108, 'endTop', Color(0xFF00695C)),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('Type:', 'Abstract class with static location constants'),
        buildInfoCard('Usage:', 'Scaffold(floatingActionButtonLocation: ...)'),
        buildInfoCard('Count:', '16+ predefined location values'),
      ],
    ),
  );
}

Widget _buildFabDot(double top, double right, String label, Color color) {
  return Positioned(
    top: top, right: right,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14, height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(child: Icon(Icons.add, color: Colors.white, size: 8)),
        ),
        Text(label, style: TextStyle(fontSize: 6, color: color)),
      ],
    ),
  );
}

Widget _buildEndFloatPositions() {
  print('Building end float positions');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFEF9A9A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('End positions place the FAB on the trailing edge (right in LTR)',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        _buildLocationScaffold('endFloat', 'Default position', 'Bottom-right, floating above bottom bar',
            Color(0xFFD32F2F), Alignment.bottomRight, 16.0),
        SizedBox(height: 8),
        _buildLocationScaffold('endDocked', 'Docked in BottomAppBar', 'Bottom-right, notched into bottom bar',
            Color(0xFFC62828), Alignment.bottomRight, 0.0),
        SizedBox(height: 8),
        _buildLocationScaffold('endTop', 'Top-right position', 'Near top, below AppBar on right side',
            Color(0xFFB71C1C), Alignment.topRight, 16.0),
        SizedBox(height: 8),
        buildInfoCard('endFloat:', 'The default FAB location in most apps'),
        buildInfoCard('endDocked:', 'Requires BottomAppBar with notch shape'),
        buildInfoCard('endTop:', 'Less common, for top-action patterns'),
      ],
    ),
  );
}

Widget _buildCenterFloatPositions() {
  print('Building center float positions');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFA5D6A7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Center positions place the FAB horizontally centered',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        _buildLocationScaffold('centerFloat', 'Centered floating', 'Bottom-center, floating above bottom bar',
            Color(0xFF2E7D32), Alignment.bottomCenter, 16.0),
        SizedBox(height: 8),
        _buildLocationScaffold('centerDocked', 'Centered docked', 'Bottom-center, notched into bottom bar',
            Color(0xFF1B5E20), Alignment.bottomCenter, 0.0),
        SizedBox(height: 8),
        _buildLocationScaffold('centerTop', 'Centered top', 'Top-center, below AppBar',
            Color(0xFF33691E), Alignment.topCenter, 16.0),
        SizedBox(height: 8),
        buildInfoCard('centerFloat:', 'Prominent central action button'),
        buildInfoCard('centerDocked:', 'Popular in bottom navigation with notch'),
        buildInfoCard('centerTop:', 'Rare, for special scenarios'),
      ],
    ),
  );
}

Widget _buildStartFloatPositions() {
  print('Building start float positions');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Start positions place the FAB on the leading edge (left in LTR)',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        _buildLocationScaffold('startFloat', 'Start floating', 'Bottom-left, floating above bottom bar',
            Color(0xFF1565C0), Alignment.bottomLeft, 16.0),
        SizedBox(height: 8),
        _buildLocationScaffold('startDocked', 'Start docked', 'Bottom-left, notched into bottom bar',
            Color(0xFF0D47A1), Alignment.bottomLeft, 0.0),
        SizedBox(height: 8),
        _buildLocationScaffold('startTop', 'Start top', 'Top-left, below AppBar',
            Color(0xFF1A237E), Alignment.topLeft, 16.0),
        SizedBox(height: 8),
        buildInfoCard('startFloat:', 'Left-aligned action button'),
        buildInfoCard('startDocked:', 'Left-docked into bottom bar'),
        buildInfoCard('startTop:', 'Top-left position'),
      ],
    ),
  );
}

Widget _buildDockedPositions() {
  print('Building docked positions section');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFCC80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Docked positions embed the FAB into the BottomAppBar with a cutout notch',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildDockedDiagram('centerDocked', Alignment.bottomCenter, Color(0xFFE65100))),
            SizedBox(width: 8),
            Expanded(child: _buildDockedDiagram('endDocked', Alignment.bottomRight, Color(0xFFF57C00))),
            SizedBox(width: 8),
            Expanded(child: _buildDockedDiagram('startDocked', Alignment.bottomLeft, Color(0xFFEF6C00))),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Notch:', 'BottomAppBar.shape = CircularNotchedRectangle()'),
        buildInfoCard('Behavior:', 'FAB sits at y=0 of the bottom bar edge'),
        buildInfoCard('Required:', 'BottomAppBar must be in Scaffold.bottomNavigationBar'),
      ],
    ),
  );
}

Widget _buildDockedDiagram(String label, Alignment alignment, Color color) {
  return Container(
    height: 100,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Stack(
      children: [
        Positioned(bottom: 0, left: 0, right: 0, height: 24,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          left: alignment == Alignment.bottomLeft ? 8 : (alignment == Alignment.bottomCenter ? null : null),
          right: alignment == Alignment.bottomRight ? 8 : (alignment == Alignment.bottomCenter ? null : null),
          child: Align(
            alignment: alignment,
            child: Container(
              width: 28, height: 28,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(Icons.add, color: Colors.white, size: 14),
            ),
          ),
        ),
        Positioned(
          bottom: 28, left: 0, right: 0,
          child: Center(child: Text(label, style: TextStyle(fontSize: 7, fontWeight: FontWeight.bold, color: color))),
        ),
      ],
    ),
  );
}

Widget _buildTopPositions() {
  print('Building top positions');
  List<Widget> items = [];

  List<String> topNames = ['startTop', 'centerTop', 'endTop', 'miniStartTop'];
  List<Alignment> topAligns = [Alignment.topLeft, Alignment.topCenter, Alignment.topRight, Alignment.topLeft];
  List<Color> topColors = [Color(0xFF00695C), Color(0xFF004D40), Color(0xFF00796B), Color(0xFF00897B)];
  List<String> topDescs = [
    'Top-left, below AppBar',
    'Top-center, below AppBar',
    'Top-right, below AppBar',
    'Top-left for mini FAB',
  ];

  int i = 0;
  for (; i < 4; i = i + 1) {
    String name = topNames[i];
    Alignment align = topAligns[i];
    Color color = topColors[i];
    String desc = topDescs[i];

    print('  Top position: $name');

    items.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 80, height: 70,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0xFFBDBDBD)),
            ),
            child: Stack(
              children: [
                Positioned(top: 0, left: 0, right: 0, height: 18,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF01579B),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                    ),
                    child: Center(child: Text('AppBar', style: TextStyle(color: Colors.white, fontSize: 6))),
                  ),
                ),
                Positioned(
                  top: 22,
                  left: align == Alignment.topLeft ? 6 : null,
                  right: align == Alignment.topRight ? 6 : null,
                  child: Container(
                    width: 16, height: 16,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    child: Icon(Icons.add, color: Colors.white, size: 8),
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
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
                Text(desc, style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80CBC4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Top positions place the FAB near the top of the Scaffold, just below the AppBar',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget _buildMiniPositions() {
  print('Building mini positions');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF3E5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFCE93D8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mini positions are designed for FloatingActionButton.small and mini FABs',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF6A1B9A), width: 2),
                ),
                child: Column(
                  children: [
                    Text('miniStartTop', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF6A1B9A))),
                    SizedBox(height: 8),
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(color: Color(0xFF6A1B9A), shape: BoxShape.circle),
                      child: Icon(Icons.add, color: Colors.white, size: 16),
                    ),
                    SizedBox(height: 4),
                    Text('Top-left, sized for mini', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9, color: Color(0xFF616161))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF4A148C), width: 2),
                ),
                child: Column(
                  children: [
                    Text('miniCenterFloat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF4A148C))),
                    SizedBox(height: 8),
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(color: Color(0xFF4A148C), shape: BoxShape.circle),
                      child: Icon(Icons.add, color: Colors.white, size: 16),
                    ),
                    SizedBox(height: 4),
                    Text('Bottom-center, mini spacing', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9, color: Color(0xFF616161))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF7B1FA2), width: 2),
                ),
                child: Column(
                  children: [
                    Text('miniEndFloat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Color(0xFF7B1FA2))),
                    SizedBox(height: 8),
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(color: Color(0xFF7B1FA2), shape: BoxShape.circle),
                      child: Icon(Icons.add, color: Colors.white, size: 16),
                    ),
                    SizedBox(height: 4),
                    Text('Bottom-right, mini spacing', textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9, color: Color(0xFF616161))),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        buildInfoCard('Difference:', 'Mini locations use smaller margin offsets'),
        buildInfoCard('Use with:', 'FloatingActionButton.small() or mini: true'),
      ],
    ),
  );
}

Widget _buildAllLocationsGrid() {
  print('Building all locations grid');
  List<Widget> rows = [];

  List<String> locNames = [
    'endFloat', 'centerFloat', 'startFloat',
    'endDocked', 'centerDocked', 'startDocked',
    'endTop', 'centerTop', 'startTop',
    'miniEndFloat', 'miniCenterFloat', 'miniStartTop',
    'endContained', 'startContained', 'endContainedTop',
  ];
  List<String> hAligns = [
    'End', 'Center', 'Start',
    'End', 'Center', 'Start',
    'End', 'Center', 'Start',
    'End', 'Center', 'Start',
    'End', 'Start', 'End',
  ];
  List<String> vPositions = [
    'Bottom (float)', 'Bottom (float)', 'Bottom (float)',
    'Bottom (docked)', 'Bottom (docked)', 'Bottom (docked)',
    'Top', 'Top', 'Top',
    'Bottom (mini)', 'Bottom (mini)', 'Top (mini)',
    'Bottom (contained)', 'Bottom (contained)', 'Top (contained)',
  ];
  List<Color> rowColors = [
    Color(0xFFD32F2F), Color(0xFF2E7D32), Color(0xFF1565C0),
    Color(0xFFE65100), Color(0xFF6A1B9A), Color(0xFF00695C),
    Color(0xFFC62828), Color(0xFF1B5E20), Color(0xFF0D47A1),
    Color(0xFFAD1457), Color(0xFF4A148C), Color(0xFF004D40),
    Color(0xFF424242), Color(0xFF37474F), Color(0xFF263238),
  ];

  int i = 0;
  for (; i < 15; i = i + 1) {
    String name = locNames[i];
    String hAlign = hAligns[i];
    String vPos = vPositions[i];
    Color color = rowColors[i];

    print('  Location: $name - $hAlign / $vPos');

    rows.add(Container(
      margin: EdgeInsets.only(bottom: 3),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: 6),
          SizedBox(
            width: 110,
            child: Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 10, fontWeight: FontWeight.bold, color: color)),
          ),
          SizedBox(width: 4),
          SizedBox(
            width: 50,
            child: Text(hAlign, style: TextStyle(fontSize: 9, color: Color(0xFF616161))),
          ),
          Expanded(
            child: Text(vPos, style: TextStyle(fontSize: 9, color: Color(0xFF757575))),
          ),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Complete list of predefined FAB locations',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              SizedBox(width: 14),
              SizedBox(width: 110, child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
              SizedBox(width: 4),
              SizedBox(width: 50, child: Text('H-Align', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
              Expanded(child: Text('V-Position', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10))),
            ],
          ),
        ),
        SizedBox(height: 4),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildFloatVsDockedComparison() {
  print('Building float vs docked comparison');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Float vs Docked: visual and behavioral differences',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF1565C0), width: 2),
                ),
                child: Stack(
                  children: [
                    Positioned(top: 4, left: 4, right: 4,
                      child: Center(child: Text('Float', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1565C0)))),
                    ),
                    Positioned(bottom: 0, left: 0, right: 0, height: 28,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                        ),
                        child: Center(child: Text('BottomBar', style: TextStyle(fontSize: 8))),
                      ),
                    ),
                    Positioned(bottom: 36, right: 12,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: Color(0xFF1565C0),
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 2))],
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 18),
                      ),
                    ),
                    Positioned(bottom: 32, right: 4,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        color: Color(0xFFFFFFFF),
                        child: Text('16px gap', style: TextStyle(fontSize: 7, color: Color(0xFF1565C0))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFE65100), width: 2),
                ),
                child: Stack(
                  children: [
                    Positioned(top: 4, left: 4, right: 4,
                      child: Center(child: Text('Docked', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFFE65100)))),
                    ),
                    Positioned(bottom: 0, left: 0, right: 0, height: 28,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7), bottomRight: Radius.circular(7)),
                        ),
                        child: Center(child: Text('BottomAppBar', style: TextStyle(fontSize: 8))),
                      ),
                    ),
                    Positioned(bottom: 14, right: 12,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: Color(0xFFE65100),
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 2))],
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 18),
                      ),
                    ),
                    Positioned(bottom: 32, right: 4,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        color: Color(0xFFFFFFFF),
                        child: Text('notched', style: TextStyle(fontSize: 7, color: Color(0xFFE65100))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        buildInfoCard('Float:', 'FAB floats above the bottom bar with a gap'),
        buildInfoCard('Docked:', 'FAB is embedded into BottomAppBar with a notch'),
        buildInfoCard('Notch Shape:', 'CircularNotchedRectangle clips the BottomAppBar'),
      ],
    ),
  );
}

Widget _buildLocationCategories() {
  print('Building location categories');
  List<Widget> cats = [];

  List<String> catNames = ['Standard Float', 'Standard Docked', 'Standard Top', 'Mini Variants', 'Contained Variants'];
  List<Color> catColors = [Color(0xFF1565C0), Color(0xFFE65100), Color(0xFF00695C), Color(0xFF6A1B9A), Color(0xFF424242)];
  List<List<String>> catMembers = [
    ['endFloat', 'centerFloat', 'startFloat'],
    ['endDocked', 'centerDocked', 'startDocked'],
    ['endTop', 'centerTop', 'startTop'],
    ['miniEndFloat', 'miniCenterFloat', 'miniStartTop'],
    ['endContained', 'startContained', 'endContainedTop'],
  ];
  List<String> catDescs = [
    'Floating above bottom bar with elevation shadow',
    'Notched into BottomAppBar surface',
    'Positioned below AppBar at the top',
    'Adjusted margins for mini (40px) FABs',
    'Contained within body without overlapping bars',
  ];

  int i = 0;
  for (; i < 5; i = i + 1) {
    String catName = catNames[i];
    Color catColor = catColors[i];
    List<String> members = catMembers[i];
    String catDesc = catDescs[i];

    print('  Category: $catName');

    List<Widget> memberWidgets = [];
    int j = 0;
    for (; j < members.length; j = j + 1) {
      String member = members[j];
      memberWidgets.add(Container(
        margin: EdgeInsets.only(right: 4, bottom: 4),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: catColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(member, style: TextStyle(color: Colors.white, fontSize: 9)),
      ));
    }

    cats.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: catColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: catColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(catName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: catColor)),
          SizedBox(height: 4),
          Text(catDesc, style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
          SizedBox(height: 6),
          Wrap(children: memberWidgets),
        ],
      ),
    ));
  }

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cats,
    ),
  );
}

Widget _buildLocationScaffold(String name, String title, String description, Color color, Alignment alignment, double gap) {
  return Container(
    margin: EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 80, height: 70,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(top: 0, left: 0, right: 0, height: 14,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF01579B),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                  ),
                ),
              ),
              Positioned(bottom: 0, left: 0, right: 0, height: 12,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                  ),
                ),
              ),
              Positioned(
                top: alignment.y < 0 ? 18 : null,
                bottom: alignment.y > 0 ? (12 + gap) : null,
                left: alignment.x < 0 ? 6 : null,
                right: alignment.x > 0 ? 6 : null,
                child: Container(
                  width: 18, height: 18,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                  child: Icon(Icons.add, color: Colors.white, size: 10),
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
              Row(
                children: [
                  Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: color)),
                  SizedBox(width: 8),
                  Text(title, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
                ],
              ),
              SizedBox(height: 2),
              Text(description, style: TextStyle(fontSize: 10, color: Color(0xFF616161))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertiesReference() {
  print('Building properties reference');
  List<Widget> items = [];

  items.add(Text('Standard Locations:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF01579B))));
  items.add(SizedBox(height: 4));
  items.add(buildInfoCard('endFloat:', 'Default. Bottom-right, floating.'));
  items.add(buildInfoCard('centerFloat:', 'Bottom-center, floating.'));
  items.add(buildInfoCard('startFloat:', 'Bottom-left, floating.'));
  items.add(buildInfoCard('endDocked:', 'Bottom-right, docked in BottomAppBar.'));
  items.add(buildInfoCard('centerDocked:', 'Bottom-center, docked in BottomAppBar.'));
  items.add(buildInfoCard('startDocked:', 'Bottom-left, docked in BottomAppBar.'));
  items.add(buildInfoCard('endTop:', 'Top-right, below AppBar.'));
  items.add(buildInfoCard('centerTop:', 'Top-center, below AppBar.'));
  items.add(buildInfoCard('startTop:', 'Top-left, below AppBar.'));
  items.add(SizedBox(height: 12));
  items.add(Text('Mini Locations:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF6A1B9A))));
  items.add(SizedBox(height: 4));
  items.add(buildInfoCard('miniStartTop:', 'Top-left for mini FAB.'));
  items.add(buildInfoCard('miniCenterFloat:', 'Bottom-center for mini FAB.'));
  items.add(buildInfoCard('miniEndFloat:', 'Bottom-right for mini FAB.'));
  items.add(SizedBox(height: 12));
  items.add(Text('Contained Locations:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF424242))));
  items.add(SizedBox(height: 4));
  items.add(buildInfoCard('endContained:', 'Bottom-right within body bounds.'));
  items.add(buildInfoCard('startContained:', 'Bottom-left within body bounds.'));
  items.add(buildInfoCard('endContainedTop:', 'Top-right within body bounds.'));
  items.add(SizedBox(height: 12));
  items.add(Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scaffold(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  floatingActionButton: FloatingActionButton(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('    onPressed: () {},', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('    child: Icon(Icons.add),', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  ),', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  floatingActionButtonLocation:', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('    FloatingActionButtonLocation.centerDocked,', style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF01579B))),
        Text('  bottomNavigationBar: BottomAppBar(', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('    shape: CircularNotchedRectangle(),', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('    child: Row(...),', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text('  ),', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
        Text(')', style: TextStyle(fontFamily: 'monospace', fontSize: 11)),
      ],
    ),
  ));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    ),
  );
}
