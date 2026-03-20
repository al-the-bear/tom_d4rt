// D4rt test script: Deep Demo for TextDecorationStyle from dart:ui
// TextDecorationStyle defines the style of text decorations (underline, etc.)
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== TextDecorationStyle Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: TextDecorationStyle Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('TextDecorationStyle defines how text decorations are drawn');
  print('All values: ${TextDecorationStyle.values}');
  print('Count: ${TextDecorationStyle.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Values
  // ═══════════════════════════════════════════════════════════════════════════

  for (final s in TextDecorationStyle.values) {
    print('${s.name}: index=${s.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Each Style
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Decoration Styles ---');
  print('solid: A single solid line');
  print('double: Two parallel solid lines');
  print('dotted: A series of dots');
  print('dashed: A series of dashes');
  print('wavy: A wavy (squiggly) line');

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
                'TextDecorationStyle Overview',
                Icons.format_underlined,
                Colors.purple,
                [
                  'Defines the visual style of text decorations',
                  'Used with TextDecoration (underline, overline, lineThrough)',
                  'Applied via TextStyle.decorationStyle property',
                  'Values: ${TextDecorationStyle.values.length} styles available',
                ],
              ),
              SizedBox(height: 16),

              // Section 2: All Styles Demo
              _buildSectionHeader('ALL DECORATION STYLES'),
              _buildAllStylesDemo(),
              SizedBox(height: 16),

              // Section 3: Underline Examples
              _buildSectionHeader('UNDERLINE STYLES'),
              _buildUnderlineDemo(),
              SizedBox(height: 16),

              // Section 4: Strikethrough Examples
              _buildSectionHeader('STRIKETHROUGH STYLES'),
              _buildStrikethroughDemo(),
              SizedBox(height: 16),

              // Section 5: Overline Examples
              _buildSectionHeader('OVERLINE STYLES'),
              _buildOverlineDemo(),
              SizedBox(height: 16),

              // Section 6: Combined Demo
              _buildSectionHeader('COMBINED DECORATIONS'),
              _buildCombinedDemo(),
              SizedBox(height: 16),

              // Section 7: Color Variations
              _buildSectionHeader('DECORATION COLORS'),
              _buildColorDemo(),
              SizedBox(height: 16),

              // Section 8: Thickness Variations
              _buildSectionHeader('DECORATION THICKNESS'),
              _buildThicknessDemo(),
              SizedBox(height: 16),

              // Section 9: Use Cases
              _buildSectionHeader('PRACTICAL USE CASES'),
              _buildUseCasesDemo(),
              SizedBox(height: 16),

              // Section 10: Style Comparison
              _buildSectionHeader('STYLE COMPARISON'),
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
        colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF9C27B0).withValues(alpha: 0.3),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: EdgeInsets.all(24),
    child: Column(
      children: [
        Icon(Icons.format_underlined, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          'TextDecorationStyle',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Visual Style of Text Decorations',
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
            'dart:ui Enum • ${TextDecorationStyle.values.length} Styles',
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

Widget _buildAllStylesDemo() {
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
        for (final style in TextDecorationStyle.values) ...[
          _buildStyleRow(style),
          if (style != TextDecorationStyle.values.last) SizedBox(height: 16),
        ],
      ],
    ),
  );
}

Widget _buildStyleRow(TextDecorationStyle style) {
  final colors = {
    TextDecorationStyle.solid: Colors.blue,
    TextDecorationStyle.double: Colors.green,
    TextDecorationStyle.dotted: Colors.orange,
    TextDecorationStyle.dashed: Colors.red,
    TextDecorationStyle.wavy: Colors.purple,
  };
  final color = colors[style] ?? Colors.grey;

  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Container(
          width: 80,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            style.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            'Sample Text',
            style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.underline,
              decorationStyle: style,
              decorationColor: color,
              decorationThickness: 2,
            ),
          ),
        ),
        Text(
          'idx: ${style.index}',
          style: TextStyle(fontSize: 10, color: Colors.grey[500]),
        ),
      ],
    ),
  );
}

Widget _buildUnderlineDemo() {
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
          'TextDecoration.underline with each style:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _buildDecorationChip(
              'Solid',
              TextDecorationStyle.solid,
              Colors.blue,
            ),
            _buildDecorationChip(
              'Double',
              TextDecorationStyle.double,
              Colors.green,
            ),
            _buildDecorationChip(
              'Dotted',
              TextDecorationStyle.dotted,
              Colors.orange,
            ),
            _buildDecorationChip(
              'Dashed',
              TextDecorationStyle.dashed,
              Colors.red,
            ),
            _buildDecorationChip(
              'Wavy',
              TextDecorationStyle.wavy,
              Colors.purple,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildDecorationChip(
  String label,
  TextDecorationStyle style,
  Color color,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
        decorationStyle: style,
        decorationColor: color,
        decorationThickness: 2,
      ),
    ),
  );
}

Widget _buildStrikethroughDemo() {
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
          'TextDecoration.lineThrough with each style:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        for (final style in TextDecorationStyle.values) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Text(
                    style.name,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
                Text(
                  'Crossed out text',
                  style: TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.lineThrough,
                    decorationStyle: style,
                    decorationColor: Colors.red,
                    decorationThickness: 2,
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

Widget _buildOverlineDemo() {
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
          'TextDecoration.overline with each style:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final style in TextDecorationStyle.values)
              Column(
                children: [
                  Text(
                    'ABC',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.overline,
                      decorationStyle: style,
                      decorationColor: Colors.teal,
                      decorationThickness: 2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    style.name,
                    style: TextStyle(fontSize: 9, color: Colors.grey[500]),
                  ),
                ],
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCombinedDemo() {
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
          'Combined decorations (underline + overline):',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            'Combined Decoration',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.combine([
                TextDecoration.underline,
                TextDecoration.overline,
              ]),
              decorationStyle: TextDecorationStyle.wavy,
              decorationColor: Colors.purple,
              decorationThickness: 2,
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Note: When combining decorations, they share the same style',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _buildColorDemo() {
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
          'Solid style with different colors:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            for (final color in [
              Colors.red,
              Colors.orange,
              Colors.green,
              Colors.blue,
              Colors.purple,
              Colors.pink,
            ])
              Text(
                'Colored',
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: color,
                  decorationThickness: 3,
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildThicknessDemo() {
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
          'Wavy style with different thicknesses:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        for (final thickness in [1.0, 2.0, 3.0, 4.0]) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Text(
                    '${thickness}x',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
                Text(
                  'Sample Text',
                  style: TextStyle(
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.wavy,
                    decorationColor: Colors.purple,
                    decorationThickness: thickness,
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

Widget _buildUseCasesDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _buildUseCaseCard(
          'Hyperlinks',
          'Solid underline for clickable text',
          Text(
            'Click here to learn more',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Spell Check Errors',
          'Wavy red underline for spelling mistakes',
          Text(
            'mispeled word',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.wavy,
              decorationColor: Colors.red,
              decorationThickness: 2,
            ),
          ),
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Original Price',
          'Strikethrough for discounted prices',
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '\$99.99',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 2,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '\$49.99',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Grammar Warning',
          'Dotted blue underline for grammar issues',
          Text(
            'grammatically suspect',
            style: TextStyle(
              fontSize: 16,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dotted,
              decorationColor: Colors.blue,
              decorationThickness: 2,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCaseCard(String title, String description, Widget sample) {
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
        sample,
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
                  'Style',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'Pattern',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Common Use',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        _buildComparisonRow('solid', '────', 'Links, emphasis'),
        _buildComparisonRow('double', '════', 'Strong emphasis, titles'),
        _buildComparisonRow('dotted', '····', 'Abbreviations, grammar'),
        _buildComparisonRow('dashed', '- - -', 'Draft content'),
        _buildComparisonRow('wavy', '∿∿∿', 'Spellerrors, warnings'),
      ],
    ),
  );
}

Widget _buildComparisonRow(String style, String pattern, String use) {
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
            style,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            pattern,
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            use,
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
          'TextDecorationStyle Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          '${TextDecorationStyle.values.length} styles: solid, double, dotted, dashed, wavy. '
          'Used with TextDecoration to create underlines, strikethroughs, and overlines with distinct visual patterns.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    ),
  );
}
