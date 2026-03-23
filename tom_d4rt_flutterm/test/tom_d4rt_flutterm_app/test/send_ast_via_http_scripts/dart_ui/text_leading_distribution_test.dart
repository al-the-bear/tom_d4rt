// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for TextLeadingDistribution from dart:ui
// TextLeadingDistribution controls how leading (extra vertical space) is distributed in text
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TextLeadingDistribution Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: TextLeadingDistribution Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('TextLeadingDistribution controls how leading is distributed in text');
  print('All values: ${TextLeadingDistribution.values}');
  print('Count: ${TextLeadingDistribution.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Values
  // ═══════════════════════════════════════════════════════════════════════════

  for (final dist in TextLeadingDistribution.values) {
    print('${dist.name}: index=${dist.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Understanding Leading
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Leading Distribution ---');
  print('proportional: Leading is split proportionally between top and bottom');
  print('even: Leading is split evenly between top and bottom');

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
                'TextLeadingDistribution Overview',
                Icons.format_line_spacing,
                Colors.indigo,
                [
                  '"Leading" refers to extra vertical space in a line of text',
                  'Controls how this extra space is distributed (top vs bottom)',
                  'Used in StrutStyle and TextStyle for fine-tuned line spacing',
                  'Values: ${TextLeadingDistribution.values.length} distribution modes',
                ],
              ),
              SizedBox(height: 16),

              // Section 2: Visual Comparison
              _buildSectionHeader('LEADING DISTRIBUTION COMPARISON'),
              _buildLeadingComparisonDemo(),
              SizedBox(height: 16),

              // Section 3: Proportional Demo
              _buildSectionHeader('PROPORTIONAL DISTRIBUTION'),
              _buildProportionalDemo(),
              SizedBox(height: 16),

              // Section 4: Even Demo
              _buildSectionHeader('EVEN DISTRIBUTION'),
              _buildEvenDemo(),
              SizedBox(height: 16),

              // Section 5: Multi-line Text
              _buildSectionHeader('MULTI-LINE TEXT COMPARISON'),
              _buildMultiLineDemo(),
              SizedBox(height: 16),

              // Section 6: With Height Multiplier
              _buildSectionHeader('WITH HEIGHT MULTIPLIER'),
              _buildHeightMultiplierDemo(),
              SizedBox(height: 16),

              // Section 7: StrutStyle Integration
              _buildSectionHeader('STRUTSTYLE INTEGRATION'),
              _buildStrutStyleDemo(),
              SizedBox(height: 16),

              // Section 8: Mixed Font Sizes
              _buildSectionHeader('MIXED FONT SIZES'),
              _buildMixedFontDemo(),
              SizedBox(height: 16),

              // Section 9: Practical Examples
              _buildSectionHeader('PRACTICAL EXAMPLES'),
              _buildPracticalExamples(),
              SizedBox(height: 16),

              // Section 10: Technical Details
              _buildSectionHeader('TECHNICAL DETAILS'),
              _buildTechnicalDetails(),
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
        colors: [Color(0xFF3F51B5), Color(0xFF7986CB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF3F51B5).withValues(alpha: 0.3),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: EdgeInsets.all(24),
    child: Column(
      children: [
        Icon(Icons.format_line_spacing, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          'TextLeadingDistribution',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Line Spacing Distribution Control',
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
            'dart:ui Enum • ${TextLeadingDistribution.values.length} Modes',
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
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
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

Widget _buildLeadingComparisonDemo() {
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
        Row(
          children: [
            Expanded(
              child: _buildLeadingBox(
                'Proportional',
                TextLeadingDistribution.proportional,
                Colors.blue,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildLeadingBox(
                'Even',
                TextLeadingDistribution.even,
                Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Notice the subtle difference in vertical spacing distribution',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildLeadingBox(
  String label,
  TextLeadingDistribution distribution,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          child: Text(
            'Sample\nText\nLines',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              height: 2.0,
              leadingDistribution: distribution,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildProportionalDemo() {
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
        Row(
          children: [
            Icon(Icons.vertical_distribute, color: Colors.blue, size: 20),
            SizedBox(width: 8),
            Text(
              'TextLeadingDistribution.proportional',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Leading is distributed proportionally between the top and bottom of the line, '
            'based on the font metrics. This is the traditional behavior.',
            style: TextStyle(
              fontSize: 14,
              height: 1.8,
              leadingDistribution: TextLeadingDistribution.proportional,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Default behavior - respects font-designed proportions',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}

Widget _buildEvenDemo() {
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
        Row(
          children: [
            Icon(Icons.align_vertical_center, color: Colors.green, size: 20),
            SizedBox(width: 8),
            Text(
              'TextLeadingDistribution.even',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Leading is distributed evenly between the top and bottom of the line, '
            'creating symmetrical spacing regardless of font metrics.',
            style: TextStyle(
              fontSize: 14,
              height: 1.8,
              leadingDistribution: TextLeadingDistribution.even,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Even split - creates symmetrical vertical spacing',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
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
          'Multi-line text with height: 2.5',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Proportional',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      'Line One\nLine Two\nLine Three\nLine Four',
                      style: TextStyle(
                        fontSize: 14,
                        height: 2.5,
                        leadingDistribution:
                            TextLeadingDistribution.proportional,
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
                    'Even',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      'Line One\nLine Two\nLine Three\nLine Four',
                      style: TextStyle(
                        fontSize: 14,
                        height: 2.5,
                        leadingDistribution: TextLeadingDistribution.even,
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

Widget _buildHeightMultiplierDemo() {
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
          'Effect increases with larger height values:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        for (final h in [1.5, 2.0, 3.0]) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    'h: $h',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Sample',
                      style: TextStyle(
                        fontSize: 16,
                        height: h,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
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

Widget _buildStrutStyleDemo() {
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
          'StrutStyle with leadingDistribution:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Text with StrutStyle\n',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Using even distribution for consistent spacing',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          strutStyle: StrutStyle(
            height: 1.8,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'StrutStyle ensures consistent baseline spacing\n'
            'across different font sizes and styles in text.',
            style: TextStyle(fontSize: 11, color: Colors.grey[700]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMixedFontDemo() {
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
          'Mixed font sizes with leading distribution:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Proportional',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          height: 2.0,
                          leadingDistribution:
                              TextLeadingDistribution.proportional,
                        ),
                        children: [
                          TextSpan(
                            text: 'Big ',
                            style: TextStyle(fontSize: 24),
                          ),
                          TextSpan(
                            text: 'small ',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextSpan(
                            text: 'text',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
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
                    'Even',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          height: 2.0,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                        children: [
                          TextSpan(
                            text: 'Big ',
                            style: TextStyle(fontSize: 24),
                          ),
                          TextSpan(
                            text: 'small ',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextSpan(
                            text: 'text',
                            style: TextStyle(fontSize: 18),
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
      ],
    ),
  );
}

Widget _buildPracticalExamples() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _buildPracticalExample(
          'Paragraph Spacing',
          'Even distribution for balanced paragraphs',
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'First paragraph line.\nSecond paragraph line.\nThird paragraph line.',
              style: TextStyle(
                fontSize: 13,
                height: 2.0,
                leadingDistribution: TextLeadingDistribution.even,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildPracticalExample(
          'Button Text',
          'Proportional for natural font centering',
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(
              'Click Me',
              style: TextStyle(
                fontSize: 16,
                height: 1.0,
                leadingDistribution: TextLeadingDistribution.proportional,
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildPracticalExample(
          'List Items',
          'Even distribution for consistent spacing',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final item in ['First item', 'Second item', 'Third item'])
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        item,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          leadingDistribution: TextLeadingDistribution.even,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPracticalExample(String title, String description, Widget sample) {
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Center(child: sample),
      ],
    ),
  );
}

Widget _buildTechnicalDetails() {
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
                  'Mode',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Distribution',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Use Case',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        _buildTechRow('proportional', 'Based on font metrics', 'Natural text'),
        _buildTechRow('even', '50% top / 50% bottom', 'Aligned UI'),
        Container(
          padding: EdgeInsets.all(12),
          child: Text(
            'Leading = (line height × font size) - font ascent - font descent',
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget _buildTechRow(String mode, String distribution, String useCase) {
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
            mode,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(distribution, style: TextStyle(fontSize: 12)),
        ),
        Expanded(
          flex: 2,
          child: Text(
            useCase,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
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
          'TextLeadingDistribution Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          '${TextLeadingDistribution.values.length} modes for controlling how leading (extra vertical space) '
          'is distributed between the top and bottom of text lines. '
          'Use proportional for natural appearance, even for UI alignment.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    ),
  );
}
