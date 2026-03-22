// D4rt test script: Deep demo for OverflowBoxFit from rendering
//
// OverflowBoxFit is an enum that defines how an OverflowBox sizes its child
// within the parent's constraints. This enum determines whether the child
// should expand to fill maximum available space or size itself naturally.
//
// Values:
//   max - Child receives maximum constraints from parent
//   deferToChild - Child determines its own size within constraints
//
// Key characteristics:
//   - Controls child sizing in overflow scenarios
//   - Affects how constraints propagate to child widgets
//   - Works with OverflowBox and SizedOverflowBox
//   - Determines whether child fills space or shrinks to content
//
// Common use cases:
//   - Creating overlays that expand to fill containers
//   - Building content that sizes naturally within overflow bounds
//   - Implementing floating elements with flexible sizing
//   - Managing constraint propagation in complex layouts
//
// This demo visualizes the OverflowBoxFit enum behavior comprehensively.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// COLOR PALETTE
// ═══════════════════════════════════════════════════════════════════════════════

Color _kPrimary50 = Color(0xFFEDE7F6);
Color _kPrimary100 = Color(0xFFD1C4E9);
Color _kPrimary200 = Color(0xFFB39DDB);
Color _kPrimary300 = Color(0xFF9575CD);
Color _kPrimary400 = Color(0xFF7E57C2);
Color _kPrimary500 = Color(0xFF673AB7);
Color _kPrimary600 = Color(0xFF5E35B1);
Color _kPrimary700 = Color(0xFF512DA8);
Color _kPrimary800 = Color(0xFF4527A0);

Color _kSecondary500 = Color(0xFF00BCD4);
Color _kSecondary600 = Color(0xFF00ACC1);
Color _kSecondary700 = Color(0xFF0097A7);

Color _kAccent500 = Color(0xFFFF5722);
Color _kAccent600 = Color(0xFFF4511E);
Color _kAccent700 = Color(0xFFE64A19);

Color _kSuccess500 = Color(0xFF4CAF50);
Color _kSuccess600 = Color(0xFF43A047);

Color _kWarning500 = Color(0xFFFF9800);
Color _kWarning600 = Color(0xFFFB8C00);

Color _kSlate100 = Color(0xFFF1F5F9);
Color _kSlate200 = Color(0xFFE2E8F0);
Color _kSlate300 = Color(0xFFCBD5E1);
Color _kSlate400 = Color(0xFF94A3B8);
Color _kSlate500 = Color(0xFF64748B);
Color _kSlate600 = Color(0xFF475569);
Color _kSlate700 = Color(0xFF334155);
Color _kSlate800 = Color(0xFF1E293B);

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMainHeader() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPrimary800, _kPrimary600, _kPrimary400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: _kPrimary800.withAlpha(120),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.open_in_full, color: Colors.white, size: 56),
        SizedBox(height: 16),
        Text(
          'OverflowBoxFit',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Enum for how OverflowBox sizes its child',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withAlpha(220),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEnumBadge('max', Icons.fullscreen, _kSecondary500),
            SizedBox(width: 16),
            _buildEnumBadge('deferToChild', Icons.child_care, _kAccent500),
          ],
        ),
      ],
    ),
  );
}

Widget _buildEnumBadge(String label, IconData icon, Color bgColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: bgColor.withAlpha(180),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withAlpha(100), width: 1),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 18),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title, IconData icon, Color color) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withAlpha(180)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: color.withAlpha(80),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        SizedBox(width: 14),
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

Widget _buildInfoCard(String title, Widget content, {Color? accentColor}) {
  Color color = accentColor ?? _kPrimary500;
  return Container(
    margin: EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withAlpha(60), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 10,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17,
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

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: _kSlate700,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _kSlate600,
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeSnippet(String code, {Color? bgColor}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: bgColor ?? _kSlate800,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFFE2E8F0),
        height: 1.5,
      ),
    ),
  );
}

Widget _buildDiagramBox(String label, Color color, {IconData? icon, double size = 80}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color.withAlpha(40),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) Icon(icon, color: color, size: 22),
        if (icon != null) SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildArrowDown(Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 2, height: 16, color: color),
      Icon(Icons.arrow_drop_down, color: color, size: 20),
    ],
  );
}

Widget _buildArrowRight(Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 16, height: 2, color: color),
      Icon(Icons.arrow_right, color: color, size: 20),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: OVERFLOW BOX FIT OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('OverflowBoxFit Overview', Icons.info_outline, _kPrimary600),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OverflowBoxFit is an enumeration that controls sizing behavior '
                'when using OverflowBox or SizedOverflowBox widgets. It determines '
                'how the child widget receives and responds to layout constraints '
                'from its parent container.',
                style: TextStyle(color: _kSlate600, fontSize: 14, height: 1.6),
              ),
              SizedBox(height: 20),
              _buildInfoCard(
                'Enum Definition',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCodeSnippet(
                      'enum OverflowBoxFit {\n'
                      '  max,\n'
                      '  deferToChild,\n'
                      '}',
                    ),
                    SizedBox(height: 16),
                    _buildInfoRow('Source', 'package:flutter/rendering.dart'),
                    _buildInfoRow('Values', '2 (max, deferToChild)'),
                    _buildInfoRow('Default', 'OverflowBoxFit.max'),
                  ],
                ),
                accentColor: _kPrimary500,
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _kPrimary50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _kPrimary200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: _kPrimary600, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'Key Concept',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _kPrimary700,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'The fit property affects how constraints propagate from '
                      'the OverflowBox to its child. With "max", the child is '
                      'encouraged to fill all available space. With "deferToChild", '
                      'the child sizes itself according to its natural dimensions.',
                      style: TextStyle(color: _kSlate600, fontSize: 13, height: 1.5),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildValueSummaryTile(
                      'max',
                      'Fills available space',
                      Icons.fullscreen,
                      _kSecondary600,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildValueSummaryTile(
                      'deferToChild',
                      'Natural child size',
                      Icons.child_care,
                      _kAccent600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildValueSummaryTile(String value, String description, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withAlpha(25),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            color: _kSlate600,
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: MAX VALUE DEMO
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildMaxValueSection() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('OverflowBoxFit.max Demo', Icons.fullscreen, _kSecondary600),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When fit is set to OverflowBoxFit.max, the child widget receives '
                'maximum constraints. This causes the child to expand and fill '
                'all available space within the OverflowBox boundaries.',
                style: TextStyle(color: _kSlate600, fontSize: 14, height: 1.6),
              ),
              SizedBox(height: 20),
              _buildInfoCard(
                'Behavior Characteristics',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBehaviorItem(
                      'Child receives maxWidth and maxHeight',
                      Icons.expand,
                      _kSecondary600,
                    ),
                    _buildBehaviorItem(
                      'Child fills all allocated space',
                      Icons.crop_square,
                      _kSecondary600,
                    ),
                    _buildBehaviorItem(
                      'Similar to how Expanded works in Flex',
                      Icons.compare_arrows,
                      _kSecondary600,
                    ),
                    _buildBehaviorItem(
                      'Default behavior for OverflowBox',
                      Icons.star,
                      _kSecondary600,
                    ),
                  ],
                ),
                accentColor: _kSecondary600,
              ),
              SizedBox(height: 16),
              _buildInfoCard(
                'Code Example',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCodeSnippet(
                      'OverflowBox(\n'
                      '  fit: OverflowBoxFit.max,\n'
                      '  maxWidth: 200,\n'
                      '  maxHeight: 150,\n'
                      '  child: Container(\n'
                      '    color: Colors.blue,\n'
                      '    // Child fills 200x150\n'
                      '  ),\n'
                      ')',
                    ),
                  ],
                ),
                accentColor: _kSlate700,
              ),
              SizedBox(height: 16),
              _buildMaxVisualDemo(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBehaviorItem(String text, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: _kSlate700, fontSize: 13),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMaxVisualDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kSecondary500.withAlpha(15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kSecondary500.withAlpha(50)),
    ),
    child: Column(
      children: [
        Text(
          'Visual Demonstration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _kSecondary600,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(
                    color: _kSlate200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kSlate400, width: 2, style: BorderStyle.solid),
                  ),
                  child: Center(
                    child: Text(
                      'Parent\n120x100',
                      style: TextStyle(color: _kSlate600, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text('Before', style: TextStyle(color: _kSlate500, fontSize: 11)),
              ],
            ),
            SizedBox(width: 20),
            _buildArrowRight(_kSecondary500),
            SizedBox(width: 20),
            Column(
              children: [
                Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(
                    color: _kSecondary500.withAlpha(100),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kSecondary600, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      'Child fills\n120x100',
                      style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text('With fit: max', style: TextStyle(color: _kSecondary600, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Child expands to fill the maximum available space',
            style: TextStyle(color: _kSlate600, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: DEFER TO CHILD VALUE DEMO
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildDeferToChildSection() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('OverflowBoxFit.deferToChild Demo', Icons.child_care, _kAccent600),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When fit is set to OverflowBoxFit.deferToChild, the child widget '
                'determines its own size. The OverflowBox passes constraints that '
                'allow the child to be as small or large as it naturally wants.',
                style: TextStyle(color: _kSlate600, fontSize: 14, height: 1.6),
              ),
              SizedBox(height: 20),
              _buildInfoCard(
                'Behavior Characteristics',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBehaviorItem(
                      'Child determines its own dimensions',
                      Icons.straighten,
                      _kAccent600,
                    ),
                    _buildBehaviorItem(
                      'Constraints allow shrinking to zero',
                      Icons.compress,
                      _kAccent600,
                    ),
                    _buildBehaviorItem(
                      'Child uses intrinsic size when possible',
                      Icons.center_focus_strong,
                      _kAccent600,
                    ),
                    _buildBehaviorItem(
                      'Useful for content-sized overlays',
                      Icons.layers,
                      _kAccent600,
                    ),
                  ],
                ),
                accentColor: _kAccent600,
              ),
              SizedBox(height: 16),
              _buildInfoCard(
                'Code Example',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCodeSnippet(
                      'OverflowBox(\n'
                      '  fit: OverflowBoxFit.deferToChild,\n'
                      '  maxWidth: 200,\n'
                      '  maxHeight: 150,\n'
                      '  child: Container(\n'
                      '    width: 80,\n'
                      '    height: 60,\n'
                      '    color: Colors.orange,\n'
                      '    // Child stays 80x60\n'
                      '  ),\n'
                      ')',
                    ),
                  ],
                ),
                accentColor: _kSlate700,
              ),
              SizedBox(height: 16),
              _buildDeferToChildVisualDemo(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDeferToChildVisualDemo() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kAccent500.withAlpha(15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kAccent500.withAlpha(50)),
    ),
    child: Column(
      children: [
        Text(
          'Visual Demonstration',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _kAccent600,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(
                    color: _kSlate200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kSlate400, width: 2, style: BorderStyle.solid),
                  ),
                  child: Center(
                    child: Text(
                      'Parent\n120x100',
                      style: TextStyle(color: _kSlate600, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text('Before', style: TextStyle(color: _kSlate500, fontSize: 11)),
              ],
            ),
            SizedBox(width: 20),
            _buildArrowRight(_kAccent500),
            SizedBox(width: 20),
            Column(
              children: [
                Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(
                    color: _kSlate100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kSlate300, width: 2),
                  ),
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 45,
                      decoration: BoxDecoration(
                        color: _kAccent500,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '60x45',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text('With deferToChild', style: TextStyle(color: _kAccent600, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Child uses its natural intrinsic size',
            style: TextStyle(color: _kSlate600, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: COMPARISON GRID
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildComparisonGridSection() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Comparison Grid', Icons.compare, _kPrimary600),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Side-by-side comparison of OverflowBoxFit values showing '
                'how each affects child sizing and constraint propagation.',
                style: TextStyle(color: _kSlate600, fontSize: 14, height: 1.6),
              ),
              SizedBox(height: 20),
              _buildComparisonTable(),
              SizedBox(height: 20),
              _buildSideBySideVisualization(),
              SizedBox(height: 20),
              _buildConstraintFlowDiagram(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonTable() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: _kSlate300),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPrimary100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(9),
              topRight: Radius.circular(9),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Property',
                  style: TextStyle(fontWeight: FontWeight.bold, color: _kPrimary700, fontSize: 13),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'max',
                  style: TextStyle(fontWeight: FontWeight.bold, color: _kSecondary600, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'deferToChild',
                  style: TextStyle(fontWeight: FontWeight.bold, color: _kAccent600, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        _buildTableRow('Min constraints', '0', '0', false),
        _buildTableRow('Max constraints', 'Parent max', 'Parent max', true),
        _buildTableRow('Child sizing', 'Fills space', 'Intrinsic size', false),
        _buildTableRow('Default', 'Yes', 'No', true),
        _buildTableRow('Use case', 'Fill containers', 'Content-sized', false),
      ],
    ),
  );
}

Widget _buildTableRow(String property, String maxValue, String deferValue, bool alternate) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: alternate ? _kSlate100 : Colors.white,
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            property,
            style: TextStyle(fontWeight: FontWeight.w500, color: _kSlate700, fontSize: 12),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            maxValue,
            style: TextStyle(color: _kSecondary600, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            deferValue,
            style: TextStyle(color: _kAccent600, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSideBySideVisualization() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kSlate100,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'Side-by-Side Visual Comparison',
          style: TextStyle(fontWeight: FontWeight.bold, color: _kSlate700, fontSize: 15),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _kSecondary500.withAlpha(80),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kSecondary600, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      'max\nFILLS',
                      style: TextStyle(color: _kSecondary700, fontSize: 11, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _kSecondary500,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'OverflowBoxFit.max',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _kSlate200,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _kSlate400, width: 2),
                  ),
                  child: Center(
                    child: Container(
                      width: 50,
                      height: 35,
                      decoration: BoxDecoration(
                        color: _kAccent500,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'defer',
                          style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _kAccent500,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'deferToChild',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildConstraintFlowDiagram() {
  return _buildInfoCard(
    'Constraint Flow Diagram',
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDiagramBox('Parent\nConstraints', _kPrimary600, icon: Icons.dashboard, size: 90),
          ],
        ),
        _buildArrowDown(_kPrimary400),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDiagramBox('OverflowBox\n(fit)', _kPrimary500, icon: Icons.open_in_full, size: 90),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                _buildArrowDown(_kSecondary500),
                SizedBox(height: 4),
                _buildDiagramBox('max\nConstrained', _kSecondary500, size: 70),
              ],
            ),
            Column(
              children: [
                _buildArrowDown(_kAccent500),
                SizedBox(height: 4),
                _buildDiagramBox('defer\nFlexible', _kAccent500, size: 70),
              ],
            ),
          ],
        ),
      ],
    ),
    accentColor: _kPrimary500,
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: OVERFLOW BOX USAGE EXAMPLES
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildUsageExamplesSection() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('OverflowBox Usage Examples', Icons.code, _kSuccess600),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Practical examples demonstrating OverflowBoxFit in real-world '
                'scenarios with OverflowBox and SizedOverflowBox widgets.',
                style: TextStyle(color: _kSlate600, fontSize: 14, height: 1.6),
              ),
              SizedBox(height: 20),
              _buildUsageExample1(),
              SizedBox(height: 16),
              _buildUsageExample2(),
              SizedBox(height: 16),
              _buildUsageExample3(),
              SizedBox(height: 16),
              _buildUsageExample4(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildUsageExample1() {
  return _buildInfoCard(
    'Example 1: Full-Width Overlay',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Using fit: max to create an overlay that fills the container.',
          style: TextStyle(color: _kSlate600, fontSize: 13),
        ),
        SizedBox(height: 12),
        _buildCodeSnippet(
          'Stack(\n'
          '  children: [\n'
          '    Image.network(imageUrl),\n'
          '    OverflowBox(\n'
          '      fit: OverflowBoxFit.max,\n'
          '      alignment: Alignment.bottomCenter,\n'
          '      maxHeight: 60,\n'
          '      child: Container(\n'
          '        color: Colors.black54,\n'
          '        // Fills full width\n'
          '        child: Text("Caption"),\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kSuccess500.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: _kSuccess600, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Child fills full width regardless of content size',
                  style: TextStyle(color: _kSuccess600, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    accentColor: _kSuccess500,
  );
}

Widget _buildUsageExample2() {
  return _buildInfoCard(
    'Example 2: Content-Sized Popup',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Using deferToChild to create a popup sized by its content.',
          style: TextStyle(color: _kSlate600, fontSize: 13),
        ),
        SizedBox(height: 12),
        _buildCodeSnippet(
          'OverflowBox(\n'
          '  fit: OverflowBoxFit.deferToChild,\n'
          '  alignment: Alignment.center,\n'
          '  child: Card(\n'
          '    child: Padding(\n'
          '      padding: EdgeInsets.all(16),\n'
          '      child: Column(\n'
          '        mainAxisSize: MainAxisSize.min,\n'
          '        children: [\n'
          '          Text("Alert"),\n'
          '          Text("Message content"),\n'
          '        ],\n'
          '      ),\n'
          '    ),\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kAccent500.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: _kAccent600, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Popup sizes itself based on content, not container',
                  style: TextStyle(color: _kAccent600, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    accentColor: _kAccent500,
  );
}

Widget _buildUsageExample3() {
  return _buildInfoCard(
    'Example 3: SizedOverflowBox with max',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SizedOverflowBox specifies exact size while child uses fit behavior.',
          style: TextStyle(color: _kSlate600, fontSize: 13),
        ),
        SizedBox(height: 12),
        _buildCodeSnippet(
          'SizedOverflowBox(\n'
          '  size: Size(200, 150),\n'
          '  fit: OverflowBoxFit.max,\n'
          '  alignment: Alignment.topLeft,\n'
          '  child: ColoredBox(\n'
          '    color: Colors.purple,\n'
          '    child: FlutterLogo(size: 300),\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kPrimary500.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: _kPrimary600, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Box is 200x150, child can overflow with max constraints',
                  style: TextStyle(color: _kPrimary600, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    accentColor: _kPrimary500,
  );
}

Widget _buildUsageExample4() {
  return _buildInfoCard(
    'Example 4: Dynamic Constraint Override',
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Using OverflowBox to break parent constraints dynamically.',
          style: TextStyle(color: _kSlate600, fontSize: 13),
        ),
        SizedBox(height: 12),
        _buildCodeSnippet(
          'Container(\n'
          '  width: 100,\n'
          '  height: 100,\n'
          '  child: OverflowBox(\n'
          '    fit: OverflowBoxFit.max,\n'
          '    minWidth: 0,\n'
          '    maxWidth: 250, // Exceeds parent\n'
          '    minHeight: 0,\n'
          '    maxHeight: 250,\n'
          '    child: Container(\n'
          '      color: Colors.red.withAlpha(128),\n'
          '      // Renders 250x250 despite parent\n'
          '    ),\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kWarning500.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber, color: _kWarning600, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Child overflows parent bounds with custom constraints',
                  style: TextStyle(color: _kWarning600, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    accentColor: _kWarning500,
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: VISUAL SIZING DEMONSTRATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildVisualSizingSection() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(12),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Visual Sizing Demonstration', Icons.aspect_ratio, _kPrimary700),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Interactive visualization showing how OverflowBoxFit affects '
                'child sizing across different parent constraint scenarios.',
                style: TextStyle(color: _kSlate600, fontSize: 14, height: 1.6),
              ),
              SizedBox(height: 20),
              _buildSizingScenario1(),
              SizedBox(height: 20),
              _buildSizingScenario2(),
              SizedBox(height: 20),
              _buildSizingScenario3(),
              SizedBox(height: 20),
              _buildSizingSummary(),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSizingScenario1() {
  return _buildInfoCard(
    'Scenario 1: Tight Parent Constraints',
    Column(
      children: [
        Text(
          'Parent: 150x100 | Child prefers: 80x60',
          style: TextStyle(fontWeight: FontWeight.w500, color: _kSlate700, fontSize: 13),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSizingDemoBox(
              'fit: max',
              150,
              100,
              150,
              100,
              _kSecondary500,
            ),
            _buildSizingDemoBox(
              'deferToChild',
              150,
              100,
              80,
              60,
              _kAccent500,
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kSecondary500.withAlpha(20),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Child: 150x100',
                  style: TextStyle(color: _kSecondary600, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _kAccent500.withAlpha(20),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Child: 80x60',
                  style: TextStyle(color: _kAccent600, fontSize: 11),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
    accentColor: _kPrimary500,
  );
}

Widget _buildSizingScenario2() {
  return _buildInfoCard(
    'Scenario 2: Unconstrained Parent',
    Column(
      children: [
        Text(
          'Parent: unbounded | Child prefers: 100x75',
          style: TextStyle(fontWeight: FontWeight.w500, color: _kSlate700, fontSize: 13),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 130,
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(color: _kSlate300, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 75,
                      decoration: BoxDecoration(
                        color: _kSecondary500.withAlpha(100),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '100x75',
                          style: TextStyle(color: _kSecondary700, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text('max (uses child size)', style: TextStyle(color: _kSecondary600, fontSize: 10)),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 130,
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(color: _kSlate300, width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 75,
                      decoration: BoxDecoration(
                        color: _kAccent500.withAlpha(100),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          '100x75',
                          style: TextStyle(color: _kAccent700, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 6),
                Text('deferToChild', style: TextStyle(color: _kAccent600, fontSize: 10)),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kSlate100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'When parent is unbounded, both fit values produce similar results',
            style: TextStyle(color: _kSlate600, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    accentColor: _kPrimary500,
  );
}

Widget _buildSizingScenario3() {
  return _buildInfoCard(
    'Scenario 3: Oversized Child',
    Column(
      children: [
        Text(
          'Parent: 100x80 | Child prefers: 200x150',
          style: TextStyle(fontWeight: FontWeight.w500, color: _kSlate700, fontSize: 13),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: _kSlate400, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Container(
                      width: 140,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _kSecondary500.withAlpha(60),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _kSecondary500, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          'Overflows',
                          style: TextStyle(color: _kSecondary700, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text('max: fills max', style: TextStyle(color: _kSecondary600, fontSize: 10)),
              ],
            ),
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: _kSlate400, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Container(
                      width: 140,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _kAccent500.withAlpha(60),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _kAccent500, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          'Natural size',
                          style: TextStyle(color: _kAccent700, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text('defer: 200x150', style: TextStyle(color: _kAccent600, fontSize: 10)),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _kWarning500.withAlpha(20),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.warning, color: _kWarning600, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Both allow overflow; max constraints differ in propagation',
                  style: TextStyle(color: _kWarning600, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    accentColor: _kWarning500,
  );
}

Widget _buildSizingDemoBox(
  String label,
  double parentW,
  double parentH,
  double childW,
  double childH,
  Color color,
) {
  double scale = 0.8;
  return Column(
    children: [
      Container(
        width: parentW * scale,
        height: parentH * scale,
        decoration: BoxDecoration(
          border: Border.all(color: _kSlate400, width: 2),
          borderRadius: BorderRadius.circular(8),
          color: _kSlate100,
        ),
        child: Center(
          child: Container(
            width: childW * scale,
            height: childH * scale,
            decoration: BoxDecoration(
              color: color.withAlpha(100),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: color, width: 2),
            ),
          ),
        ),
      ),
      SizedBox(height: 6),
      Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    ],
  );
}

Widget _buildSizingSummary() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPrimary100, _kPrimary50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPrimary300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: _kPrimary700, size: 20),
            SizedBox(width: 10),
            Text(
              'Sizing Behavior Summary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _kPrimary700,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildSummaryRow(
          Icons.fullscreen,
          'max',
          'Child expands to fill parent constraints',
          _kSecondary600,
        ),
        SizedBox(height: 8),
        _buildSummaryRow(
          Icons.child_care,
          'deferToChild',
          'Child uses its preferred intrinsic size',
          _kAccent600,
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Choose "max" when child should fill space, '
            '"deferToChild" when child should size itself.',
            style: TextStyle(color: _kSlate600, fontSize: 12, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryRow(IconData icon, String value, String description, Color color) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withAlpha(30),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: color, size: 16),
      ),
      SizedBox(width: 10),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(
          description,
          style: TextStyle(color: _kSlate600, fontSize: 12),
        ),
      ),
    ],
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN DEMO WIDGET
// ═══════════════════════════════════════════════════════════════════════════════

Widget build() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMainHeader(),
              SizedBox(height: 24),
              _buildOverviewSection(),
              SizedBox(height: 24),
              _buildMaxValueSection(),
              SizedBox(height: 24),
              _buildDeferToChildSection(),
              SizedBox(height: 24),
              _buildComparisonGridSection(),
              SizedBox(height: 24),
              _buildUsageExamplesSection(),
              SizedBox(height: 24),
              _buildVisualSizingSection(),
              SizedBox(height: 24),
              _buildFooter(),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildFooter() {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _kSlate800,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.open_in_full, color: _kPrimary300, size: 24),
            SizedBox(width: 10),
            Text(
              'OverflowBoxFit Demo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Demonstrating enum values for OverflowBox child sizing behavior',
          style: TextStyle(color: _kSlate300, fontSize: 12),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFooterBadge('max', _kSecondary500),
            SizedBox(width: 12),
            _buildFooterBadge('deferToChild', _kAccent500),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: _kSlate600, thickness: 1),
        SizedBox(height: 12),
        Text(
          'Flutter Rendering Library | OverflowBoxFit Enum',
          style: TextStyle(color: _kSlate500, fontSize: 11),
        ),
      ],
    ),
  );
}

Widget _buildFooterBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color.withAlpha(50),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
