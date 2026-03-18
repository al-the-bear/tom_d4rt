// D4rt test script: Deep Demo for FontStyle from dart:ui
// FontStyle is an enum with two values: normal and italic
// Controls whether text is rendered upright or slanted
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== FontStyle Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  for (final style in ui.FontStyle.values) {
    print('FontStyle.${style.name} (index ${style.index})');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  final normal = ui.FontStyle.normal;
  final italic = ui.FontStyle.italic;

  print('normal: name=${normal.name}, index=${normal.index}');
  print('italic: name=${italic.name}, index=${italic.index}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: EQUALITY
  // ═══════════════════════════════════════════════════════════════════════════

  print('normal == normal: ${normal == ui.FontStyle.normal}');
  print('normal == italic: ${normal == italic}');
  print('hashCode equal: ${normal.hashCode == ui.FontStyle.normal.hashCode}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: USAGE IN TextStyle
  // ═══════════════════════════════════════════════════════════════════════════

  print('TextStyle(fontStyle: FontStyle.normal) → upright text');
  print('TextStyle(fontStyle: FontStyle.italic) → slanted text');
  print('Used with FontWeight for full font variation selection');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: FONT FILE SELECTION
  // ═══════════════════════════════════════════════════════════════════════════

  print('Font files typically ship as:');
  print('  Regular (normal w400), Bold (normal w700)');
  print('  Italic (italic w400), BoldItalic (italic w700)');
  print('If italic file missing, engine synthesizes oblique');

  print('FontStyle demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  final samples = <_TextSample>[
    _TextSample('Regular', ui.FontStyle.normal, FontWeight.w400),
    _TextSample('Medium', ui.FontStyle.normal, FontWeight.w500),
    _TextSample('Bold', ui.FontStyle.normal, FontWeight.w700),
    _TextSample('Black', ui.FontStyle.normal, FontWeight.w900),
    _TextSample('Italic', ui.FontStyle.italic, FontWeight.w400),
    _TextSample('Medium Italic', ui.FontStyle.italic, FontWeight.w500),
    _TextSample('Bold Italic', ui.FontStyle.italic, FontWeight.w700),
    _TextSample('Black Italic', ui.FontStyle.italic, FontWeight.w900),
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF311B92), Color(0xFF7C4DFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.text_fields, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'FontStyle',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'normal vs italic — controls text slant rendering',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _headerChip('normal'),
                        SizedBox(width: 8),
                        _headerChip('italic'),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Section 1: Side-by-Side ──
              _sectionTitle('1. NORMAL vs ITALIC'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Aa',
                              style: TextStyle(
                                fontSize: 48,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF311B92),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'FontStyle.normal',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFF311B92),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Upright glyphs\nStandard posture',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Aa',
                              style: TextStyle(
                                fontSize: 48,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFBF360C),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'FontStyle.italic',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFFBF360C),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Slanted glyphs\nCursive posture',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Full Weight × Style Matrix ──
              _sectionTitle('2. WEIGHT × STYLE MATRIX'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: samples.map((s) => _fontSampleRow(s)).toList(),
                ),
              ),

              // ── Section 3: Paragraph Demo ──
              _sectionTitle('3. PARAGRAPH RENDERING'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                        children: [
                          TextSpan(text: 'This is normal text. '),
                          TextSpan(
                            text: 'This is italic text for emphasis. ',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          TextSpan(text: 'Back to normal. '),
                          TextSpan(
                            text: 'Bold italic ',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: 'for strong emphasis.'),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFEDE7F6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Italic is commonly used for: emphasis, book titles, '
                        'foreign words, technical terms, variables in math.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF311B92),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 4: Enum Properties ──
              _sectionTitle('4. ENUM PROPERTIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _enumPropRow(
                      'FontStyle.normal',
                      'index: 0',
                      'name: "normal"',
                      Color(0xFF311B92),
                    ),
                    SizedBox(height: 8),
                    _enumPropRow(
                      'FontStyle.italic',
                      'index: 1',
                      'name: "italic"',
                      Color(0xFFBF360C),
                    ),
                    SizedBox(height: 12),
                    _equalityRow('normal == normal', true),
                    _equalityRow('normal == italic', false),
                    _equalityRow(
                      'values.length == 2',
                      ui.FontStyle.values.length == 2,
                    ),
                  ],
                ),
              ),

              // ── Section 5: Font File Mapping ──
              _sectionTitle('5. FONT FILE MAPPING'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _fontFileRow(
                      'Regular',
                      'normal',
                      'w400',
                      Color(0xFF311B92),
                    ),
                    _fontFileRow('Bold', 'normal', 'w700', Color(0xFF1565C0)),
                    _fontFileRow('Italic', 'italic', 'w400', Color(0xFFBF360C)),
                    _fontFileRow(
                      'BoldItalic',
                      'italic',
                      'w700',
                      Color(0xFFC62828),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 14,
                            color: Color(0xFFE65100),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'If an italic variant is not available in the font files, '
                              'the engine synthesizes an oblique style by skewing glyphs.',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFFE65100),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 6: Use Cases ──
              _sectionTitle('6. TYPICAL USE CASES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _useCaseRow(
                      'Emphasis',
                      'Highlighting important words',
                      Icons.format_italic,
                      Color(0xFF311B92),
                    ),
                    _useCaseRow(
                      'Citations',
                      'Book titles, quotes, references',
                      Icons.menu_book,
                      Color(0xFF0D47A1),
                    ),
                    _useCaseRow(
                      'Variables',
                      'Math variables: x, y, z',
                      Icons.functions,
                      Color(0xFF2E7D32),
                    ),
                    _useCaseRow(
                      'Foreign words',
                      'et cetera, vis-à-vis',
                      Icons.translate,
                      Color(0xFFE65100),
                    ),
                    _useCaseRow(
                      'Placeholder text',
                      'Hint text, prompts',
                      Icons.text_format,
                      Color(0xFF6A1B9A),
                    ),
                  ],
                ),
              ),

              // ── Section 7: API Context ──
              _sectionTitle('7. API CONTEXT'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _apiContextRow(
                      'TextStyle',
                      'fontStyle: FontStyle.italic',
                      Color(0xFF311B92),
                    ),
                    _apiContextRow(
                      'TextPainter',
                      'Uses TextStyle.fontStyle',
                      Color(0xFF0D47A1),
                    ),
                    _apiContextRow(
                      'ParagraphStyle',
                      'fontStyle parameter',
                      Color(0xFF2E7D32),
                    ),
                    _apiContextRow(
                      'Font selection',
                      'Matches style → italic file',
                      Color(0xFFE65100),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'FontStyle is one axis of font variant selection. '
                      'Combined with FontWeight, it determines which font file '
                      'the engine loads from the font family.',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── DATA CLASS ────────────────────────────────────────────────────────────

class _TextSample {
  final String label;
  final ui.FontStyle style;
  final FontWeight weight;
  _TextSample(this.label, this.style, this.weight);
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _headerChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(label, style: TextStyle(fontSize: 11, color: Colors.white)),
  );
}

Widget _fontSampleRow(_TextSample s) {
  final isItalic = s.style == ui.FontStyle.italic;
  final color = isItalic ? Color(0xFFBF360C) : Color(0xFF311B92);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            s.label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            isItalic ? 'italic' : 'normal',
            style: TextStyle(fontSize: 9, color: color),
          ),
        ),
        SizedBox(width: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'w${s.weight.value}',
            style: TextStyle(fontSize: 9, fontFamily: 'monospace'),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            'The quick brown fox',
            style: TextStyle(
              fontSize: 14,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
              fontWeight: s.weight,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _enumPropRow(String name, String idx, String nm, Color color) {
  return Row(
    children: [
      Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 8),
      Expanded(
        child: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: color,
          ),
        ),
      ),
      Text(idx, style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
      SizedBox(width: 8),
      Text(nm, style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
    ],
  );
}

Widget _equalityRow(String expr, bool result) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Expanded(
          child: Text(
            expr,
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: result ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            result ? 'true' : 'false',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _fontFileRow(String file, String style, String weight, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(Icons.insert_drive_file, size: 14, color: color),
        SizedBox(width: 6),
        SizedBox(
          width: 80,
          child: Text(
            file,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(style, style: TextStyle(fontSize: 9, color: color)),
        ),
        SizedBox(width: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            weight,
            style: TextStyle(fontSize: 9, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}

Widget _useCaseRow(String title, String desc, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        SizedBox(width: 8),
        SizedBox(
          width: 100,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _apiContextRow(String api, String usage, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 90,
          child: Text(
            api,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            usage,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    ),
  );
}
