// ignore_for_file: avoid_print
// D4rt test script: Tests FabMiniOffsetAdjustment from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FabMiniOffsetAdjustment Visual Demo ===');
  print(
    'Demonstrating how mini FABs get different offset adjustments than standard FABs',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FabMiniOffsetAdjustment Demo'),
        backgroundColor: Color(0xFF283593),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Mini vs Standard FAB Size'),
            SizedBox(height: 8),
            _buildSizeComparison(),
            SizedBox(height: 24),
            buildSectionHeader('Offset Adjustment Concept'),
            SizedBox(height: 8),
            _buildAdjustmentConcept(),
            SizedBox(height: 24),
            buildSectionHeader('Visual Size Difference'),
            SizedBox(height: 8),
            _buildVisualSizeDifference(),
            SizedBox(height: 24),
            buildSectionHeader('Mini Offset X Adjustments'),
            SizedBox(height: 8),
            _buildMiniOffsetXAdjustments(),
            SizedBox(height: 24),
            buildSectionHeader('Mini Offset Y Adjustments'),
            SizedBox(height: 8),
            _buildMiniOffsetYAdjustments(),
            SizedBox(height: 24),
            buildSectionHeader('All Mini FAB Locations'),
            SizedBox(height: 8),
            _buildAllMiniLocations(),
            SizedBox(height: 24),
            buildSectionHeader('Adjustment Calculation'),
            SizedBox(height: 8),
            _buildAdjustmentCalculation(),
            SizedBox(height: 24),
            buildSectionHeader('Mini FAB in Scaffold Context'),
            SizedBox(height: 8),
            _buildMiniInScaffold(),
            SizedBox(height: 24),
            buildSectionHeader('Side-by-Side Positioning'),
            SizedBox(height: 8),
            _buildSideBySidePositioning(),
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

Widget _buildSizeComparison() {
  print('Building mini vs standard size comparison');
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
        Text(
          'Standard vs Mini FAB Dimensions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFabSizeDisplay('Standard', 56.0, Color(0xFF283593)),
            _buildFabSizeDisplay('Mini', 40.0, Color(0xFF6A1B9A)),
            _buildFabSizeDisplay('Extended', 48.0, Color(0xFF00695C)),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard(
          'Size delta:',
          'Mini is 16px smaller than standard (56 - 40 = 16)',
        ),
        buildInfoCard(
          'Adjustment:',
          'Offset compensation = (standardSize - miniSize) / 2 = 8px',
        ),
      ],
    ),
  );
}

Widget _buildFabSizeDisplay(String label, double size, Color color) {
  return Column(
    children: [
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: size * 0.5),
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
        '${size.toInt()}x${size.toInt()} dp',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: Color(0xFF757575),
        ),
      ),
    ],
  );
}

Widget _buildAdjustmentConcept() {
  print('Building offset adjustment concept');
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
          'Why Mini FABs Need Offset Adjustment',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 12),
        Text(
          'When a mini FAB replaces a standard FAB, the smaller size means the offset calculation from standard locations would place it incorrectly. The adjustment compensates for the size difference.',
          style: TextStyle(fontSize: 13, color: Color(0xFF37474F)),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '// Without adjustment (wrong for mini):',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                'x = (scaffoldWidth - 56) / 2   // uses standard size',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFFEF9A9A),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '// With mini offset adjustment:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                'adjustment = (56 - 40) / 2 = 8.0',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFFA5D6A7),
                ),
              ),
              Text(
                'x = (scaffoldWidth - 40) / 2   // correct for mini',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFF80CBC4),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Key:',
          'The adjustment shifts the offset to account for the smaller FAB radius',
        ),
      ],
    ),
  );
}

Widget _buildVisualSizeDifference() {
  print('Building visual size difference');
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
          'Visual Size Comparison Overlay',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE0E0E0)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Color(0xFF283593).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF283593), width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'Large\n96dp',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF283593),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFFD84315).withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFD84315), width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'Std\n56dp',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9, color: Color(0xFFD84315)),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF6A1B9A).withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF6A1B9A), width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'Mini\n40dp',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 8, color: Color(0xFF6A1B9A)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLegendItem('Large (96dp)', Color(0xFF283593)),
            _buildLegendItem('Standard (56dp)', Color(0xFFD84315)),
            _buildLegendItem('Mini (40dp)', Color(0xFF6A1B9A)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLegendItem(String text, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 4),
      Text(text, style: TextStyle(fontSize: 10, color: color)),
    ],
  );
}

Widget _buildMiniOffsetXAdjustments() {
  print('Building mini offset X adjustments');
  List<Widget> items = [];

  items.add(_buildXAdjustmentRow('centerFloat', 172.0, Color(0xFFD84315)));
  items.add(SizedBox(height: 6));
  items.add(_buildXAdjustmentRow('miniCenterFloat', 180.0, Color(0xFF283593)));
  items.add(SizedBox(height: 6));
  items.add(_buildXAdjustmentRow('endFloat', 328.0, Color(0xFFD84315)));
  items.add(SizedBox(height: 6));
  items.add(_buildXAdjustmentRow('miniEndFloat', 344.0, Color(0xFF283593)));
  items.add(SizedBox(height: 6));
  items.add(_buildXAdjustmentRow('startFloat', 16.0, Color(0xFFD84315)));
  items.add(SizedBox(height: 6));
  items.add(_buildXAdjustmentRow('miniStartFloat', 16.0, Color(0xFF283593)));

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
        Text(
          'X-Axis Offset Adjustments (scaffold=400, padding=16)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 12),
        buildInfoCard(
          'Note:',
          'Center positions shift by (56-40)/2 = 8px for mini',
        ),
      ],
    ),
  );
}

Widget _buildXAdjustmentRow(String name, double standardX, Color color) {
  bool isMini = name.indexOf('mini') >= 0;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: isMini ? Color(0xFFE8EAF6) : Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 10),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Text(
          'x = ${standardX.toStringAsFixed(1)}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF616161),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMiniOffsetYAdjustments() {
  print('Building mini offset Y adjustments');
  List<Widget> items = [];

  items.add(
    _buildYAdjustmentRow(
      'centerFloat Y',
      672.0,
      'Standard FAB float Y',
      Color(0xFFD84315),
    ),
  );
  items.add(SizedBox(height: 6));
  items.add(
    _buildYAdjustmentRow(
      'miniCenterFloat Y',
      680.0,
      'Mini FAB adjusted float Y',
      Color(0xFF283593),
    ),
  );
  items.add(SizedBox(height: 6));
  items.add(
    _buildYAdjustmentRow(
      'centerDocked Y',
      716.0,
      'Standard FAB docked Y',
      Color(0xFFD84315),
    ),
  );
  items.add(SizedBox(height: 6));
  items.add(
    _buildYAdjustmentRow(
      'miniCenterDocked Y',
      724.0,
      'Mini FAB adjusted docked Y',
      Color(0xFF283593),
    ),
  );

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
          'Y-Axis Offset Adjustments (scaffold=800, bar=56)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 12),
        buildInfoCard(
          'Delta:',
          'Mini Y offsets differ by 8px from standard (half the size delta)',
        ),
      ],
    ),
  );
}

Widget _buildYAdjustmentRow(
  String name,
  double yVal,
  String desc,
  Color color,
) {
  bool isMini = name.indexOf('mini') >= 0;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: isMini ? Color(0xFFE8EAF6) : Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        Container(
          width: isMini ? 16 : 22,
          height: isMini ? 16 : 22,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Icon(
              Icons.add,
              color: Color(0xFFFFFFFF),
              size: isMini ? 8 : 11,
            ),
          ),
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
        Text(
          'y = ${yVal.toStringAsFixed(1)}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF616161),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAllMiniLocations() {
  print('Building all mini FAB locations');
  List<Widget> locations = [];

  locations.add(
    _buildMiniLocationRow(
      'miniStartFloat',
      'Start X, floating, mini size',
      Color(0xFF00695C),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildMiniLocationRow(
      'miniStartDocked',
      'Start X, docked, mini size',
      Color(0xFF1565C0),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildMiniLocationRow(
      'miniStartTop',
      'Start X, top, mini size',
      Color(0xFF6A1B9A),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildMiniLocationRow(
      'miniCenterFloat',
      'Center X, floating, mini size',
      Color(0xFFD84315),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildMiniLocationRow(
      'miniCenterDocked',
      'Center X, docked, mini size',
      Color(0xFF283593),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildMiniLocationRow(
      'miniCenterTop',
      'Center X, top, mini size',
      Color(0xFF00897B),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildMiniLocationRow(
      'miniEndFloat',
      'End X, floating, mini size',
      Color(0xFFC62828),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildMiniLocationRow(
      'miniEndDocked',
      'End X, docked, mini size',
      Color(0xFF4527A0),
    ),
  );
  locations.add(SizedBox(height: 4));
  locations.add(
    _buildMiniLocationRow(
      'miniEndTop',
      'End X, top, mini size',
      Color(0xFF795548),
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
          'All Mini FAB Location Variants',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        Column(children: locations),
      ],
    ),
  );
}

Widget _buildMiniLocationRow(String name, String desc, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 9),
          ),
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
        Text(
          'mini',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAdjustmentCalculation() {
  print('Building adjustment calculation');
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
          'Mini Offset Adjustment Formula',
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
                '// FabMiniOffsetAdjustment calculation:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              SizedBox(height: 6),
              Text(
                'standardFabSize = 56.0',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Color(0xFF80CBC4),
                ),
              ),
              Text(
                'miniFabSize = 40.0',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Color(0xFF80CBC4),
                ),
              ),
              Text(
                'adjustment = (standardFabSize - miniFabSize) / 2.0',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Color(0xFFA5D6A7),
                ),
              ),
              Text(
                '// adjustment = (56 - 40) / 2 = 8.0',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFFFFCC80),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '// Applied to base offset:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                'miniOffsetX = baseOffsetX + adjustment',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Color(0xFF80CBC4),
                ),
              ),
              Text(
                'miniOffsetY = baseOffsetY + adjustment',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                  color: Color(0xFF80CBC4),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildCalcRow(
          'standardFabSize',
          '56.0',
          'Standard FAB diameter',
          Color(0xFFD84315),
        ),
        SizedBox(height: 4),
        _buildCalcRow(
          'miniFabSize',
          '40.0',
          'Mini FAB diameter',
          Color(0xFF283593),
        ),
        SizedBox(height: 4),
        _buildCalcRow(
          'sizeDelta',
          '16.0',
          'Difference in diameters',
          Color(0xFF00695C),
        ),
        SizedBox(height: 4),
        _buildCalcRow(
          'adjustment',
          '8.0',
          'Half of size delta',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 8),
        buildInfoCard(
          'Purpose:',
          'Adjustment ensures mini FAB appears at the same visual center as standard',
        ),
      ],
    ),
  );
}

Widget _buildCalcRow(String name, String val, String desc, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.3)),
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
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Container(
          width: 60,
          child: Text(
            val,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
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

Widget _buildMiniInScaffold() {
  print('Building mini FAB in scaffold context');
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
          'Mini FAB in Full Scaffold Layout',
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
                    color: Color(0xFF283593),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Mini FAB App',
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.touch_app, color: Color(0xFF9E9E9E), size: 32),
                      Text(
                        'Tap the mini FAB',
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 11,
                        ),
                      ),
                    ],
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
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                    border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.home, size: 20, color: Color(0xFF283593)),
                      Icon(Icons.search, size: 20, color: Color(0xFF9E9E9E)),
                      Icon(Icons.favorite, size: 20, color: Color(0xFF9E9E9E)),
                      Icon(Icons.person, size: 20, color: Color(0xFF9E9E9E)),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 56,
                right: 16,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF283593),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.edit, color: Color(0xFFFFFFFF), size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Mini FAB:',
          'Compact 40dp button, ideal for secondary actions',
        ),
        buildInfoCard(
          'Offset adjusted:',
          'Position accounts for smaller size via FabMiniOffsetAdjustment',
        ),
      ],
    ),
  );
}

Widget _buildSideBySidePositioning() {
  print('Building side-by-side positioning comparison');
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
          'Standard vs Mini at Same Location',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildPositionCompare('endFloat', Color(0xFFD84315), Color(0xFF283593)),
        SizedBox(height: 12),
        _buildPositionCompare(
          'centerFloat',
          Color(0xFFD84315),
          Color(0xFF283593),
        ),
        SizedBox(height: 12),
        _buildPositionCompare(
          'centerDocked',
          Color(0xFFD84315),
          Color(0xFF283593),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Visual center:',
          'Both sizes share the same visual center point',
        ),
        buildInfoCard(
          'Offset shift:',
          'Mini offset is adjusted so center overlaps with standard center',
        ),
      ],
    ),
  );
}

Widget _buildPositionCompare(String location, Color stdColor, Color miniColor) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Text(
          location,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0xFF37474F),
          ),
        ),
        Expanded(child: SizedBox()),
        Column(
          children: [
            Text('Standard', style: TextStyle(fontSize: 9, color: stdColor)),
            SizedBox(height: 2),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: stdColor.withValues(alpha: 0.3),
                shape: BoxShape.circle,
                border: Border.all(color: stdColor, width: 2),
              ),
              child: Center(child: Icon(Icons.add, color: stdColor, size: 18)),
            ),
          ],
        ),
        SizedBox(width: 16),
        Column(
          children: [
            Text('Mini', style: TextStyle(fontSize: 9, color: miniColor)),
            SizedBox(height: 2),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: miniColor.withValues(alpha: 0.3),
                shape: BoxShape.circle,
                border: Border.all(color: miniColor, width: 2),
              ),
              child: Center(child: Icon(Icons.add, color: miniColor, size: 13)),
            ),
          ],
        ),
        SizedBox(width: 16),
        Column(
          children: [
            Text(
              'Overlap',
              style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
            ),
            SizedBox(height: 2),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: stdColor.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: miniColor.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
      'getOffsetAdjustment',
      'double',
      'Returns offset adjustment for mini size',
      Color(0xFF283593),
    ),
  );
  rows.add(
    _buildApiRow(
      'standardSize',
      'double',
      'Standard FAB diameter (56dp)',
      Color(0xFFD84315),
    ),
  );
  rows.add(
    _buildApiRow(
      'miniSize',
      'double',
      'Mini FAB diameter (40dp)',
      Color(0xFF6A1B9A),
    ),
  );
  rows.add(
    _buildApiRow(
      'isMini',
      'bool',
      'Whether current FAB is mini variant',
      Color(0xFF00695C),
    ),
  );
  rows.add(
    _buildApiRow(
      'adjustment',
      'double',
      'Computed offset shift value',
      Color(0xFFC62828),
    ),
  );
  rows.add(
    _buildApiRow(
      'fabSize',
      'Size',
      'Actual FAB size used for layout',
      Color(0xFF00897B),
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
