// ignore_for_file: avoid_print
// D4rt test script: Tests FabStartOffsetX from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FabStartOffsetX Visual Demo ===');
  print(
    'Demonstrating FAB start X offset positioning for startDocked and startFloat',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FabStartOffsetX Demo'),
        backgroundColor: Color(0xFF1B5E20),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Start-Aligned FAB Positions'),
            SizedBox(height: 8),
            _buildStartAlignedPositions(),
            SizedBox(height: 24),
            buildSectionHeader('StartFloat vs StartDocked'),
            SizedBox(height: 8),
            _buildStartFloatVsDocked(),
            SizedBox(height: 24),
            buildSectionHeader('X-Offset Calculation'),
            SizedBox(height: 8),
            _buildXOffsetCalculation(),
            SizedBox(height: 24),
            buildSectionHeader('LTR vs RTL Start Position'),
            SizedBox(height: 8),
            _buildLtrVsRtl(),
            SizedBox(height: 24),
            buildSectionHeader('Start Offset at Different Widths'),
            SizedBox(height: 8),
            _buildStartOffsetWidths(),
            SizedBox(height: 24),
            buildSectionHeader('Start Position with BottomAppBar'),
            SizedBox(height: 8),
            _buildStartWithBottomAppBar(),
            SizedBox(height: 24),
            buildSectionHeader('Start and End Comparison'),
            SizedBox(height: 8),
            _buildStartEndComparison(),
            SizedBox(height: 24),
            buildSectionHeader('Mini FAB Start Positions'),
            SizedBox(height: 8),
            _buildMiniFabStartPositions(),
            SizedBox(height: 24),
            buildSectionHeader('Start Position Enum Values'),
            SizedBox(height: 8),
            _buildStartPositionEnumValues(),
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

Widget _buildStartAlignedPositions() {
  print('Building start-aligned FAB positions');
  List<Widget> items = [];

  items.add(
    _buildStartDiagram('startFloat', 0.12, 0.7, Color(0xFF1B5E20), false),
  );
  items.add(SizedBox(height: 12));
  items.add(
    _buildStartDiagram('startDocked', 0.12, 0.92, Color(0xFF00897B), true),
  );
  items.add(SizedBox(height: 12));
  items.add(
    _buildStartDiagram('startTop', 0.12, 0.12, Color(0xFFD84315), false),
  );

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
          'Three Start-Aligned FAB Locations',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 12),
        buildInfoCard(
          'FabStartOffsetX:',
          'Mixin providing getOffsetX for start-alignment',
        ),
      ],
    ),
  );
}

Widget _buildStartDiagram(
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
                'X offset: startPadding (typically 16dp)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF616161),
                ),
              ),
              SizedBox(height: 4),
              Text(
                docked
                    ? 'Docked into bottom bar at start'
                    : 'Floating at start position',
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

Widget _buildStartFloatVsDocked() {
  print('Building startFloat vs startDocked comparison');
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
              border: Border.all(color: Color(0xFF1B5E20), width: 2),
            ),
            child: Column(
              children: [
                Text(
                  'startFloat',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1B5E20),
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
                        left: 8,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFF1B5E20),
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
                  'FAB floats at start, above bar',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
                ),
                Text(
                  'Standard start margin',
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
                  'startDocked',
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
                        left: 8,
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
                  'FAB docked at start into bar',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
                ),
                Text(
                  'Notch at leading edge',
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
          'FabStartOffsetX.getOffsetX Formula',
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
                'x = startPadding',
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
                'x = scaffoldWidth - fabWidth - startPadding',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Color(0xFFFFCC80),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '// Example LTR: padding=16:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                'x = 16.0',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFFA5D6A7),
                ),
              ),
              SizedBox(height: 4),
              Text(
                '// Example RTL: scaffold=400, fab=56, padding=16:',
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
          height: 70,
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
                top: 22,
                left: 48,
                child: Container(
                  height: 14,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF1B5E20).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      'FAB',
                      style: TextStyle(fontSize: 7, color: Color(0xFF1B5E20)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 22,
                left: 92,
                child: Container(
                  height: 14,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFFA5D6A7).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Text(
                      'remaining content area',
                      style: TextStyle(fontSize: 7, color: Color(0xFF2E7D32)),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 42,
                left: 52,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Color(0xFF1B5E20),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        buildInfoCard(
          'Key:',
          'Start position is simply the padding value in LTR layout',
        ),
      ],
    ),
  );
}

Widget _buildLtrVsRtl() {
  print('Building LTR vs RTL start position');
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
          'Start Position in LTR vs RTL Layouts',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildDirectionDiagram('LTR (Left-to-Right)', true, Color(0xFF1B5E20)),
        SizedBox(height: 12),
        _buildDirectionDiagram('RTL (Right-to-Left)', false, Color(0xFFD84315)),
        SizedBox(height: 12),
        buildInfoCard(
          'LTR Start:',
          'Left side of scaffold (standard Western layout)',
        ),
        buildInfoCard(
          'RTL Start:',
          'Right side of scaffold (Arabic, Hebrew layout)',
        ),
        buildInfoCard(
          'Opposite of End:',
          'Start is always the opposite side from End',
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
                left: isLtr ? 12 : null,
                right: isLtr ? null : 12,
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

Widget _buildStartOffsetWidths() {
  print('Building start offset at different widths');
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
          'Start offset stays constant regardless of scaffold width (LTR)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Column(children: rows),
        SizedBox(height: 8),
        buildInfoCard(
          'Constant:',
          'Start X = 16dp for all widths in LTR (padding only)',
        ),
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
  double fraction = (padding + fabW) / scaffoldW.toDouble();
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
              'offsetX = ${padding.toDouble().toStringAsFixed(1)}',
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
                color: color.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'FAB occupies ${(fraction * 100).toStringAsFixed(1)}% from start',
          style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
        ),
      ],
    ),
  );
}

Widget _buildStartWithBottomAppBar() {
  print('Building start position with BottomAppBar');
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
          'Start-Docked FAB with BottomAppBar Pattern',
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
                    color: Color(0xFF1B5E20),
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
                      Expanded(child: SizedBox()),
                      Icon(Icons.search, color: Color(0xFFFFFFFF), size: 18),
                      SizedBox(width: 16),
                      Icon(Icons.bookmark, color: Color(0xFFFFFFFF), size: 18),
                      SizedBox(width: 16),
                      Icon(Icons.more_vert, color: Color(0xFFFFFFFF), size: 18),
                      SizedBox(width: 16),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 22,
                left: 16,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Color(0xFF1B5E20),
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
          'startDocked FAB with actions on the trailing side',
        ),
        buildInfoCard(
          'X Position:',
          'Calculated by FabStartOffsetX.getOffsetX()',
        ),
        buildInfoCard(
          'Use case:',
          'Primary action on the start side for left-handed users',
        ),
      ],
    ),
  );
}

Widget _buildStartEndComparison() {
  print('Building start and end comparison');
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
        Text(
          'Start vs End FAB Positioning',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD), width: 2),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 30,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF546E7A),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'BottomAppBar',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 9),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF1B5E20),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFFFFFFF), width: 2),
                  ),
                  child: Center(
                    child: Text(
                      'S',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFF1565C0),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFFFFFFF), width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFD84315),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFFFFFFF), width: 2),
                  ),
                  child: Center(
                    child: Text(
                      'E',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
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
            _buildPositionLegend('S', 'Start', Color(0xFF1B5E20)),
            SizedBox(width: 16),
            _buildPositionLegend('C', 'Center', Color(0xFF1565C0)),
            SizedBox(width: 16),
            _buildPositionLegend('E', 'End', Color(0xFFD84315)),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Start:',
          'X = padding (LTR) or scaffoldWidth - fabWidth - padding (RTL)',
        ),
        buildInfoCard('Center:', 'X = (scaffoldWidth - fabWidth) / 2'),
        buildInfoCard(
          'End:',
          'X = scaffoldWidth - fabWidth - padding (LTR) or padding (RTL)',
        ),
      ],
    ),
  );
}

Widget _buildPositionLegend(String letter, String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(width: 4),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget _buildMiniFabStartPositions() {
  print('Building mini FAB start positions');
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
          'Mini FAB Start Variants',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFabStartSizeCard('Standard', 56, Color(0xFF1B5E20)),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildFabStartSizeCard('Mini', 40, Color(0xFF6A1B9A)),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('miniStartFloat:', 'Mini FAB floating at start position'),
        buildInfoCard('miniStartDocked:', 'Mini FAB docked at start position'),
        buildInfoCard(
          'Start padding:',
          'Same start padding applies, only FAB width differs',
        ),
      ],
    ),
  );
}

Widget _buildFabStartSizeCard(String label, double size, Color color) {
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
                left: 8,
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

Widget _buildStartPositionEnumValues() {
  print('Building start position enum values');
  List<Widget> locations = [];

  locations.add(
    _buildLocationRow(
      'startFloat',
      'Start X, floating above bottom',
      true,
      Color(0xFF1B5E20),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'startDocked',
      'Start X, docked into bottom bar',
      true,
      Color(0xFF00897B),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'startTop',
      'Start X, top of body area',
      true,
      Color(0xFFD84315),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'miniStartFloat',
      'Start X, mini size, floating',
      true,
      Color(0xFF6A1B9A),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'miniStartDocked',
      'Start X, mini size, docked',
      true,
      Color(0xFF283593),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'miniStartTop',
      'Start X, mini size, top',
      true,
      Color(0xFF00695C),
    ),
  );
  locations.add(SizedBox(height: 10));
  locations.add(
    _buildLocationRow(
      'centerFloat',
      'Center X (NOT start)',
      false,
      Color(0xFF757575),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildLocationRow(
      'endFloat',
      'End X (NOT start)',
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
          'FAB Location values using FabStartOffsetX',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Column(children: locations),
      ],
    ),
  );
}

Widget _buildLocationRow(
  String name,
  String desc,
  bool usesStart,
  Color color,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: usesStart ? color.withValues(alpha: 0.06) : Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: usesStart ? color : Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Icon(
          usesStart ? Icons.check_circle : Icons.cancel,
          color: usesStart ? color : Color(0xFFBDBDBD),
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
      'Returns X offset for start-aligned FAB',
      Color(0xFF1B5E20),
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
      'LTR or RTL for correct start side',
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
      'startPadding',
      'double',
      'Padding from scaffold start edge',
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
