// D4rt test script: Tests FabCenterOffsetX from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FabCenterOffsetX Visual Demo ===');
  print('Demonstrating FAB center offset X positioning in Scaffold contexts');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FabCenterOffsetX Demo'),
        backgroundColor: Color(0xFFD84315),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Center-Aligned FAB Positions'),
            SizedBox(height: 8),
            _buildCenterAlignedPositions(),
            SizedBox(height: 24),
            buildSectionHeader('CenterFloat vs CenterDocked'),
            SizedBox(height: 8),
            _buildCenterFloatVsDocked(),
            SizedBox(height: 24),
            buildSectionHeader('X-Axis Offset Calculation'),
            SizedBox(height: 8),
            _buildXAxisCalculation(),
            SizedBox(height: 24),
            buildSectionHeader('FAB with BottomNavigationBar'),
            SizedBox(height: 8),
            _buildFabWithBottomNav(),
            SizedBox(height: 24),
            buildSectionHeader('Mini FAB Center Positions'),
            SizedBox(height: 8),
            _buildMiniFabCenterPositions(),
            SizedBox(height: 24),
            buildSectionHeader('Scaffold Width Impact'),
            SizedBox(height: 8),
            _buildScaffoldWidthImpact(),
            SizedBox(height: 24),
            buildSectionHeader('CenterTop FAB Location'),
            SizedBox(height: 8),
            _buildCenterTopLocation(),
            SizedBox(height: 24),
            buildSectionHeader('FAB Location Enum Values'),
            SizedBox(height: 8),
            _buildLocationEnumValues(),
            SizedBox(height: 24),
            buildSectionHeader('Offset Measurement Visual'),
            SizedBox(height: 8),
            _buildOffsetMeasurementVisual(),
            SizedBox(height: 24),
            buildSectionHeader('Properties and Methods'),
            SizedBox(height: 8),
            _buildPropertiesAndMethods(),
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
      color: Colors.teal.shade700,
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

Widget _buildCenterAlignedPositions() {
  print('Building center-aligned FAB positions');
  List<Widget> items = [];

  items.add(_buildScaffoldDiagram('centerFloat', 0.5, 0.7, Color(0xFFD84315), false));
  items.add(SizedBox(height: 12));
  items.add(_buildScaffoldDiagram('centerDocked', 0.5, 0.92, Color(0xFF00897B), true));
  items.add(SizedBox(height: 12));
  items.add(_buildScaffoldDiagram('centerTop', 0.5, 0.12, Color(0xFF1565C0), false));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFBE9E7),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFAB91)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Three Center X-Offset FAB Locations',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('FabCenterOffsetX:', 'Mixin providing getOffsetX for horizontal centering'),
      ],
    ),
  );
}

Widget _buildScaffoldDiagram(String label, double xFraction, double yFraction, Color fabColor, bool docked) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Container(
          width: 120, height: 160,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0, height: 24,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF455A64),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Center(child: Text('AppBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 8))),
                ),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0, height: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF78909C),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Center(child: Text('BottomNav', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 7))),
                ),
              ),
              Positioned(
                left: (120 * xFraction) - 14,
                top: (160 * yFraction) - 14,
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: fabColor,
                    shape: BoxShape.circle,
                    border: docked ? Border.all(color: Color(0xFFFFFFFF), width: 2) : null,
                  ),
                  child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 14)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: fabColor)),
              SizedBox(height: 4),
              Text('X offset: centered (scaffoldWidth - fabWidth) / 2',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF616161))),
              SizedBox(height: 4),
              Text(docked ? 'Docked into bottom bar' : 'Floating above content',
                  style: TextStyle(fontSize: 12, color: Color(0xFF757575))),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: fabColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text('FloatingActionButtonLocation.$label',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: fabColor)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCenterFloatVsDocked() {
  print('Building centerFloat vs centerDocked comparison');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF90CAF9)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFFD84315), width: 2),
            ),
            child: Column(
              children: [
                Text('centerFloat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFFD84315))),
                SizedBox(height: 12),
                Container(
                  height: 100, width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 24, left: 0, right: 0,
                        child: Center(
                          child: Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFD84315),
                              shape: BoxShape.circle,
                            ),
                            child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 20)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0, left: 0, right: 0, height: 16,
                        child: Container(
                          color: Color(0xFF78909C),
                          child: Center(child: Text('BottomNav', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 7))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text('FAB floats ABOVE bottom bar', style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                Text('Gap between FAB and bar', style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
              ],
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFF00897B), width: 2),
            ),
            child: Column(
              children: [
                Text('centerDocked', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF00897B))),
                SizedBox(height: 12),
                Container(
                  height: 100, width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 6, left: 0, right: 0,
                        child: Center(
                          child: Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF00897B),
                              shape: BoxShape.circle,
                              border: Border.all(color: Color(0xFFFFFFFF), width: 3),
                            ),
                            child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 20)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0, left: 0, right: 0, height: 16,
                        child: Container(
                          color: Color(0xFF78909C),
                          child: Center(child: Text('BottomAppBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 7))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text('FAB docked INTO bottom bar', style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                Text('Notch cradles the FAB', style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildXAxisCalculation() {
  print('Building X-axis offset calculation');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFFFE082)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('getOffsetX Calculation Formula',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('x = (scaffoldWidth - fabWidth) / 2.0',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 14, color: Color(0xFF80CBC4))),
              SizedBox(height: 8),
              Text('// Example with 400px scaffold, 56px FAB:',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF78909C))),
              Text('x = (400 - 56) / 2.0 = 172.0',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFFFCC80))),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 4, left: 4, right: 4,
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Color(0xFF90CAF9).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(child: Text('scaffoldWidth', style: TextStyle(fontSize: 8, color: Color(0xFF1565C0)))),
                ),
              ),
              Positioned(
                top: 24, left: 4,
                child: Container(
                  height: 14, width: 130,
                  decoration: BoxDecoration(
                    color: Color(0xFFA5D6A7).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(child: Text('(scaffoldWidth - fabWidth) / 2', style: TextStyle(fontSize: 7, color: Color(0xFF2E7D32)))),
                ),
              ),
              Positioned(
                top: 24, left: 134,
                child: Container(
                  height: 14, width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFFD84315).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(child: Text('fabWidth', style: TextStyle(fontSize: 7, color: Color(0xFFD84315)))),
                ),
              ),
              Positioned(
                top: 44, left: 4,
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, size: 10, color: Color(0xFF2E7D32)),
                    Text(' offsetX ', style: TextStyle(fontSize: 8, color: Color(0xFF2E7D32))),
                    Icon(Icons.arrow_forward, size: 10, color: Color(0xFF2E7D32)),
                    SizedBox(width: 4),
                    Container(width: 20, height: 20, decoration: BoxDecoration(color: Color(0xFFD84315), shape: BoxShape.circle),
                      child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 10))),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_back, size: 10, color: Color(0xFF2E7D32)),
                    Text(' offsetX ', style: TextStyle(fontSize: 8, color: Color(0xFF2E7D32))),
                    Icon(Icons.arrow_forward, size: 10, color: Color(0xFF2E7D32)),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('Key:', 'X offset ensures FAB is horizontally centered in Scaffold'),
      ],
    ),
  );
}

Widget _buildFabWithBottomNav() {
  print('Building FAB with BottomNavigationBar');
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
        Text('Common Pattern: Center FAB with Bottom Navigation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 16),
        Container(
          height: 200, width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD), width: 2),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0, height: 36,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1565C0),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                  ),
                  child: Center(child: Text('My App', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12, fontWeight: FontWeight.bold))),
                ),
              ),
              Positioned(
                top: 36, left: 0, right: 0, bottom: 44,
                child: Center(child: Text('Content Area', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11))),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0, height: 44,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                    border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.home, 'Home', true),
                      _buildNavItem(Icons.search, 'Search', false),
                      SizedBox(width: 48),
                      _buildNavItem(Icons.favorite, 'Favs', false),
                      _buildNavItem(Icons.person, 'Profile', false),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 24, left: 0, right: 0,
                child: Center(
                  child: Container(
                    width: 52, height: 52,
                    decoration: BoxDecoration(
                      color: Color(0xFFD84315),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFFFFFFF), width: 3),
                    ),
                    child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 28)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Pattern:', 'centerDocked FAB with BottomAppBar having a notch'),
        buildInfoCard('X Position:', 'Calculated by FabCenterOffsetX.getOffsetX()'),
      ],
    ),
  );
}

Widget _buildNavItem(IconData icon, String label, bool active) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 4),
      Icon(icon, size: 20, color: active ? Color(0xFF1565C0) : Color(0xFF9E9E9E)),
      Text(label, style: TextStyle(fontSize: 9, color: active ? Color(0xFF1565C0) : Color(0xFF9E9E9E))),
    ],
  );
}

Widget _buildMiniFabCenterPositions() {
  print('Building mini FAB center positions');
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
        Text('Mini FAB variants also use center X offset',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildFabSizeCard('Standard FAB', 56, Color(0xFFD84315))),
            SizedBox(width: 12),
            Expanded(child: _buildFabSizeCard('Mini FAB', 40, Color(0xFF6A1B9A))),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Standard:', 'miniCenterFloat, miniCenterDocked, miniCenterTop'),
        buildInfoCard('Size Difference:', 'Mini FAB adjusts the offset calculation for its smaller width'),
      ],
    ),
  );
}

Widget _buildFabSizeCard(String label, double size, Color color) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Container(
          width: size, height: size,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: size * 0.5)),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
        Text('${size.toInt()}x${size.toInt()} px', style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
      ],
    ),
  );
}

Widget _buildScaffoldWidthImpact() {
  print('Building scaffold width impact');
  List<Widget> rows = [];

  rows.add(_buildWidthRow('Narrow (320px)', 320, 56, Color(0xFFF44336)));
  rows.add(SizedBox(height: 6));
  rows.add(_buildWidthRow('Phone (375px)', 375, 56, Color(0xFFFF9800)));
  rows.add(SizedBox(height: 6));
  rows.add(_buildWidthRow('Tablet (768px)', 768, 56, Color(0xFF4CAF50)));
  rows.add(SizedBox(height: 6));
  rows.add(_buildWidthRow('Desktop (1200px)', 1200, 56, Color(0xFF2196F3)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How scaffold width affects center X offset',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildWidthRow(String label, int scaffoldW, int fabW, Color color) {
  double offset = (scaffoldW - fabW) / 2.0;
  double fraction = fabW / scaffoldW;
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
            Expanded(child: SizedBox()),
            Text('offsetX = ${offset.toStringAsFixed(1)}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF616161))),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 20,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            widthFactor: fraction,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text('FAB takes ${(fraction * 100).toStringAsFixed(1)}% of scaffold width',
            style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E))),
      ],
    ),
  );
}

Widget _buildCenterTopLocation() {
  print('Building centerTop location');
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
        Text('CenterTop: FAB positioned at top-center',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 16),
        Container(
          height: 180, width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0, height: 32,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1565C0),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7)),
                  ),
                  child: Center(child: Text('AppBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10))),
                ),
              ),
              Positioned(
                top: 14, left: 0, right: 0,
                child: Center(
                  child: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xFF1565C0),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFFFFFFF), width: 3),
                    ),
                    child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 22)),
                  ),
                ),
              ),
              Positioned(
                top: 68, left: 16, right: 16,
                child: Column(
                  children: [
                    Text('centerTop places FAB overlapping AppBar',
                        style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
                    SizedBox(height: 4),
                    Text('Same X offset as centerFloat and centerDocked',
                        style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E))),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('X Offset:', 'Identical to centerFloat - horizontally centered'),
        buildInfoCard('Y Offset:', 'Different - positions FAB at top of body area'),
      ],
    ),
  );
}

Widget _buildLocationEnumValues() {
  print('Building location enum values');
  List<Widget> locations = [];

  locations.add(_buildLocationRow('centerFloat', 'Center X, floating above bottom', true, Color(0xFFD84315)));
  locations.add(SizedBox(height: 4));
  locations.add(_buildLocationRow('centerDocked', 'Center X, docked into bottom bar', true, Color(0xFF00897B)));
  locations.add(SizedBox(height: 4));
  locations.add(_buildLocationRow('centerTop', 'Center X, top of body area', true, Color(0xFF1565C0)));
  locations.add(SizedBox(height: 4));
  locations.add(_buildLocationRow('miniCenterFloat', 'Center X, mini size, floating', true, Color(0xFF6A1B9A)));
  locations.add(SizedBox(height: 4));
  locations.add(_buildLocationRow('miniCenterDocked', 'Center X, mini size, docked', true, Color(0xFF283593)));
  locations.add(SizedBox(height: 4));
  locations.add(_buildLocationRow('miniCenterTop', 'Center X, mini size, top', true, Color(0xFF00695C)));
  locations.add(SizedBox(height: 10));
  locations.add(_buildLocationRow('endFloat', 'End X, floating (NOT center)', false, Color(0xFF757575)));
  locations.add(SizedBox(height: 4));
  locations.add(_buildLocationRow('endDocked', 'End X, docked (NOT center)', false, Color(0xFF757575)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FloatingActionButtonLocation values using FabCenterOffsetX',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: locations),
      ],
    ),
  );
}

Widget _buildLocationRow(String name, String desc, bool usesCenter, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: usesCenter ? color.withValues(alpha: 0.06) : Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: usesCenter ? color : Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Icon(
          usesCenter ? Icons.check_circle : Icons.cancel,
          color: usesCenter ? color : Color(0xFFBDBDBD),
          size: 18,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              Text(desc, style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildOffsetMeasurementVisual() {
  print('Building offset measurement visual');
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
        Text('Visual Offset Measurement',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 16),
        Container(
          height: 100, width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0,
                child: Container(
                  height: 2,
                  color: Color(0xFF90CAF9),
                ),
              ),
              Positioned(
                top: 4, left: 0,
                child: Text('0', style: TextStyle(fontSize: 8, color: Color(0xFF1565C0))),
              ),
              Positioned(
                top: 4, right: 0,
                child: Text('scaffoldWidth', style: TextStyle(fontSize: 8, color: Color(0xFF1565C0))),
              ),
              Positioned(
                top: 20, left: 0, right: 0,
                child: Center(
                  child: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xFFD84315),
                      shape: BoxShape.circle,
                    ),
                    child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 22)),
                  ),
                ),
              ),
              Positioned(
                top: 70, left: 0, right: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(height: 1, color: Color(0xFF4CAF50)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text('FAB', style: TextStyle(fontSize: 8, color: Color(0xFFD84315))),
                    ),
                    Expanded(
                      child: Container(height: 1, color: Color(0xFF4CAF50)),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0, left: 8,
                child: Text('offsetX', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF4CAF50))),
              ),
              Positioned(
                bottom: 0, right: 8,
                child: Text('offsetX', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF4CAF50))),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('Symmetry:', 'Left offset = Right offset (perfect centering)'),
      ],
    ),
  );
}

Widget _buildPropertiesAndMethods() {
  print('Building properties and methods');
  List<Widget> rows = [];
  rows.add(_buildPropRow('getOffsetX', 'double', 'Returns X offset for centering FAB', Color(0xFFD84315)));
  rows.add(_buildPropRow('scaffoldGeometry', 'ScaffoldPrelayoutGeometry', 'Input: scaffold layout info', Color(0xFF00897B)));
  rows.add(_buildPropRow('adjustment', 'double', 'Additional offset adjustment', Color(0xFF1565C0)));
  rows.add(_buildPropRow('scaffoldSize', 'Size', 'Total scaffold dimensions', Color(0xFF6A1B9A)));
  rows.add(_buildPropRow('floatingActionButtonSize', 'Size', 'FAB dimensions for calculation', Color(0xFFC62828)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(flex: 3, child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(flex: 3, child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
            Expanded(flex: 4, child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
          ],
        ),
        Divider(color: Color(0xFFBDBDBD)),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildPropRow(String name, String type, String desc, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
    ),
    child: Row(
      children: [
        Expanded(flex: 3, child: Text(name, style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: color, fontWeight: FontWeight.bold))),
        Expanded(flex: 3, child: Text(type, style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF616161)))),
        Expanded(flex: 4, child: Text(desc, style: TextStyle(fontSize: 11, color: Color(0xFF757575)))),
      ],
    ),
  );
}
