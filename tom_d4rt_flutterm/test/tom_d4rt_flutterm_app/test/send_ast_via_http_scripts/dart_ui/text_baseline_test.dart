// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for TextBaseline from dart:ui
// TextBaseline defines the horizontal alignment of text within its bounding box
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TextBaseline Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: TextBaseline Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('TextBaseline defines text alignment baselines');
  print('All values: ${TextBaseline.values}');
  print('Count: ${TextBaseline.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Values
  // ═══════════════════════════════════════════════════════════════════════════

  for (final b in TextBaseline.values) {
    print('${b.name}: index=${b.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: alphabetic
  // ═══════════════════════════════════════════════════════════════════════════

  final alphabetic = TextBaseline.alphabetic;
  print('\nalphabetic: ${alphabetic.name}');
  print('The baseline for Latin/Greek/Cyrillic text');
  print('Characters like "g", "y", "p" hang below this baseline');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: ideographic
  // ═══════════════════════════════════════════════════════════════════════════

  final ideographic = TextBaseline.ideographic;
  print('\nideographic: ${ideographic.name}');
  print('The baseline for CJK (Chinese, Japanese, Korean) text');
  print('Characters sit on the bottom edge of the em box');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Baseline Usage in Row
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Baseline alignment in Row ---');
  print('CrossAxisAlignment.baseline requires textBaseline parameter');

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
                'TextBaseline Overview',
                Icons.format_line_spacing,
                Colors.blue,
                [
                  'Defines the horizontal line at which text is aligned',
                  'Used with CrossAxisAlignment.baseline in Row/Flex',
                  'Important for aligning mixed-size text and different scripts',
                  'Values: ${TextBaseline.values.length} (alphabetic, ideographic)',
                ],
              ),

              // Section 2: Value Cards
              _buildSectionHeader('BASELINE VALUES'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildBaselineCard(
                        TextBaseline.alphabetic,
                        Colors.indigo,
                        'Latin Script',
                        'Used for Western languages\nDescenders hang below',
                        'Abcgypq',
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildBaselineCard(
                        TextBaseline.ideographic,
                        Colors.teal,
                        'CJK Script',
                        'For Chinese/Japanese/Korean\nBottom of character box',
                        '中文字',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Section 3: Visual Baseline Demo
              _buildSectionHeader('ALPHABETIC BASELINE VISUALIZATION'),
              _buildAlphabeticDemo(),
              SizedBox(height: 16),

              // Section 4: Ideographic Demo
              _buildSectionHeader('IDEOGRAPHIC BASELINE VISUALIZATION'),
              _buildIdeographicDemo(),
              SizedBox(height: 16),

              // Section 5: Mixed Font Sizes
              _buildSectionHeader('BASELINE ALIGNMENT IN ROW'),
              _buildRowAlignmentDemo(),
              SizedBox(height: 16),

              // Section 6: Comparison
              _buildSectionHeader('BASELINE COMPARISON'),
              _buildComparisonDemo(),
              SizedBox(height: 16),

              // Section 7: Practical Examples
              _buildSectionHeader('PRACTICAL EXAMPLES'),
              _buildPracticalExamples(),
              SizedBox(height: 16),

              // Section 8: RichText Alignment
              _buildSectionHeader('RICHTEXT WITH DIFFERENT SIZES'),
              _buildRichTextDemo(),
              SizedBox(height: 16),

              // Section 9: Cross-Baseline Analysis
              _buildSectionHeader('BASELINE ANALYSIS'),
              _buildBaselineAnalysis(),
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
        colors: [Color(0xFF673AB7), Color(0xFF9575CD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF673AB7).withValues(alpha: 0.3),
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
          'TextBaseline',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Horizontal Text Alignment Reference Line',
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
            'dart:ui Enum • ${TextBaseline.values.length} Values',
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

Widget _buildBaselineCard(
  TextBaseline baseline,
  Color color,
  String subtitle,
  String description,
  String sample,
) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Column(
            children: [
              Text(
                baseline.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                sample,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'index: ${baseline.index}',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAlphabeticDemo() {
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
          'Alphabetic Baseline',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        Stack(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            // Baseline indicator
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(height: 2, color: Colors.indigo),
            ),
            Positioned(
              top: 50,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'baseline',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
            // Text
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Hxpqy',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Icon(Icons.arrow_upward, size: 16, color: Colors.green),
            SizedBox(width: 4),
            Text(
              'Ascenders: H, x',
              style: TextStyle(fontSize: 12, color: Colors.green[700]),
            ),
            SizedBox(width: 16),
            Icon(Icons.arrow_downward, size: 16, color: Colors.red),
            SizedBox(width: 4),
            Text(
              'Descenders: p, q, y',
              style: TextStyle(fontSize: 12, color: Colors.red[700]),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildIdeographicDemo() {
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
          'Ideographic Baseline',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        Stack(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            // Baseline indicator at bottom
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(height: 2, color: Colors.teal),
            ),
            Positioned(
              bottom: 10,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'baseline',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
            // Text
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '中文字',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'CJK characters sit fully above the ideographic baseline',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}

Widget _buildRowAlignmentDemo() {
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
          'CrossAxisAlignment.baseline',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Aligning different text sizes on the same baseline:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),

        // Alphabetic baseline
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TextBaseline.alphabetic',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    'Big',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Text('Medium', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text('Small', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 8),
                  Text('tiny', style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 12),

        // Ideographic baseline
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TextBaseline.ideographic',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Text(
                    'Big',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8),
                  Text('Medium', style: TextStyle(fontSize: 24)),
                  SizedBox(width: 8),
                  Text('Small', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 8),
                  Text('tiny', style: TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonDemo() {
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
          'Side-by-Side Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        Row(
          children: [
            Text(
              'Latin:',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(width: 8),
            Text(
              'Hxpg',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              'CJK:',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            SizedBox(width: 8),
            Text(
              '中文',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Divider(),
        SizedBox(height: 8),

        _buildComparisonRow('Baseline type', 'alphabetic', 'ideographic'),
        _buildComparisonRow('Descenders', 'Yes (p, g, y)', 'No'),
        _buildComparisonRow('Ascenders', 'Yes (H, l, f)', 'No (full height)'),
        _buildComparisonRow('Character fit', 'Variable height', 'Fixed em box'),
      ],
    ),
  );
}

Widget _buildComparisonRow(String label, String alpha, String ideo) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            alpha,
            style: TextStyle(fontSize: 12, color: Colors.indigo),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(ideo, style: TextStyle(fontSize: 12, color: Colors.teal)),
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
        _buildExampleCard(
          'Price Display',
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '\$',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              Text(
                '99',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Text(
                '.99',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              Text(
                '/mo',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        _buildExampleCard(
          'Time Display',
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '12',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text(':', style: TextStyle(fontSize: 36)),
              Text(
                '30',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Text(
                'PM',
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        _buildExampleCard(
          'Mixed Script',
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text('Hello ', style: TextStyle(fontSize: 24)),
              Text('世界', style: TextStyle(fontSize: 24)),
              Text('!', style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildExampleCard(String title, Widget content) {
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
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Center(child: content),
      ],
    ),
  );
}

Widget _buildRichTextDemo() {
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
          'RichText with Baseline Alignment',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black),
            children: [
              TextSpan(text: 'The ', style: TextStyle(fontSize: 18)),
              TextSpan(
                text: 'quick',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              TextSpan(text: ' brown ', style: TextStyle(fontSize: 14)),
              TextSpan(
                text: 'fox',
                style: TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  color: Colors.brown,
                ),
              ),
              TextSpan(text: ' jumps', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'All text spans align on the shared baseline regardless of size or style',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}

Widget _buildBaselineAnalysis() {
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
          'When to Use Each Baseline',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        _buildAnalysisRow(
          TextBaseline.alphabetic,
          Colors.indigo,
          'Use for',
          'Latin, Greek, Cyrillic scripts, Western UIs',
        ),
        SizedBox(height: 8),
        _buildAnalysisRow(
          TextBaseline.ideographic,
          Colors.teal,
          'Use for',
          'Chinese, Japanese, Korean text, East Asian UIs',
        ),
        SizedBox(height: 16),

        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber[700], size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'For mixed content (Latin + CJK), ideographic often provides better visual harmony',
                  style: TextStyle(fontSize: 12, color: Colors.amber[900]),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnalysisRow(
  TextBaseline baseline,
  Color color,
  String label,
  String text,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          baseline.name,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 11, color: Colors.grey[500]),
            ),
            Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[800])),
          ],
        ),
      ),
    ],
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
          'TextBaseline Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          '${TextBaseline.values.length} values: alphabetic (Latin text) and ideographic (CJK text). '
          'Essential for aligning mixed-size text in Row widgets with CrossAxisAlignment.baseline.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    ),
  );
}
