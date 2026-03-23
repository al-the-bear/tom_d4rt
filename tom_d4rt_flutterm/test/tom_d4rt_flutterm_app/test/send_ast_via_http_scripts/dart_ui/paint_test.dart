// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for Paint from dart:ui
// Paint configures how shapes, paths, and text are drawn on a Canvas
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Paint Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: DEFAULT PAINT
  // ═══════════════════════════════════════════════════════════════════════════

  final defaultPaint = Paint();
  print('Default paint:');
  print('  color=${defaultPaint.color}');
  print('  style=${defaultPaint.style}');
  print('  strokeWidth=${defaultPaint.strokeWidth}');
  print('  strokeCap=${defaultPaint.strokeCap}');
  print('  strokeJoin=${defaultPaint.strokeJoin}');
  print('  isAntiAlias=${defaultPaint.isAntiAlias}');
  print('  blendMode=${defaultPaint.blendMode}');
  print('  filterQuality=${defaultPaint.filterQuality}');
  print('  strokeMiterLimit=${defaultPaint.strokeMiterLimit}');
  print('  invertColors=${defaultPaint.invertColors}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PAINTING STYLE
  // ═══════════════════════════════════════════════════════════════════════════

  final fillPaint = Paint()
    ..color = Color(0xFF1565C0)
    ..style = PaintingStyle.fill;
  print('Fill paint: style=${fillPaint.style}');

  final strokePaint = Paint()
    ..color = Color(0xFFC62828)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0;
  print(
    'Stroke paint: style=${strokePaint.style}, width=${strokePaint.strokeWidth}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: STROKE PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  // StrokeCap
  for (final cap in StrokeCap.values) {
    print('StrokeCap.$cap');
  }

  // StrokeJoin
  for (final join in StrokeJoin.values) {
    print('StrokeJoin.$join');
  }

  // Various widths
  final widths = [1.0, 2.0, 4.0, 8.0, 12.0, 20.0];
  for (final w in widths) {
    final p = Paint()..strokeWidth = w;
    print('strokeWidth=$w: ${p.strokeWidth}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: BLEND MODES
  // ═══════════════════════════════════════════════════════════════════════════

  final blendModes = [
    BlendMode.srcOver,
    BlendMode.srcIn,
    BlendMode.srcOut,
    BlendMode.dstOver,
    BlendMode.dstIn,
    BlendMode.multiply,
    BlendMode.screen,
    BlendMode.overlay,
    BlendMode.darken,
    BlendMode.lighten,
    BlendMode.colorDodge,
    BlendMode.colorBurn,
  ];
  for (final mode in blendModes) {
    print('BlendMode.$mode');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: FILTER QUALITY
  // ═══════════════════════════════════════════════════════════════════════════

  for (final q in FilterQuality.values) {
    final p = Paint()..filterQuality = q;
    print('filterQuality=$q: ${p.filterQuality}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: SHADER & MASK FILTER
  // ═══════════════════════════════════════════════════════════════════════════

  final gradientShader = ui.Gradient.linear(Offset(0, 0), Offset(200, 0), [
    Color(0xFF1565C0),
    Color(0xFFE91E63),
  ]);
  final shaderPaint = Paint()..shader = gradientShader;
  print('Shader paint: shader=${shaderPaint.shader != null}');

  final blurPaint = Paint()
    ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5.0);
  print('MaskFilter: ${blurPaint.maskFilter}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: COLOR FILTER
  // ═══════════════════════════════════════════════════════════════════════════

  final cfPaint = Paint()
    ..colorFilter = ColorFilter.mode(Color(0xFF4CAF50), BlendMode.srcATop);
  print('ColorFilter: ${cfPaint.colorFilter}');

  print('Paint demo complete');

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
                    colors: [Color(0xFFBF360C), Color(0xFFFF6E40)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepOrange.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.brush, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Paint Deep Demo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'How shapes are drawn on Canvas',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 1: Default Paint Properties ──
              _sectionTitle('1. DEFAULT PAINT PROPERTIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _paintPropRow(
                      'color',
                      '${defaultPaint.color}',
                      Icons.color_lens,
                      Color(0xFF1565C0),
                    ),
                    _paintPropRow(
                      'style',
                      '${defaultPaint.style}',
                      Icons.format_paint,
                      Color(0xFF6A1B9A),
                    ),
                    _paintPropRow(
                      'strokeWidth',
                      '${defaultPaint.strokeWidth}',
                      Icons.line_weight,
                      Color(0xFFE65100),
                    ),
                    _paintPropRow(
                      'strokeCap',
                      '${defaultPaint.strokeCap}',
                      Icons.linear_scale,
                      Color(0xFF00695C),
                    ),
                    _paintPropRow(
                      'strokeJoin',
                      '${defaultPaint.strokeJoin}',
                      Icons.call_merge,
                      Color(0xFFC62828),
                    ),
                    _paintPropRow(
                      'isAntiAlias',
                      '${defaultPaint.isAntiAlias}',
                      Icons.grain,
                      Color(0xFF2E7D32),
                    ),
                    _paintPropRow(
                      'blendMode',
                      '${defaultPaint.blendMode}',
                      Icons.layers,
                      Color(0xFF00838F),
                    ),
                    _paintPropRow(
                      'filterQuality',
                      '${defaultPaint.filterQuality}',
                      Icons.tune,
                      Color(0xFF455A64),
                    ),
                  ],
                ),
              ),

              // ── Demo 2: Fill vs Stroke ──
              _sectionTitle('2. FILL vs STROKE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color(0xFF1565C0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'PaintingStyle.fill',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Solid interior',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFC62828),
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'PaintingStyle.stroke',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Outline only',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 3: Stroke Width Comparison ──
              _sectionTitle('3. STROKE WIDTH'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: widths.map((w) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                            child: Text(
                              '${w}px',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: w.clamp(1.0, 20.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFBF360C),
                                borderRadius: BorderRadius.circular(w / 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              // ── Demo 4: Stroke Cap ──
              _sectionTitle('4. STROKE CAP STYLES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: StrokeCap.values.asMap().entries.map((entry) {
                    final colors = [
                      Color(0xFF1565C0),
                      Color(0xFF6A1B9A),
                      Color(0xFF00695C),
                    ];
                    return _strokeCapRow(
                      entry.value.name,
                      colors[entry.key % 3],
                    );
                  }).toList(),
                ),
              ),

              // ── Demo 5: Stroke Join ──
              _sectionTitle('5. STROKE JOIN STYLES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: StrokeJoin.values.asMap().entries.map((entry) {
                    final colors = [
                      Color(0xFFBF360C),
                      Color(0xFFC62828),
                      Color(0xFFE65100),
                    ];
                    return _strokeJoinRow(
                      entry.value.name,
                      colors[entry.key % 3],
                    );
                  }).toList(),
                ),
              ),

              // ── Demo 6: Blend Modes ──
              _sectionTitle('6. BLEND MODES (SELECTION)'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: blendModes.asMap().entries.map((entry) {
                    final hue = (entry.key * 30.0) % 360;
                    final color = HSVColor.fromAHSV(
                      1.0,
                      hue,
                      0.7,
                      0.85,
                    ).toColor();
                    return _blendModeChip(entry.value.name, color);
                  }).toList(),
                ),
              ),

              // ── Demo 7: Filter Quality ──
              _sectionTitle('7. FILTER QUALITY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: FilterQuality.values.asMap().entries.map((entry) {
                    return _filterQualityRow(entry.value.name, entry.key);
                  }).toList(),
                ),
              ),

              // ── Demo 8: Gradient Shader ──
              _sectionTitle('8. SHADER (GRADIENT)'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFFE91E63)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Paint.shader = Gradient.linear',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // ── Demo 9: MaskFilter (Blur) ──
              _sectionTitle('9. MASKFILTER (BLUR)'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [0.0, 3.0, 6.0, 12.0].map((sigma) {
                    return Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF1565C0),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF1565C0).withValues(alpha: 0.6),
                                blurRadius: sigma,
                                spreadRadius: sigma / 3,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'σ=${sigma.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              // ── Demo 10: Color Filter ──
              _sectionTitle('10. COLOR FILTER'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF2196F3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Before',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.arrow_forward, color: Colors.grey),
                    SizedBox(width: 16),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF4CAF50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'After',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'ColorFilter.mode\n(green, srcATop)',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
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

Widget _paintPropRow(String name, String value, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget _strokeCapRow(String name, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 140,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: name == 'round'
                ? BorderRadius.circular(6)
                : name == 'square'
                ? BorderRadius.circular(0)
                : BorderRadius.circular(1),
          ),
        ),
        Spacer(),
        Text(
          name == 'butt'
              ? 'Ends at endpoint'
              : name == 'round'
              ? 'Rounded ends'
              : 'Square extends past',
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}

Widget _strokeJoinRow(String name, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        SizedBox(width: 8),
        // Visual join representation
        Container(
          width: 40,
          height: 30,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: color, width: 3),
              left: BorderSide(color: color, width: 3),
            ),
            borderRadius: name == 'round'
                ? BorderRadius.only(topLeft: Radius.circular(8))
                : BorderRadius.zero,
          ),
        ),
        Spacer(),
        Text(
          name == 'miter'
              ? 'Sharp corner'
              : name == 'round'
              ? 'Rounded corner'
              : 'Beveled corner',
          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}

Widget _blendModeChip(String name, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      name,
      style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
    ),
  );
}

Widget _filterQualityRow(String name, int index) {
  final qualityPercent = (index / 3.0);
  final color = Color.lerp(
    Color(0xFFC62828),
    Color(0xFF2E7D32),
    qualityPercent,
  )!;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ),
        Expanded(
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Color(0xFFEEEEEE),
            ),
            child: FractionallySizedBox(
              widthFactor: 0.25 + (qualityPercent * 0.75),
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: color,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${(qualityPercent * 100).round()}%',
          style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
        ),
      ],
    ),
  );
}
