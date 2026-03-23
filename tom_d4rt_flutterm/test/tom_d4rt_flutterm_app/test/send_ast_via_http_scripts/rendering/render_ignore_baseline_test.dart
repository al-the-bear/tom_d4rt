// Deep demo: RenderIgnoreBaseline / IgnoreBaseline widget
// Demonstrates how IgnoreBaseline causes its child's baseline to be
// ignored during layout, particularly in Row with CrossAxisAlignment.baseline.
// Shows visual differences between baseline-participating and ignored children.

import 'package:flutter/material.dart';

Widget _buildHeader(String title, String subtitle) {
  print('Building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF00695C), Color(0xFF00897B), Color(0xFF26A69A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      boxShadow: [
        BoxShadow(
          color: Color(0x4000695C),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 6),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xCCFFFFFF),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(IconData icon, String title) {
  print('Building section: $title');
  return Padding(
    padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF00897B),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF004D40),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCard(Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFB2DFDB), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: child,
  );
}

Widget _buildLabel(String text, Color bgColor) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600),
    ),
  );
}

// Section 1: Basic baseline-aligned Row with and without IgnoreBaseline
Widget _buildBaselineComparisonRow() {
  print('Building baseline comparison row - with vs without IgnoreBaseline');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Row WITHOUT IgnoreBaseline (all participate in baseline)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFF80CBC4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Big',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF00695C)),
              ),
              SizedBox(width: 12),
              Text(
                'Medium',
                style: TextStyle(fontSize: 20, color: Color(0xFF00897B)),
              ),
              SizedBox(width: 12),
              Text(
                'Small',
                style: TextStyle(fontSize: 12, color: Color(0xFF4DB6AC)),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Row WITH IgnoreBaseline on "Medium" (it does not align to baseline)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFFCC80)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Big',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF00695C)),
              ),
              SizedBox(width: 12),
              // IgnoreBaseline wrapping causes this child to not participate
              // in baseline alignment - it falls to top of the row instead
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  'Medium (ignored)',
                  style: TextStyle(fontSize: 20, color: Color(0xFFE65100)),
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Small',
                style: TextStyle(fontSize: 12, color: Color(0xFF4DB6AC)),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _buildLabel('BASELINE ALIGNED', Color(0xFF00897B)),
            SizedBox(width: 6),
            _buildLabel('BASELINE IGNORED', Color(0xFFE65100)),
          ],
        ),
      ],
    ),
  );
}

// Section 2: Different font sizes showing baseline alignment differences
Widget _buildMixedFontSizeRow() {
  print('Building mixed font size baseline row');
  print('Font sizes: 48, 32, 16, 10 - some with baseline ignored');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mixed Font Sizes - All Baseline Aligned',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 8),
        Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('Huge', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Color(0xFF1B5E20))),
              SizedBox(width: 8),
              Text('Large', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32))),
              SizedBox(width: 8),
              Text('Normal', style: TextStyle(fontSize: 16, color: Color(0xFF388E3C))),
              SizedBox(width: 8),
              Text('Tiny', style: TextStyle(fontSize: 10, color: Color(0xFF66BB6A))),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Same Sizes - "Large" and "Tiny" Baseline Ignored',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 8),
        Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('Huge', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Color(0xFF1B5E20))),
              SizedBox(width: 8),
              // This child has its baseline ignored - will top-align in its slot
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0x33E91E63),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('Large (ignored)', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xFFC62828))),
                ),
              ),
              SizedBox(width: 8),
              Text('Normal', style: TextStyle(fontSize: 16, color: Color(0xFF388E3C))),
              SizedBox(width: 8),
              // This child also has its baseline ignored
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0x33E91E63),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('Tiny (ignored)', style: TextStyle(fontSize: 10, color: Color(0xFFC62828))),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 3: Icons mixed with text - icon baselines ignored
Widget _buildIconsWithTextRow() {
  print('Building icons mixed with text row');
  print('Icons do not have alphabetic baselines - ignoring them prevents misalignment');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icons in Baseline Row (icons align to text baseline)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Icon(Icons.star, size: 32, color: Color(0xFFFFA000)),
              SizedBox(width: 8),
              Text('Rating', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF1565C0))),
              SizedBox(width: 16),
              Icon(Icons.favorite, size: 28, color: Color(0xFFE53935)),
              SizedBox(width: 8),
              Text('Likes', style: TextStyle(fontSize: 18, color: Color(0xFF1976D2))),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Icons with Baseline Ignored (icons free from baseline constraint)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // Icon baseline ignored - it centers itself instead
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Icon(Icons.star, size: 32, color: Color(0xFFFFA000)),
              ),
              SizedBox(width: 8),
              Text('Rating', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF6A1B9A))),
              SizedBox(width: 16),
              // Icon baseline ignored
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Icon(Icons.favorite, size: 28, color: Color(0xFFE53935)),
              ),
              SizedBox(width: 8),
              Text('Likes', style: TextStyle(fontSize: 18, color: Color(0xFF7B1FA2))),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Notice: Icons shift position when their baselines are ignored',
          style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 4: Baseline widget with explicit baseline control
Widget _buildExplicitBaselineControl() {
  print('Building explicit Baseline widget control demo');
  print('Baseline widget sets an explicit baseline offset for its child');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explicit Baseline Control with Baseline Widget',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 8),
        // Row where one child uses Baseline for explicit positioning
        Container(
          height: 80,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFFFD54F)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Normal',
                style: TextStyle(fontSize: 28, color: Color(0xFFF57F17)),
              ),
              SizedBox(width: 12),
              // Explicit baseline at 60px from top
              Baseline(
                baseline: 60,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  'Baseline=60',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF00695C)),
                ),
              ),
              SizedBox(width: 12),
              // Explicit baseline at 20px from top
              Baseline(
                baseline: 20,
                baselineType: TextBaseline.alphabetic,
                child: Text(
                  'Baseline=20',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFD32F2F)),
                ),
              ),
              SizedBox(width: 12),
              // Baseline=0 effectively ignores baseline alignment
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Container(
                  padding: EdgeInsets.all(4),
                  color: Color(0x33673AB7),
                  child: Text(
                    'Baseline=0 (ignored)',
                    style: TextStyle(fontSize: 12, color: Color(0xFF4527A0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Baseline widget overrides natural baseline. Setting baseline=0 effectively ignores it.',
          style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 5: Table with baseline alignment and ignored cells
Widget _buildTableBaselineDemo() {
  print('Building Table with baseline alignment demo');
  print('Table cells can use baseline vertical alignment');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Table with Baseline Alignment',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 8),
        // Table header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF00897B),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Expanded(child: Text('Product', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13))),
              Expanded(child: Text('Price', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13))),
              Expanded(child: Text('Status', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13))),
            ],
          ),
        ),
        // Row 1: All baseline aligned
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            border: Border(bottom: BorderSide(color: Color(0xFFB2DFDB))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text('Widget Pro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF004D40))),
              ),
              Expanded(
                child: Text('\$49.99', style: TextStyle(fontSize: 16, color: Color(0xFF2E7D32))),
              ),
              Expanded(
                child: Text('Available', style: TextStyle(fontSize: 12, color: Color(0xFF00897B))),
              ),
            ],
          ),
        ),
        // Row 2: Status has baseline ignored (uses icon badge)
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xFFB2DFDB))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text('Flutter Kit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF004D40))),
              ),
              Expanded(
                child: Text('\$29.99', style: TextStyle(fontSize: 16, color: Color(0xFF2E7D32))),
              ),
              Expanded(
                // Status badge with baseline ignored
                child: Baseline(
                  baseline: 0,
                  baselineType: TextBaseline.alphabetic,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFE53935),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Sold Out', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Row 3: Price has icon prefix with baseline ignored
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            border: Border(bottom: BorderSide(color: Color(0xFFB2DFDB))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text('Dart Engine', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF004D40))),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Baseline(
                      baseline: 0,
                      baselineType: TextBaseline.alphabetic,
                      child: Icon(Icons.attach_money, size: 18, color: Color(0xFF2E7D32)),
                    ),
                    Text('99.99', style: TextStyle(fontSize: 16, color: Color(0xFF2E7D32))),
                  ],
                ),
              ),
              Expanded(
                child: Text('Pre-order', style: TextStyle(fontSize: 12, color: Color(0xFFF57F17))),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Row 2 status badge and Row 3 money icon have baselines ignored',
          style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 6: Practical pattern - decorative elements ignore baseline
Widget _buildDecorativeElementsRow() {
  print('Building practical decorative elements pattern');
  print('Decorative dots, dividers, and badges should ignore baseline');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Practical: Decorative Elements Ignoring Baseline',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 10),
        // Pattern 1: User info row with avatar ignoring baseline
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // Avatar ignores baseline
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFF00897B),
                  child: Text('JD', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(width: 10),
              Text('John Doe', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF212121))),
              SizedBox(width: 8),
              // Verification badge ignores baseline
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Icon(Icons.verified, size: 18, color: Color(0xFF1976D2)),
              ),
              SizedBox(width: 8),
              Text('Senior Developer', style: TextStyle(fontSize: 14, color: Color(0xFF757575))),
            ],
          ),
        ),
        SizedBox(height: 12),
        // Pattern 2: Price display with currency symbol baseline-aligned, decoration ignored
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFFFF8E1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // Sale tag ignores baseline
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xFFE53935),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('SALE', style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w700)),
                ),
              ),
              SizedBox(width: 8),
              Text('\$', style: TextStyle(fontSize: 16, color: Color(0xFF2E7D32))),
              Text('199', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Color(0xFF1B5E20))),
              Text('.99', style: TextStyle(fontSize: 16, color: Color(0xFF2E7D32))),
              SizedBox(width: 8),
              // Strikethrough old price
              Text('\$299.99', style: TextStyle(fontSize: 14, color: Color(0xFFBDBDBD), decoration: TextDecoration.lineThrough)),
            ],
          ),
        ),
        SizedBox(height: 12),
        // Pattern 3: Navigation breadcrumb with separator dots ignored
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('Home', style: TextStyle(fontSize: 16, color: Color(0xFF5E35B1))),
              SizedBox(width: 6),
              // Separator ignores baseline
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Icon(Icons.chevron_right, size: 20, color: Color(0xFF9E9E9E)),
              ),
              SizedBox(width: 6),
              Text('Products', style: TextStyle(fontSize: 16, color: Color(0xFF5E35B1))),
              SizedBox(width: 6),
              // Separator ignores baseline
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Icon(Icons.chevron_right, size: 20, color: Color(0xFF9E9E9E)),
              ),
              SizedBox(width: 6),
              Text('Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF311B92))),
            ],
          ),
        ),
      ],
    ),
  );
}

// Section 7: Multiple baseline types comparison
Widget _buildBaselineTypesComparison() {
  print('Building baseline types comparison - alphabetic vs ideographic');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alphabetic vs Ideographic Baseline',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 8),
        // Alphabetic baseline
        Text('TextBaseline.alphabetic:', style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
        SizedBox(height: 4),
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('Abc', style: TextStyle(fontSize: 36, color: Color(0xFF2E7D32))),
              SizedBox(width: 8),
              Text('xyz', style: TextStyle(fontSize: 20, color: Color(0xFF388E3C))),
              SizedBox(width: 8),
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF7043),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text('X', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                ),
              ),
              SizedBox(width: 8),
              Text('end', style: TextStyle(fontSize: 14, color: Color(0xFF66BB6A))),
            ],
          ),
        ),
        SizedBox(height: 12),
        // Ideographic baseline
        Text('TextBaseline.ideographic:', style: TextStyle(fontSize: 11, color: Color(0xFF616161))),
        SizedBox(height: 4),
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text('Abc', style: TextStyle(fontSize: 36, color: Color(0xFF1565C0))),
              SizedBox(width: 8),
              Text('xyz', style: TextStyle(fontSize: 20, color: Color(0xFF1976D2))),
              SizedBox(width: 8),
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.ideographic,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF7043),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text('X', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700))),
                ),
              ),
              SizedBox(width: 8),
              Text('end', style: TextStyle(fontSize: 14, color: Color(0xFF42A5F5))),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Orange box has baseline ignored in both rows - notice different positions',
          style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Section 8: Nested baseline ignore scenarios
Widget _buildNestedBaselineIgnore() {
  print('Building nested baseline ignore scenarios');
  print('Nested containers with mixed baseline behavior');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nested Containers with Mixed Baseline Behavior',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 10),
        // Outer row with baseline alignment
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFF48FB1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('Title', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF880E4F))),
              SizedBox(width: 12),
              // Nested column with its own baseline-aligned row inside
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xFFE0E0E0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nested content block', style: TextStyle(fontSize: 12, color: Color(0xFF616161))),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          // Badge inside nested structure - baseline ignored
                          Baseline(
                            baseline: 0,
                            baselineType: TextBaseline.alphabetic,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Color(0xFF4CAF50),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text('Online', style: TextStyle(fontSize: 11, color: Color(0xFF4CAF50))),
                          SizedBox(width: 12),
                          Baseline(
                            baseline: 0,
                            baselineType: TextBaseline.alphabetic,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Color(0xFFFF9800),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text('Away', style: TextStyle(fontSize: 11, color: Color(0xFFFF9800))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        // Another example: chip-style tags in a baseline row
        Text(
          'Chip Tags in Baseline Row',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF004D40)),
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('Tags:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF4527A0))),
              SizedBox(width: 8),
              // Chip with baseline ignored
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF7C4DFF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text('Flutter', style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
              SizedBox(width: 6),
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF00BFA5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text('Dart', style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
              SizedBox(width: 6),
              Baseline(
                baseline: 0,
                baselineType: TextBaseline.alphabetic,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF6D00),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text('D4rt', style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Summary section
Widget _buildSummarySection() {
  print('Building summary of IgnoreBaseline behaviors');
  return _buildCard(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb_outline, size: 20, color: Color(0xFFFFA000)),
            SizedBox(width: 8),
            Text(
              'Key Takeaways',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF004D40)),
            ),
          ],
        ),
        SizedBox(height: 10),
        _buildTakeawayItem('1', 'IgnoreBaseline prevents a child from participating in baseline alignment'),
        SizedBox(height: 6),
        _buildTakeawayItem('2', 'Useful for decorative elements (icons, badges, avatars) in text rows'),
        SizedBox(height: 6),
        _buildTakeawayItem('3', 'Baseline widget with baseline=0 achieves similar effect'),
        SizedBox(height: 6),
        _buildTakeawayItem('4', 'Works with both alphabetic and ideographic baselines'),
        SizedBox(height: 6),
        _buildTakeawayItem('5', 'Essential for mixed content rows (text + non-text widgets)'),
        SizedBox(height: 6),
        _buildTakeawayItem('6', 'RenderIgnoreBaseline is the render object behind IgnoreBaseline widget'),
      ],
    ),
  );
}

Widget _buildTakeawayItem(String number, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: Color(0xFF00897B),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(number, style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w700)),
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: 2),
          child: Text(text, style: TextStyle(fontSize: 13, color: Color(0xFF37474F))),
        ),
      ),
    ],
  );
}

dynamic build(BuildContext context) {
  print('=== RenderIgnoreBaseline Deep Demo ===');
  print('IgnoreBaseline: Makes child not participate in baseline alignment');
  print('RenderIgnoreBaseline: The RenderObject that implements this behavior');
  print('Common use case: Decorative elements in CrossAxisAlignment.baseline rows');
  print('');
  print('Building all demo sections...');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(
          'RenderIgnoreBaseline',
          'Controlling baseline participation in layout alignment',
        ),
        _buildSectionTitle(Icons.compare_arrows, '1. Baseline Alignment: With vs Without'),
        _buildBaselineComparisonRow(),
        _buildSectionTitle(Icons.format_size, '2. Mixed Font Sizes with Baseline Ignored'),
        _buildMixedFontSizeRow(),
        _buildSectionTitle(Icons.insert_emoticon, '3. Icons Mixed with Text'),
        _buildIconsWithTextRow(),
        _buildSectionTitle(Icons.tune, '4. Explicit Baseline Control'),
        _buildExplicitBaselineControl(),
        _buildSectionTitle(Icons.table_chart, '5. Table Rows with Baseline Alignment'),
        _buildTableBaselineDemo(),
        _buildSectionTitle(Icons.auto_awesome, '6. Practical: Decorative Elements Pattern'),
        _buildDecorativeElementsRow(),
        _buildSectionTitle(Icons.swap_vert, '7. Alphabetic vs Ideographic Baselines'),
        _buildBaselineTypesComparison(),
        _buildSectionTitle(Icons.layers, '8. Nested Baseline Ignore Scenarios'),
        _buildNestedBaselineIgnore(),
        _buildSectionTitle(Icons.summarize, 'Summary'),
        _buildSummarySection(),
        SizedBox(height: 32),
      ],
    ),
  );
}
