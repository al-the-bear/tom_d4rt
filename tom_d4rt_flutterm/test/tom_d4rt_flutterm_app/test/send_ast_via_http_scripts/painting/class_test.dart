// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo of painting package classes and concepts
import 'dart:math' as math;
import 'package:flutter/material.dart';

Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    margin: EdgeInsets.only(bottom: 8, top: 14),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade700,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

Widget buildSubsectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 10, bottom: 6),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.deepPurple.shade600,
      ),
    ),
  );
}

class PaintDemoCustomPainter extends CustomPainter {
  final Color strokeColor;
  final Color fillColor;
  final double strokeWidth;
  
  PaintDemoCustomPainter({
    required this.strokeColor,
    required this.fillColor,
    required this.strokeWidth,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    print('PaintDemoCustomPainter.paint called with size: $size');
    
    final paintStroke = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    
    final paintFill = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 3;
    
    canvas.drawCircle(center, radius, paintFill);
    canvas.drawCircle(center, radius, paintStroke);
    
    final rectWidth = size.width * 0.4;
    final rectHeight = size.height * 0.25;
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * 0.15),
      width: rectWidth,
      height: rectHeight,
    );
    
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(8));
    canvas.drawRRect(rrect, paintFill);
    canvas.drawRRect(rrect, paintStroke);
    
    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.85)
      ..lineTo(size.width * 0.5, size.height * 0.65)
      ..lineTo(size.width * 0.8, size.height * 0.85)
      ..close();
    
    canvas.drawPath(path, paintFill);
    canvas.drawPath(path, paintStroke);
  }
  
  @override
  bool shouldRepaint(covariant PaintDemoCustomPainter oldDelegate) {
    return strokeColor != oldDelegate.strokeColor ||
           fillColor != oldDelegate.fillColor ||
           strokeWidth != oldDelegate.strokeWidth;
  }
}

class GradientPainter extends CustomPainter {
  final Gradient gradient;
  
  GradientPainter({required this.gradient});
  
  @override
  void paint(Canvas canvas, Size size) {
    print('GradientPainter.paint called');
    
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final shader = gradient.createShader(rect);
    
    final paint = Paint()
      ..shader = shader
      ..style = PaintingStyle.fill;
    
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(12));
    canvas.drawRRect(rrect, paint);
    
    final outlinePaint = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    
    canvas.drawRRect(rrect, outlinePaint);
  }
  
  @override
  bool shouldRepaint(covariant GradientPainter oldDelegate) {
    return gradient != oldDelegate.gradient;
  }
}

class CanvasOperationsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('CanvasOperationsPainter.paint - demonstrating canvas methods');
    
    canvas.save();
    print('Canvas saved');
    
    canvas.translate(20, 20);
    
    final paint = Paint()
      ..color = Colors.blue.shade600
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(Rect.fromLTWH(0, 0, 40, 25), paint);
    
    canvas.restore();
    print('Canvas restored');
    
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(math.pi / 6);
    
    final rotatedPaint = Paint()
      ..color = Colors.green.shade600
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(Rect.fromLTWH(-20, -12, 40, 25), rotatedPaint);
    canvas.restore();
    
    canvas.save();
    canvas.translate(size.width - 60, 30);
    canvas.scale(0.8, 1.2);
    
    final scaledPaint = Paint()
      ..color = Colors.orange.shade600
      ..style = PaintingStyle.fill;
    
    canvas.drawOval(Rect.fromLTWH(0, 0, 40, 30), scaledPaint);
    canvas.restore();
    
    final clipRect = Rect.fromLTWH(10, size.height - 50, 60, 35);
    canvas.save();
    canvas.clipRect(clipRect);
    
    final clipPaint = Paint()
      ..color = Colors.purple.shade400
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(40, size.height - 32),
      30,
      clipPaint,
    );
    canvas.restore();
    
    final borderPaint = Paint()
      ..color = Colors.grey.shade800
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(clipRect, borderPaint);
    
    final linePaint = Paint()
      ..color = Colors.red.shade500
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    canvas.drawLine(
      Offset(size.width - 50, size.height - 40),
      Offset(size.width - 10, size.height - 10),
      linePaint,
    );
    
    final arcRect = Rect.fromLTWH(size.width / 2 - 20, size.height - 45, 40, 40);
    final arcPaint = Paint()
      ..color = Colors.teal.shade500
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    
    canvas.drawArc(arcRect, 0, math.pi * 1.5, false, arcPaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TextPainterDemo extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double maxWidth;
  
  const TextPainterDemo({
    super.key,
    required this.text,
    required this.textStyle,
    required this.maxWidth,
  });
  
  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(text: text, style: textStyle);
    
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 3,
      ellipsis: '...',
    );
    
    textPainter.layout(minWidth: 0, maxWidth: maxWidth);
    
    print('TextPainter metrics:');
    print('  size: ${textPainter.size}');
    print('  width: ${textPainter.width}');
    print('  height: ${textPainter.height}');
    print('  didExceedMaxLines: ${textPainter.didExceedMaxLines}');
    print('  minIntrinsicWidth: ${textPainter.minIntrinsicWidth}');
    print('  maxIntrinsicWidth: ${textPainter.maxIntrinsicWidth}');
    
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        border: Border.all(color: Colors.amber.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TextPainter Measurement Demo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(height: 8),
          Container(
            width: maxWidth,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Text(text, style: textStyle, maxLines: 3, overflow: TextOverflow.ellipsis),
          ),
          SizedBox(height: 8),
          Text('Computed size: ${textPainter.size.width.toStringAsFixed(1)} x ${textPainter.size.height.toStringAsFixed(1)}'),
          Text('Did exceed max lines: ${textPainter.didExceedMaxLines}'),
        ],
      ),
    );
  }
}

dynamic build(BuildContext context) {
  print('=== Painting Package Deep Demo ===');
  print('Demonstrating various painting classes and concepts');
  
  // Section 1: Paint Objects
  print('\n--- Section 1: Paint Objects ---');
  
  final basicPaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill;
  print('Basic Paint: color=${basicPaint.color}, style=${basicPaint.style}');
  
  final strokePaint = Paint()
    ..color = Colors.red.shade700
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4.0
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.miter
    ..strokeMiterLimit = 4.0;
  print('Stroke Paint properties:');
  print('  strokeWidth: ${strokePaint.strokeWidth}');
  print('  strokeCap: ${strokePaint.strokeCap}');
  print('  strokeJoin: ${strokePaint.strokeJoin}');
  print('  strokeMiterLimit: ${strokePaint.strokeMiterLimit}');
  
  final antiAliasPaint = Paint()
    ..isAntiAlias = true
    ..color = Colors.green;
  print('AntiAlias Paint: isAntiAlias=${antiAliasPaint.isAntiAlias}');
  
  final blendModePaint = Paint()
    ..blendMode = BlendMode.multiply
    ..color = Colors.orange;
  print('BlendMode Paint: blendMode=${blendModePaint.blendMode}');
  
  final filterQualityPaint = Paint()
    ..filterQuality = FilterQuality.high
    ..color = Colors.purple;
  print('FilterQuality Paint: filterQuality=${filterQualityPaint.filterQuality}');
  
  // Section 2: Color Operations
  print('\n--- Section 2: Color Operations ---');
  
  final baseColor = Color(0xFF3498DB);
  print('Base color: $baseColor');
  print('  alpha: ${baseColor.alpha}');
  print('  red: ${baseColor.red}');
  print('  green: ${baseColor.green}');
  print('  blue: ${baseColor.blue}');
  
  final withAlphaColor = baseColor.withAlpha(128);
  print('With alpha 128: $withAlphaColor');
  
  final withOpacityColor = baseColor.withValues(alpha: 0.5);
  print('With opacity 0.5: $withOpacityColor');
  
  final colorFromARGB = Color.fromARGB(255, 231, 76, 60);
  print('Color from ARGB: $colorFromARGB');
  
  final colorFromRGBO = Color.fromRGBO(46, 204, 113, 1.0);
  print('Color from RGBO: $colorFromRGBO');
  
  final computeLuminance = baseColor.computeLuminance();
  print('Base color luminance: $computeLuminance');
  
  final hslColor = HSLColor.fromColor(baseColor);
  print('HSL representation:');
  print('  hue: ${hslColor.hue}');
  print('  saturation: ${hslColor.saturation}');
  print('  lightness: ${hslColor.lightness}');
  
  final hsvColor = HSVColor.fromColor(baseColor);
  print('HSV representation:');
  print('  hue: ${hsvColor.hue}');
  print('  saturation: ${hsvColor.saturation}');
  print('  value: ${hsvColor.value}');
  
  final lerpedColor = Color.lerp(Colors.red, Colors.blue, 0.5);
  print('Lerped color (red->blue at 0.5): $lerpedColor');
  
  // Section 3: Gradient Usage
  print('\n--- Section 3: Gradient Usage ---');
  
  final linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.blue.shade300, Colors.purple.shade600, Colors.pink.shade400],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );
  print('LinearGradient created');
  print('  begin: ${linearGradient.begin}');
  print('  end: ${linearGradient.end}');
  print('  colors count: ${linearGradient.colors.length}');
  print('  tileMode: ${linearGradient.tileMode}');
  
  final radialGradient = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [Colors.yellow.shade300, Colors.orange.shade600],
    stops: [0.3, 1.0],
    focal: Alignment(0.1, 0.1),
    focalRadius: 0.1,
  );
  print('RadialGradient created');
  print('  center: ${radialGradient.center}');
  print('  radius: ${radialGradient.radius}');
  print('  focal: ${radialGradient.focal}');
  print('  focalRadius: ${radialGradient.focalRadius}');
  
  final sweepGradient = SweepGradient(
    center: Alignment.center,
    startAngle: 0.0,
    endAngle: math.pi * 2,
    colors: [Colors.red, Colors.green, Colors.blue, Colors.red],
    stops: [0.0, 0.33, 0.66, 1.0],
  );
  print('SweepGradient created');
  print('  startAngle: ${sweepGradient.startAngle}');
  print('  endAngle: ${sweepGradient.endAngle}');
  
  final transformedGradient = LinearGradient(
    colors: [Colors.cyan, Colors.indigo],
    transform: GradientRotation(math.pi / 4),
  );
  print('LinearGradient with rotation transform: ${transformedGradient.colors}');
  
  final scaledLinear = linearGradient.scale(0.5);
  print('Scaled gradient to 50%: $scaledLinear');
  
  final lerpedGradient = LinearGradient.lerp(linearGradient, transformedGradient, 0.5);
  print('Lerped gradient: ${lerpedGradient?.runtimeType}');
  
  // Section 4: BoxDecoration and Decoration Concepts
  print('\n--- Section 4: BoxDecoration and Decoration ---');
  
  final simpleBoxDecoration = BoxDecoration(
    color: Colors.teal.shade100,
    borderRadius: BorderRadius.circular(12),
  );
  print('Simple BoxDecoration: $simpleBoxDecoration');
  
  final complexBoxDecoration = BoxDecoration(
    gradient: linearGradient,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.2),
        blurRadius: 10,
        spreadRadius: 2,
        offset: Offset(0, 4),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        blurRadius: 4,
        spreadRadius: 0,
        offset: Offset(0, 2),
      ),
    ],
    border: Border.all(color: Colors.grey.shade400, width: 1.5),
  );
  print('Complex BoxDecoration created with multiple shadows');
  
  final shapeDecoration = ShapeDecoration(
    color: Colors.lime.shade200,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.lime.shade700, width: 2),
    ),
    shadows: [
      BoxShadow(
        color: Colors.lime.shade900.withValues(alpha: 0.3),
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  );
  print('ShapeDecoration: ${shapeDecoration.shape}');
  
  final flutterLogoDecoration = FlutterLogoDecoration(
    style: FlutterLogoStyle.markOnly,
    textColor: Colors.blue.shade800,
  );
  print('FlutterLogoDecoration: style=${flutterLogoDecoration.style}');
  
  final boxPainter = complexBoxDecoration.createBoxPainter();
  print('BoxPainter created: ${boxPainter.runtimeType}');
  boxPainter.dispose();
  print('BoxPainter disposed');
  
  // Section 5: DecorationImage Concepts
  print('\n--- Section 5: DecorationImage Concepts ---');
  
  print('DecorationImage properties:');
  print('  - image: ImageProvider (required)');
  print('  - fit: BoxFit (default: BoxFit.cover)');
  print('  - alignment: Alignment (default: Alignment.center)');
  print('  - repeat: ImageRepeat (default: ImageRepeat.noRepeat)');
  print('  - filterQuality: FilterQuality (default: FilterQuality.low)');
  print('  - scale: double (default: 1.0)');
  print('  - opacity: double (0.0 to 1.0)');
  print('  - colorFilter: ColorFilter (optional)');
  
  print('\nBoxFit options:');
  print('  BoxFit.fill - stretch to fill');
  print('  BoxFit.contain - fit inside maintaining aspect');
  print('  BoxFit.cover - cover entire area maintaining aspect');
  print('  BoxFit.fitWidth - fit width, may overflow height');
  print('  BoxFit.fitHeight - fit height, may overflow width');
  print('  BoxFit.none - no scaling');
  print('  BoxFit.scaleDown - contain but only scale down');
  
  print('\nImageRepeat options:');
  print('  ImageRepeat.noRepeat');
  print('  ImageRepeat.repeat');
  print('  ImageRepeat.repeatX');
  print('  ImageRepeat.repeatY');
  
  print('\nColorFilter usage:');
  final colorFilterMode = ColorFilter.mode(Colors.blue.withValues(alpha: 0.5), BlendMode.colorBurn);
  print('  ColorFilter.mode: $colorFilterMode');
  
  final colorFilterMatrix = ColorFilter.matrix([
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ]);
  print('  ColorFilter.matrix (grayscale): $colorFilterMatrix');
  
  // Section 6: Border and BorderSide
  print('\n--- Section 6: Border and BorderSide ---');
  
  final simpleBorderSide = BorderSide(
    color: Colors.blue,
    width: 2.0,
    style: BorderStyle.solid,
    strokeAlign: BorderSide.strokeAlignCenter,
  );
  print('BorderSide: $simpleBorderSide');
  print('  strokeAlign: ${simpleBorderSide.strokeAlign}');
  
  final uniformBorder = Border.all(color: Colors.purple, width: 3);
  print('Uniform Border: $uniformBorder');
  
  final directionalBorder = Border(
    top: BorderSide(color: Colors.red, width: 4),
    right: BorderSide(color: Colors.green, width: 2),
    bottom: BorderSide(color: Colors.blue, width: 4),
    left: BorderSide(color: Colors.orange, width: 2),
  );
  print('Directional Border created with different sides');
  
  final borderRadius = BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.elliptical(16, 8),
    bottomLeft: Radius.zero,
    bottomRight: Radius.circular(8),
  );
  print('BorderRadius with mixed corners: $borderRadius');
  
  // Section 7: EdgeInsets and Alignment
  print('\n--- Section 7: EdgeInsets and Alignment ---');
  
  final edgeInsetsAll = EdgeInsets.all(16);
  print('EdgeInsets.all: $edgeInsetsAll');
  
  final edgeInsetsSymmetric = EdgeInsets.symmetric(horizontal: 24, vertical: 12);
  print('EdgeInsets.symmetric: $edgeInsetsSymmetric');
  
  final edgeInsetsOnly = EdgeInsets.only(left: 8, top: 16, right: 8, bottom: 4);
  print('EdgeInsets.only: $edgeInsetsOnly');
  
  final edgeInsetsFromLTRB = EdgeInsets.fromLTRB(10, 20, 30, 40);
  print('EdgeInsets.fromLTRB: $edgeInsetsFromLTRB');
  
  final collapsedEdgeInsets = edgeInsetsFromLTRB.collapsedSize;
  print('Collapsed size: $collapsedEdgeInsets');
  
  final flippedEdgeInsets = edgeInsetsFromLTRB.flipped;
  print('Flipped: $flippedEdgeInsets');
  
  print('\nAlignment values:');
  print('  topLeft: ${Alignment.topLeft}');
  print('  topCenter: ${Alignment.topCenter}');
  print('  center: ${Alignment.center}');
  print('  bottomRight: ${Alignment.bottomRight}');
  
  final customAlignment = Alignment(0.25, -0.75);
  print('Custom alignment: $customAlignment');
  
  final fractionalOffset = FractionalOffset(0.5, 0.5);
  print('FractionalOffset center: $fractionalOffset');
  
  // Section 8: TextStyle Properties
  print('\n--- Section 8: TextStyle Comprehensive ---');
  
  final comprehensiveTextStyle = TextStyle(
    color: Colors.indigo.shade800,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.5,
    wordSpacing: 2.0,
    height: 1.5,
    textBaseline: TextBaseline.alphabetic,
    decoration: TextDecoration.none,
    decorationColor: Colors.red,
    decorationStyle: TextDecorationStyle.solid,
    decorationThickness: 1.0,
    overflow: TextOverflow.ellipsis,
  );
  print('Comprehensive TextStyle created');
  print('  fontSize: ${comprehensiveTextStyle.fontSize}');
  print('  fontWeight: ${comprehensiveTextStyle.fontWeight}');
  print('  letterSpacing: ${comprehensiveTextStyle.letterSpacing}');
  print('  height: ${comprehensiveTextStyle.height}');
  
  final decoratedTextStyle = TextStyle(
    fontSize: 16,
    decoration: TextDecoration.combine([
      TextDecoration.underline,
      TextDecoration.overline,
    ]),
    decorationStyle: TextDecorationStyle.wavy,
    decorationColor: Colors.red,
  );
  print('Decorated TextStyle with wavy underline+overline');
  
  final shadowTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(
        color: Colors.black54,
        offset: Offset(2, 2),
        blurRadius: 4,
      ),
      Shadow(
        color: Colors.blue.shade200,
        offset: Offset(-1, -1),
        blurRadius: 2,
      ),
    ],
  );
  print('TextStyle with multiple shadows');
  
  final copiedStyle = comprehensiveTextStyle.copyWith(
    color: Colors.teal,
    fontSize: 20,
  );
  print('Copied and modified style: fontSize=${copiedStyle.fontSize}');
  
  final mergedStyle = comprehensiveTextStyle.merge(TextStyle(
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  ));
  print('Merged style: letterSpacing=${mergedStyle.letterSpacing}');
  
  // Section 9: StrutStyle
  print('\n--- Section 9: StrutStyle ---');
  
  final strutStyle = StrutStyle(
    fontSize: 16,
    height: 1.8,
    leading: 0.5,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    forceStrutHeight: true,
  );
  print('StrutStyle: height=${strutStyle.height}, forceStrutHeight=${strutStyle.forceStrutHeight}');
  
  final strutFromTextStyle = StrutStyle.fromTextStyle(
    comprehensiveTextStyle,
    forceStrutHeight: true,
  );
  print('StrutStyle from TextStyle: fontSize=${strutFromTextStyle.fontSize}');
  
  // Build the visual demo
  print('\n=== Building Visual Demo ===');
  
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Painting Package Deep Demo',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        
        buildSectionHeader('1. Paint Objects Demo'),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomPaint(
            size: Size.infinite,
            painter: PaintDemoCustomPainter(
              strokeColor: Colors.indigo.shade800,
              fillColor: Colors.indigo.shade200,
              strokeWidth: 3.0,
            ),
          ),
        ),
        buildInfoCard('Stroke Paint', 'color, width, cap, join, miterLimit'),
        buildInfoCard('Fill Paint', 'color, style=fill'),
        buildInfoCard('Special', 'isAntiAlias, blendMode, filterQuality'),
        
        buildSectionHeader('2. Canvas Operations'),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomPaint(
            size: Size.infinite,
            painter: CanvasOperationsPainter(),
          ),
        ),
        buildInfoCard('Transform', 'translate, rotate, scale'),
        buildInfoCard('State', 'save, restore'),
        buildInfoCard('Clip', 'clipRect, clipPath, clipRRect'),
        buildInfoCard('Draw', 'drawLine, drawArc, drawPath'),
        
        buildSectionHeader('3. Color Operations'),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                ),
                child: Center(child: Text('Base', style: TextStyle(color: Colors.white))),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                color: withAlphaColor,
                child: Center(child: Text('Alpha 128')),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: lerpedColor,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                ),
                child: Center(child: Text('Lerped', style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        buildInfoCard('HSL', 'H:${hslColor.hue.toStringAsFixed(0)}° S:${(hslColor.saturation*100).toStringAsFixed(0)}% L:${(hslColor.lightness*100).toStringAsFixed(0)}%'),
        buildInfoCard('HSV', 'H:${hsvColor.hue.toStringAsFixed(0)}° S:${(hsvColor.saturation*100).toStringAsFixed(0)}% V:${(hsvColor.value*100).toStringAsFixed(0)}%'),
        buildInfoCard('Luminance', computeLuminance.toStringAsFixed(3)),
        
        buildSectionHeader('4. Gradient Usage'),
        buildSubsectionTitle('Linear Gradient'),
        SizedBox(
          height: 60,
          child: CustomPaint(
            size: Size.infinite,
            painter: GradientPainter(gradient: linearGradient),
          ),
        ),
        buildSubsectionTitle('Radial Gradient'),
        SizedBox(
          height: 80,
          child: CustomPaint(
            size: Size.infinite,
            painter: GradientPainter(gradient: radialGradient),
          ),
        ),
        buildSubsectionTitle('Sweep Gradient'),
        SizedBox(
          height: 80,
          child: CustomPaint(
            size: Size.infinite,
            painter: GradientPainter(gradient: sweepGradient),
          ),
        ),
        buildInfoCard('TileMode', 'clamp, repeated, mirror, decal'),
        buildInfoCard('Transform', 'GradientRotation for rotation'),
        
        buildSectionHeader('5. TextPainter Demo'),
        TextPainterDemo(
          text: 'The TextPainter class is used to paint text onto a canvas. It can compute the width and height of text before painting. This is a longer text to demonstrate how TextPainter handles overflow.',
          textStyle: TextStyle(fontSize: 14, color: Colors.grey.shade800),
          maxWidth: 280,
        ),
        buildInfoCard('Layout', 'layout(minWidth, maxWidth)'),
        buildInfoCard('Metrics', 'size, width, height, baseline'),
        buildInfoCard('Overflow', 'didExceedMaxLines, ellipsis'),
        
        buildSectionHeader('6. BoxDecoration Examples'),
        buildSubsectionTitle('Simple with Shadow'),
        Container(
          height: 60,
          decoration: complexBoxDecoration,
          child: Center(
            child: Text(
              'Gradient + Shadow + Border',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 12),
        buildSubsectionTitle('ShapeDecoration'),
        Container(
          height: 50,
          decoration: shapeDecoration,
          child: Center(
            child: Text('RoundedRectangleBorder shape'),
          ),
        ),
        SizedBox(height: 12),
        buildSubsectionTitle('FlutterLogoDecoration'),
        Container(
          height: 80,
          decoration: flutterLogoDecoration,
        ),
        buildInfoCard('BoxPainter', 'createBoxPainter() -> paint() -> dispose()'),
        
        buildSectionHeader('7. Border Variations'),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(border: uniformBorder),
                child: Center(child: Text('Uniform')),
              ),
            ),
            Expanded(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(left: 4),
                decoration: BoxDecoration(border: directionalBorder),
                child: Center(child: Text('Directional')),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.cyan.shade50,
            borderRadius: borderRadius,
            border: Border.all(color: Colors.cyan.shade700),
          ),
          child: Center(child: Text('Mixed BorderRadius')),
        ),
        buildInfoCard('strokeAlign', 'inside, center, outside'),
        
        buildSectionHeader('8. TextStyle Showcase'),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Comprehensive Style', style: comprehensiveTextStyle),
              SizedBox(height: 8),
              Text('Wavy Decoration', style: decoratedTextStyle),
              SizedBox(height: 8),
              Text('Shadow Text', style: shadowTextStyle),
            ],
          ),
        ),
        buildInfoCard('Properties', 'color, size, weight, spacing, height'),
        buildInfoCard('Decoration', 'underline, overline, lineThrough'),
        buildInfoCard('Methods', 'copyWith, merge, apply'),
        
        buildSectionHeader('9. EdgeInsets & Alignment'),
        Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(width: 30, height: 30, color: Colors.red.shade200, child: Center(child: Text('TL'))),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(width: 30, height: 30, color: Colors.green.shade200, child: Center(child: Text('TR'))),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(width: 40, height: 40, color: Colors.blue.shade200, child: Center(child: Text('C'))),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(width: 30, height: 30, color: Colors.orange.shade200, child: Center(child: Text('BL'))),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(width: 30, height: 30, color: Colors.purple.shade200, child: Center(child: Text('BR'))),
              ),
              Align(
                alignment: customAlignment,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(color: Colors.pink.shade300, shape: BoxShape.circle),
                  child: Center(child: Text('*', style: TextStyle(fontSize: 12))),
                ),
              ),
            ],
          ),
        ),
        buildInfoCard('EdgeInsets', 'all, symmetric, only, fromLTRB'),
        buildInfoCard('Alignment', 'x,y from -1 to 1, or named constants'),
        buildInfoCard('FractionalOffset', '0,0=topLeft, 1,1=bottomRight'),
        
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Painting Package Demo Complete!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
