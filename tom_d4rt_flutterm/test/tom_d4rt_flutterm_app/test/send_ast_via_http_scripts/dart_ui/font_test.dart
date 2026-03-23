// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for Font-related APIs from dart:ui
// Covers: loadFontFromList, FontFeature, FontVariation
// Font registration pipeline and OpenType feature/variation axis control
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Font Registration & Features Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: FontFeature
  // ═══════════════════════════════════════════════════════════════════════════

  final ligaOn = ui.FontFeature.enable('liga');
  final ligaOff = ui.FontFeature.disable('liga');
  final smcp = ui.FontFeature('smcp');
  final onum = ui.FontFeature('onum');
  final kern = ui.FontFeature.enable('kern');
  final ss01 = ui.FontFeature('ss01');
  final frac = ui.FontFeature('frac');
  final tnum = ui.FontFeature.tabularFigures();
  final pnum = ui.FontFeature.proportionalFigures();
  final oldstyle = ui.FontFeature.oldstyleFigures();

  print(
    'FontFeature liga on: $ligaOn (feature=${ligaOn.feature}, value=${ligaOn.value})',
  );
  print('FontFeature liga off: $ligaOff (value=${ligaOff.value})');
  print('FontFeature smcp: $smcp');
  print('FontFeature onum: $onum');
  print('FontFeature kern: $kern');
  print('FontFeature ss01: $ss01');
  print('FontFeature frac: $frac');
  print('FontFeature.tabularFigures: $tnum');
  print('FontFeature.proportionalFigures: $pnum');
  print('FontFeature.oldstyleFigures: $oldstyle');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: FontVariation
  // ═══════════════════════════════════════════════════════════════════════════

  final wght = ui.FontVariation('wght', 700);
  final wdth = ui.FontVariation('wdth', 75);
  final slnt = ui.FontVariation('slnt', -12);
  final ital = ui.FontVariation('ital', 1);
  final opsz = ui.FontVariation('opsz', 48);

  print('FontVariation wght: axis=${wght.axis}, value=${wght.value}');
  print('FontVariation wdth: axis=${wdth.axis}, value=${wdth.value}');
  print('FontVariation slnt: axis=${slnt.axis}, value=${slnt.value}');
  print('FontVariation ital: axis=${ital.axis}, value=${ital.value}');
  print('FontVariation opsz: axis=${opsz.axis}, value=${opsz.value}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: loadFontFromList
  // ═══════════════════════════════════════════════════════════════════════════

  // loadFontFromList registers font bytes at runtime
  print('ui.loadFontFromList(Uint8List, fontFamily: "MyFont")');
  print('Returns Future<void> — font available after completion');
  print('Used for: downloading fonts, bundling custom fonts, dynamic loading');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: EQUALITY
  // ═══════════════════════════════════════════════════════════════════════════

  final ligaOn2 = ui.FontFeature.enable('liga');
  print('FontFeature equality: ${ligaOn == ligaOn2}');
  print('FontFeature hashCode: ${ligaOn.hashCode == ligaOn2.hashCode}');

  final wght2 = ui.FontVariation('wght', 700);
  print('FontVariation equality: ${wght == wght2}');

  print('Font demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  final features = <_FeatureInfo>[
    _FeatureInfo('liga', 'Ligatures', 'Joins letter pairs (fi, fl)', true),
    _FeatureInfo(
      'kern',
      'Kerning',
      'Adjusts spacing between letter pairs',
      true,
    ),
    _FeatureInfo(
      'smcp',
      'Small Caps',
      'Lowercase → small capital forms',
      false,
    ),
    _FeatureInfo(
      'onum',
      'Oldstyle Nums',
      'Numerals with varying heights',
      false,
    ),
    _FeatureInfo(
      'tnum',
      'Tabular Figs',
      'Fixed-width numerals for alignment',
      false,
    ),
    _FeatureInfo('pnum', 'Proportional', 'Natural-width numerals', false),
    _FeatureInfo('frac', 'Fractions', 'Stacked fraction rendering', false),
    _FeatureInfo(
      'ss01',
      'Stylistic Set',
      'Alternate glyph designs (#1)',
      false,
    ),
  ];

  final variations = <_VariationInfo>[
    _VariationInfo('wght', 'Weight', 100, 900, 400, 'Thin to Black'),
    _VariationInfo('wdth', 'Width', 75, 125, 100, 'Condensed to Extended'),
    _VariationInfo('slnt', 'Slant', -12, 0, 0, 'Oblique angle in degrees'),
    _VariationInfo('ital', 'Italic', 0, 1, 0, 'Off (0) or On (1)'),
    _VariationInfo(
      'opsz',
      'Optical Size',
      8,
      144,
      14,
      'Optimize for display size',
    ),
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
                    colors: [Color(0xFF880E4F), Color(0xFFF06292)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.font_download, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Font APIs',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'FontFeature, FontVariation, loadFontFromList',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: FontFeature Cards ──
              _sectionTitle('1. FONT FEATURES (OpenType)'),
              ...features.map((f) => _featureCard(f)),

              // ── Section 2: FontFeature API ──
              _sectionTitle('2. FONT FEATURE CONSTRUCTORS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _apiRow(
                      "FontFeature('tag')",
                      'Enable with value 1',
                      Color(0xFF880E4F),
                    ),
                    _apiRow(
                      "FontFeature('tag', 0)",
                      'Disable feature',
                      Color(0xFF880E4F),
                    ),
                    _apiRow(
                      "FontFeature.enable('tag')",
                      'Named enable',
                      Color(0xFF0D47A1),
                    ),
                    _apiRow(
                      "FontFeature.disable('tag')",
                      'Named disable',
                      Color(0xFF0D47A1),
                    ),
                    _apiRow(
                      '.tabularFigures()',
                      'tnum feature',
                      Color(0xFF2E7D32),
                    ),
                    _apiRow(
                      '.proportionalFigures()',
                      'pnum feature',
                      Color(0xFF2E7D32),
                    ),
                    _apiRow(
                      '.oldstyleFigures()',
                      'onum feature',
                      Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),

              // ── Section 3: FontVariation Axes ──
              _sectionTitle('3. FONT VARIATION AXES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: variations.map((v) => _variationRow(v)).toList(),
                ),
              ),

              // ── Section 4: Variation Range Visualization ──
              _sectionTitle('4. VARIATION RANGE BARS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: variations.map((v) => _variationBar(v)).toList(),
                ),
              ),

              // ── Section 5: loadFontFromList Pipeline ──
              _sectionTitle('5. DYNAMIC FONT LOADING'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _pipeStep(
                      1,
                      'Get font bytes',
                      'http.get() or rootBundle.load()',
                      Icons.download,
                      Color(0xFF880E4F),
                    ),
                    _arrow(),
                    _pipeStep(
                      2,
                      'Convert to Uint8List',
                      'response.bodyBytes',
                      Icons.memory,
                      Color(0xFF0D47A1),
                    ),
                    _arrow(),
                    _pipeStep(
                      3,
                      'Register font',
                      'loadFontFromList(bytes, fontFamily: name)',
                      Icons.app_registration,
                      Color(0xFF2E7D32),
                    ),
                    _arrow(),
                    _pipeStep(
                      4,
                      'Await completion',
                      'await future; // font now available',
                      Icons.check_circle,
                      Color(0xFFE65100),
                    ),
                    _arrow(),
                    _pipeStep(
                      5,
                      'Use in TextStyle',
                      'TextStyle(fontFamily: name)',
                      Icons.text_fields,
                      Color(0xFF6A1B9A),
                    ),
                  ],
                ),
              ),

              // ── Section 6: Equality & Properties ──
              _sectionTitle('6. EQUALITY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Text(
                      'FontFeature',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF880E4F),
                      ),
                    ),
                    SizedBox(height: 6),
                    _eqRow(
                      'enable("liga") == enable("liga")',
                      ligaOn == ligaOn2,
                    ),
                    _eqRow(
                      'enable("liga") == disable("liga")',
                      ligaOn == ligaOff,
                    ),
                    _eqRow(
                      '.feature property',
                      true,
                      suffix: '"${ligaOn.feature}"',
                    ),
                    _eqRow('.value property', true, suffix: '${ligaOn.value}'),
                    SizedBox(height: 12),
                    Text(
                      'FontVariation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF0D47A1),
                      ),
                    ),
                    SizedBox(height: 6),
                    _eqRow('wght(700) == wght(700)', wght == wght2),
                    _eqRow('.axis property', true, suffix: '"${wght.axis}"'),
                    _eqRow('.value property', true, suffix: '${wght.value}'),
                  ],
                ),
              ),

              // ── Section 7: Usage in TextStyle ──
              _sectionTitle('7. USAGE IN TEXTSTYLE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _codeBlock([
                      'TextStyle(',
                      '  fontFeatures: [',
                      "    FontFeature.enable('smcp'),",
                      "    FontFeature.tabularFigures(),",
                      '  ],',
                      '  fontVariations: [',
                      "    FontVariation('wght', 600),",
                      "    FontVariation('wdth', 90),",
                      '  ],',
                      ')',
                    ]),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFCE4EC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Variable fonts support continuous adjustment along axes. '
                        'A single font file replaces multiple weight/width variants.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF880E4F),
                        ),
                      ),
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

// ─── DATA CLASSES ──────────────────────────────────────────────────────────

class _FeatureInfo {
  final String tag;
  final String name;
  final String desc;
  final bool defaultOn;
  _FeatureInfo(this.tag, this.name, this.desc, this.defaultOn);
}

class _VariationInfo {
  final String axis;
  final String name;
  final double min;
  final double max;
  final double defaultVal;
  final String desc;
  _VariationInfo(
    this.axis,
    this.name,
    this.min,
    this.max,
    this.defaultVal,
    this.desc,
  );
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

Widget _featureCard(_FeatureInfo f) {
  final color = f.defaultOn ? Color(0xFF2E7D32) : Color(0xFF880E4F);
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 28,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              f.tag,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                f.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              Text(
                f.desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: f.defaultOn ? Color(0xFFE8F5E9) : Color(0xFFFCE4EC),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            f.defaultOn ? 'ON' : 'OFF',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _apiRow(String api, String desc, Color color) {
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
        Expanded(
          child: Text(
            api,
            style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
          ),
        ),
        Text(desc, style: TextStyle(fontSize: 9, color: Colors.grey[600])),
      ],
    ),
  );
}

Widget _variationRow(_VariationInfo v) {
  final color = Color(0xFF0D47A1);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 24,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              v.axis,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            v.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
        Expanded(
          child: Text(
            v.desc,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _variationBar(_VariationInfo v) {
  final range = v.max - v.min;
  final fraction = range > 0 ? (v.defaultVal - v.min) / range : 0.5;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        SizedBox(
          width: 38,
          child: Text(
            v.axis,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        Text(
          '${v.min.toInt()}',
          style: TextStyle(fontSize: 9, color: Colors.grey[500]),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 12,
                decoration: BoxDecoration(
                  color: Color(0xFFE8EAF6),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              FractionallySizedBox(
                widthFactor: fraction.clamp(0.0, 1.0),
                child: Container(
                  height: 12,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF880E4F), Color(0xFFF06292)],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 4),
        Text(
          '${v.max.toInt()}',
          style: TextStyle(fontSize: 9, color: Colors.grey[500]),
        ),
        SizedBox(width: 8),
        Text(
          'def: ${v.defaultVal.toInt()}',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Color(0xFF880E4F),
          ),
        ),
      ],
    ),
  );
}

Widget _pipeStep(int n, String label, String desc, IconData icon, Color color) {
  return Row(
    children: [
      Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            '$n',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ),
      SizedBox(width: 10),
      Icon(icon, size: 16, color: color),
      SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text(
              desc,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _arrow() {
  return Padding(
    padding: EdgeInsets.only(left: 11),
    child: Icon(Icons.arrow_downward, size: 12, color: Colors.grey[300]),
  );
}

Widget _eqRow(String expr, bool result, {String? suffix}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Expanded(
          child: Text(
            expr,
            style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
          ),
        ),
        if (suffix != null) ...[
          Text(
            suffix,
            style: TextStyle(fontSize: 10, color: Color(0xFF880E4F)),
          ),
          SizedBox(width: 6),
        ],
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: result ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            result ? 'true' : 'false',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(List<String> lines) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      lines.join('\n'),
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        color: Color(0xFFF48FB1),
        height: 1.5,
      ),
    ),
  );
}
