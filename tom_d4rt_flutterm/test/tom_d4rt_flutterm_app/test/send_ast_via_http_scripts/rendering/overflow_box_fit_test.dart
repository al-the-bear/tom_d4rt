// D4rt test script: Comprehensive demo for OverflowBoxFit from rendering
//
// OverflowBoxFit is an enum that controls how OverflowBox and SizedOverflowBox
// fit their child within the available space.
//
// Values:
//   - max: Child receives max constraints, fills available space
//   - deferToChild: Child determines its own size within constraints
//
// This demo shows:
//   1. OverflowBoxFit.max vs OverflowBoxFit.deferToChild demonstration
//   2. Visual comparison with different sized children
//   3. Use in SizedOverflowBox
//   4. Constraint behavior visualization
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════

Color _kCyan100 = Color(0xFFCFFAFE);
Color _kCyan400 = Color(0xFF22D3EE);
Color _kCyan500 = Color(0xFF06B6D4);
Color _kCyan600 = Color(0xFF0891B2);
Color _kCyan700 = Color(0xFF0E7490);
Color _kCyan800 = Color(0xFF155E75);

Color _kOrange500 = Color(0xFFF97316);

Color _kSlate600 = Color(0xFF475569);
Color _kSlate700 = Color(0xFF334155);
Color _kSlate800 = Color(0xFF1E293B);

Color _kRose500 = Color(0xFFF43F5E);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCyan700, _kCyan500],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kCyan700.withAlpha(80),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCard(String title, Widget content, {Color? accentColor}) {
  Color color = accentColor ?? _kCyan500;
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(50), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withAlpha(25),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Padding(padding: EdgeInsets.all(16), child: content),
      ],
    ),
  );
}

Widget _buildMainHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kCyan800, _kCyan600, _kCyan400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: _kCyan800.withAlpha(100),
          blurRadius: 16,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.open_with, color: Colors.white, size: 48),
        SizedBox(height: 12),
        Text(
          'OverflowBoxFit',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Control how OverflowBox fits its child',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatBadge('max', Icons.fullscreen),
            SizedBox(width: 12),
            _buildStatBadge('deferToChild', Icons.child_care),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStatBadge(String label, IconData icon) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withAlpha(40),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 16),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Widget _buildEnumValueRow(
  OverflowBoxFit value,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'OverflowBoxFit.${value.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'index: ${value.index}',
                      style: TextStyle(
                        fontSize: 10,
                        color: color,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: color.withAlpha(180)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeSnippet(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontSize: 11,
        color: Color(0xFF9CDCFE),
        fontFamily: 'monospace',
        height: 1.4,
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// OVERFLOW BOX FIT VISUALIZATIONS
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildOverflowBoxDemo(String title, OverflowBoxFit fit, Color color) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: 14,
        ),
      ),
      SizedBox(height: 8),
      Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: _kSlate600.withAlpha(30),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _kSlate600.withAlpha(60), width: 2),
        ),
        child: Stack(
          children: [
            // Label for parent container
            Positioned(
              top: 2,
              left: 4,
              child: Text(
                'Parent 150×100',
                style: TextStyle(
                  fontSize: 8,
                  color: _kSlate600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // The OverflowBox with the specified fit
            Center(
              child: OverflowBox(
                fit: fit,
                maxWidth: 100,
                maxHeight: 60,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        fit.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 4),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'OverflowBoxFit.${fit.name}',
          style: TextStyle(fontSize: 9, fontFamily: 'monospace', color: color),
        ),
      ),
    ],
  );
}

Widget _buildChildSizeComparison() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Different sized children with each fit:',
        style: TextStyle(fontWeight: FontWeight.bold, color: _kSlate800),
      ),
      SizedBox(height: 12),
      // Small child comparison
      _buildSizeRow('Small child (40×30)', 40.0, 30.0),
      SizedBox(height: 12),
      // Medium child comparison
      _buildSizeRow('Medium child (80×50)', 80.0, 50.0),
      SizedBox(height: 12),
      // Large child (overflows)
      _buildSizeRow('Large child (150×90)', 150.0, 90.0),
    ],
  );
}

Widget _buildSizeRow(String label, double childW, double childH) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontSize: 12, color: _kSlate700)),
      SizedBox(height: 6),
      Row(
        children: [
          _buildSizedChildDemo(OverflowBoxFit.max, childW, childH, _kCyan500),
          SizedBox(width: 16),
          _buildSizedChildDemo(
            OverflowBoxFit.deferToChild,
            childW,
            childH,
            _kOrange500,
          ),
        ],
      ),
    ],
  );
}

Widget _buildSizedChildDemo(
  OverflowBoxFit fit,
  double childW,
  double childH,
  Color color,
) {
  return Column(
    children: [
      Container(
        width: 100,
        height: 70,
        decoration: BoxDecoration(
          color: _kSlate600.withAlpha(20),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _kSlate600.withAlpha(40)),
        ),
        clipBehavior: Clip.none,
        child: OverflowBox(
          fit: fit,
          maxWidth: 120,
          maxHeight: 80,
          child: Container(
            width: childW,
            height: childH,
            decoration: BoxDecoration(
              color: color.withAlpha(200),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color, width: 2),
            ),
            child: Center(
              child: Text(
                '${childW.toInt()}×${childH.toInt()}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 4),
      Text(
        fit.name,
        style: TextStyle(fontSize: 9, color: color, fontFamily: 'monospace'),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// SIZED OVERFLOW BOX SECTION
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildSizedOverflowBoxDemo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'SizedOverflowBox with different fits:',
        style: TextStyle(fontWeight: FontWeight.bold, color: _kSlate800),
      ),
      SizedBox(height: 8),
      Text(
        'SizedOverflowBox combines SizedBox sizing with OverflowBox behavior.',
        style: TextStyle(fontSize: 12, color: _kSlate600),
      ),
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSizedOverflowBoxItem(OverflowBoxFit.max, _kCyan500),
          _buildSizedOverflowBoxItem(OverflowBoxFit.deferToChild, _kOrange500),
        ],
      ),
    ],
  );
}

Widget _buildSizedOverflowBoxItem(OverflowBoxFit fit, Color color) {
  return Column(
    children: [
      Container(
        width: 120,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Center(
          child: SizedOverflowBox(
            size: Size(80, 50),
            alignment: Alignment.center,
            child: Container(
              width: 100,
              height: 70,
              decoration: BoxDecoration(
                color: color.withAlpha(180),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: color, width: 2),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Child',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '100×70',
                      style: TextStyle(color: Colors.white70, fontSize: 9),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          fit.name,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ),
      SizedBox(height: 4),
      Text(
        'Size: 80×50',
        style: TextStyle(fontSize: 10, color: _kSlate600),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// CONSTRAINT BEHAVIOR VISUALIZATION
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildConstraintVisualization() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'How constraints flow to child:',
        style: TextStyle(fontWeight: FontWeight.bold, color: _kSlate800),
      ),
      SizedBox(height: 16),
      // max visualization
      _buildConstraintFlowDiagram(
        OverflowBoxFit.max,
        'Child receives maximum constraints\n→ Child fills available space',
        _kCyan500,
        Icons.fullscreen,
      ),
      SizedBox(height: 16),
      // deferToChild visualization
      _buildConstraintFlowDiagram(
        OverflowBoxFit.deferToChild,
        'Child determines own size\n→ Child can be smaller',
        _kOrange500,
        Icons.child_care,
      ),
    ],
  );
}

Widget _buildConstraintFlowDiagram(
  OverflowBoxFit fit,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(40)),
    ),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OverflowBoxFit.${fit.name}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 15,
                  fontFamily: 'monospace',
                ),
              ),
              SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kSlate700, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildConstraintBoxDiagram() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Visual constraint demonstration:',
        style: TextStyle(fontWeight: FontWeight.bold, color: _kSlate800),
      ),
      SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildConstraintBox(
            'max',
            'Child expands to fill constraints',
            _kCyan500,
            true,
          ),
          _buildConstraintBox(
            'deferToChild',
            'Child sizes itself naturally',
            _kOrange500,
            false,
          ),
        ],
      ),
    ],
  );
}

Widget _buildConstraintBox(
  String label,
  String desc,
  Color color,
  bool fillsSpace,
) {
  return Column(
    children: [
      Container(
        width: 120,
        height: 90,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withAlpha(30),
              color.withAlpha(60),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color, width: 2),
        ),
        child: Stack(
          children: [
            // Constraint area marker
            Positioned(
              top: 0,
              right: 0,
              child: Icon(
                Icons.crop_free,
                color: color.withAlpha(100),
                size: 16,
              ),
            ),
            // Child representation
            Center(
              child: Container(
                width: fillsSpace ? 100 : 60,
                height: fillsSpace ? 70 : 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    fillsSpace ? 'FILLS' : 'SIZED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
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
          color: color,
          fontFamily: 'monospace',
        ),
      ),
      SizedBox(height: 4),
      SizedBox(
        width: 100,
        child: Text(
          desc,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 9, color: _kSlate600),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// PRACTICAL EXAMPLES
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildPracticalExamples() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildExample(
        'Profile Avatar Overflow',
        'Avatar extends beyond container bounds',
        _kCyan500,
        _buildAvatarExample(),
      ),
      SizedBox(height: 16),
      _buildExample(
        'Floating Badge',
        'Badge overflows parent to overlap siblings',
        _kRose500,
        _buildBadgeExample(),
      ),
      SizedBox(height: 16),
      _buildExample(
        'Decorative Shadow',
        'Shadow extends beyond widget boundaries',
        _kOrange500,
        _buildShadowExample(),
      ),
    ],
  );
}

Widget _buildExample(String title, String desc, Color color, Widget example) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(10),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(30)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 13,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          desc,
          style: TextStyle(fontSize: 11, color: _kSlate600),
        ),
        SizedBox(height: 12),
        Center(child: example),
      ],
    ),
  );
}

Widget _buildAvatarExample() {
  return Container(
    width: 80,
    height: 60,
    decoration: BoxDecoration(
      color: _kCyan100,
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.none,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Text(
            'Card',
            style: TextStyle(
              color: _kCyan700,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Positioned(
          top: -15,
          left: 0,
          right: 0,
          child: Center(
            child: OverflowBox(
              fit: OverflowBoxFit.max,
              maxWidth: 40,
              maxHeight: 40,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _kCyan500,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBadgeExample() {
  return Container(
    width: 100,
    height: 50,
    decoration: BoxDecoration(
      color: _kSlate600.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
    ),
    clipBehavior: Clip.none,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            width: 70,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: _kSlate600.withAlpha(40)),
            ),
            child: Center(
              child: Text(
                'Item',
                style: TextStyle(color: _kSlate700, fontSize: 12),
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 10,
          child: OverflowBox(
            fit: OverflowBoxFit.deferToChild,
            maxWidth: 30,
            maxHeight: 30,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _kRose500,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildShadowExample() {
  return Container(
    width: 100,
    height: 60,
    clipBehavior: Clip.none,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Shadow layer using OverflowBox
        OverflowBox(
          fit: OverflowBoxFit.max,
          maxWidth: 120,
          maxHeight: 80,
          child: Container(
            decoration: BoxDecoration(
              color: _kOrange500.withAlpha(40),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // Main content
        Center(
          child: Container(
            width: 80,
            height: 45,
            decoration: BoxDecoration(
              color: _kOrange500,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                'Content',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// ENUM PROPERTIES DISPLAY
// ═══════════════════════════════════════════════════════════════════════════

Widget _buildEnumProperties() {
  List<OverflowBoxFit> allValues = OverflowBoxFit.values;
  OverflowBoxFit firstValue = allValues.first;
  OverflowBoxFit lastValue = allValues.last;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildPropertyRow('Values count', '${allValues.length}'),
      SizedBox(height: 8),
      _buildPropertyRow('First value', firstValue.name),
      SizedBox(height: 8),
      _buildPropertyRow('Last value', lastValue.name),
      SizedBox(height: 8),
      _buildPropertyRow('First index', '${firstValue.index}'),
      SizedBox(height: 8),
      _buildPropertyRow('Last index', '${lastValue.index}'),
    ],
  );
}

Widget _buildPropertyRow(String label, String value) {
  return Row(
    children: [
      Text(
        '$label: ',
        style: TextStyle(
          color: _kSlate600,
          fontSize: 13,
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: _kCyan500.withAlpha(20),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: _kCyan700,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('OverflowBoxFit comprehensive test executing');

  // Log all enum values
  print('OverflowBoxFit values:');
  for (OverflowBoxFit value in OverflowBoxFit.values) {
    print('  ${value.name}: index=${value.index}');
  }

  OverflowBoxFit maxFit = OverflowBoxFit.max;
  OverflowBoxFit deferFit = OverflowBoxFit.deferToChild;

  print('max index: ${maxFit.index}');
  print('deferToChild index: ${deferFit.index}');
  print('max == max: ${maxFit == OverflowBoxFit.max}');
  print('max == deferToChild: ${maxFit == OverflowBoxFit.deferToChild}');

  return SingleChildScrollView(
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMainHeader(),
        SizedBox(height: 24),

        // Section 1: Enum Values Overview
        _buildSectionHeader('Enum Values', Icons.list),
        _buildCard(
          'OverflowBoxFit Values',
          Column(
            children: [
              _buildEnumValueRow(
                OverflowBoxFit.max,
                'Child fills maximum available space',
                Icons.fullscreen,
                _kCyan500,
              ),
              SizedBox(height: 12),
              _buildEnumValueRow(
                OverflowBoxFit.deferToChild,
                'Child determines its own size',
                Icons.child_care,
                _kOrange500,
              ),
            ],
          ),
        ),

        // Section 2: max vs deferToChild Demonstration
        _buildSectionHeader(
          'max vs deferToChild Demo',
          Icons.compare_arrows,
        ),
        _buildCard(
          'Visual Comparison',
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOverflowBoxDemo('Max Fit', OverflowBoxFit.max, _kCyan500),
              _buildOverflowBoxDemo(
                'Defer to Child',
                OverflowBoxFit.deferToChild,
                _kOrange500,
              ),
            ],
          ),
        ),

        // Section 3: Different Sized Children
        _buildSectionHeader('Different Sized Children', Icons.photo_size_select_large),
        _buildCard(
          'Size Variations',
          _buildChildSizeComparison(),
          accentColor: _kCyan600,
        ),

        // Section 4: SizedOverflowBox Usage
        _buildSectionHeader('SizedOverflowBox', Icons.crop_square),
        _buildCard(
          'SizedOverflowBox Demo',
          _buildSizedOverflowBoxDemo(),
          accentColor: _kOrange500,
        ),

        // Section 5: Constraint Behavior
        _buildSectionHeader('Constraint Behavior', Icons.settings_overscan),
        _buildCard(
          'Constraint Flow',
          _buildConstraintVisualization(),
        ),
        _buildCard(
          'Visual Constraint Demo',
          _buildConstraintBoxDiagram(),
          accentColor: _kCyan600,
        ),

        // Section 6: Practical Examples
        _buildSectionHeader('Practical Examples', Icons.lightbulb),
        _buildCard(
          'Real-World Use Cases',
          _buildPracticalExamples(),
          accentColor: _kOrange500,
        ),

        // Section 7: Code Examples
        _buildSectionHeader('Code Examples', Icons.code),
        _buildCard(
          'Using OverflowBoxFit.max',
          _buildCodeSnippet(
            'OverflowBox(\n'
            '  fit: OverflowBoxFit.max,\n'
            '  maxWidth: 200,\n'
            '  maxHeight: 150,\n'
            '  child: Container(\n'
            '    color: Colors.blue,\n'
            '    child: Text("Fills space"),\n'
            '  ),\n'
            ')',
          ),
          accentColor: _kCyan500,
        ),
        _buildCard(
          'Using OverflowBoxFit.deferToChild',
          _buildCodeSnippet(
            'OverflowBox(\n'
            '  fit: OverflowBoxFit.deferToChild,\n'
            '  maxWidth: 200,\n'
            '  maxHeight: 150,\n'
            '  child: Container(\n'
            '    width: 100,\n'
            '    height: 80,\n'
            '    color: Colors.orange,\n'
            '  ),\n'
            ')',
          ),
          accentColor: _kOrange500,
        ),
        _buildCard(
          'SizedOverflowBox Example',
          _buildCodeSnippet(
            'SizedOverflowBox(\n'
            '  size: Size(100, 80),\n'
            '  alignment: Alignment.center,\n'
            '  child: Container(\n'
            '    width: 150,\n'
            '    height: 100,\n'
            '    color: Colors.purple,\n'
            '  ),\n'
            ')',
          ),
          accentColor: _kRose500,
        ),

        // Section 8: Enum Properties
        _buildSectionHeader('Enum Properties', Icons.info),
        _buildCard(
          'OverflowBoxFit Properties',
          _buildEnumProperties(),
        ),

        // Footer summary
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _kSlate700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'OverflowBoxFit Demo Complete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Demonstrated: max and deferToChild fit behaviors,\n'
                'visual comparisons, SizedOverflowBox usage,\n'
                'and constraint handling patterns.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    ),
  );
}
