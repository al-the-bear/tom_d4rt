// ignore_for_file: avoid_print
// D4rt test script: Tests FabDockedOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FabDockedOffsetY Visual Demo ===');
  print(
    'Demonstrating FAB docked Y offset positioning relative to BottomAppBar',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FabDockedOffsetY Demo'),
        backgroundColor: Color(0xFF00695C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Docked FAB Y-Offset Concept'),
            SizedBox(height: 8),
            _buildDockedConcept(),
            SizedBox(height: 24),
            buildSectionHeader('Y-Offset Value Comparison'),
            SizedBox(height: 8),
            _buildOffsetComparison(),
            SizedBox(height: 24),
            buildSectionHeader('Docked vs Floating Y Position'),
            SizedBox(height: 8),
            _buildDockedVsFloating(),
            SizedBox(height: 24),
            buildSectionHeader('BottomAppBar Notch Integration'),
            SizedBox(height: 8),
            _buildNotchIntegration(),
            SizedBox(height: 24),
            buildSectionHeader('Offset Y Calculation Formula'),
            SizedBox(height: 8),
            _buildCalculationFormula(),
            SizedBox(height: 24),
            buildSectionHeader('Negative Y-Offset Effects'),
            SizedBox(height: 8),
            _buildNegativeOffsetEffects(),
            SizedBox(height: 24),
            buildSectionHeader('Positive Y-Offset Effects'),
            SizedBox(height: 8),
            _buildPositiveOffsetEffects(),
            SizedBox(height: 24),
            buildSectionHeader('FAB Sizes and Docked Y'),
            SizedBox(height: 8),
            _buildFabSizesDockedY(),
            SizedBox(height: 24),
            buildSectionHeader('Scaffold Layout Geometry'),
            SizedBox(height: 8),
            _buildScaffoldLayoutGeometry(),
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

Widget _buildDockedConcept() {
  print('Building docked FAB Y-offset concept');
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
          'How Docked Y-Offset Positions the FAB',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 12),
        Text(
          'The docked Y-offset controls how far the FAB sinks into or rises above the BottomAppBar. A value of 0 means the FAB center aligns with the top edge of the bar.',
          style: TextStyle(fontSize: 13, color: Color(0xFF37474F)),
        ),
        SizedBox(height: 16),
        _buildDockedDiagram(0.0, 'Default (0.0)', Color(0xFF00695C)),
        SizedBox(height: 12),
        _buildDockedDiagram(-8.0, 'Raised (-8.0)', Color(0xFF1565C0)),
        SizedBox(height: 12),
        _buildDockedDiagram(8.0, 'Sunk (+8.0)', Color(0xFFD84315)),
        SizedBox(height: 12),
        buildInfoCard(
          'Mixin:',
          'FabDockedOffsetY provides getDockedY() for vertical positioning',
        ),
      ],
    ),
  );
}

Widget _buildDockedDiagram(double offset, String label, Color fabColor) {
  double fabTop = 30.0 + offset;
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
          height: 100,
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
                height: 18,
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
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 7),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 30,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF546E7A),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'BottomAppBar',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 7),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: fabTop,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: fabColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFFFFFFFF), width: 2),
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
                'Y offset: $offset px',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFF616161),
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: fabColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'getDockedY(offset: $offset)',
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

Widget _buildOffsetComparison() {
  print('Building Y-offset value comparison');
  List<Widget> items = [];
  List<double> offsets = [-16.0, -8.0, -4.0, 0.0, 4.0, 8.0, 16.0];

  int i = 0;
  for (; i < offsets.length; i = i + 1) {
    double val = offsets[i];
    Color barColor = Color(0xFF00695C);
    if (val < 0) {
      barColor = Color(0xFF1565C0);
    }
    if (val > 0) {
      barColor = Color(0xFFD84315);
    }
    items.add(_buildOffsetBar(val, barColor));
    if (i < offsets.length - 1) {
      items.add(SizedBox(height: 4));
    }
  }

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
          'Y-Offset Values from -16 to +16',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 4),
        Text(
          'Negative = FAB rises above bar, Positive = FAB sinks into bar',
          style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
        ),
        SizedBox(height: 16),
        Column(children: items),
        SizedBox(height: 12),
        buildInfoCard(
          'Range:',
          'Typical docked Y offsets are -16 to +16 pixels',
        ),
      ],
    ),
  );
}

Widget _buildOffsetBar(double val, Color color) {
  double normalized = (val + 16.0) / 32.0;
  String offsetLabel = val.toStringAsFixed(1);
  if (val > 0) {
    offsetLabel = '+' + offsetLabel;
  }
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
          width: 60,
          child: Text(
            offsetLabel,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 16,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              widthFactor: normalized,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 10),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDockedVsFloating() {
  print('Building docked vs floating comparison');
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
              border: Border.all(color: Color(0xFF00695C), width: 2),
            ),
            child: Column(
              children: [
                Text(
                  'Docked (Y-Offset)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF00695C),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFE0E0E0)),
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
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'BottomAppBar',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 14,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF00695C),
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
                                size: 20,
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
                  'FAB overlaps BottomAppBar',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
                ),
                Text(
                  'Uses FabDockedOffsetY',
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
              border: Border.all(color: Color(0xFFD84315), width: 2),
            ),
            child: Column(
              children: [
                Text(
                  'Floating (No Dock)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFFD84315),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFE0E0E0)),
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
                            color: Color(0xFF78909C),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'BottomNav',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 42,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFD84315),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Color(0xFFFFFFFF),
                                size: 20,
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
                  'FAB floats above bottom bar',
                  style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
                ),
                Text(
                  'Uses FabFloatOffsetY',
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

Widget _buildNotchIntegration() {
  print('Building notch integration diagram');
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
          'BottomAppBar Notch and Docked FAB',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 28,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF6A1B9A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'AppBar',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 28,
                left: 0,
                right: 0,
                bottom: 40,
                child: Center(
                  child: Text(
                    'Body Content',
                    style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 40,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF37474F),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Icon(Icons.menu, color: Color(0xFFFFFFFF), size: 16),
                      Expanded(child: SizedBox()),
                      Icon(Icons.search, color: Color(0xFFFFFFFF), size: 16),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xFF6A1B9A),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFFFFFFF), width: 3),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFFFFFFF),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Notch:',
          'BottomAppBar shape property creates space around the FAB',
        ),
        buildInfoCard(
          'Y-Offset:',
          'Controls how deep the FAB sits in the notch area',
        ),
        buildInfoCard(
          'Shape:',
          'CircularNotchedRectangle is the standard notch shape',
        ),
      ],
    ),
  );
}

Widget _buildCalculationFormula() {
  print('Building calculation formula');
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
          'getDockedY Calculation',
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
                '// FabDockedOffsetY.getDockedY() calculation:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              SizedBox(height: 6),
              Text(
                'fabY = scaffoldHeight',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Color(0xFF80CBC4),
                ),
              ),
              Text(
                '     - bottomBarHeight',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Color(0xFF80CBC4),
                ),
              ),
              Text(
                '     - fabHeight / 2.0',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Color(0xFF80CBC4),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '// Example: scaffold=800, bar=56, fab=56:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                'fabY = 800 - 56 - 56/2 = 716.0',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFFFFCC80),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildCalculationRow(
          'scaffoldHeight',
          '800.0',
          'Total scaffold height',
          Color(0xFF00695C),
        ),
        SizedBox(height: 4),
        _buildCalculationRow(
          'bottomBarHeight',
          '56.0',
          'BottomAppBar height',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 4),
        _buildCalculationRow(
          'fabHeight',
          '56.0',
          'Standard FAB height',
          Color(0xFFD84315),
        ),
        SizedBox(height: 4),
        _buildCalculationRow(
          'fabY result',
          '716.0',
          'FAB top-left Y position',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 8),
        buildInfoCard(
          'Key:',
          'The FAB center aligns with the top edge of BottomAppBar',
        ),
      ],
    ),
  );
}

Widget _buildCalculationRow(String name, String val, String desc, Color color) {
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

Widget _buildNegativeOffsetEffects() {
  print('Building negative Y-offset effects');
  List<Widget> cards = [];
  List<double> negativeOffsets = [-4.0, -8.0, -12.0, -20.0];

  int i = 0;
  for (; i < negativeOffsets.length; i = i + 1) {
    double offset = negativeOffsets[i];
    double raisePx = 0.0 - offset;
    cards.add(
      _buildOffsetEffectCard(
        offset,
        'Raised ${raisePx.toStringAsFixed(0)}px above default',
        'FAB moves upward, more visible above the bar',
        Color(0xFF1565C0),
      ),
    );
    if (i < negativeOffsets.length - 1) {
      cards.add(SizedBox(height: 8));
    }
  }

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
          'Negative Offsets: FAB Rises Above Bar',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 4),
        Text(
          'Negative Y-offset moves the FAB upward, away from the bar',
          style: TextStyle(fontSize: 12, color: Color(0xFF546E7A)),
        ),
        SizedBox(height: 16),
        Column(children: cards),
        SizedBox(height: 12),
        buildInfoCard(
          'Use case:',
          'Negative offsets make the FAB more prominent and easier to tap',
        ),
      ],
    ),
  );
}

Widget _buildOffsetEffectCard(
  double offset,
  String summary,
  String detail,
  Color color,
) {
  String sign = '';
  if (offset > 0) {
    sign = '+';
  }
  double fabBottom = 16.0 - offset;
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 18,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF546E7A),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: fabBottom,
                left: 22,
                right: 22,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
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
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$sign${offset.toStringAsFixed(1)} px',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: color,
                ),
              ),
              SizedBox(height: 2),
              Text(
                summary,
                style: TextStyle(fontSize: 12, color: Color(0xFF37474F)),
              ),
              Text(
                detail,
                style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPositiveOffsetEffects() {
  print('Building positive Y-offset effects');
  List<Widget> cards = [];
  List<double> positiveOffsets = [4.0, 8.0, 12.0, 20.0];

  int i = 0;
  for (; i < positiveOffsets.length; i = i + 1) {
    double offset = positiveOffsets[i];
    cards.add(
      _buildOffsetEffectCard(
        offset,
        'Pushed ${offset.toStringAsFixed(0)}px into the bar',
        'FAB sinks deeper into the BottomAppBar notch',
        Color(0xFFD84315),
      ),
    );
    if (i < positiveOffsets.length - 1) {
      cards.add(SizedBox(height: 8));
    }
  }

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
          'Positive Offsets: FAB Sinks Into Bar',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 4),
        Text(
          'Positive Y-offset pushes the FAB downward into the bar area',
          style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
        ),
        SizedBox(height: 16),
        Column(children: cards),
        SizedBox(height: 12),
        buildInfoCard(
          'Use case:',
          'Positive offsets create a more flush look with the bar',
        ),
      ],
    ),
  );
}

Widget _buildFabSizesDockedY() {
  print('Building FAB sizes and docked Y');
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
          'FAB Size Impact on Docked Y Position',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSizeDockedCard('Standard', 56.0, Color(0xFF00695C)),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildSizeDockedCard('Mini', 40.0, Color(0xFF6A1B9A)),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildSizeDockedCard('Large', 96.0, Color(0xFFD84315)),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard(
          'Standard:',
          'scaffoldH - barH - (56 / 2) = default docked Y',
        ),
        buildInfoCard(
          'Mini:',
          'scaffoldH - barH - (40 / 2) = higher starting position',
        ),
        buildInfoCard(
          'Large:',
          'scaffoldH - barH - (96 / 2) = lower starting position',
        ),
      ],
    ),
  );
}

Widget _buildSizeDockedCard(String label, double size, Color color) {
  double halfSize = size / 2.0;
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 24,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF546E7A),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: size * 0.5,
                    height: size * 0.5,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFFFFFFF), width: 2),
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
          '${size.toInt()}px',
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
        ),
        Text(
          'half: ${halfSize.toStringAsFixed(0)}px',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: Color(0xFF9E9E9E),
          ),
        ),
      ],
    ),
  );
}

Widget _buildScaffoldLayoutGeometry() {
  print('Building scaffold layout geometry');
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
          'ScaffoldPrelayoutGeometry for Docked Y',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD), width: 2),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 30,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF455A64),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'scaffoldSize.height (top)',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 9),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 0,
                right: 0,
                bottom: 40,
                child: Container(
                  color: Color(0xFFF5F5F5),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.straighten,
                          color: Color(0xFF9E9E9E),
                          size: 24,
                        ),
                        Text(
                          'contentBottom',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 40,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF37474F),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'bottomBarHeight',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 9),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xFF00695C),
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFFFFFFFF), width: 3),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFFFFFFF),
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 4,
                top: 36,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  color: Color(0xFFFFEB3B).withValues(alpha: 0.8),
                  child: Text(
                    'fabY',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 8,
                      color: Color(0xFF37474F),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'scaffoldSize:',
          'Full scaffold dimensions from geometry',
        ),
        buildInfoCard(
          'bottomBarHeight:',
          'Height of BottomAppBar used in Y calculation',
        ),
        buildInfoCard(
          'fabSize:',
          'FAB dimensions needed to compute docked center',
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
      'getDockedY',
      'double',
      'Returns Y offset for docked FAB position',
      Color(0xFF00695C),
    ),
  );
  rows.add(
    _buildApiRow(
      'scaffoldGeometry',
      'ScaffoldPrelayoutGeometry',
      'Input: scaffold layout data',
      Color(0xFF1565C0),
    ),
  );
  rows.add(
    _buildApiRow(
      'adjustment',
      'double',
      'Additional Y offset adjustment value',
      Color(0xFFD84315),
    ),
  );
  rows.add(
    _buildApiRow(
      'bottomBarHeight',
      'double',
      'Height of BottomAppBar',
      Color(0xFF6A1B9A),
    ),
  );
  rows.add(
    _buildApiRow(
      'fabHeight',
      'double',
      'FAB height for centering calc',
      Color(0xFFC62828),
    ),
  );
  rows.add(
    _buildApiRow(
      'scaffoldHeight',
      'double',
      'Total scaffold height dimension',
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
