// ignore_for_file: avoid_print
// D4rt test script: Tests StrutStyle, TextAlignVertical, TextScaler
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextPaintingTest test executing');

  // StrutStyle
  final strutStyle = StrutStyle(
    fontSize: 16.0,
    height: 1.5,
    leading: 0.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    forceStrutHeight: true,
  );
  print('StrutStyle fontSize: ${strutStyle.fontSize}');
  print('StrutStyle height: ${strutStyle.height}');
  print('StrutStyle leading: ${strutStyle.leading}');
  print('StrutStyle fontWeight: ${strutStyle.fontWeight}');
  print('StrutStyle fontStyle: ${strutStyle.fontStyle}');
  print('StrutStyle forceStrutHeight: ${strutStyle.forceStrutHeight}');

  // StrutStyle with fontFamily
  final strutWithFamily = StrutStyle(
    fontFamily: 'Roboto',
    fontSize: 20.0,
    height: 1.2,
  );
  print('StrutStyle fontFamily: ${strutWithFamily.fontFamily}');
  print('StrutStyle fontSize: ${strutWithFamily.fontSize}');
  print('StrutStyle height: ${strutWithFamily.height}');

  // TextAlignVertical
  final tavTop = TextAlignVertical.top;
  final tavCenter = TextAlignVertical.center;
  final tavBottom = TextAlignVertical.bottom;
  print('TextAlignVertical.top y: ${tavTop.y}');
  print('TextAlignVertical.center y: ${tavCenter.y}');
  print('TextAlignVertical.bottom y: ${tavBottom.y}');

  // Custom TextAlignVertical
  final tavCustom = TextAlignVertical(y: 0.25);
  print('TextAlignVertical(y: 0.25) y: ${tavCustom.y}');

  // TextScaler
  final scaler = TextScaler.linear(1.5);
  print('TextScaler.linear(1.5): $scaler');

  final scalerNoOp = TextScaler.noScaling;
  print('TextScaler.noScaling: $scalerNoOp');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'StrutStyle applied (h:1.5, leading:0.5)',
        strutStyle: strutStyle,
        style: TextStyle(fontSize: 16.0),
      ),
      SizedBox(height: 8.0),
      Text(
        'StrutStyle with fontFamily',
        strutStyle: strutWithFamily,
        style: TextStyle(fontSize: 20.0),
      ),
      SizedBox(height: 12.0),
      Container(
        height: 60.0,
        width: 250.0,
        color: Colors.blue.shade50,
        child: TextField(
          textAlignVertical: tavTop,
          decoration: InputDecoration(
            hintText: 'TextAlignVertical.top',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      SizedBox(height: 8.0),
      Container(
        height: 60.0,
        width: 250.0,
        color: Colors.green.shade50,
        child: TextField(
          textAlignVertical: tavCenter,
          decoration: InputDecoration(
            hintText: 'TextAlignVertical.center',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      SizedBox(height: 12.0),
      Text(
        'TextScaler.linear(1.5)',
        textScaler: scaler,
        style: TextStyle(fontSize: 14.0),
      ),
      SizedBox(height: 4.0),
      Text(
        'TextScaler.noScaling',
        textScaler: scalerNoOp,
        style: TextStyle(fontSize: 14.0),
      ),
    ],
  );
}
