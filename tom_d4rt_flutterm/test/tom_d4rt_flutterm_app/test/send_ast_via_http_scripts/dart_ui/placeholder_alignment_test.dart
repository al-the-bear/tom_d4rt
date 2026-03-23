// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for PlaceholderAlignment from dart:ui
// PlaceholderAlignment defines alignment of inline widgets within text
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== PlaceholderAlignment Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: PlaceholderAlignment Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('PlaceholderAlignment controls how inline widgets align with text');
  print('All values: ${PlaceholderAlignment.values}');
  print('Count: ${PlaceholderAlignment.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Values
  // ═══════════════════════════════════════════════════════════════════════════

  for (final align in PlaceholderAlignment.values) {
    print('${align.name}: index=${align.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Understanding Alignments
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Alignment Options ---');
  print('baseline: Align bottom of widget with text baseline');
  print('aboveBaseline: Align bottom above the baseline');
  print('belowBaseline: Align top below the baseline');
  print('top: Align top of widget with top of text');
  print('bottom: Align bottom of widget with bottom of text');
  print('middle: Center widget vertically in text');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              _buildHeader(),
              SizedBox(height: 16),

              // Section 1: Overview
              _buildSectionCard(
                'PlaceholderAlignment Overview',
                Icons.format_indent_increase,
                Colors.teal,
                [
                  'Controls vertical alignment of inline widgets in text',
                  'Used with Text.rich and WidgetSpan',
                  'Aligns relative to text baseline or bounds',
                  'Values: ${PlaceholderAlignment.values.length} alignment modes',
                ],
              ),
              SizedBox(height: 16),

              // Section 2: All Alignments Demo
              _buildSectionHeader('ALL ALIGNMENT MODES'),
              _buildAllAlignmentsDemo(),
              SizedBox(height: 16),

              // Section 3: Baseline Alignments
              _buildSectionHeader('BASELINE ALIGNMENTS'),
              _buildBaselineAlignments(),
              SizedBox(height: 16),

              // Section 4: Bounds Alignments
              _buildSectionHeader('BOUNDS ALIGNMENTS'),
              _buildBoundsAlignments(),
              SizedBox(height: 16),

              // Section 5: Icon in Text
              _buildSectionHeader('ICON IN TEXT EXAMPLES'),
              _buildIconInTextDemo(),
              SizedBox(height: 16),

              // Section 6: Emoji/Badge Examples
              _buildSectionHeader('BADGES & EMOJIS'),
              _buildBadgeDemo(),
              SizedBox(height: 16),

              // Section 7: Size Comparison
              _buildSectionHeader('DIFFERENT WIDGET SIZES'),
              _buildSizeComparisonDemo(),
              SizedBox(height: 16),

              // Section 8: Practical Use Cases
              _buildSectionHeader('PRACTICAL USE CASES'),
              _buildPracticalUseCases(),
              SizedBox(height: 16),

              // Section 9: Multi-line Text
              _buildSectionHeader('MULTI-LINE TEXT'),
              _buildMultiLineDemo(),
              SizedBox(height: 16),

              // Section 10: Comparison Table
              _buildSectionHeader('ALIGNMENT COMPARISON'),
              _buildComparisonTable(),
              SizedBox(height: 32),

              // Footer
              _buildFooter(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildHeader() {
  return Container(
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF009688), Color(0xFF4DB6AC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF009688).withValues(alpha: 0.3),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: EdgeInsets.all(24),
    child: Column(
      children: [
        Icon(Icons.format_indent_increase, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          'PlaceholderAlignment',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Inline Widget Alignment in Text',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'dart:ui Enum • ${PlaceholderAlignment.values.length} Modes',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
        letterSpacing: 1.2,
      ),
    ),
  );
}

Widget _buildSectionCard(
  String title,
  IconData icon,
  Color color,
  List<String> points,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: points
                .map(
                  (point) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            point,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAllAlignmentsDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        for (final align in PlaceholderAlignment.values) ...[
          _buildAlignmentRow(align),
          if (align != PlaceholderAlignment.values.last) SizedBox(height: 12),
        ],
      ],
    ),
  );
}

Widget _buildAlignmentRow(PlaceholderAlignment alignment) {
  final colors = {
    PlaceholderAlignment.baseline: Colors.blue,
    PlaceholderAlignment.aboveBaseline: Colors.green,
    PlaceholderAlignment.belowBaseline: Colors.orange,
    PlaceholderAlignment.top: Colors.purple,
    PlaceholderAlignment.bottom: Colors.red,
    PlaceholderAlignment.middle: Colors.teal,
  };
  final color = colors[alignment] ?? Colors.grey;

  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Container(
          width: 100,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            alignment.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Text with ', style: TextStyle(fontSize: 16)),
                WidgetSpan(
                  alignment: alignment,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Icon(Icons.star, size: 14, color: Colors.white),
                    ),
                  ),
                ),
                TextSpan(text: ' widget', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBaselineAlignments() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alignments relative to text baseline:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        _buildBaselineExample(
          'baseline',
          PlaceholderAlignment.baseline,
          Colors.blue,
        ),
        SizedBox(height: 12),
        _buildBaselineExample(
          'aboveBaseline',
          PlaceholderAlignment.aboveBaseline,
          Colors.green,
        ),
        SizedBox(height: 12),
        _buildBaselineExample(
          'belowBaseline',
          PlaceholderAlignment.belowBaseline,
          Colors.orange,
        ),
      ],
    ),
  );
}

Widget _buildBaselineExample(
  String name,
  PlaceholderAlignment align,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 8),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Sample text '),
              WidgetSpan(
                alignment: align,
                child: Container(
                  width: 24,
                  height: 24,
                  color: color,
                  child: Center(
                    child: Text(
                      'W',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
              TextSpan(text: ' more text'),
            ],
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBoundsAlignments() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alignments relative to text bounds:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildBoundsExample(
                'top',
                PlaceholderAlignment.top,
                Colors.purple,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildBoundsExample(
                'middle',
                PlaceholderAlignment.middle,
                Colors.teal,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildBoundsExample(
                'bottom',
                PlaceholderAlignment.bottom,
                Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBoundsExample(
  String name,
  PlaceholderAlignment align,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 6),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Ag'),
              WidgetSpan(
                alignment: align,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
  );
}

Widget _buildIconInTextDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        _buildIconTextExample(
          'Email me at ',
          Icons.email,
          ' for help',
          PlaceholderAlignment.middle,
          Colors.blue,
        ),
        SizedBox(height: 12),
        _buildIconTextExample(
          'Call us ',
          Icons.phone,
          ' anytime',
          PlaceholderAlignment.middle,
          Colors.green,
        ),
        SizedBox(height: 12),
        _buildIconTextExample(
          'Rate us ',
          Icons.star,
          ' on the store',
          PlaceholderAlignment.middle,
          Colors.orange,
        ),
      ],
    ),
  );
}

Widget _buildIconTextExample(
  String before,
  IconData icon,
  String after,
  PlaceholderAlignment align,
  Color color,
) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(text: before, style: TextStyle(fontSize: 16)),
        WidgetSpan(
          alignment: align,
          child: Icon(icon, size: 18, color: color),
        ),
        TextSpan(text: after, style: TextStyle(fontSize: 16)),
      ],
    ),
  );
}

Widget _buildBadgeDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inline badges and labels:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Premium Feature ',
                style: TextStyle(fontSize: 16),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'PRO',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'New feature available ',
                style: TextStyle(fontSize: 16),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'NEW',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Special offer ', style: TextStyle(fontSize: 16)),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.pink],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '50% OFF',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

Widget _buildSizeComparisonDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How alignment affects different widget sizes:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        for (final size in [12.0, 20.0, 32.0]) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Text(
                    '${size.toInt()}px',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Text '),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Container(
                            width: size,
                            height: size,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        TextSpan(text: ' with widget'),
                      ],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _buildPracticalUseCases() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _buildUseCaseCard(
          'Status Indicator',
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Server status: ',
                  style: TextStyle(fontSize: 14),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                TextSpan(
                  text: ' Online',
                  style: TextStyle(fontSize: 14, color: Colors.green),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Action Link',
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Click ', style: TextStyle(fontSize: 14)),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.open_in_new, size: 14, color: Colors.blue),
                ),
                TextSpan(
                  text: ' to open',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Verified Badge',
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'John Doe ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(Icons.verified, size: 16, color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCaseCard(String title, Widget content) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(child: content),
      ],
    ),
  );
}

Widget _buildMultiLineDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inline widgets in wrapped text:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'This is a longer text that contains multiple '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Icon(Icons.widgets, size: 16, color: Colors.purple),
              ),
              TextSpan(
                text:
                    ' widgets inline with the text flow. When the text wraps to a new line, the ',
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    'inline',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
              TextSpan(text: ' widgets flow with it naturally.'),
            ],
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonTable() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Alignment',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Reference',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Best For',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
        _buildTableRow('baseline', 'Text baseline', 'Default'),
        _buildTableRow('aboveBaseline', 'Above baseline', 'Superscript'),
        _buildTableRow('belowBaseline', 'Below baseline', 'Subscript'),
        _buildTableRow('top', 'Text top', 'Top icons'),
        _buildTableRow('middle', 'Text center', 'Most common'),
        _buildTableRow('bottom', 'Text bottom', 'Bottom badges'),
      ],
    ),
  );
}

Widget _buildTableRow(String alignment, String reference, String bestFor) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            alignment,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(reference, style: TextStyle(fontSize: 11)),
        ),
        Expanded(
          flex: 2,
          child: Text(
            bestFor,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFooter() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'PlaceholderAlignment Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          '${PlaceholderAlignment.values.length} alignment modes for inline widgets in text. '
          'Use "middle" for most cases, baseline alignments for text-like widgets, '
          'and bounds alignments for specific positioning needs.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    ),
  );
}
