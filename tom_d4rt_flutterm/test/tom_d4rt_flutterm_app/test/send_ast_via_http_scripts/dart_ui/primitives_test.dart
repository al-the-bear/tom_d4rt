// D4rt test script: Tests Color, Offset, Size from dart:ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Dart:ui primitives test executing');

  // ========== COLOR ==========
  print('--- Color Tests ---');

  // Test Color constructor with hex value
  final red = Color(0xFFFF0000);
  print('Red: $red');
  print('  value: ${red.value}');
  print('  alpha: ${red.alpha}');
  print('  red: ${red.red}');
  print('  green: ${red.green}');
  print('  blue: ${red.blue}');
  print('  opacity: ${red.opacity}');

  // Test Color.fromARGB
  final fromARGB = Color.fromARGB(255, 0, 255, 0);
  print('Green fromARGB: $fromARGB');
  print(
    '  alpha=${fromARGB.alpha}, red=${fromARGB.red}, green=${fromARGB.green}, blue=${fromARGB.blue}',
  );

  // Test Color.fromRGBO
  final fromRGBO = Color.fromRGBO(0, 0, 255, 1.0);
  print('Blue fromRGBO: $fromRGBO');

  final semiTransparent = Color.fromRGBO(255, 0, 0, 0.5);
  print('Semi-transparent red: opacity=${semiTransparent.opacity}');

  // Test withAlpha
  final withAlpha = red.withAlpha(128);
  print('Red with alpha 128: opacity=${withAlpha.opacity}');

  // Test withOpacity
  final withOpacity = red.withOpacity(0.5);
  print('Red with opacity 0.5: alpha=${withOpacity.alpha}');

  // Test withRed/withGreen/withBlue
  final withRed = red.withRed(128);
  print('Red with red=128: red=${withRed.red}');

  final withGreen = red.withGreen(255);
  print('Red with green=255: $withGreen');

  final withBlue = red.withBlue(255);
  print('Red with blue=255: $withBlue');

  // Test Color.lerp
  final colorLerp = Color.lerp(red, Color(0xFF0000FF), 0.5);
  print('Lerp red to blue at 0.5: $colorLerp');

  // Test alphaBlend
  final blended = Color.alphaBlend(Color(0x80FF0000), Color(0xFFFFFFFF));
  print('Alpha blend red on white: $blended');

  // Test computeLuminance
  print('White luminance: ${Color(0xFFFFFFFF).computeLuminance()}');
  print('Black luminance: ${Color(0xFF000000).computeLuminance()}');
  print('Red luminance: ${red.computeLuminance()}');

  // Test equality
  print('Color equality: ${red == Color(0xFFFF0000)}');

  // ========== OFFSET ==========
  print('--- Offset Tests ---');

  // Test Offset constructor
  final offset = Offset(10.0, 20.0);
  print('Offset(10, 20): $offset');
  print('  dx: ${offset.dx}');
  print('  dy: ${offset.dy}');

  // Test Offset.zero
  print('Offset.zero: ${Offset.zero}');

  // Test Offset.infinite
  print('Offset.infinite: ${Offset.infinite}');

  // Test Offset.fromDirection
  final fromDirection = Offset.fromDirection(
    0.0,
    10.0,
  ); // 0 radians, distance 10
  print('Offset.fromDirection(0, 10): $fromDirection');

  final fromDirection45 = Offset.fromDirection(0.785, 10.0); // 45 degrees
  print('Offset.fromDirection(45°, 10): $fromDirection45');

  // Test operators
  final offset2 = Offset(5.0, 5.0);
  print('Offset + Offset: ${offset + offset2}');
  print('Offset - Offset: ${offset - offset2}');
  print('Offset * 2: ${offset * 2.0}');
  print('Offset / 2: ${offset / 2.0}');
  print('Offset ~/ 3: ${offset ~/ 3}');
  print('-Offset: ${-offset}');

  // Test distance
  print('Distance to origin: ${offset.distance}');
  print('Distance squared: ${offset.distanceSquared}');

  // Test direction
  print('Direction: ${offset.direction}');

  // Test scale
  final scaled = offset.scale(2.0, 3.0);
  print('Scaled 2x, 3y: $scaled');

  // Test translate
  final translated = offset.translate(5.0, -5.0);
  print('Translated (+5, -5): $translated');

  // Test isFinite/isInfinite
  print('isFinite: ${offset.isFinite}');
  print('infinite.isInfinite: ${Offset.infinite.isInfinite}');

  // Test Offset.lerp
  final offsetLerp = Offset.lerp(Offset.zero, Offset(100.0, 100.0), 0.5);
  print('Offset.lerp at 0.5: $offsetLerp');

  // ========== SIZE ==========
  print('--- Size Tests ---');

  // Test Size constructor
  final size = Size(100.0, 80.0);
  print('Size(100, 80): $size');
  print('  width: ${size.width}');
  print('  height: ${size.height}');

  // Test Size.zero
  print('Size.zero: ${Size.zero}');

  // Test Size.infinite
  print('Size.infinite: ${Size.infinite}');

  // Test Size.square
  final square = Size.square(50.0);
  print('Size.square(50): $square');

  // Test Size.fromWidth
  final fromWidth = Size.fromWidth(100.0);
  print('Size.fromWidth(100): $fromWidth');

  // Test Size.fromHeight
  final fromHeight = Size.fromHeight(80.0);
  print('Size.fromHeight(80): $fromHeight');

  // Test Size.fromRadius
  final fromRadius = Size.fromRadius(25.0);
  print('Size.fromRadius(25): $fromRadius');

  // Test Size.copy
  final sizeCopy = Size.copy(size);
  print('Size.copy: $sizeCopy');

  // Test aspectRatio
  print('Aspect ratio: ${size.aspectRatio}');

  // Test isEmpty
  print('isEmpty: ${size.isEmpty}');
  print('Size.zero.isEmpty: ${Size.zero.isEmpty}');

  // Test isFinite/isInfinite
  print('isFinite: ${size.isFinite}');
  print('Size.infinite.isInfinite: ${Size.infinite.isInfinite}');

  // Test operators
  final size2 = Size(20.0, 10.0);
  print('Size - Offset: ${size - Offset(10.0, 10.0)}'); // Returns OffsetBase
  print('Size * 2: ${size * 2.0}');
  print('Size / 2: ${size / 2.0}');
  print('Size ~/ 2: ${size ~/ 2}');

  // Test flipped
  print('Flipped: ${size.flipped}');

  // Test shortestSide/longestSide
  print('Shortest side: ${size.shortestSide}');
  print('Longest side: ${size.longestSide}');

  // Test topLeft/topCenter/topRight etc
  print('topLeft: ${size.topLeft(Offset(50.0, 50.0))}');
  print('topCenter: ${size.topCenter(Offset(50.0, 50.0))}');
  print('topRight: ${size.topRight(Offset(50.0, 50.0))}');
  print('centerLeft: ${size.centerLeft(Offset(50.0, 50.0))}');
  print('center: ${size.center(Offset(50.0, 50.0))}');
  print('centerRight: ${size.centerRight(Offset(50.0, 50.0))}');
  print('bottomLeft: ${size.bottomLeft(Offset(50.0, 50.0))}');
  print('bottomCenter: ${size.bottomCenter(Offset(50.0, 50.0))}');
  print('bottomRight: ${size.bottomRight(Offset(50.0, 50.0))}');

  // Test contains
  print('Contains Offset(50, 40): ${size.contains(Offset(50.0, 40.0))}');
  print('Contains Offset(200, 200): ${size.contains(Offset(200.0, 200.0))}');

  // Test Size.lerp
  final sizeLerp = Size.lerp(Size.zero, Size(100.0, 100.0), 0.5);
  print('Size.lerp at 0.5: $sizeLerp');

  // ========== RADIUS ==========
  print('--- Radius Tests ---');

  // Test Radius.circular
  final circularRadius = Radius.circular(10.0);
  print('Radius.circular(10): $circularRadius');
  print('  x: ${circularRadius.x}');
  print('  y: ${circularRadius.y}');

  // Test Radius.elliptical
  final ellipticalRadius = Radius.elliptical(10.0, 20.0);
  print('Radius.elliptical(10, 20): $ellipticalRadius');

  // Test Radius.zero
  print('Radius.zero: ${Radius.zero}');

  // Test operators
  print('Radius * 2: ${circularRadius * 2.0}');
  print('Radius / 2: ${circularRadius / 2.0}');
  print('-Radius: ${-circularRadius}');

  // Test Radius.lerp
  final radiusLerp = Radius.lerp(Radius.zero, Radius.circular(20.0), 0.5);
  print('Radius.lerp at 0.5: $radiusLerp');

  // Test Radius.clamp
  final largeRadius = Radius.circular(50.0);
  final clampedRadius = largeRadius.clamp(
    minimum: Radius.zero,
    maximum: Radius.circular(30.0),
  );
  print('Radius.clamp(50 to max 30): $clampedRadius');

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

  // Test FontWeight.lerp
  final fontWeightLerp = FontWeight.lerp(FontWeight.w400, FontWeight.w700, 0.5);
  print('FontWeight.lerp(400, 700, 0.5): $fontWeightLerp');

  // ========== LOCALE ==========
  print('--- Locale Tests ---');

  final enUS = Locale('en', 'US');
  print('Locale(en, US): $enUS');
  print('  languageCode: ${enUS.languageCode}');
  print('  countryCode: ${enUS.countryCode}');

  final enOnly = Locale('en');
  print('Locale(en): $enOnly');

  final jaJP = Locale('ja', 'JP');
  print('Locale(ja, JP): $jaJP');

  // Test with script code
  final zhHantTW = Locale.fromSubtags(
    languageCode: 'zh',
    scriptCode: 'Hant',
    countryCode: 'TW',
  );
  print('Chinese Traditional Taiwan: $zhHantTW');
  print('  scriptCode: ${zhHantTW.scriptCode}');

  // Test toLanguageTag
  print('toLanguageTag: ${enUS.toLanguageTag()}');

  // ========== SHADOW ==========
  print('--- Shadow Tests ---');

  final shadow = Shadow(
    color: Color(0x80000000),
    offset: Offset(2.0, 2.0),
    blurRadius: 4.0,
  );
  print('Shadow: $shadow');
  print('  color: ${shadow.color}');
  print('  offset: ${shadow.offset}');
  print('  blurRadius: ${shadow.blurRadius}');
  print('  blurSigma: ${shadow.blurSigma}');

  // Test Shadow.lerp
  final shadowLerp = Shadow.lerp(
    Shadow(color: Color(0x00000000), blurRadius: 0.0),
    Shadow(
      color: Color(0xFF000000),
      blurRadius: 10.0,
      offset: Offset(5.0, 5.0),
    ),
    0.5,
  );
  print('Shadow.lerp at 0.5: blurRadius=${shadowLerp?.blurRadius}');

  // Test Shadow.lerpList
  final shadowList = Shadow.lerpList(
    [Shadow(blurRadius: 0.0)],
    [Shadow(blurRadius: 10.0), Shadow(blurRadius: 20.0)],
    0.5,
  );
  print('Shadow.lerpList: ${shadowList?.length} shadows');

  // Test toPaint
  final paint = shadow.toPaint();
  print('Shadow.toPaint: color=${paint.color}');

  // Test scale
  final scaledShadow = shadow.scale(2.0);
  print('Shadow.scale(2): blurRadius=${scaledShadow.blurRadius}');

  print('Dart:ui primitives test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dart:UI Primitives Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text('Color:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(width: 40.0, height: 40.0, color: Color(0xFFFF0000)),
                Container(width: 40.0, height: 40.0, color: Color(0xFF00FF00)),
                Container(width: 40.0, height: 40.0, color: Color(0xFF0000FF)),
                Container(width: 40.0, height: 40.0, color: Color(0xFFFFFF00)),
                Container(width: 40.0, height: 40.0, color: Color(0xFF00FFFF)),
                Container(width: 40.0, height: 40.0, color: Color(0xFFFF00FF)),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (var i = 0; i <= 10; i++)
                  Container(
                    width: 20.0,
                    height: 20.0,
                    color: Color.lerp(
                      Color(0xFFFF0000),
                      Color(0xFF0000FF),
                      i / 10.0,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Offset:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Container(
              width: 150.0,
              height: 100.0,
              color: Color(0xFFE0E0E0),
              child: Stack(
                children: [
                  Positioned(
                    left: 10.0,
                    top: 20.0,
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF2196F3),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 60.0,
                    top: 40.0,
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 100.0,
                    top: 60.0,
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text('Size:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(width: 30.0, height: 30.0, color: Color(0xFFFF9800)),
                SizedBox(width: 8.0),
                Container(width: 50.0, height: 40.0, color: Color(0xFFFF9800)),
                SizedBox(width: 8.0),
                Container(width: 80.0, height: 60.0, color: Color(0xFFFF9800)),
                SizedBox(width: 8.0),
                Container(width: 100.0, height: 80.0, color: Color(0xFFFF9800)),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Radius (BorderRadius):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C27B0),
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C27B0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C27B0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C27B0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('FontWeight:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text('w100', style: TextStyle(fontWeight: FontWeight.w100)),
                SizedBox(width: 8.0),
                Text('w300', style: TextStyle(fontWeight: FontWeight.w300)),
                SizedBox(width: 8.0),
                Text('w400', style: TextStyle(fontWeight: FontWeight.w400)),
                SizedBox(width: 8.0),
                Text('w600', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 8.0),
                Text('w900', style: TextStyle(fontWeight: FontWeight.w900)),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Shadow:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('4px', style: TextStyle(fontSize: 12.0)),
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(4.0, 4.0),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('8px', style: TextStyle(fontSize: 12.0)),
                  ),
                ),
                SizedBox(width: 16.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(8.0, 8.0),
                        blurRadius: 16.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('16px', style: TextStyle(fontSize: 12.0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
