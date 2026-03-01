// D4rt test script: Tests Paint, Canvas, and drawing primitives from dart:ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Dart:ui paint test executing');

  // ========== PAINT ==========
  print('--- Paint Tests ---');

  // Test Paint default constructor
  final paint = Paint();
  print('Paint created');

  // Test color
  paint.color = const Color(0xFF2196F3);
  print('Color: ${paint.color}');

  // Test isAntiAlias
  paint.isAntiAlias = true;
  print('isAntiAlias: ${paint.isAntiAlias}');

  paint.isAntiAlias = false;
  print('isAntiAlias disabled: ${paint.isAntiAlias}');

  // Test style (fill vs stroke)
  paint.style = PaintingStyle.fill;
  print('PaintingStyle.fill: ${paint.style}');

  paint.style = PaintingStyle.stroke;
  print('PaintingStyle.stroke: ${paint.style}');

  // Test strokeWidth
  paint.strokeWidth = 2.0;
  print('strokeWidth: ${paint.strokeWidth}');

  paint.strokeWidth = 5.0;
  print('strokeWidth (thick): ${paint.strokeWidth}');

  // Test strokeCap
  paint.strokeCap = StrokeCap.butt;
  print('StrokeCap.butt: ${paint.strokeCap}');

  paint.strokeCap = StrokeCap.round;
  print('StrokeCap.round: ${paint.strokeCap}');

  paint.strokeCap = StrokeCap.square;
  print('StrokeCap.square: ${paint.strokeCap}');

  // Test strokeJoin
  paint.strokeJoin = StrokeJoin.miter;
  print('StrokeJoin.miter: ${paint.strokeJoin}');

  paint.strokeJoin = StrokeJoin.round;
  print('StrokeJoin.round: ${paint.strokeJoin}');

  paint.strokeJoin = StrokeJoin.bevel;
  print('StrokeJoin.bevel: ${paint.strokeJoin}');

  // Test strokeMiterLimit
  paint.strokeMiterLimit = 4.0;
  print('strokeMiterLimit: ${paint.strokeMiterLimit}');

  // Test blendMode
  print('--- BlendMode Tests ---');
  paint.blendMode = BlendMode.srcOver;
  print('BlendMode.srcOver (default): ${paint.blendMode}');

  final blendModes = [
    BlendMode.clear,
    BlendMode.src,
    BlendMode.dst,
    BlendMode.srcOver,
    BlendMode.dstOver,
    BlendMode.srcIn,
    BlendMode.dstIn,
    BlendMode.srcOut,
    BlendMode.dstOut,
    BlendMode.srcATop,
    BlendMode.dstATop,
    BlendMode.xor,
    BlendMode.plus,
    BlendMode.modulate,
    BlendMode.screen,
    BlendMode.overlay,
    BlendMode.darken,
    BlendMode.lighten,
    BlendMode.colorDodge,
    BlendMode.colorBurn,
    BlendMode.hardLight,
    BlendMode.softLight,
    BlendMode.difference,
    BlendMode.exclusion,
    BlendMode.multiply,
    BlendMode.hue,
    BlendMode.saturation,
    BlendMode.color,
    BlendMode.luminosity,
  ];

  for (final mode in blendModes) {
    paint.blendMode = mode;
    print('BlendMode.$mode');
  }

  // Test filterQuality
  print('--- FilterQuality Tests ---');
  paint.filterQuality = FilterQuality.none;
  print('FilterQuality.none: ${paint.filterQuality}');

  paint.filterQuality = FilterQuality.low;
  print('FilterQuality.low: ${paint.filterQuality}');

  paint.filterQuality = FilterQuality.medium;
  print('FilterQuality.medium: ${paint.filterQuality}');

  paint.filterQuality = FilterQuality.high;
  print('FilterQuality.high: ${paint.filterQuality}');

  // Test colorFilter
  print('--- ColorFilter Tests ---');
  paint.colorFilter = const ColorFilter.mode(
    Color(0xFFFF0000),
    BlendMode.srcIn,
  );
  print('ColorFilter.mode: ${paint.colorFilter}');

  paint.colorFilter = const ColorFilter.linearToSrgbGamma();
  print('ColorFilter.linearToSrgbGamma');

  paint.colorFilter = const ColorFilter.srgbToLinearGamma();
  print('ColorFilter.srgbToLinearGamma');

  // Reset for next tests
  paint.colorFilter = null;
  print('ColorFilter cleared');

  // Test maskFilter
  print('--- MaskFilter Tests ---');
  paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);
  print('MaskFilter.blur(normal, 5.0)');

  paint.maskFilter = const MaskFilter.blur(BlurStyle.solid, 3.0);
  print('MaskFilter.blur(solid, 3.0)');

  paint.maskFilter = const MaskFilter.blur(BlurStyle.outer, 4.0);
  print('MaskFilter.blur(outer, 4.0)');

  paint.maskFilter = const MaskFilter.blur(BlurStyle.inner, 2.0);
  print('MaskFilter.blur(inner, 2.0)');

  paint.maskFilter = null;
  print('MaskFilter cleared');

  // Test shader
  print('--- Shader Tests ---');
  final linearShader = Gradient.linear(Offset(0.0, 0.0), Offset(100.0, 0.0), [
    const Color(0xFFFF0000),
    const Color(0xFF0000FF),
  ]);
  paint.shader = linearShader;
  print('Linear gradient shader set');

  final radialShader = Gradient.radial(Offset(50.0, 50.0), 50.0, [
    const Color(0xFFFFFFFF),
    const Color(0xFF000000),
  ]);
  paint.shader = radialShader;
  print('Radial gradient shader set');

  final sweepShader = Gradient.sweep(Offset(50.0, 50.0), [
    const Color(0xFFFF0000),
    const Color(0xFF00FF00),
    const Color(0xFF0000FF),
    const Color(0xFFFF0000),
  ]);
  paint.shader = sweepShader;
  print('Sweep gradient shader set');

  paint.shader = null;
  print('Shader cleared');

  // Test imageFilter
  print('--- ImageFilter Tests ---');
  final blurFilter = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  paint.imageFilter = blurFilter;
  print('ImageFilter.blur(5, 5)');

  final blurClampFilter = ImageFilter.blur(
    sigmaX: 3.0,
    sigmaY: 3.0,
    tileMode: TileMode.clamp,
  );
  paint.imageFilter = blurClampFilter;
  print('ImageFilter.blur with TileMode.clamp');

  final blurMirrorFilter = ImageFilter.blur(
    sigmaX: 3.0,
    sigmaY: 3.0,
    tileMode: TileMode.mirror,
  );
  paint.imageFilter = blurMirrorFilter;
  print('ImageFilter.blur with TileMode.mirror');

  final blurRepeatFilter = ImageFilter.blur(
    sigmaX: 3.0,
    sigmaY: 3.0,
    tileMode: TileMode.repeated,
  );
  paint.imageFilter = blurRepeatFilter;
  print('ImageFilter.blur with TileMode.repeated');

  final dilateFilter = ImageFilter.dilate(radiusX: 2.0, radiusY: 2.0);
  paint.imageFilter = dilateFilter;
  print('ImageFilter.dilate(2, 2)');

  final erodeFilter = ImageFilter.erode(radiusX: 2.0, radiusY: 2.0);
  paint.imageFilter = erodeFilter;
  print('ImageFilter.erode(2, 2)');

  final matrixFilter = ImageFilter.matrix(Matrix4.rotationZ(0.1).storage);
  paint.imageFilter = matrixFilter;
  print('ImageFilter.matrix (rotation)');

  // Compose filters
  final composedFilter = ImageFilter.compose(
    outer: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
    inner: ImageFilter.dilate(radiusX: 1.0, radiusY: 1.0),
  );
  paint.imageFilter = composedFilter;
  print('ImageFilter.compose (blur + dilate)');

  paint.imageFilter = null;
  print('ImageFilter cleared');

  // Test invertColors
  paint.invertColors = true;
  print('invertColors: ${paint.invertColors}');

  paint.invertColors = false;
  print('invertColors disabled: ${paint.invertColors}');

  // ========== GRADIENT ==========
  print('--- Gradient Tests ---');

  // Linear gradient
  final linearGrad = Gradient.linear(
    Offset(0.0, 0.0),
    Offset(200.0, 200.0),
    [const Color(0xFFFF0000), const Color(0xFFFFFF00), const Color(0xFF00FF00)],
    [0.0, 0.5, 1.0],
  );
  print('Linear gradient with stops');

  // Linear gradient with TileMode
  final linearRepeat = Gradient.linear(
    Offset(0.0, 0.0),
    Offset(50.0, 0.0),
    [const Color(0xFFFF0000), const Color(0xFF0000FF)],
    null,
    TileMode.repeated,
  );
  print('Linear gradient TileMode.repeated');

  final linearMirror = Gradient.linear(
    Offset(0.0, 0.0),
    Offset(50.0, 0.0),
    [const Color(0xFFFF0000), const Color(0xFF0000FF)],
    null,
    TileMode.mirror,
  );
  print('Linear gradient TileMode.mirror');

  // Radial gradient
  final radialGrad = Gradient.radial(
    Offset(100.0, 100.0),
    100.0,
    [const Color(0xFFFFFFFF), const Color(0xFFFF0000), const Color(0xFF000000)],
    [0.0, 0.5, 1.0],
  );
  print('Radial gradient with stops');

  // Radial gradient with focal point
  final radialFocal = Gradient.radial(
    Offset(100.0, 100.0),
    100.0,
    [const Color(0xFFFFFFFF), const Color(0xFF000000)],
    null,
    TileMode.clamp,
    null,
    Offset(80.0, 80.0),
    10.0,
  );
  print('Radial gradient with focal point');

  // Sweep gradient
  final sweepGrad = Gradient.sweep(Offset(100.0, 100.0), [
    const Color(0xFFFF0000),
    const Color(0xFFFF7F00),
    const Color(0xFFFFFF00),
    const Color(0xFF00FF00),
    const Color(0xFF0000FF),
    const Color(0xFF8B00FF),
    const Color(0xFFFF0000),
  ]);
  print('Sweep gradient (rainbow)');

  // Sweep with angles
  final sweepPartial = Gradient.sweep(
    Offset(100.0, 100.0),
    [const Color(0xFFFF0000), const Color(0xFF0000FF)],
    null,
    TileMode.clamp,
    0.0, // startAngle
    3.14159, // endAngle (180 degrees)
  );
  print('Sweep gradient partial (0 to 180 degrees)');

  // ========== TEXTDIRECTION ==========
  print('--- TextDirection Tests ---');
  print('TextDirection.ltr: ${TextDirection.ltr}');
  print('TextDirection.rtl: ${TextDirection.rtl}');

  // ========== FONTWEIGHT ==========
  print('--- FontWeight Tests ---');
  print('FontWeight.w100: ${FontWeight.w100}');
  print('FontWeight.w200: ${FontWeight.w200}');
  print('FontWeight.w300: ${FontWeight.w300}');
  print('FontWeight.w400: ${FontWeight.w400}');
  print('FontWeight.w500: ${FontWeight.w500}');
  print('FontWeight.w600: ${FontWeight.w600}');
  print('FontWeight.w700: ${FontWeight.w700}');
  print('FontWeight.w800: ${FontWeight.w800}');
  print('FontWeight.w900: ${FontWeight.w900}');
  print('FontWeight.normal: ${FontWeight.normal}');
  print('FontWeight.bold: ${FontWeight.bold}');
  print(
    'FontWeight.lerp(w400, w900, 0.5): ${FontWeight.lerp(FontWeight.w400, FontWeight.w900, 0.5)}',
  );

  // ========== FONTSTYLE ==========
  print('--- FontStyle Tests ---');
  print('FontStyle.normal: ${FontStyle.normal}');
  print('FontStyle.italic: ${FontStyle.italic}');

  // ========== TEXTBASELINE ==========
  print('--- TextBaseline Tests ---');
  print('TextBaseline.alphabetic: ${TextBaseline.alphabetic}');
  print('TextBaseline.ideographic: ${TextBaseline.ideographic}');

  // ========== CLIP ==========
  print('--- Clip Tests ---');
  print('Clip.none: ${Clip.none}');
  print('Clip.hardEdge: ${Clip.hardEdge}');
  print('Clip.antiAlias: ${Clip.antiAlias}');
  print('Clip.antiAliasWithSaveLayer: ${Clip.antiAliasWithSaveLayer}');

  print('Dart:ui paint test completed');

  // Return visual demonstration
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dart:UI Paint Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'PaintingStyle:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF2196F3),
                    border: Border.all(color: Color(0xFF1565C0), width: 2.0),
                  ),
                  child: Center(
                    child: Text(
                      'Fill',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Color(0xFF2196F3), width: 4.0),
                  ),
                  child: Center(
                    child: Text(
                      'Stroke',
                      style: TextStyle(
                        color: Color(0xFF2196F3),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('StrokeCap:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• butt - flat end at line endpoint',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• round - semicircle at endpoint',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• square - square extending past endpoint',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'BlendMode (selected):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: [
                for (final mode in [
                  'srcOver',
                  'multiply',
                  'screen',
                  'overlay',
                  'colorDodge',
                  'colorBurn',
                ])
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    color: Color(0xFF2196F3),
                    child: Text(
                      mode,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'FilterQuality:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (final quality in ['none', 'low', 'medium', 'high'])
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      color: Color(0xFF4CAF50),
                      child: Text(
                        quality,
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Gradient Types:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Linear',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [Color(0xFFFFFFFF), Color(0xFF000000)],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Radial',
                      style: TextStyle(
                        color: Color(0xFF2196F3),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    gradient: SweepGradient(
                      colors: [
                        Color(0xFFFF0000),
                        Color(0xFFFFFF00),
                        Color(0xFF00FF00),
                        Color(0xFF00FFFF),
                        Color(0xFF0000FF),
                        Color(0xFFFF00FF),
                        Color(0xFFFF0000),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Sweep',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'MaskFilter (blur styles):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (final style in ['normal', 'solid', 'outer', 'inner'])
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      color: Color(0xFF9C27B0),
                      child: Text(
                        style,
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'ImageFilter types:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• blur(sigmaX, sigmaY) - Gaussian blur',
                  style: TextStyle(fontSize: 12.0),
                ),
                Text(
                  '• dilate(radiusX, radiusY) - Expand edges',
                  style: TextStyle(fontSize: 12.0),
                ),
                Text(
                  '• erode(radiusX, radiusY) - Contract edges',
                  style: TextStyle(fontSize: 12.0),
                ),
                Text(
                  '• matrix(Float64List) - Transform filter',
                  style: TextStyle(fontSize: 12.0),
                ),
                Text(
                  '• compose(outer, inner) - Chain filters',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
