// ignore_for_file: avoid_print
// D4rt test script: Tests FabFloatOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FabFloatOffsetY Visual Demo ===');
  print(
    'Demonstrating FAB floating Y offset above BottomNavigationBar or BottomAppBar',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FabFloatOffsetY Demo'),
        backgroundColor: Color(0xFFBF360C),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Float Y-Offset Concept'),
            SizedBox(height: 8),
            _buildFloatConcept(),
            SizedBox(height: 24),
            buildSectionHeader('Float Height Comparison'),
            SizedBox(height: 8),
            _buildFloatHeightComparison(),
            SizedBox(height: 24),
            buildSectionHeader('Floating vs Docked Y Position'),
            SizedBox(height: 8),
            _buildFloatingVsDocked(),
            SizedBox(height: 24),
            buildSectionHeader('Float Y with BottomNavigationBar'),
            SizedBox(height: 8),
            _buildFloatWithBottomNav(),
            SizedBox(height: 24),
            buildSectionHeader('Float Y Offset Calculation'),
            SizedBox(height: 8),
            _buildCalculationFormula(),
            SizedBox(height: 24),
            buildSectionHeader('Different Float Heights'),
            SizedBox(height: 8),
            _buildDifferentFloatHeights(),
            SizedBox(height: 24),
            buildSectionHeader('Float Y with Large FAB'),
            SizedBox(height: 8),
            _buildFloatWithLargeFab(),
            SizedBox(height: 24),
            buildSectionHeader('BottomAppBar vs BottomNavigationBar'),
            SizedBox(height: 8),
            _buildBarTypeComparison(),
            SizedBox(height: 24),
            buildSectionHeader('Visual Spacing Guide'),
            SizedBox(height: 8),
            _buildVisualSpacingGuide(),
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

Widget _buildFloatConcept() {
  print('Building float Y-offset concept');
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
          'How Floating Y-Offset Works',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 12),
        Text(
          'The float Y-offset determines how high the FAB hovers above the bottom navigation bar. Unlike docked FABs that overlap the bar, floating FABs maintain a gap between the FAB and the bar.',
          style: TextStyle(fontSize: 13, color: Color(0xFF37474F)),
        ),
        SizedBox(height: 16),
        _buildFloatDiagram(0.0, 'Default gap (0.0)', Color(0xFFBF360C)),
        SizedBox(height: 12),
        _buildFloatDiagram(-12.0, 'Closer to bar (-12.0)', Color(0xFF1565C0)),
        SizedBox(height: 12),
        _buildFloatDiagram(12.0, 'Higher above bar (+12.0)', Color(0xFF00695C)),
        SizedBox(height: 12),
        buildInfoCard(
          'Mixin:',
          'FabFloatOffsetY provides getFloatY() for vertical positioning',
        ),
      ],
    ),
  );
}

Widget _buildFloatDiagram(double offset, String label, Color fabColor) {
  double gapSize = 16.0 + offset;
  if (gapSize < 4.0) {
    gapSize = 4.0;
  }
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
                height: 22,
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
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 7),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 22.0 + gapSize,
                right: 10,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: fabColor,
                    shape: BoxShape.circle,
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
                'Y offset adjustment: $offset px',
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
                  'Gap: ~${gapSize.toStringAsFixed(0)}px visible',
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

Widget _buildFloatHeightComparison() {
  print('Building float height comparison');
  List<Widget> items = [];
  List<double> offsets = [-16.0, -8.0, 0.0, 8.0, 16.0, 24.0, 32.0];

  int i = 0;
  for (; i < offsets.length; i = i + 1) {
    double val = offsets[i];
    Color barColor = Color(0xFFBF360C);
    if (val < 0) {
      barColor = Color(0xFF1565C0);
    }
    if (val > 0) {
      barColor = Color(0xFF00695C);
    }
    items.add(_buildHeightBar(val, barColor));
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
          'Float Y-Offset Values (-16 to +32)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 4),
        Text(
          'Negative = closer to bar, Positive = higher above bar',
          style: TextStyle(fontSize: 12, color: Color(0xFF795548)),
        ),
        SizedBox(height: 16),
        Column(children: items),
        SizedBox(height: 12),
        buildInfoCard(
          'Default:',
          'Float offset of 0.0 gives a standard gap above the bar',
        ),
      ],
    ),
  );
}

Widget _buildHeightBar(double val, Color color) {
  double normalized = (val + 16.0) / 48.0;
  String label = val.toStringAsFixed(1);
  if (val > 0) {
    label = '+' + label;
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
            label,
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
        Icon(Icons.vertical_align_top, size: 16, color: color),
      ],
    ),
  );
}

Widget _buildFloatingVsDocked() {
  print('Building floating vs docked Y comparison');
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
              border: Border.all(color: Color(0xFFBF360C), width: 2),
            ),
            child: Column(
              children: [
                Text(
                  'Float Y',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFFBF360C),
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
                        height: 28,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF78909C),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 40,
                        right: 12,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xFFBF360C),
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
                        bottom: 28,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Container(
                            height: 8,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFEB3B).withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Center(
                              child: Text(
                                'gap',
                                style: TextStyle(
                                  fontSize: 5,
                                  color: Color(0xFF795548),
                                ),
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
                  'FAB floats with visible gap',
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
        SizedBox(width: 12),
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
                  'Docked Y',
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
                        height: 28,
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
                        bottom: 10,
                        right: 12,
                        child: Container(
                          width: 36,
                          height: 36,
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
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'FAB overlaps into the bar',
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
      ],
    ),
  );
}

Widget _buildFloatWithBottomNav() {
  print('Building float Y with BottomNavigationBar');
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
          'Floating FAB Above BottomNavigationBar',
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
                    color: Color(0xFFBF360C),
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
                      _buildNavItem(Icons.home, 'Home', true),
                      _buildNavItem(Icons.search, 'Search', false),
                      _buildNavItem(Icons.favorite, 'Favs', false),
                      _buildNavItem(Icons.person, 'Profile', false),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 56,
                right: 16,
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Color(0xFFBF360C),
                    shape: BoxShape.circle,
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
          'Gap:',
          '12-16dp standard gap between FAB and BottomNavigationBar',
        ),
        buildInfoCard(
          'Float Y:',
          'Positions FAB bottom edge above the bar top edge',
        ),
      ],
    ),
  );
}

Widget _buildNavItem(IconData icon, String label, bool active) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 4),
      Icon(
        icon,
        size: 20,
        color: active ? Color(0xFFBF360C) : Color(0xFF9E9E9E),
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 9,
          color: active ? Color(0xFFBF360C) : Color(0xFF9E9E9E),
        ),
      ),
    ],
  );
}

Widget _buildCalculationFormula() {
  print('Building float Y calculation formula');
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
          'getFloatY Calculation',
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
                '// FabFloatOffsetY.getFloatY() calculation:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              SizedBox(height: 6),
              Text(
                'fabY = contentBottom - fabHeight - bottomBarGap',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  color: Color(0xFF80CBC4),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '// Where:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                '// contentBottom = scaffoldHeight - bottomBarHeight',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                '// bottomBarGap = standard padding (16dp)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '// Example: scaffold=800, bar=56, fab=56, gap=16:',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF78909C),
                ),
              ),
              Text(
                'fabY = (800 - 56) - 56 - 16 = 672.0',
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
        _buildCalcRow(
          'scaffoldHeight',
          '800.0',
          'Total scaffold height',
          Color(0xFFBF360C),
        ),
        SizedBox(height: 4),
        _buildCalcRow(
          'bottomBarHeight',
          '56.0',
          'BottomNavigationBar height',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 4),
        _buildCalcRow(
          'fabHeight',
          '56.0',
          'Standard FAB height',
          Color(0xFF00695C),
        ),
        SizedBox(height: 4),
        _buildCalcRow(
          'bottomBarGap',
          '16.0',
          'Standard gap above bar',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 4),
        _buildCalcRow(
          'fabY result',
          '672.0',
          'FAB top-left Y position',
          Color(0xFFD84315),
        ),
        SizedBox(height: 8),
        buildInfoCard(
          'Key:',
          'Float Y ensures a gap between the FAB and the bottom bar',
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

Widget _buildDifferentFloatHeights() {
  print('Building different float heights');
  List<Widget> cards = [];

  cards.add(
    _buildFloatHeightCard(
      0.0,
      'Default height',
      'Standard gap above bottom bar',
      Color(0xFFBF360C),
    ),
  );
  cards.add(SizedBox(height: 8));
  cards.add(
    _buildFloatHeightCard(
      8.0,
      'Slightly higher',
      'More breathing room above bar',
      Color(0xFF00695C),
    ),
  );
  cards.add(SizedBox(height: 8));
  cards.add(
    _buildFloatHeightCard(
      24.0,
      'Much higher',
      'Large gap, FAB stands out more',
      Color(0xFF1565C0),
    ),
  );
  cards.add(SizedBox(height: 8));
  cards.add(
    _buildFloatHeightCard(
      -8.0,
      'Slightly lower',
      'Closer to bar, almost touching',
      Color(0xFF6A1B9A),
    ),
  );
  cards.add(SizedBox(height: 8));
  cards.add(
    _buildFloatHeightCard(
      40.0,
      'Very high',
      'FAB far above bar, disconnected feel',
      Color(0xFFD84315),
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
          'Visual Impact of Different Float Heights',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Column(children: cards),
        SizedBox(height: 12),
        buildInfoCard(
          'Best practice:',
          'Keep float offset small (0 to 16) for a balanced look',
        ),
      ],
    ),
  );
}

Widget _buildFloatHeightCard(
  double offset,
  String title,
  String desc,
  Color color,
) {
  String sign = '';
  if (offset > 0) {
    sign = '+';
  }
  double gapHeight = 16.0 + offset;
  if (gapHeight < 2.0) {
    gapHeight = 2.0;
  }
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
          height: 70,
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
                    color: Color(0xFF78909C),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 18.0 + gapHeight * 0.5,
                right: 8,
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
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
              Text(
                'Offset: $sign${offset.toStringAsFixed(1)}px',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  color: Color(0xFF616161),
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFloatWithLargeFab() {
  print('Building float with large FAB');
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
          'FAB Size Impact on Float Y',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSizeFloatCard('Mini', 40.0, Color(0xFF6A1B9A)),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildSizeFloatCard('Standard', 56.0, Color(0xFFBF360C)),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildSizeFloatCard('Large', 96.0, Color(0xFF00695C)),
            ),
          ],
        ),
        SizedBox(height: 16),
        buildInfoCard(
          'Mini FAB:',
          'Less vertical space consumed, higher apparent gap',
        ),
        buildInfoCard(
          'Large FAB:',
          'More vertical space consumed, closer to content',
        ),
        buildInfoCard(
          'Formula:',
          'All sizes use contentBottom - fabHeight - gap',
        ),
      ],
    ),
  );
}

Widget _buildSizeFloatCard(String label, double size, Color color) {
  return Container(
    padding: EdgeInsets.all(10),
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
                height: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF78909C),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 26,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: size * 0.45,
                    height: size * 0.45,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFFFFFFF),
                        size: size * 0.2,
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
            fontSize: 12,
            color: color,
          ),
        ),
        Text(
          '${size.toInt()}px',
          style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

Widget _buildBarTypeComparison() {
  print('Building bar type comparison');
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
          'Float Y Behavior with Different Bottom Bars',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        _buildBarTypeRow(
          'BottomNavigationBar',
          '56dp',
          'Standard tab nav, FAB floats above',
          Color(0xFFBF360C),
        ),
        SizedBox(height: 8),
        _buildBarTypeRow(
          'BottomAppBar',
          '56dp',
          'Action bar, FAB floats above (or docked)',
          Color(0xFF1565C0),
        ),
        SizedBox(height: 8),
        _buildBarTypeRow(
          'NavigationBar (M3)',
          '80dp',
          'Material 3 nav, taller bar shifts FAB higher',
          Color(0xFF00695C),
        ),
        SizedBox(height: 8),
        _buildBarTypeRow(
          'No bottom bar',
          '0dp',
          'FAB floats above scaffold bottom edge',
          Color(0xFF6A1B9A),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Adapts:',
          'Float Y adjusts based on actual bottom bar height',
        ),
      ],
    ),
  );
}

Widget _buildBarTypeRow(String name, String height, String desc, Color color) {
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
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.horizontal_rule, size: 16, color: color),
                Text(
                  height,
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildVisualSpacingGuide() {
  print('Building visual spacing guide');
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
          'Visual Spacing Between FAB and Bar',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(height: 16),
        Container(
          height: 180,
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 36,
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
                      'BottomNavigationBar (56dp)',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 9),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 36,
                left: 0,
                right: 0,
                height: 20,
                child: Container(
                  color: Color(0xFFFFEB3B).withValues(alpha: 0.3),
                  child: Center(
                    child: Text(
                      'Float gap (16dp default)',
                      style: TextStyle(fontSize: 8, color: Color(0xFF795548)),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 56,
                right: 20,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xFFBF360C),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 24),
                  ),
                ),
              ),
              Positioned(
                bottom: 108,
                right: 16,
                child: Text(
                  'fabY',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFBF360C),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                bottom: 44,
                top: 0,
                child: Container(width: 1, color: Color(0xFF90CAF9)),
              ),
              Positioned(
                left: 4,
                top: 8,
                child: Text(
                  'scaffoldHeight',
                  style: TextStyle(fontSize: 7, color: Color(0xFF1565C0)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard(
          'Structure:',
          'Content > Gap > BottomBar from top to bottom',
        ),
        buildInfoCard(
          'FAB position:',
          'FAB bottom edge sits at top of gap area',
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
      'getFloatY',
      'double',
      'Returns Y offset for floating FAB',
      Color(0xFFBF360C),
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
      'Additional Y offset adjustment',
      Color(0xFF00695C),
    ),
  );
  rows.add(
    _buildApiRow(
      'contentBottom',
      'double',
      'Bottom edge of content area',
      Color(0xFF6A1B9A),
    ),
  );
  rows.add(
    _buildApiRow(
      'fabHeight',
      'double',
      'FAB height for position calc',
      Color(0xFFD84315),
    ),
  );
  rows.add(
    _buildApiRow(
      'bottomBarGap',
      'double',
      'Gap between FAB and bottom bar',
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
