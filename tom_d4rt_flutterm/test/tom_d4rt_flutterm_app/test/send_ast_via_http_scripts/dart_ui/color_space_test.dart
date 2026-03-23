// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for ColorSpace from dart:ui
// ColorSpace defines the color gamut for rendering and display
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ColorSpace Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final values = ui.ColorSpace.values;
  print('ColorSpace values: $values');
  print('Count: ${values.length}');

  for (final cs in values) {
    print('ColorSpace.${cs.name}: index=${cs.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: INDIVIDUAL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final srgb = ui.ColorSpace.sRGB;
  print('sRGB: $srgb');

  final extSrgb = ui.ColorSpace.extendedSRGB;
  print('extendedSRGB: $extSrgb');

  final displayP3 = ui.ColorSpace.displayP3;
  print('displayP3: $displayP3');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: COMPARISONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('sRGB == sRGB: ${srgb == ui.ColorSpace.sRGB}');
  print('sRGB == displayP3: ${srgb == displayP3}');
  print('sRGB index: ${srgb.index}');
  print('extSRGB index: ${extSrgb.index}');
  print('displayP3 index: ${displayP3.index}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: COLOR SPACE CHARACTERISTICS
  // ═══════════════════════════════════════════════════════════════════════════

  // Colors that demonstrate gamut differences
  final standardRed = Color(0xFFFF0000);
  final vividGreen = Color(0xFF00FF00);
  final deepBlue = Color(0xFF0000FF);
  final brightCyan = Color(0xFF00FFFF);
  final hotPink = Color(0xFFFF00FF);
  final brightYellow = Color(0xFFFFFF00);
  print('Standard gamut colors: R=$standardRed G=$vividGreen B=$deepBlue');
  print('Extended gamut colors: C=$brightCyan M=$hotPink Y=$brightYellow');

  print('ColorSpace demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

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
                    colors: [
                      Color(0xFF1A237E),
                      Color(0xFF7C4DFF),
                      Color(0xFFE040FB),
                    ],
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
                    Icon(Icons.color_lens, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'ColorSpace Deep Demo',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Color gamuts for rendering & display',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 1: Enum Values ──
              _sectionTitle('1. COLORSPACE ENUM VALUES'),
              ...values.map((cs) {
                final info = _colorSpaceInfo(cs);
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: info['color'] as Color, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: (info['color'] as Color).withValues(alpha: 0.15),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: info['color'] as Color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '${cs.index}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ColorSpace.${cs.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              info['description'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              // ── Demo 2: Gamut Comparison ──
              _sectionTitle('2. COLOR GAMUT COMPARISON'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 260,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Display P3 (outermost)
                    Positioned(
                      left: 30,
                      top: 20,
                      child: Container(
                        width: 260,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFE040FB),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFFE040FB).withValues(alpha: 0.05),
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'Display P3',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFE040FB),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Extended sRGB (middle)
                    Positioned(
                      left: 55,
                      top: 45,
                      child: Container(
                        width: 210,
                        height: 155,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF7C4DFF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(80),
                          color: Color(0xFF7C4DFF).withValues(alpha: 0.05),
                        ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              'Extended sRGB',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF7C4DFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // sRGB (innermost)
                    Positioned(
                      left: 85,
                      top: 70,
                      child: Container(
                        width: 150,
                        height: 110,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF1A237E),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(55),
                          color: Color(0xFF1A237E).withValues(alpha: 0.08),
                        ),
                        child: Center(
                          child: Text(
                            'sRGB',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1A237E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Legend
                    Positioned(
                      left: 30,
                      bottom: 8,
                      child: Text(
                        'Nested regions show gamut inclusiveness',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 3: sRGB Primary Colors ──
              _sectionTitle('3. sRGB PRIMARY & SECONDARY COLORS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _colorDot(standardRed, 'Red'),
                        _colorDot(vividGreen, 'Green'),
                        _colorDot(deepBlue, 'Blue'),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        _colorDot(brightCyan, 'Cyan'),
                        _colorDot(hotPink, 'Magenta'),
                        _colorDot(brightYellow, 'Yellow'),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'All colors above are within sRGB gamut',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // ── Demo 4: Color Space Properties ──
              _sectionTitle('4. TECHNICAL PROPERTIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _techRow(
                      'sRGB',
                      'Standard',
                      'IEC 61966-2-1',
                      'D65',
                      Color(0xFF1A237E),
                    ),
                    Divider(height: 16),
                    _techRow(
                      'extendedSRGB',
                      'Extended',
                      'Same primaries, -∞ to +∞ range',
                      'D65',
                      Color(0xFF7C4DFF),
                    ),
                    Divider(height: 16),
                    _techRow(
                      'displayP3',
                      'Wide Gamut',
                      'DCI-P3 primaries',
                      'D65',
                      Color(0xFFE040FB),
                    ),
                  ],
                ),
              ),

              // ── Demo 5: Gamut Coverage ──
              _sectionTitle('5. APPROXIMATE GAMUT COVERAGE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _gamutBar('sRGB', 0.35, Color(0xFF1A237E)),
                    SizedBox(height: 12),
                    _gamutBar('extendedSRGB', 0.55, Color(0xFF7C4DFF)),
                    SizedBox(height: 12),
                    _gamutBar('Display P3', 0.46, Color(0xFFE040FB)),
                    SizedBox(height: 12),
                    _gamutBar('Human Vision', 1.0, Color(0xFF455A64)),
                    SizedBox(height: 8),
                    Text(
                      'Fraction of visible spectrum covered (approximate)',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // ── Demo 6: Equality & Indexing ──
              _sectionTitle('6. EQUALITY & INDEX'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _equalityRow(
                      'sRGB == sRGB',
                      srgb == ui.ColorSpace.sRGB,
                      true,
                    ),
                    SizedBox(height: 8),
                    _equalityRow('sRGB == displayP3', srgb == displayP3, false),
                    SizedBox(height: 12),
                    ...values.map((cs) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Text(
                              '${cs.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'index: ${cs.index}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

              // ── Demo 7: Usage Context ──
              _sectionTitle('7. USAGE CONTEXT'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _usageRow(
                      Icons.phone_android,
                      'Standard displays',
                      'sRGB (most screens)',
                      Color(0xFF1A237E),
                    ),
                    Divider(height: 16),
                    _usageRow(
                      Icons.hdr_on,
                      'HDR content',
                      'extendedSRGB (>1.0 values)',
                      Color(0xFF7C4DFF),
                    ),
                    Divider(height: 16),
                    _usageRow(
                      Icons.tablet_mac,
                      'Apple/Pro displays',
                      'displayP3 (wider gamut)',
                      Color(0xFFE040FB),
                    ),
                    Divider(height: 16),
                    _usageRow(
                      Icons.camera,
                      'Photography',
                      'displayP3 (vibrant colors)',
                      Color(0xFFE040FB),
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

Map<String, dynamic> _colorSpaceInfo(ui.ColorSpace cs) {
  switch (cs) {
    case ui.ColorSpace.sRGB:
      return {
        'color': Color(0xFF1A237E),
        'description': 'Standard RGB — the default web/display color space',
      };
    case ui.ColorSpace.extendedSRGB:
      return {
        'color': Color(0xFF7C4DFF),
        'description':
            'Extended sRGB — same primaries, allows values outside 0-1 range for HDR',
      };
    case ui.ColorSpace.displayP3:
      return {
        'color': Color(0xFFE040FB),
        'description':
            'Display P3 — wider gamut used by Apple displays and modern screens',
      };
  }
}

Widget _colorDot(Color color, String label) {
  return Expanded(
    child: Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 6),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

Widget _techRow(String name, String type, String spec, String wp, Color color) {
  return Row(
    children: [
      Container(
        width: 6,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(fontSize: 10, color: color),
                  ),
                ),
              ],
            ),
            Text(
              '$spec • White point: $wp',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _gamutBar(String label, double fraction, Color color) {
  return Row(
    children: [
      Container(
        width: 100,
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
      Expanded(
        child: Container(
          height: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFFEEEEEE),
          ),
          child: FractionallySizedBox(
            widthFactor: fraction,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [color, color.withValues(alpha: 0.6)],
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 8),
      Text(
        '${(fraction * 100).round()}%',
        style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
      ),
    ],
  );
}

Widget _equalityRow(String label, bool result, bool expected) {
  return Row(
    children: [
      Icon(
        result == expected ? Icons.check_circle : Icons.cancel,
        color: result == expected ? Colors.green : Colors.red,
        size: 20,
      ),
      SizedBox(width: 8),
      Text(label, style: TextStyle(fontSize: 13, fontFamily: 'monospace')),
      Spacer(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: result ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '$result',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
          ),
        ),
      ),
    ],
  );
}

Widget _usageRow(IconData icon, String title, String desc, Color color) {
  return Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}
