// D4rt test script: Tests multiple painting classes from Flutter painting package
// Covers: TextPainter, BoxDecoration, ImageProvider, Gradient, Border, TextStyle
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Painting class overview test executing');

  // ========== TEXTPAINTER ==========
  print('--- TextPainter Tests ---');
  final textPainter = TextPainter(
    text: TextSpan(
      text: 'Hello TextPainter',
      style: TextStyle(fontSize: 20.0, color: Colors.blue),
    ),
    textDirection: TextDirection.ltr,
    textAlign: TextAlign.left,
    maxLines: 1,
  );
  textPainter.layout(minWidth: 0.0, maxWidth: 300.0);
  print('TextPainter width: ${textPainter.width}');
  print('TextPainter height: ${textPainter.height}');
  print('TextPainter size: ${textPainter.size}');
  print('TextPainter minIntrinsicWidth: ${textPainter.minIntrinsicWidth}');
  print('TextPainter maxIntrinsicWidth: ${textPainter.maxIntrinsicWidth}');
  print('TextPainter preferredLineHeight: ${textPainter.preferredLineHeight}');

  // TextPainter with multiline
  final multiLinePainter = TextPainter(
    text: TextSpan(
      text: 'Line 1\nLine 2\nLine 3',
      style: TextStyle(fontSize: 16.0),
    ),
    textDirection: TextDirection.ltr,
    maxLines: 3,
  );
  multiLinePainter.layout(maxWidth: 200.0);
  print('Multiline height: ${multiLinePainter.height}');

  // ========== TEXTSTYLE ==========
  print('--- TextStyle Tests ---');
  final textStyle1 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    color: Colors.red,
    letterSpacing: 1.5,
    wordSpacing: 2.0,
    height: 1.2,
    decoration: TextDecoration.underline,
    decorationColor: Colors.blue,
    decorationStyle: TextDecorationStyle.wavy,
  );
  print('TextStyle fontSize: ${textStyle1.fontSize}');
  print('TextStyle fontWeight: ${textStyle1.fontWeight}');
  print('TextStyle decoration: ${textStyle1.decoration}');

  final mergedStyle = textStyle1.merge(TextStyle(color: Colors.green));
  print('Merged TextStyle color: ${mergedStyle.color}');

  final copiedStyle = textStyle1.copyWith(fontSize: 32.0);
  print('Copied TextStyle fontSize: ${copiedStyle.fontSize}');

  // ========== BOXDECORATION ==========
  print('--- BoxDecoration Tests ---');
  final boxDeco1 = BoxDecoration(
    color: Colors.purple,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(color: Colors.black38, blurRadius: 8.0, offset: Offset(2, 4)),
    ],
  );
  print('BoxDecoration color: ${boxDeco1.color}');
  print('BoxDecoration borderRadius: ${boxDeco1.borderRadius}');

  final boxDeco2 = BoxDecoration(
    gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
    shape: BoxShape.circle,
  );
  print('BoxDecoration shape: ${boxDeco2.shape}');

  // ========== GRADIENT ==========
  print('--- Gradient Tests ---');
  final linearGrad = LinearGradient(
    colors: [Colors.blue, Colors.green, Colors.yellow],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  print('LinearGradient colors: ${linearGrad.colors.length}');
  print('LinearGradient begin: ${linearGrad.begin}');

  final radialGrad = RadialGradient(
    colors: [Colors.white, Colors.blue],
    center: Alignment.center,
    radius: 0.8,
  );
  print('RadialGradient radius: ${radialGrad.radius}');

  final sweepGrad = SweepGradient(
    colors: [Colors.red, Colors.green, Colors.blue, Colors.red],
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
  );
  print('SweepGradient colors: ${sweepGrad.colors.length}');

  // ========== BORDER ==========
  print('--- Border Tests ---');
  final border1 = Border.all(color: Colors.black, width: 2.0);
  print('Border.all width: ${border1.top.width}');

  final border2 = Border(
    top: BorderSide(color: Colors.red, width: 3.0),
    bottom: BorderSide(color: Colors.blue, width: 3.0),
    left: BorderSide(color: Colors.green, width: 1.0),
    right: BorderSide(color: Colors.yellow, width: 1.0),
  );
  print('Border top color: ${border2.top.color}');
  print('Border dimensions: ${border2.dimensions}');

  // ========== BORDERRADIUS ==========
  print('--- BorderRadius Tests ---');
  final br1 = BorderRadius.circular(16.0);
  print('BorderRadius.circular: ${br1.topLeft}');

  final br2 = BorderRadius.only(
    topLeft: Radius.circular(8.0),
    bottomRight: Radius.elliptical(16.0, 8.0),
  );
  print('BorderRadius.only topLeft: ${br2.topLeft}');

  // ========== EDGEINSETS ==========
  print('--- EdgeInsets Tests ---');
  final ei1 = EdgeInsets.all(16.0);
  print('EdgeInsets.all: ${ei1.left}');

  final ei2 = EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);
  print('EdgeInsets.symmetric h: ${ei2.left}, v: ${ei2.top}');

  final ei3 = EdgeInsets.fromLTRB(5, 10, 15, 20);
  print(
    'EdgeInsets.fromLTRB: ${ei3.left}, ${ei3.top}, ${ei3.right}, ${ei3.bottom}',
  );

  // ========== ALIGNMENT ==========
  print('--- Alignment Tests ---');
  print('Alignment.topLeft: ${Alignment.topLeft}');
  print('Alignment.center: ${Alignment.center}');
  print('Alignment.bottomRight: ${Alignment.bottomRight}');
  final customAlign = Alignment(0.5, -0.3);
  print('Custom Alignment: $customAlign');

  print('Painting class overview test completed');

  // ========== RETURN WIDGET ==========
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Painting Classes Overview',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          // TextPainter demo
          Text(
            'TextPainter: ${textPainter.width.toStringAsFixed(1)} x ${textPainter.height.toStringAsFixed(1)}',
          ),
          SizedBox(height: 8),

          // TextStyle demos
          Text('Bold Italic Underline', style: textStyle1),
          Text('Merged Green', style: mergedStyle),
          SizedBox(height: 12),

          // BoxDecoration demos
          Container(
            width: 150,
            height: 50,
            decoration: boxDeco1,
            child: Center(
              child: Text('Shadow Box', style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 8),
          Container(width: 60, height: 60, decoration: boxDeco2),
          SizedBox(height: 12),

          // Gradient demos
          Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
              gradient: linearGrad,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(child: Text('LinearGradient')),
          ),
          SizedBox(height: 8),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: radialGrad,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: sweepGrad,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 12),

          // Border demo
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(border: border2, color: Colors.white),
            child: Center(child: Text('Borders')),
          ),
          SizedBox(height: 12),

          // EdgeInsets demo
          Container(
            color: Colors.grey.shade300,
            child: Padding(
              padding: ei2,
              child: Container(color: Colors.blue, width: 80, height: 40),
            ),
          ),
        ],
      ),
    ),
  );
}
