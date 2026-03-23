// ignore_for_file: avoid_print
// D4rt test script: Tests FabContainedOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FabContainedOffsetY Visual Demo ===');
  print('Demonstrating FAB contained offset Y positioning in Scaffold contexts');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('FabContainedOffsetY Demo'),
        backgroundColor: Color(0xFF283593),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader('Contained Y-Offset Concept'),
            SizedBox(height: 8),
            _buildContainedConcept(),
            SizedBox(height: 24),
            buildSectionHeader('Float vs Docked vs Top Y-Positions'),
            SizedBox(height: 8),
            _buildFloatVsDockedVsTop(),
            SizedBox(height: 24),
            buildSectionHeader('Y-Offset Calculation'),
            SizedBox(height: 8),
            _buildYOffsetCalculation(),
            SizedBox(height: 24),
            buildSectionHeader('Contained Boundary Rules'),
            SizedBox(height: 8),
            _buildContainedBoundaryRules(),
            SizedBox(height: 24),
            buildSectionHeader('Bottom Bar Height Impact'),
            SizedBox(height: 8),
            _buildBottomBarImpact(),
            SizedBox(height: 24),
            buildSectionHeader('Snackbar Adjustment'),
            SizedBox(height: 8),
            _buildSnackbarAdjustment(),
            SizedBox(height: 24),
            buildSectionHeader('Mini FAB Y-Offset Differences'),
            SizedBox(height: 8),
            _buildMiniFabYDifferences(),
            SizedBox(height: 24),
            buildSectionHeader('Keyboard Visibility Impact'),
            SizedBox(height: 8),
            _buildKeyboardImpact(),
            SizedBox(height: 24),
            buildSectionHeader('Y-Offset Comparison Table'),
            SizedBox(height: 8),
            _buildComparisonTable(),
            SizedBox(height: 24),
            buildSectionHeader('Properties and Parameters'),
            SizedBox(height: 8),
            _buildPropertiesSection(),
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
      color: Colors.indigo.shade700,
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

Widget _buildContainedConcept() {
  print('Building contained concept');
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
        Text('What does "Contained" mean?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 12),
        Text('Contained offset Y ensures the FAB stays within the visible bounds of the Scaffold body. '
            'Unlike floating positions that can overlap the bottom bar or extend beyond the content area, '
            'contained positions clamp the Y offset so the FAB is guaranteed to be fully visible.',
            style: TextStyle(fontSize: 13, color: Color(0xFF37474F), height: 1.5)),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildConceptCard(
              'Unconstrained (Float)',
              'May overlap bottom bar or extend below scaffold',
              Color(0xFFEF5350),
              Icons.open_with,
            )),
            SizedBox(width: 12),
            Expanded(child: _buildConceptCard(
              'Contained',
              'Clamped to stay within visible scaffold body',
              Color(0xFF66BB6A),
              Icons.check_box_outline_blank,
            )),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Mixin:', 'FabContainedOffsetY provides getOffsetY with containment logic'),
      ],
    ),
  );
}

Widget _buildConceptCard(String title, String desc, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 32),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: color),
            textAlign: TextAlign.center),
        SizedBox(height: 4),
        Text(desc, style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
            textAlign: TextAlign.center),
      ],
    ),
  );
}

Widget _buildFloatVsDockedVsTop() {
  print('Building float vs docked vs top comparison');
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
        Text('Three Y-Position Strategies',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildYPositionScaffold('Float', 0.72, Color(0xFFD84315), false)),
            SizedBox(width: 8),
            Expanded(child: _buildYPositionScaffold('Docked', 0.88, Color(0xFF00897B), true)),
            SizedBox(width: 8),
            Expanded(child: _buildYPositionScaffold('Top', 0.12, Color(0xFF1565C0), false)),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Float Y:', 'Positioned above bottom bar with padding'),
        buildInfoCard('Docked Y:', 'Partially embedded in bottom bar notch'),
        buildInfoCard('Top Y:', 'Positioned at top of body, below AppBar'),
      ],
    ),
  );
}

Widget _buildYPositionScaffold(String label, double yFraction, Color color, bool docked) {
  return Container(
    padding: EdgeInsets.all(4),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color),
    ),
    child: Column(
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: color)),
        SizedBox(height: 4),
        Container(
          width: double.infinity, height: 140,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0, height: 18,
                child: Container(
                  color: Color(0xFF455A64),
                  child: Center(child: Text('AppBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 6))),
                ),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0, height: 14,
                child: Container(
                  color: Color(0xFF78909C),
                  child: Center(child: Text('Bottom', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 6))),
                ),
              ),
              Positioned(
                left: 0, right: 0,
                top: (140 * yFraction) - 12,
                child: Center(
                  child: Container(
                    width: 24, height: 24,
                    decoration: BoxDecoration(
                      color: color, shape: BoxShape.circle,
                      border: docked ? Border.all(color: Color(0xFFFFFFFF), width: 2) : null,
                    ),
                    child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 12)),
                  ),
                ),
              ),
              Positioned(
                left: 2, top: (140 * yFraction) - 4,
                child: Container(
                  width: 1, height: 40,
                  color: color.withValues(alpha: 0.4),
                ),
              ),
              Positioned(
                left: 6, top: (140 * yFraction) + 16,
                child: Text('Y', style: TextStyle(fontSize: 7, color: color, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildYOffsetCalculation() {
  print('Building Y-offset calculation');
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
        Text('getOffsetY Calculation Steps',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 16),
        _buildCalcStep(1, 'Get scaffold height', 'scaffoldHeight = scaffoldGeometry.scaffoldSize.height', Color(0xFF1565C0)),
        SizedBox(height: 8),
        _buildCalcStep(2, 'Get content bottom', 'contentBottom = scaffoldHeight - bottomBarHeight', Color(0xFF00897B)),
        SizedBox(height: 8),
        _buildCalcStep(3, 'Calculate raw Y', 'rawY = contentBottom - fabHeight - padding', Color(0xFFD84315)),
        SizedBox(height: 8),
        _buildCalcStep(4, 'Apply containment', 'y = clamp(rawY, minY, maxY)', Color(0xFF6A1B9A)),
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
              Text('// Contained offset Y formula:',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF78909C))),
              SizedBox(height: 4),
              Text('fabY = scaffoldSize.height',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF80CBC4))),
              Text('     - bottomViewPadding',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF80CBC4))),
              Text('     - floatingActionButtonHeight',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF80CBC4))),
              Text('     - kFloatingActionButtonMargin;',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFF80CBC4))),
              SizedBox(height: 8),
              Text('// Then clamp to content area',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF78909C))),
              Text('y = y.clamp(contentTop, contentBottom);',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: Color(0xFFFFCC80))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCalcStep(int step, String title, String formula, Color color) {
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
          width: 28, height: 28,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(child: Text('$step', style: TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold, fontSize: 13))),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
              Text(formula, style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF616161))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildContainedBoundaryRules() {
  print('Building containment boundary rules');
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
        Text('Containment ensures FAB stays within bounds',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 16),
        Container(
          width: double.infinity, height: 220,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD), width: 2),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0, height: 30,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF455A64),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                  ),
                  child: Center(child: Text('AppBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10))),
                ),
              ),
              Positioned(
                top: 30, left: 0, right: 0, height: 1,
                child: Container(color: Color(0xFFEF5350)),
              ),
              Positioned(
                top: 33, left: 8,
                child: Text('minY (content top)', style: TextStyle(fontSize: 8, color: Color(0xFFEF5350))),
              ),
              Positioned(
                bottom: 44, left: 0, right: 0, height: 1,
                child: Container(color: Color(0xFF4CAF50)),
              ),
              Positioned(
                bottom: 47, left: 8,
                child: Text('maxY (content bottom)', style: TextStyle(fontSize: 8, color: Color(0xFF4CAF50))),
              ),
              Positioned(
                bottom: 0, left: 0, right: 0, height: 36,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF78909C),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
                  ),
                  child: Center(child: Text('BottomNavigationBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 9))),
                ),
              ),
              Positioned(
                top: 50, left: 16, right: 16, bottom: 56,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2196F3).withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Color(0xFF2196F3).withValues(alpha: 0.3), width: 1),
                  ),
                  child: Center(
                    child: Text('Valid FAB Y range\n(contained area)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Color(0xFF2196F3))),
                  ),
                ),
              ),
              Positioned(
                bottom: 56, right: 24,
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: Color(0xFF283593),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 18)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        buildInfoCard('Top Boundary:', 'Below the AppBar (content area start)'),
        buildInfoCard('Bottom Boundary:', 'Above the BottomNavigationBar/BottomAppBar'),
        buildInfoCard('Clamping:', 'Y position clamped between top and bottom boundaries'),
      ],
    ),
  );
}

Widget _buildBottomBarImpact() {
  print('Building bottom bar height impact');
  List<Widget> items = [];

  items.add(_buildBarHeightRow('No bottom bar', 0, Color(0xFF4CAF50)));
  items.add(SizedBox(height: 6));
  items.add(_buildBarHeightRow('BottomNavigationBar (56px)', 56, Color(0xFF2196F3)));
  items.add(SizedBox(height: 6));
  items.add(_buildBarHeightRow('BottomAppBar (80px)', 80, Color(0xFFFF9800)));
  items.add(SizedBox(height: 6));
  items.add(_buildBarHeightRow('Tall custom bar (120px)', 120, Color(0xFFF44336)));

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
        Text('Bottom bar height changes the contained Y maximum',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: items),
        SizedBox(height: 12),
        buildInfoCard('Rule:', 'Larger bottom bar = FAB moves UP in contained mode'),
      ],
    ),
  );
}

Widget _buildBarHeightRow(String label, int barHeight, Color color) {
  int scaffoldH = 600;
  int fabH = 56;
  int margin = 16;
  int availableY = scaffoldH - barHeight - fabH - margin;
  double fraction = availableY / scaffoldH;
  if (fraction > 1.0) fraction = 1.0;
  if (fraction < 0.0) fraction = 0.0;

  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Row(
      children: [
        Container(
          width: 60, height: 60,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0, left: 0, right: 0,
                height: barHeight > 0 ? (barHeight / scaffoldH * 60).clamp(4.0, 30.0) : 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF78909C),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(3),
                      bottomRight: Radius.circular(3),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: barHeight > 0 ? ((barHeight / scaffoldH * 60) + 4).clamp(8.0, 34.0) : 8,
                left: 0, right: 0,
                child: Center(
                  child: Container(
                    width: 16, height: 16,
                    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 8)),
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
              Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: color)),
              SizedBox(height: 2),
              Text('Bar: ${barHeight}px  |  Available Y: ${availableY}px',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF616161))),
              SizedBox(height: 4),
              Container(
                height: 8,
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
                      color: color.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
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

Widget _buildSnackbarAdjustment() {
  print('Building snackbar adjustment');
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
        Text('Snackbar pushes FAB upward',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFBDBDBD)),
                ),
                child: Column(
                  children: [
                    Text('Without Snackbar', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Container(
                      height: 120, width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 20, right: 8,
                            child: Container(
                              width: 32, height: 32,
                              decoration: BoxDecoration(color: Color(0xFF283593), shape: BoxShape.circle),
                              child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 16)),
                            ),
                          ),
                          Positioned(
                            bottom: 0, left: 0, right: 0, height: 14,
                            child: Container(
                              color: Color(0xFF78909C),
                              child: Center(child: Text('BottomBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 6))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFFF6F00)),
                ),
                child: Column(
                  children: [
                    Text('With Snackbar', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFFF6F00))),
                    SizedBox(height: 4),
                    Container(
                      height: 120, width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 56, right: 8,
                            child: Container(
                              width: 32, height: 32,
                              decoration: BoxDecoration(color: Color(0xFF283593), shape: BoxShape.circle),
                              child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 16)),
                            ),
                          ),
                          Positioned(
                            bottom: 14, left: 4, right: 4, height: 36,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF323232),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 8),
                                  Expanded(child: Text('Action completed', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 8))),
                                  Text('UNDO', style: TextStyle(color: Color(0xFFFFCC80), fontSize: 8, fontWeight: FontWeight.bold)),
                                  SizedBox(width: 8),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0, left: 0, right: 0, height: 14,
                            child: Container(
                              color: Color(0xFF78909C),
                              child: Center(child: Text('BottomBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 6))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Snackbar:', 'snackBarSize.height is subtracted from contained Y'),
        buildInfoCard('Still Contained:', 'FAB moves up but remains within content bounds'),
      ],
    ),
  );
}

Widget _buildMiniFabYDifferences() {
  print('Building mini FAB Y differences');
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
        Text('Standard vs Mini FAB Y Offset',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFF283593), width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 56, height: 56,
                      decoration: BoxDecoration(color: Color(0xFF283593), shape: BoxShape.circle),
                      child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 28)),
                    ),
                    SizedBox(height: 8),
                    Text('Standard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF283593))),
                    Text('56x56 px', style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
                    SizedBox(height: 4),
                    Text('margin: 16px', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF616161))),
                    Text('total offset: 72px', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF616161))),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFF6A1B9A), width: 2),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: Color(0xFF6A1B9A), shape: BoxShape.circle),
                      child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 20)),
                    ),
                    SizedBox(height: 8),
                    Text('Mini', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF6A1B9A))),
                    Text('40x40 px', style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
                    SizedBox(height: 4),
                    Text('margin: 16px', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF616161))),
                    Text('total offset: 56px', style: TextStyle(fontFamily: 'monospace', fontSize: 10, color: Color(0xFF616161))),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Difference:', 'Mini FAB uses less Y offset (smaller height)'),
        buildInfoCard('Same mixin:', 'Both use FabContainedOffsetY.getOffsetY()'),
      ],
    ),
  );
}

Widget _buildKeyboardImpact() {
  print('Building keyboard impact');
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
        Text('Keyboard Visibility Changes Contained Area',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFF4CAF50)),
                ),
                child: Column(
                  children: [
                    Text('Keyboard Hidden', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF4CAF50))),
                    SizedBox(height: 4),
                    Container(
                      height: 130, width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0xFFBDBDBD)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0, left: 0, right: 0, height: 16,
                            child: Container(color: Color(0xFF455A64),
                              child: Center(child: Text('AppBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 6)))),
                          ),
                          Positioned(
                            top: 16, left: 4, right: 4, bottom: 18,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF4CAF50).withValues(alpha: 0.08),
                                border: Border.all(color: Color(0xFF4CAF50).withValues(alpha: 0.3)),
                              ),
                              child: Center(child: Text('Full\nContent\nArea', textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 8, color: Color(0xFF4CAF50)))),
                            ),
                          ),
                          Positioned(
                            bottom: 24, right: 8,
                            child: Container(
                              width: 20, height: 20,
                              decoration: BoxDecoration(color: Color(0xFF283593), shape: BoxShape.circle),
                              child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 10)),
                            ),
                          ),
                          Positioned(
                            bottom: 0, left: 0, right: 0, height: 14,
                            child: Container(color: Color(0xFF78909C)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Color(0xFFFF6F00)),
                ),
                child: Column(
                  children: [
                    Text('Keyboard Visible', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFFF6F00))),
                    SizedBox(height: 4),
                    Container(
                      height: 130, width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Color(0xFFBDBDBD)),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0, left: 0, right: 0, height: 16,
                            child: Container(color: Color(0xFF455A64),
                              child: Center(child: Text('AppBar', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 6)))),
                          ),
                          Positioned(
                            top: 16, left: 4, right: 4, bottom: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFF6F00).withValues(alpha: 0.08),
                                border: Border.all(color: Color(0xFFFF6F00).withValues(alpha: 0.3)),
                              ),
                              child: Center(child: Text('Reduced\nArea', textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 8, color: Color(0xFFFF6F00)))),
                            ),
                          ),
                          Positioned(
                            bottom: 68, right: 8,
                            child: Container(
                              width: 20, height: 20,
                              decoration: BoxDecoration(color: Color(0xFF283593), shape: BoxShape.circle),
                              child: Center(child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 10)),
                            ),
                          ),
                          Positioned(
                            bottom: 0, left: 0, right: 0, height: 56,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF424242),
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3), bottomRight: Radius.circular(3)),
                              ),
                              child: Center(child: Text('Keyboard', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 9))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        buildInfoCard('Impact:', 'bottomViewPadding increases => FAB moves up'),
        buildInfoCard('Contained:', 'FAB never goes below keyboard, always visible'),
      ],
    ),
  );
}

Widget _buildComparisonTable() {
  print('Building comparison table');
  List<Widget> rows = [];
  rows.add(_buildTableRow('Location', 'Uses Center X', 'Uses Contained Y', true));
  rows.add(_buildTableRow('centerFloat', 'Yes', 'No (basic float)', false));
  rows.add(_buildTableRow('centerDocked', 'Yes', 'No (docked)', false));
  rows.add(_buildTableRow('centerTop', 'Yes', 'No (top)', false));
  rows.add(_buildTableRow('endContained', 'No', 'Yes', false));
  rows.add(_buildTableRow('miniEndContained', 'No', 'Yes', false));
  rows.add(_buildTableRow('miniStartContained', 'No', 'Yes (planned)', false));
  rows.add(_buildTableRow('endFloat', 'No', 'No', false));
  rows.add(_buildTableRow('startFloat', 'No', 'No', false));

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
        Text('Which locations use which offset mixins?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: rows),
      ],
    ),
  );
}

Widget _buildTableRow(String location, String centerX, String containedY, bool isHeader) {
  Color bg = isHeader ? Color(0xFF283593) : Color(0xFFFFFFFF);
  Color textColor = isHeader ? Color(0xFFFFFFFF) : Color(0xFF37474F);
  FontWeight weight = isHeader ? FontWeight.bold : FontWeight.normal;

  return Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: bg,
      border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
    ),
    child: Row(
      children: [
        Expanded(flex: 4, child: Text(location, style: TextStyle(fontSize: 11, color: textColor, fontWeight: weight, fontFamily: isHeader ? null : 'monospace'))),
        Expanded(flex: 3, child: Text(centerX, style: TextStyle(fontSize: 11, color: textColor, fontWeight: weight))),
        Expanded(flex: 3, child: Text(containedY, style: TextStyle(fontSize: 11, color: textColor, fontWeight: weight))),
      ],
    ),
  );
}

Widget _buildPropertiesSection() {
  print('Building properties section');
  List<Widget> props = [];
  props.add(_buildPropCard('getOffsetY', 'double', 'Returns contained Y offset for FAB positioning', Color(0xFF283593)));
  props.add(SizedBox(height: 6));
  props.add(_buildPropCard('scaffoldGeometry', 'ScaffoldPrelayoutGeometry', 'Layout measurements input', Color(0xFF00897B)));
  props.add(SizedBox(height: 6));
  props.add(_buildPropCard('adjustment', 'double', 'Fine-tune Y position', Color(0xFFD84315)));
  props.add(SizedBox(height: 6));
  props.add(_buildPropCard('scaffoldSize.height', 'double', 'Total scaffold height', Color(0xFF6A1B9A)));
  props.add(SizedBox(height: 6));
  props.add(_buildPropCard('contentBottom', 'double', 'Bottom edge of content area', Color(0xFF1565C0)));
  props.add(SizedBox(height: 6));
  props.add(_buildPropCard('contentTop', 'double', 'Top edge of content area', Color(0xFFC62828)));
  props.add(SizedBox(height: 6));
  props.add(_buildPropCard('snackBarSize', 'Size', 'Active snackbar dimensions', Color(0xFFFF6F00)));
  props.add(SizedBox(height: 6));
  props.add(_buildPropCard('bottomViewPadding', 'double', 'System inset (keyboard, etc.)', Color(0xFF00695C)));

  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB0BEC5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('FabContainedOffsetY Properties and Parameters',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        SizedBox(height: 12),
        Column(children: props),
      ],
    ),
  );
}

Widget _buildPropCard(String name, String type, String desc, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4, height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name, style: TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 12, color: color)),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(type, style: TextStyle(fontFamily: 'monospace', fontSize: 9, color: Color(0xFF616161))),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(desc, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
            ],
          ),
        ),
      ],
    ),
  );
}
