// D4rt test script: Tests TargetImageSize from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TargetImageSize test executing');

  final ts1 = ui.TargetImageSize();
  print('Default: width=${ts1.width}, height=${ts1.height}');

  final ts2 = ui.TargetImageSize(width: 100, height: 200);
  print('100x200: width=${ts2.width}, height=${ts2.height}');

  final ts3 = ui.TargetImageSize(width: 50);
  print('width only: width=${ts3.width}, height=${ts3.height}');

  final ts4 = ui.TargetImageSize(height: 75);
  print('height only: width=${ts4.width}, height=${ts4.height}');

  print('TargetImageSize test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('TargetImageSize Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Default: w=${ts1.width}, h=${ts1.height}'),
    Text('100x200: w=${ts2.width}, h=${ts2.height}'),
    Text('Width only: w=${ts3.width}'),
  ]);
}
