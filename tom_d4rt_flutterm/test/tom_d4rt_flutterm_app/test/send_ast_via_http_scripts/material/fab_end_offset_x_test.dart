// D4rt test script: Tests FabEndOffsetX from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FabEndOffsetX Visual Demo ===');
  print(
    'Demonstrating FAB end X offset positioning for endDocked and endFloat',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FabEndOffsetX Demo'),
        backgroundColor: Color(0xFF4527A0),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('End-Aligned FAB Positions'),
            SizedBox(height: 8),
            _buildEndAlignedPositions(),
            SizedBox(height: 24),
            buildSectionHeader('EndFloat vs EndDocked'),
            SizedBox(height: 8),
            _buildEndFloatVsDocked(),
            SizedBox(height: 24),
            buildSectionHeader('X-Offset Calculation'),
            SizedBox(height: 8),
            _buildXOffsetCalculation(),
            SizedBox(height: 24),
            buildSectionHeader('LTR vs RTL End Position'),
            SizedBox(height: 8),
            _buildLtrVsRtl(),
            SizedBox(height: 24),
            buildSectionHeader('End Offset at Different Widths'),
            SizedBox(height: 8),
            _buildEndOffsetWidths(),
            SizedBox(height: 24),
            buildSectionHeader('End Position with BottomAppBar'),
            SizedBox(height: 8),
            _buildEndWithBottomAppBar(),
            SizedBox(height: 24),
            buildSectionHeader('Padding and Safe Area Effects'),
            SizedBox(height: 8),
            _buildPaddingAndSafeArea(),
            SizedBox(height: 24),
            buildSectionHeader('Mini FAB End Positions'),
            SizedBox(height: 8),
            _buildMiniFabEndPositions(),
            SizedBox(height: 24),
            buildSectionHeader('End Position Enum Values'),
            SizedBox(height: 8),
            _buildEndPositionEnumValues(),
            SizedBox(height: 24),
            buildSectionHeader('Properties and API'),
            SizedBox(height: 8),
            _buildPropertiesAndApi(),
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

Widget _buildEndAlignedPositions() {
  print('Building end-aligned FAB positions');
  List<Widget> items = [];

  items.add(_buildEndDiagram('endFloat', 0.88, 0.7, Color(0xFF4527A0), false));
  items.add(SizedBox(height: 12));
  items.add(_buildEndDiagram('endDocked', 0.88, 0.92, Color(0xFF00897B), true));
  items.add(SizedBox(height: 12));
  items.add(_buildEndDiagram('endTop', 0.88, 0.12, Color(0xFFD84315), false));

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
        Text(
          'Three End-Aligned FAB Locations',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 12),
        buildInfoCard(
          'FabEndOffsetX:',
          'Mixin providing getOffsetX for end-alignment',
        ),
      ],
    ),
  );
}

Widget _buildEndDiagram(
  String label,
  double xFraction,
  double yFraction,
  Color fabColor,
  bool docked,
) {
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
          width: 120,
          height: 160,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 24,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF455A64),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'AppBar',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 8),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF78909C),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'BottomBar',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 7),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: (120 * xFraction) - 14,
                top: (160 * yFraction) - 14,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: fabColor,
                    shape: BoxShape.circle,
                    border: docked
                        ? Border.all(color: Color(0xFFFFFFFF), width: 2)
                        : null,
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 14),
                  ),
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
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: fabColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'X offset: scaffoldWidth - fabWidth - padding',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF616161),
                ),
              ),
              SizedBox(height: 4),
              Text(
                docked
                    ? 'Docked into bottom bar at end'
                    : 'Floating at end position',
                style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: fabColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'FloatingActionButtonLocation.$label',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    color: fabColor,
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

Widget _buildEndFloatVsDocked() {
  print('Building endFloat vs endDocked comparison');
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
              border: Border.all(color: Color(0xFF4527A0), width: 2),
            ),
            child: Column(
              children: [
                Text(
                  'endFloat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF4527A0),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 24,
                        right: 8,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFF4527A0),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFFFFFFFF),
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 16,
                        child: Container(
                          color: Color(0xFF78909C),
                          child: Center(
                            child: Text(
                              'BottomNav',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 7,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'FAB floats at end, above bar',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
                ),
                Text(
                  'Standard 16px end margin',
                  style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                ),
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
                Text(
                  'endDocked',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF00897B),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 4,
                        right: 8,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFF00897B),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFFFFFFFF),
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFFFFFFFF),
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 16,
                        child: Container(
                          color: Color(0xFF78909C),
                          child: Center(
                            child: Text(
                              'BottomAppBar',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 7,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'FAB docked at end into bar',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
                ),
                Text(
                  'Notch at trailing edge',
                  style: TextStyle(fontSize: 11, color: Color(0xFF9E9E9E)),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildXOffsetCalculation() {
  print('Building X-offset calculation');
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
        Text(
          'FabEndOffsetX.getOffsetX Formula',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
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
              Text(
                '// LTR (Left-to-Right) layout:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                'x = scaffoldWidth - fabWidth - endPadding',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Color(0xFF80CBC4),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '// RTL (Right-to-Left) layout:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                'x = endPadding',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Color(0xFFFFCC80),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '// Example LTR: scaffold=400, fab=56, padding=16:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                'x = 400 - 56 - 16 = 328.0',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFFA5D6A7),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 80,
          width: double.infinity,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 2,
                left: 2,
                right: 2,
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Color(0xFF90CAF9).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      'scaffoldWidth',
                      style: TextStyle(fontSize: 8, color: Color(0xFF1565C0)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 22,
                left: 2,
                child: Container(
                  height: 14,
                  width: 240,
                  decoration: BoxDecoration(
                    color: Color(0xFFA5D6A7).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      'body content area',
                      style: TextStyle(fontSize: 7, color: Color(0xFF2E7D32)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 22,
                right: 48,
                child: Container(
                  height: 14,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF4527A0).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      'FAB',
                      style: TextStyle(fontSize: 7, color: Color(0xFF4527A0)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 22,
                right: 2,
                child: Container(
                  height: 14,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFAB91).withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      'pad',
                      style: TextStyle(fontSize: 7, color: Color(0xFFD84315)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 46,
                right: 52,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: Color(0xFF4527A0),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard(
          'Key:',
          'End-aligned FAB sits at scaffoldWidth minus FAB width minus padding',
        ),
      ],
    ),
  );
}

Widget _buildLtrVsRtl() {
  print('Building LTR vs RTL comparison');
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
        Text(
          'End Position in LTR vs RTL Layouts',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildDirectionDiagram('LTR (Left-to-Right)', true, Color(0xFF4527A0)),
        SizedBox(height: 12),
        _buildDirectionDiagram('RTL (Right-to-Left)', false, Color(0xFFD84315)),
        SizedBox(height: 12),
        buildInfoCard(
          'LTR End:',
          'Right side of scaffold (standard Western layout)',
        ),
        buildInfoCard(
          'RTL End:',
          'Left side of scaffold (Arabic, Hebrew layout)',
        ),
        buildInfoCard(
          'Impact:',
          'getOffsetX considers TextDirection for correct end placement',
        ),
      ],
    ),
  );
}

Widget _buildDirectionDiagram(String label, bool isLtr, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isLtr
                  ? Icons.format_textdirection_l_to_r
                  : Icons.format_textdirection_r_to_l,
              color: color,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 8,
                top: 8,
                child: Text(
                  isLtr ? 'Start' : 'End',
                  style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Text(
                  isLtr ? 'End' : 'Start',
                  style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
                ),
              ),
              Positioned(
                left: isLtr ? null : 12,
                right: isLtr ? 12 : null,
                top: 8,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 16),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 2,
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isLtr ? Icons.arrow_forward : Icons.arrow_back,
                        size: 10,
                        color: Color(0xFF9E9E9E),
                      ),
                      Text(
                        isLtr
                            ? ' Text direction: LTR '
                            : ' Text direction: RTL ',
                        style: TextStyle(fontSize: 8, color: Color(0xFF9E9E9E)),
                      ),
                      Icon(
                        isLtr ? Icons.arrow_forward : Icons.arrow_back,
                        size: 10,
                        color: Color(0xFF9E9E9E),
                      ),
                    ],
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

Widget _buildEndOffsetWidths() {
  print('Building end offset at different widths');
  List<Widget> rows = [];

  rows.add(_buildWidthRow('Narrow (320)', 320, 56, 16, Color(0xFFF44336)));
  rows.add(SizedBox(height: 6));
  rows.add(_buildWidthRow('Phone (375)', 375, 56, 16, Color(0xFFFF9800)));
  rows.add(SizedBox(height: 6));
  rows.add(_buildWidthRow('Tablet (768)', 768, 56, 16, Color(0xFF4CAF50)));
  rows.add(SizedBox(height: 6));
  rows.add(_buildWidthRow('Desktop (1200)', 1200, 56, 16, Color(0xFF2196F3)));

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
        Text(
          'End X Offset at various scaffold widths (LTR)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildWidthRow(
  String label,
  int scaffoldW,
  int fabW,
  int padding,
  Color color,
) {
  double offset = (scaffoldW - fabW - padding).toDouble();
  double fraction = offset / scaffoldW;
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
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: color,
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              'offsetX = ${offset.toStringAsFixed(1)}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFF616161),
              ),
            ),
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
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'FAB starts at ${(fraction * 100).toStringAsFixed(1)}% from left',
          style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
        ),
      ],
    ),
  );
}

Widget _buildEndWithBottomAppBar() {
  print('Building end position with BottomAppBar');
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
        Text(
          'End-Docked FAB with BottomAppBar Pattern',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD), width: 2),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 36,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF4527A0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'My App',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 36,
                left: 0,
                right: 0,
                bottom: 44,
                child: Center(
                  child: Text(
                    'Content Area',
                    style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 44,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF37474F),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 16),
                      Icon(Icons.menu, color: Color(0xFFFFFFFF), size: 18),
                      SizedBox(width: 16),
                      Icon(Icons.search, color: Color(0xFFFFFFFF), size: 18),
                      SizedBox(width: 16),
                      Icon(Icons.more_vert, color: Color(0xFFFFFFFF), size: 18),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 22,
                right: 16,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Color(0xFF4527A0),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFFFFFFF), width: 3),
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 28),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Pattern:',
          'endDocked FAB with BottomAppBar gives leading actions space',
        ),
        buildInfoCard(
          'X Position:',
          'Calculated by FabEndOffsetX.getOffsetX()',
        ),
        buildInfoCard(
          'Benefit:',
          'Menu items on the left, FAB on the right for easy access',
        ),
      ],
    ),
  );
}

Widget _buildPaddingAndSafeArea() {
  print('Building padding and safe area effects');
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
        Text(
          'End Padding and Safe Area Considerations',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildPaddingRow('Default padding', 16, Color(0xFF4527A0)),
        SizedBox(height: 8),
        _buildPaddingRow('Safe area inset (notch)', 32, Color(0xFFD84315)),
        SizedBox(height: 8),
        _buildPaddingRow('Landscape safe area', 44, Color(0xFF00695C)),
        SizedBox(height: 8),
        _buildPaddingRow('Minimal padding', 8, Color(0xFF1565C0)),
        SizedBox(height: 12),
        buildInfoCard(
          'Safe Area:',
          'End offset accounts for device safe area insets',
        ),
        buildInfoCard(
          'Standard:',
          'Default end padding is typically 16dp from scaffold edge',
        ),
      ],
    ),
  );
}

Widget _buildPaddingRow(String label, int padding, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        Container(
          width: 140,
          height: 36,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Stack(
            children: [
              Positioned(
                right: (padding * 0.6).toDouble(),
                top: 4,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 10),
                  ),
                ),
              ),
              Positioned(
                right: 2,
                top: 10,
                child: Container(
                  width: (padding * 0.6).toDouble(),
                  height: 1,
                  color: Color(0xFFE57373),
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
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: color,
                ),
              ),
              Text(
                '${padding}dp end inset',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF757575),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMiniFabEndPositions() {
  print('Building mini FAB end positions');
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
        Text(
          'Mini FAB End Variants',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFabEndSizeCard('Standard', 56, Color(0xFF4527A0)),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildFabEndSizeCard('Mini', 40, Color(0xFF6A1B9A)),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('miniEndFloat:', 'Mini FAB floating at end position'),
        buildInfoCard('miniEndDocked:', 'Mini FAB docked at end position'),
        buildInfoCard(
          'Calculation:',
          'Same formula but with smaller fabWidth (40 instead of 56)',
        ),
      ],
    ),
  );
}

Widget _buildFabEndSizeCard(String label, double size, Color color) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  width: size * 0.5,
                  height: size * 0.5,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Color(0xFFFFFFFF),
                      size: size * 0.25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: color,
          ),
        ),
        Text(
          '${size.toInt()}x${size.toInt()} px',
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

Widget _buildEndPositionEnumValues() {
  print('Building end position enum values');
  List<Widget> locations = [];

  locations.add(
    _buildLocationRow(
      'endFloat',
      'End X, floating above bottom',
      true,
      Color(0xFF4527A0),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'endDocked',
      'End X, docked into bottom bar',
      true,
      Color(0xFF00897B),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'endTop',
      'End X, top of body area',
      true,
      Color(0xFFD84315),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'miniEndFloat',
      'End X, mini size, floating',
      true,
      Color(0xFF6A1B9A),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'miniEndDocked',
      'End X, mini size, docked',
      true,
      Color(0xFF283593),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'miniEndTop',
      'End X, mini size, top',
      true,
      Color(0xFF00695C),
    ),
  );
  locations.add(SizedBox(height: 10));
  locations.add(
    _buildLocationRow(
      'centerFloat',
      'Center X (NOT end)',
      false,
      Color(0xFF757575),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'startFloat',
      'Start X (NOT end)',
      false,
      Color(0xFF757575),
    ),
  );

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
        Text(
          'FAB Location values using FabEndOffsetX',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Column(children: locations),
      ],
    ),
  );
}

Widget _buildLocationRow(String name, String desc, bool usesEnd, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: usesEnd ? color.withValues(alpha: 0.06) : Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: usesEnd ? color : Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Icon(
          usesEnd ? Icons.check_circle : Icons.cancel,
          color: usesEnd ? color : Color(0xFFBDBDBD),
          size: 18,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPropertiesAndApi() {
  print('Building properties and API');
  List<Widget> rows = [];
  rows.add(
    _buildApiRow(
      'getOffsetX',
      'double',
      'Returns X offset for end-aligned FAB',
      Color(0xFF4527A0),
    ),
  );
  rows.add(
    _buildApiRow(
      'scaffoldGeometry',
      'ScaffoldPrelayoutGeometry',
      'Input: scaffold layout info',
      Color(0xFF00897B),
    ),
  );
  rows.add(
    _buildApiRow(
      'textDirection',
      'TextDirection',
      'LTR or RTL for correct end side',
      Color(0xFFD84315),
    ),
  );
  rows.add(
    _buildApiRow(
      'adjustment',
      'double',
      'Additional offset adjustment',
      Color(0xFF1565C0),
    ),
  );
  rows.add(
    _buildApiRow(
      'endPadding',
      'double',
      'Padding from scaffold edge',
      Color(0xFF6A1B9A),
    ),
  );
  rows.add(
    _buildApiRow(
      'safeAreaInset',
      'double',
      'Device safe area consideration',
      Color(0xFFC62828),
    ),
  );

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
            Expanded(
              flex: 3,
              child: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            Expanded(
              flex: 3,
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
        Divider(color: Color(0xFFBDBDBD)),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildApiRow(String name, String type, String desc, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            type,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: Color(0xFF616161),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            desc,
            style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
          ),
        ),
      ],
    ),
  );
}
