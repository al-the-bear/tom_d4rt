// D4rt test script: Deep Demo for ImageFilter and ColorFilter from dart:ui
// Covers ImageFilter factory constructors (blur, dilate, erode, matrix, compose)
// and ColorFilter modes (mode, matrix, linearToSrgbGamma, srgbToLinearGamma)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Filters Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: IMAGE FILTER — BLUR
  // ═══════════════════════════════════════════════════════════════════════════

  final blurLight = ui.ImageFilter.blur(sigmaX: 2, sigmaY: 2);
  final blurHeavy = ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12);
  final blurAsymmetric = ui.ImageFilter.blur(sigmaX: 8, sigmaY: 1);
  print('ImageFilter.blur light: $blurLight');
  print('ImageFilter.blur heavy: $blurHeavy');
  print('ImageFilter.blur asymmetric: $blurAsymmetric');

  // TileMode options: clamp, repeated, mirror, decal
  final blurClamp = ui.ImageFilter.blur(
    sigmaX: 5,
    sigmaY: 5,
    tileMode: TileMode.clamp,
  );
  final blurRepeat = ui.ImageFilter.blur(
    sigmaX: 5,
    sigmaY: 5,
    tileMode: TileMode.repeated,
  );
  final blurMirror = ui.ImageFilter.blur(
    sigmaX: 5,
    sigmaY: 5,
    tileMode: TileMode.mirror,
  );
  final blurDecal = ui.ImageFilter.blur(
    sigmaX: 5,
    sigmaY: 5,
    tileMode: TileMode.decal,
  );
  print(
    'Blur tile modes: clamp=$blurClamp, repeat=$blurRepeat, mirror=$blurMirror, decal=$blurDecal',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: IMAGE FILTER — DILATE / ERODE
  // ═══════════════════════════════════════════════════════════════════════════

  final dilate = ui.ImageFilter.dilate(radiusX: 3, radiusY: 3);
  final erode = ui.ImageFilter.erode(radiusX: 2, radiusY: 2);
  print('ImageFilter.dilate r3: $dilate');
  print('ImageFilter.erode r2: $erode');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: IMAGE FILTER — MATRIX
  // ═══════════════════════════════════════════════════════════════════════════

  final identity = Matrix4.identity();
  final matrixFilter = ui.ImageFilter.matrix(identity.storage);
  print('ImageFilter.matrix(identity): $matrixFilter');

  final rotated = Matrix4.rotationZ(0.1);
  final rotFilter = ui.ImageFilter.matrix(
    rotated.storage,
    filterQuality: ui.FilterQuality.high,
  );
  print('ImageFilter.matrix(rotZ): $rotFilter');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: IMAGE FILTER — COMPOSE
  // ═══════════════════════════════════════════════════════════════════════════

  final composed = ui.ImageFilter.compose(
    outer: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
    inner: ui.ImageFilter.dilate(radiusX: 1, radiusY: 1),
  );
  print('ImageFilter.compose(blur + dilate): $composed');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: COLOR FILTER — MODE
  // ═══════════════════════════════════════════════════════════════════════════

  final cfRed = ColorFilter.mode(Colors.red, BlendMode.colorBurn);
  final cfBlue = ColorFilter.mode(
    Colors.blue.withValues(alpha: 0.5),
    BlendMode.srcATop,
  );
  final cfGreen = ColorFilter.mode(Colors.green, BlendMode.overlay);
  print('ColorFilter.mode red: $cfRed');
  print('ColorFilter.mode blue: $cfBlue');
  print('ColorFilter.mode green: $cfGreen');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: COLOR FILTER — MATRIX
  // ═══════════════════════════════════════════════════════════════════════════

  // Grayscale matrix
  final grayscaleMatrix = ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  print('ColorFilter.matrix(grayscale): $grayscaleMatrix');

  // Sepia matrix
  final sepiaMatrix = ColorFilter.matrix(<double>[
    0.393,
    0.769,
    0.189,
    0,
    0,
    0.349,
    0.686,
    0.168,
    0,
    0,
    0.272,
    0.534,
    0.131,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  print('ColorFilter.matrix(sepia): $sepiaMatrix');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: COLOR FILTER — GAMMA
  // ═══════════════════════════════════════════════════════════════════════════

  final toSrgb = ColorFilter.linearToSrgbGamma();
  final toLinear = ColorFilter.srgbToLinearGamma();
  print('ColorFilter.linearToSrgbGamma: $toSrgb');
  print('ColorFilter.srgbToLinearGamma: $toLinear');

  print('Filters demo complete');

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
                    colors: [Color(0xFF006064), Color(0xFF00ACC1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyan.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.filter_vintage, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'ImageFilter & ColorFilter',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Visual effects: blur, dilate, erode, matrix, compose, '
                      'color modes, gamma',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: ImageFilter.blur ──
              _sectionTitle('1. IMAGE FILTER — BLUR'),
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
                        _blurSample('σ=2', 2, Color(0xFF006064)),
                        SizedBox(width: 8),
                        _blurSample('σ=5', 5, Color(0xFF006064)),
                        SizedBox(width: 8),
                        _blurSample('σ=12', 12, Color(0xFF006064)),
                        SizedBox(width: 8),
                        _blurSample('σx=8\nσy=1', 8, Color(0xFFBF360C)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE0F7FA),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'sigmaX and sigmaY control blur amount independently. '
                        'Higher sigma = more blur. Asymmetric creates directional blur.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFF006064),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Blur TileMode ──
              _sectionTitle('2. BLUR TILE MODES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _tileModeTile(
                      'clamp',
                      'Edge pixels extend outward',
                      Icons.border_outer,
                      Color(0xFF0D47A1),
                    ),
                    _tileModeTile(
                      'repeated',
                      'Image tiles/repeats',
                      Icons.grid_on,
                      Color(0xFF2E7D32),
                    ),
                    _tileModeTile(
                      'mirror',
                      'Image mirrors at edges',
                      Icons.flip,
                      Color(0xFF6A1B9A),
                    ),
                    _tileModeTile(
                      'decal',
                      'Transparent beyond edges',
                      Icons.crop_free,
                      Color(0xFFBF360C),
                    ),
                  ],
                ),
              ),

              // ── Section 3: Dilate & Erode ──
              _sectionTitle('3. DILATE & ERODE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.zoom_out_map,
                              size: 28,
                              color: Color(0xFF2E7D32),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'dilate',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Expands bright regions\nGrows edges outward',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),
                            _radiusBar('rX', 3, Color(0xFF2E7D32)),
                            _radiusBar('rY', 3, Color(0xFF2E7D32)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.zoom_in_map,
                              size: 28,
                              color: Color(0xFFBF360C),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'erode',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color(0xFFBF360C),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Shrinks bright regions\nErodes edges inward',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 8),
                            _radiusBar('rX', 2, Color(0xFFBF360C)),
                            _radiusBar('rY', 2, Color(0xFFBF360C)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 4: Compose ──
              _sectionTitle('4. IMAGE FILTER COMPOSE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    _composeBox('inner', 'dilate(r1)', Color(0xFF2E7D32)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(Icons.add, color: Colors.grey[400], size: 18),
                    ),
                    _composeBox('outer', 'blur(σ3)', Color(0xFF006064)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.grey[400],
                        size: 18,
                      ),
                    ),
                    _composeBox('result', 'composed', Color(0xFF6A1B9A)),
                  ],
                ),
              ),

              // ── Section 5: ColorFilter Mode ──
              _sectionTitle('5. COLOR FILTER — MODE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _colorFilterRow(
                      'Red + colorBurn',
                      Colors.red,
                      BlendMode.colorBurn,
                    ),
                    _colorFilterRow(
                      'Blue + srcATop',
                      Colors.blue,
                      BlendMode.srcATop,
                    ),
                    _colorFilterRow(
                      'Green + overlay',
                      Colors.green,
                      BlendMode.overlay,
                    ),
                    _colorFilterRow(
                      'Orange + multiply',
                      Colors.orange,
                      BlendMode.multiply,
                    ),
                    _colorFilterRow(
                      'Purple + screen',
                      Colors.purple,
                      BlendMode.screen,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'ColorFilter.mode(color, blendMode) applies a color '
                      'with the specified blend mode to every pixel.',
                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),

              // ── Section 6: ColorFilter Matrix ──
              _sectionTitle('6. COLOR FILTER — MATRIX'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Grayscale',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.grey[800]!,
                                    Colors.grey[400]!,
                                    Colors.grey[200]!,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'R,G,B → 0.2126R + 0.7152G + 0.0722B',
                              style: TextStyle(
                                fontSize: 8,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Sepia',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF8B7355),
                                    Color(0xFFD2B48C),
                                    Color(0xFFF5DEB3),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '5×4 matrix for warm toning',
                              style: TextStyle(
                                fontSize: 8,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 7: Gamma & Summary ──
              _sectionTitle('7. GAMMA CONVERSION & API MAP'),
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
                        _gammaBox(
                          'Linear',
                          'linearToSrgbGamma()',
                          Color(0xFF0D47A1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(
                            Icons.swap_horiz,
                            color: Colors.grey[400],
                            size: 18,
                          ),
                        ),
                        _gammaBox(
                          'sRGB',
                          'srgbToLinearGamma()',
                          Color(0xFF2E7D32),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'COMPLETE FILTER API MAP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Color(0xFF455A64),
                      ),
                    ),
                    SizedBox(height: 8),
                    _apiRow(
                      'ImageFilter',
                      'blur, dilate, erode, matrix, compose',
                      Color(0xFF006064),
                    ),
                    _apiRow(
                      'ColorFilter',
                      'mode, matrix, linearToSrgb, srgbToLinear',
                      Color(0xFFBF360C),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF8E1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'ImageFilter processes pixel positions (blur/distort). '
                        'ColorFilter processes color values per pixel.',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xFFF57F17),
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

Widget _blurSample(String label, double sigma, Color color) {
  return Expanded(
    child: Container(
      height: 70,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.blur_on,
              size: 20,
              color: color.withValues(alpha: 0.3 + sigma / 20),
            ),
            SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _tileModeTile(String name, String desc, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        SizedBox(width: 10),
        SizedBox(
          width: 70,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
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

Widget _radiusBar(String label, int radius, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        SizedBox(width: 4),
        Expanded(
          child: Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              widthFactor: radius / 5,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 4),
        Text('$radius', style: TextStyle(fontSize: 9, color: color)),
      ],
    ),
  );
}

Widget _composeBox(String label, String name, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 9, color: Colors.grey[500])),
          Text(
            name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _colorFilterRow(String label, Color filterColor, BlendMode mode) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: filterColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 8),
        Expanded(child: Text(label, style: TextStyle(fontSize: 11))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: filterColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            mode.name,
            style: TextStyle(fontSize: 9, color: filterColor),
          ),
        ),
      ],
    ),
  );
}

Widget _gammaBox(String label, String api, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: color,
            ),
          ),
          Text(
            api,
            style: TextStyle(
              fontSize: 9,
              fontFamily: 'monospace',
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _apiRow(String name, String methods, Color color) {
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
          width: 80,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            methods,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}
