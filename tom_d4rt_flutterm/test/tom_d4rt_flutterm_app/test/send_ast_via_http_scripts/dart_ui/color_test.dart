// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for Color from dart:ui
// Color represents an ARGB color value in the sRGB color space
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Color Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CONSTRUCTORS
  // ═══════════════════════════════════════════════════════════════════════════

  // from integer value (0xAARRGGBB)
  final fromInt = Color(0xFF42A5F5);
  print('Color(0xFF42A5F5): $fromInt');

  // fromARGB
  final fromArgb = Color.fromARGB(255, 66, 165, 245);
  print('fromARGB(255,66,165,245): $fromArgb');

  // fromRGBO (alpha as double 0.0-1.0)
  final fromRgbo = Color.fromRGBO(66, 165, 245, 1.0);
  print('fromRGBO(66,165,245,1.0): $fromRgbo');

  // Fully transparent
  final transparent = Color.fromARGB(0, 0, 0, 0);
  print('Transparent: $transparent');

  // Semi-transparent
  final semiTransparent = Color.fromARGB(128, 255, 0, 0);
  print('Semi-transparent red: $semiTransparent');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: ARGB COMPONENTS
  // ═══════════════════════════════════════════════════════════════════════════

  final c = Color(0xFFE91E63);
  print('Color: $c');
  print('  a=${c.a}, r=${c.r}, g=${c.g}, b=${c.b}');

  // Component extraction for various colors
  final colors = <String, Color>{
    'Red': Color(0xFFF44336),
    'Green': Color(0xFF4CAF50),
    'Blue': Color(0xFF2196F3),
    'Yellow': Color(0xFFFFEB3B),
    'Purple': Color(0xFF9C27B0),
    'Cyan': Color(0xFF00BCD4),
    'Orange': Color(0xFFFF9800),
    'White': Color(0xFFFFFFFF),
    'Black': Color(0xFF000000),
  };
  for (final entry in colors.entries) {
    final col = entry.value;
    print('${entry.key}: a=${col.a}, r=${col.r}, g=${col.g}, b=${col.b}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: withValues
  // ═══════════════════════════════════════════════════════════════════════════

  final base = Color(0xFF2196F3);
  final withAlpha50 = base.withValues(alpha: 0.5);
  print('withValues(alpha:0.5): $withAlpha50');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: COLOR LERP (INTERPOLATION)
  // ═══════════════════════════════════════════════════════════════════════════

  final start = Color(0xFF1565C0); // dark blue
  final end = Color(0xFFE91E63); // pink
  final lerpSteps = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
  final lerpColors = lerpSteps.map((t) => Color.lerp(start, end, t)!).toList();
  for (var i = 0; i < lerpSteps.length; i++) {
    print('lerp t=${lerpSteps[i]}: ${lerpColors[i]}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: ALPHA BLENDING
  // ═══════════════════════════════════════════════════════════════════════════

  final alphaSteps = [255, 200, 150, 100, 50, 0];
  final alphaColors = alphaSteps
      .map((a) => Color.fromARGB(a, 33, 150, 243))
      .toList();
  for (var i = 0; i < alphaSteps.length; i++) {
    print('alpha=${alphaSteps[i]}: ${alphaColors[i]}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: EQUALITY & HASHCODE
  // ═══════════════════════════════════════════════════════════════════════════

  final eq1 = Color(0xFF42A5F5);
  final eq2 = Color.fromARGB(255, 66, 165, 245);
  final eq3 = Color(0xFF42A5F6);
  print('eq1 == eq2: ${eq1 == eq2}');
  print('eq1 == eq3: ${eq1 == eq3}');
  print('hashCode match: ${eq1.hashCode == eq2.hashCode}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: SPECIAL COLOR VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final specials = <String, Color>{
    'Fully opaque black': Color(0xFF000000),
    'Fully opaque white': Color(0xFFFFFFFF),
    'Transparent': Color(0x00000000),
    'Half alpha red': Color(0x80FF0000),
  };
  for (final entry in specials.entries) {
    print('${entry.key}: ${entry.value}');
  }

  print('Color demo complete');

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
                      Color(0xFFE91E63),
                      Color(0xFFFF5722),
                      Color(0xFFFF9800),
                    ],
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
                    Icon(Icons.palette, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Color Deep Demo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'ARGB color in sRGB space',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 1: Constructor Swatches ──
              _sectionTitle('1. COLOR CONSTRUCTORS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _colorConstructorRow('Color(0xFF42A5F5)', fromInt),
                    _colorConstructorRow('fromARGB(255,66,165,245)', fromArgb),
                    _colorConstructorRow('fromRGBO(66,165,245,1.0)', fromRgbo),
                    _colorConstructorRow('transparent', transparent),
                    _colorConstructorRow(
                      'semi-transparent red',
                      semiTransparent,
                    ),
                  ],
                ),
              ),

              // ── Demo 2: ARGB Component Bars ──
              _sectionTitle('2. ARGB COMPONENTS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _componentBar('Alpha', c.a, Color(0xFF616161)),
                    SizedBox(height: 8),
                    _componentBar('Red', c.r, Color(0xFFC62828)),
                    SizedBox(height: 8),
                    _componentBar('Green', c.g, Color(0xFF2E7D32)),
                    SizedBox(height: 8),
                    _componentBar('Blue', c.b, Color(0xFF1565C0)),
                  ],
                ),
              ),

              // ── Demo 3: Color Palette Grid ──
              _sectionTitle('3. COLOR PALETTE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: colors.entries.map((entry) {
                    return _colorSwatch(entry.key, entry.value);
                  }).toList(),
                ),
              ),

              // ── Demo 4: Lerp Gradient ──
              _sectionTitle('4. COLOR.LERP INTERPOLATION'),
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
                      children: lerpColors.asMap().entries.map((entry) {
                        return Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: entry.value,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: entry.value.withValues(alpha: 0.4),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${lerpSteps[entry.key]}',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _miniSwatch('Start', start),
                        Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                        _miniSwatch('End', end),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Demo 5: Alpha Transparency ──
              _sectionTitle('5. ALPHA TRANSPARENCY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    // Checkerboard background with overlaid alpha colors
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFE0E0E0)),
                      ),
                      child: Row(
                        children: alphaColors.asMap().entries.map((entry) {
                          return Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: entry.value,
                                borderRadius: entry.key == 0
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                      )
                                    : entry.key == alphaColors.length - 1
                                    ? BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      )
                                    : null,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: alphaSteps
                          .map(
                            (a) => Text('$a', style: TextStyle(fontSize: 10)),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Alpha values from 255 (opaque) to 0 (transparent)',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              // ── Demo 6: withValues ──
              _sectionTitle('6. withValues METHOD'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _colorCompareRow('Original', base),
                    _colorCompareRow('alpha: 0.5', withAlpha50),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3E5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'withValues() creates a new Color with modified channels',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF4A148C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 7: Equality ──
              _sectionTitle('7. EQUALITY & HASHCODE'),
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
                      'Color(0xFF42A5F5) == fromARGB',
                      eq1 == eq2,
                      true,
                    ),
                    SizedBox(height: 8),
                    _equalityRow('0xFF42A5F5 == 0xFF42A5F6', eq1 == eq3, false),
                    SizedBox(height: 8),
                    _equalityRow(
                      'hashCode match',
                      eq1.hashCode == eq2.hashCode,
                      true,
                    ),
                  ],
                ),
              ),

              // ── Demo 8: Special Values ──
              _sectionTitle('8. SPECIAL COLOR VALUES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: specials.entries.map((entry) {
                    return _specialValueRow(entry.key, entry.value);
                  }).toList(),
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

Widget _colorConstructorRow(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE0E0E0)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}

Widget _componentBar(String label, double value, Color color) {
  return Row(
    children: [
      Container(
        width: 50,
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
      Expanded(
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFEEEEEE),
          ),
          child: FractionallySizedBox(
            widthFactor: value / 1.0,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: color,
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 8),
      Container(
        width: 40,
        child: Text(
          '${(value * 255).round()}',
          style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}

Widget _colorSwatch(String name, Color color) {
  return Container(
    width: 92,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
      ],
    ),
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
        SizedBox(height: 6),
        Text(name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

Widget _miniSwatch(String label, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      SizedBox(width: 4),
      Text(label, style: TextStyle(fontSize: 11)),
    ],
  );
}

Widget _colorCompareRow(String label, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFE0E0E0)),
          ),
        ),
        SizedBox(width: 12),
        Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
        Spacer(),
        Text(
          'a=${color.a.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
        ),
      ],
    ),
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
      Expanded(
        child: Text(
          label,
          style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
        ),
      ),
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

Widget _specialValueRow(String name, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              Text(
                '0x${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
