// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests FabTopOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FabTopOffsetY Visual Demo ===');
  print('Demonstrating FAB top offset Y positioning for top-aligned FAB locations');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FabTopOffsetY Demo'),
        backgroundColor: Color(0xFF6A1B9A),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Top FAB Positions Overview'),
            SizedBox(height: 8),
            _buildTopPositionsOverview(),
            SizedBox(height: 24),
            buildSectionHeader('StartTop FAB Location'),
            SizedBox(height: 8),
            _buildStartTopLocation(),
            SizedBox(height: 24),
            buildSectionHeader('EndTop FAB Location'),
            SizedBox(height: 8),
            _buildEndTopLocation(),
            SizedBox(height: 24),
            buildSectionHeader('CenterTop FAB Location'),
            SizedBox(height: 8),
            _buildCenterTopLocation(),
            SizedBox(height: 24),
            buildSectionHeader('Y Offset Relative to AppBar'),
            SizedBox(height: 8),
            _buildYOffsetRelativeToAppBar(),
            SizedBox(height: 24),
            buildSectionHeader('FAB Size Impact on Y Position'),
            SizedBox(height: 8),
            _buildFabSizeImpactOnY(),
            SizedBox(height: 24),
            buildSectionHeader('AppBar Height Variations'),
            SizedBox(height: 8),
            _buildAppBarHeightVariations(),
            SizedBox(height: 24),
            buildSectionHeader('Top FAB with Body Content'),
            SizedBox(height: 8),
            _buildTopFabWithBodyContent(),
            SizedBox(height: 24),
            buildSectionHeader('Mini FAB Top Positions'),
            SizedBox(height: 8),
            _buildMiniFabTopPositions(),
            SizedBox(height: 24),
            buildSectionHeader('Y Offset Measurement Diagram'),
            SizedBox(height: 8),
            _buildYOffsetMeasurementDiagram(),
            SizedBox(height: 24),
            buildSectionHeader('All Top Locations Comparison'),
            SizedBox(height: 8),
            _buildAllTopLocationsComparison(),
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
      color: Color(0xFF6A1B9A),
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

Widget _buildTopPositionsOverview() {
  print('Building top positions overview');
  List<Widget> items = [];

  items.add(Text('FAB top positions place the FloatingActionButton near the top of the Scaffold.',
      style: TextStyle(fontSize: 14, color: Color(0xFF424242))));
  items.add(SizedBox(height: 12));
  items.add(_buildScaffoldDiagram('startTop', 0.12, 0.18, Color(0xFF6A1B9A)));
  items.add(SizedBox(height: 12));
  items.add(_buildScaffoldDiagram('endTop', 0.88, 0.18, Color(0xFFC62828)));
  items.add(SizedBox(height: 12));
  items.add(_buildScaffoldDiagram('centerTop', 0.5, 0.18, Color(0xFF00695C)));

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
        Text('Three Top FAB Position Variants',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('Y Offset:', 'Calculated from top of Scaffold body, below AppBar'),
      ],
    ),
  );
}

Widget _buildScaffoldDiagram(String label, double xFraction, double yFraction, Color fabColor) {
  print('  Drawing scaffold diagram: $label at Y=$yFraction');
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
          width: 120, height: 180,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0, height: 28,
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
                top: 32, left: 6, right: 6,
                child: Text('Body Content', style: TextStyle(fontSize: 7, color: Color(0xFF9E9E9E))),
              ),
              Positioned(
                left: (120 * xFraction) - 14,
                top: (180 * yFraction) - 14,
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: fabColor,
                    shape: BoxShape.circle,
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
              Text('Y offset places FAB below AppBar',
                  style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
              SizedBox(height: 4),
              Text('Top position at y=$yFraction',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF616161))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildStartTopLocation() {
  print('Building startTop location detail');
  List<Widget> rows = [];

  rows.add(buildInfoCard('Location:', 'FloatingActionButtonLocation.startTop'));
  rows.add(buildInfoCard('X Position:', 'Start side (left in LTR, right in RTL)'));
  rows.add(buildInfoCard('Y Position:', 'Just below the AppBar bottom edge'));
  rows.add(SizedBox(height: 12));
  rows.add(_buildStartTopDiagramDetailed());

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB39DDB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    ),
  );
}

Widget _buildStartTopDiagramDetailed() {
  return Container(
    height: 200,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0, left: 0, right: 0, height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF6A1B9A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
            child: Center(child: Text('AppBar (kToolbarHeight = 56)', style: TextStyle(color: Colors.white, fontSize: 11))),
          ),
        ),
        Positioned(
          top: 28, left: 8,
          child: Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: Color(0xFF6A1B9A),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Center(child: Icon(Icons.add, color: Colors.white, size: 24)),
          ),
        ),
        Positioned(
          top: 90, left: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FAB overlaps AppBar bottom edge',
                  style: TextStyle(fontSize: 11, color: Color(0xFF424242))),
              SizedBox(height: 4),
              Text('Y = appBarHeight - (fabHeight / 2)',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF6A1B9A))),
              SizedBox(height: 4),
              Text('Creates a visual bridge between AppBar and body',
                  style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
            ],
          ),
        ),
        Positioned(
          right: 8, top: 90,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Text('startTop', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF6A1B9A))),
                SizedBox(height: 2),
                Text('x: start', style: TextStyle(fontSize: 10)),
                Text('y: top', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildEndTopLocation() {
  print('Building endTop location detail');
  List<Widget> rows = [];

  rows.add(buildInfoCard('Location:', 'FloatingActionButtonLocation.endTop'));
  rows.add(buildInfoCard('X Position:', 'End side (right in LTR, left in RTL)'));
  rows.add(buildInfoCard('Y Position:', 'Just below the AppBar bottom edge'));
  rows.add(SizedBox(height: 12));

  rows.add(Container(
    height: 200,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0, left: 0, right: 0, height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFC62828),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
            child: Center(child: Text('AppBar', style: TextStyle(color: Colors.white, fontSize: 12))),
          ),
        ),
        Positioned(
          top: 28, right: 8,
          child: Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: Color(0xFFC62828),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Center(child: Icon(Icons.add, color: Colors.white, size: 24)),
          ),
        ),
        Positioned(
          top: 100, left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('endTop places FAB at right edge',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFC62828))),
              SizedBox(height: 4),
              Text('Y: Overlapping AppBar bottom edge',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
              SizedBox(height: 4),
              Text('Useful for primary actions related to AppBar context',
                  style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
            ],
          ),
        ),
      ],
    ),
  ));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFEF9A9A)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    ),
  );
}

Widget _buildCenterTopLocation() {
  print('Building centerTop location detail');
  List<Widget> rows = [];

  rows.add(buildInfoCard('Location:', 'FloatingActionButtonLocation.centerTop'));
  rows.add(buildInfoCard('X Position:', 'Horizontally centered'));
  rows.add(buildInfoCard('Y Position:', 'Just below the AppBar bottom edge'));
  rows.add(SizedBox(height: 12));

  rows.add(Container(
    height: 200,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0, left: 0, right: 0, height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF00695C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
            child: Center(child: Text('AppBar', style: TextStyle(color: Colors.white, fontSize: 12))),
          ),
        ),
        Positioned(
          top: 28, left: 0, right: 0,
          child: Center(
            child: Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: Color(0xFF00695C),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 4, offset: Offset(0, 2))],
              ),
              child: Center(child: Icon(Icons.add, color: Colors.white, size: 24)),
            ),
          ),
        ),
        Positioned(
          bottom: 40, left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('centerTop: Symmetrical placement',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF00695C))),
              SizedBox(height: 4),
              Text('Combines horizontal center with top Y offset',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
            ],
          ),
        ),
      ],
    ),
  ));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE0F2F1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF80CBC4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    ),
  );
}

Widget _buildYOffsetRelativeToAppBar() {
  print('Building Y offset relative to AppBar section');
  List<Widget> items = [];

  items.add(Text('The Y offset for top FAB positions is calculated relative to the AppBar.',
      style: TextStyle(fontSize: 13, color: Color(0xFF424242))));
  items.add(SizedBox(height: 12));

  items.add(Container(
    height: 180,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 0, left: 0, right: 0, height: 20,
          child: Container(
            color: Color(0xFF1565C0),
            child: Center(child: Text('Status Bar', style: TextStyle(color: Colors.white, fontSize: 8))),
          ),
        ),
        Positioned(
          top: 20, left: 0, right: 0, height: 40,
          child: Container(
            color: Color(0xFF1976D2),
            child: Center(child: Text('AppBar (56px default)', style: TextStyle(color: Colors.white, fontSize: 10))),
          ),
        ),
        Positioned(
          top: 42, right: 20,
          child: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: Color(0xFFFF5722),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text('FAB', style: TextStyle(color: Colors.white, fontSize: 8))),
          ),
        ),
        Positioned(
          top: 65, left: 8,
          child: Container(
            padding: EdgeInsets.all(6),
            color: Color(0xFFFFF3E0),
            child: Text('Y = appBarBottom - (fabHeight / 2)',
                style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFFE65100))),
          ),
        ),
        Positioned(
          top: 90, left: 8,
          child: Container(
            padding: EdgeInsets.all(6),
            color: Color(0xFFE3F2FD),
            child: Text('appBarBottom = statusBar + toolbarHeight + bottomOpacity',
                style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: Color(0xFF1565C0))),
          ),
        ),
        Positioned(
          bottom: 20, left: 16, right: 16,
          child: Row(
            children: [
              Container(width: 12, height: 12, color: Color(0xFF1565C0)),
              SizedBox(width: 4),
              Text('AppBar', style: TextStyle(fontSize: 10)),
              SizedBox(width: 12),
              Container(width: 12, height: 12, color: Color(0xFFFF5722)),
              SizedBox(width: 4),
              Text('FAB', style: TextStyle(fontSize: 10)),
              SizedBox(width: 12),
              Container(width: 12, height: 12, color: Color(0xFFFFF3E0)),
              SizedBox(width: 4),
              Text('Y formula', style: TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ],
    ),
  ));

  items.add(SizedBox(height: 8));
  items.add(buildInfoCard('Default AppBar Height:', '56.0 pixels (kToolbarHeight)'));
  items.add(buildInfoCard('FAB Overlap:', 'Half the FAB diameter extends into AppBar area'));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFF9FA8DA)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    ),
  );
}

Widget _buildFabSizeImpactOnY() {
  print('Building FAB size impact on Y section');
  List<Widget> sizes = [];

  List<double> fabDiameters = [40.0, 56.0, 72.0];
  List<String> sizeLabels = ['Mini FAB (40)', 'Regular FAB (56)', 'Large FAB (72)'];
  List<Color> sizeColors = [Color(0xFF43A047), Color(0xFF1E88E5), Color(0xFFE53935)];

  int i = 0;
  for (; i < 3; i = i + 1) {
    double diameter = fabDiameters[i];
    String sizeLabel = sizeLabels[i];
    Color sizeColor = sizeColors[i];
    double overlap = diameter / 2;

    print('  FAB size: $sizeLabel, overlap: $overlap');

    sizes.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: sizeColor.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: diameter * 0.6, height: diameter * 0.6,
            decoration: BoxDecoration(
              color: sizeColor,
              shape: BoxShape.circle,
            ),
            child: Center(child: Icon(Icons.add, color: Colors.white, size: diameter * 0.3)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sizeLabel, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: sizeColor)),
                SizedBox(height: 4),
                Text('Diameter: ${diameter.toStringAsFixed(0)}px',
                    style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                Text('Overlap into AppBar: ${overlap.toStringAsFixed(0)}px',
                    style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                Text('Top Y = appBarBottom - ${overlap.toStringAsFixed(0)}',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: sizeColor)),
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
      color: Color(0xFFF1F8E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFA5D6A7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Larger FABs overlap more into the AppBar area',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: sizes),
        SizedBox(height: 8),
        buildInfoCard('Formula:', 'topY = appBarBottom - (fabDiameter / 2)'),
      ],
    ),
  );
}

Widget _buildAppBarHeightVariations() {
  print('Building AppBar height variations');
  List<Widget> items = [];

  List<double> appBarHeights = [48.0, 56.0, 72.0, 100.0];
  List<String> heightLabels = ['Compact (48)', 'Default (56)', 'Medium (72)', 'Extended (100)'];

  int i = 0;
  for (; i < 4; i = i + 1) {
    double barHeight = appBarHeights[i];
    String heightLabel = heightLabels[i];
    double scaledHeight = barHeight * 0.5;

    print('  AppBar height variation: $heightLabel');

    items.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Container(
            width: 80, height: scaledHeight + 50,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xFFBDBDBD)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0, left: 0, right: 0, height: scaledHeight,
                  child: Container(
                    color: Color(0xFF7B1FA2),
                    child: Center(child: Text('${barHeight.toStringAsFixed(0)}px', style: TextStyle(color: Colors.white, fontSize: 8))),
                  ),
                ),
                Positioned(
                  top: scaledHeight - 10, right: 4,
                  child: Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF6F00),
                      shape: BoxShape.circle,
                    ),
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
                Text(heightLabel, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(height: 4),
                Text('FAB top Y = ${barHeight.toStringAsFixed(0)} - 28 = ${(barHeight - 28).toStringAsFixed(0)}px',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF7B1FA2))),
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
      color: Color(0xFFFCE4EC),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFF48FB1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AppBar height changes the Y origin for top FAB positions',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
      ],
    ),
  );
}

Widget _buildTopFabWithBodyContent() {
  print('Building top FAB with body content interaction');
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
        Text('Top FAB overlaps body content at the top edge',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Container(
          height: 220,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0, height: 36,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF6A1B9A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                  ),
                  child: Center(child: Text('AppBar', style: TextStyle(color: Colors.white, fontSize: 11))),
                ),
              ),
              Positioned(
                top: 42, left: 12, right: 12,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Body content starts here',
                          style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
                      SizedBox(height: 4),
                      Text('Content may be partially obscured by FAB',
                          style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
                      SizedBox(height: 4),
                      Text('Use padding to avoid overlap',
                          style: TextStyle(fontSize: 10, color: Color(0xFF757575))),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 22, right: 12,
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF5722),
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Color(0x40000000), blurRadius: 6, offset: Offset(0, 3))],
                  ),
                  child: Center(child: Icon(Icons.add, color: Colors.white, size: 20)),
                ),
              ),
              Positioned(
                bottom: 20, left: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tip: Add top padding to body content',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF6A1B9A))),
                    SizedBox(height: 2),
                    Text('padding: EdgeInsets.only(top: fabSize + 8)',
                        style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF424242))),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('Overlap Issue:', 'Top FABs overlap body content - add padding to compensate'),
      ],
    ),
  );
}

Widget _buildMiniFabTopPositions() {
  print('Building mini FAB top positions');
  List<Widget> items = [];

  items.add(Text('MiniStartTop uses a smaller FAB at the start-top position.',
      style: TextStyle(fontSize: 13, color: Color(0xFF424242))));
  items.add(SizedBox(height: 12));

  items.add(Row(
    children: [
      Expanded(
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF81C784)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0, height: 25,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF388E3C),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                  ),
                  child: Center(child: Text('AppBar', style: TextStyle(color: Colors.white, fontSize: 8))),
                ),
              ),
              Positioned(
                top: 16, left: 6,
                child: Container(
                  width: 20, height: 20,
                  decoration: BoxDecoration(
                    color: Color(0xFF388E3C),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(Icons.add, color: Colors.white, size: 10)),
                ),
              ),
              Positioned(
                bottom: 10, left: 6,
                child: Text('miniStartTop', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF388E3C))),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE57373)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0, height: 25,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFC62828),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                  ),
                  child: Center(child: Text('AppBar', style: TextStyle(color: Colors.white, fontSize: 8))),
                ),
              ),
              Positioned(
                top: 16, left: 6,
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFFC62828),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(Icons.add, color: Colors.white, size: 18)),
                ),
              ),
              Positioned(
                bottom: 10, left: 6,
                child: Text('startTop (regular)', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFFC62828))),
              ),
            ],
          ),
        ),
      ),
    ],
  ));

  items.add(SizedBox(height: 8));
  items.add(buildInfoCard('Mini FAB:', 'Smaller diameter (40px vs 56px regular)'));
  items.add(buildInfoCard('Y Overlap:', 'Less overlap into AppBar due to smaller size'));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFA5D6A7)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    ),
  );
}

Widget _buildYOffsetMeasurementDiagram() {
  print('Building Y offset measurement diagram');
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
        Text('Y Offset Measurement Points',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 12),
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0, height: 16,
                child: Container(color: Color(0xFF37474F),
                    child: Center(child: Text('Status Bar', style: TextStyle(color: Colors.white, fontSize: 7)))),
              ),
              Positioned(
                top: 16, left: 0, right: 0, height: 36,
                child: Container(color: Color(0xFF6A1B9A),
                    child: Center(child: Text('AppBar', style: TextStyle(color: Colors.white, fontSize: 10)))),
              ),
              Positioned(
                top: 52, left: 0, right: 0, bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                  ),
                  child: Center(child: Text('Body', style: TextStyle(fontSize: 14, color: Color(0xFFBDBDBD)))),
                ),
              ),
              Positioned(
                top: 38, right: 16,
                child: Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF6F00),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(Icons.add, color: Colors.white, size: 16)),
                ),
              ),
              Positioned(
                top: 80, left: 8, right: 8,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFFFE082)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Measurement Points:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                      SizedBox(height: 4),
                      Text('A. Top of screen = 0', style: TextStyle(fontSize: 10)),
                      Text('B. Bottom of status bar = 24', style: TextStyle(fontSize: 10)),
                      Text('C. Bottom of AppBar = 80', style: TextStyle(fontSize: 10)),
                      Text('D. FAB center Y = 80 (AppBar bottom)', style: TextStyle(fontSize: 10)),
                      Text('E. FAB top edge = 80 - 28 = 52', style: TextStyle(fontSize: 10)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard('getOffsetY:', 'Mixin method returning Y position for top-aligned FAB'),
      ],
    ),
  );
}

Widget _buildAllTopLocationsComparison() {
  print('Building all top locations comparison grid');
  List<Widget> items = [];

  List<String> locationNames = ['startTop', 'centerTop', 'endTop', 'miniStartTop'];
  List<double> xFractions = [0.15, 0.5, 0.85, 0.12];
  List<Color> locationColors = [
    Color(0xFF6A1B9A),
    Color(0xFF00695C),
    Color(0xFFC62828),
    Color(0xFF388E3C),
  ];

  int i = 0;
  for (; i < 4; i = i + 1) {
    print('  Comparison item: ${locationNames[i]}');
    items.add(Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: locationColors[i].withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 60, height: 80,
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xFFBDBDBD)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0, left: 0, right: 0, height: 14,
                  child: Container(
                    decoration: BoxDecoration(
                      color: locationColors[i],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: (60 * xFractions[i]) - 8,
                  top: 8,
                  child: Container(
                    width: 16, height: 16,
                    decoration: BoxDecoration(
                      color: locationColors[i],
                      shape: BoxShape.circle,
                    ),
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
                Text(locationNames[i],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: locationColors[i])),
                SizedBox(height: 2),
                Text('X: ${xFractions[i] < 0.3 ? "start" : xFractions[i] > 0.7 ? "end" : "center"}',
                    style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
                Text('Y: top (below AppBar)',
                    style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
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
      color: Color(0xFFEDE7F6),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB39DDB)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('All four top-aligned FAB locations share the same Y offset calculation',
            style: TextStyle(fontSize: 13, color: Color(0xFF424242))),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 8),
        buildInfoCard('Shared Mixin:', 'FabTopOffsetY provides getOffsetY for all top locations'),
        buildInfoCard('Y Formula:', 'scaffoldGeometry.contentTop - (fabHeight / 2)'),
      ],
    ),
  );
}
