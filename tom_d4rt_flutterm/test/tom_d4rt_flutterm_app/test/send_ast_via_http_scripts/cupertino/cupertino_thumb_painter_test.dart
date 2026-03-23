// ignore_for_file: avoid_print
// D4rt test script: Tests CupertinoThumbPainter from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoThumbPainter test executing');

  // ===== 1. Default constructor =====
  print('--- Default CupertinoThumbPainter ---');
  final defaultPainter = CupertinoThumbPainter();
  print('  default painter created: ${defaultPainter.runtimeType}');

  // ===== 2. With custom color =====
  print('--- Custom color ---');
  final bluePainter = CupertinoThumbPainter(
    color: CupertinoColors.activeBlue,
  );
  print('  blue painter created [${bluePainter.hashCode }]');

  final redPainter = CupertinoThumbPainter(
    color: CupertinoColors.systemRed,
  );
  print('  red painter created [${redPainter.hashCode }]');

  final grayPainter = CupertinoThumbPainter(
    color: CupertinoColors.systemGrey,
  );
  print('  gray painter created [${grayPainter.hashCode }]');

  // ===== 3. With custom shadows =====
  print('--- Custom shadows ---');
  final customShadows = CupertinoThumbPainter(
    shadows: [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 4.0,
        offset: Offset(0.0, 2.0),
      ),
    ],
  );
  print('  custom shadows painter created [${customShadows.hashCode }]');

  final noShadows = CupertinoThumbPainter(
    shadows: [],
  );
  print('  no-shadow painter created [${noShadows.hashCode }]');

  final heavyShadows = CupertinoThumbPainter(
    shadows: [
      BoxShadow(
        color: Color(0x66000000),
        blurRadius: 8.0,
        offset: Offset(0.0, 4.0),
      ),
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 16.0,
        offset: Offset(0.0, 8.0),
      ),
    ],
  );
  print('  heavy shadows painter created (2 shadows) [${heavyShadows.hashCode }]');

  // ===== 4. switchThumb named constructor =====
  print('--- CupertinoThumbPainter.switchThumb ---');
  final switchDefault = CupertinoThumbPainter.switchThumb();
  print('  switch thumb default: ${switchDefault.runtimeType}');

  final switchColored = CupertinoThumbPainter.switchThumb(
    color: CupertinoColors.systemGreen,
  );
  print('  switch thumb green created [${switchColored.hashCode }]');

  final switchCustom = CupertinoThumbPainter.switchThumb(
    color: CupertinoColors.white,
    shadows: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 6.0,
        offset: Offset(0.0, 3.0),
      ),
    ],
  );
  print('  switch thumb custom created [${switchCustom.hashCode }]');

  // ===== 5. Static properties =====
  print('--- Static properties ---');
  print('  radius: ${CupertinoThumbPainter.radius}');
  print('  extension: ${CupertinoThumbPainter.extension}');

  // ===== 6. Color + shadows combined =====
  print('--- Combined customization ---');
  final combined = CupertinoThumbPainter(
    color: Color(0xFFE8E8E8),
    shadows: [
      BoxShadow(
        color: Color(0x22000000),
        blurRadius: 3.0,
        offset: Offset(0.0, 1.0),
      ),
    ],
  );
  print('  combined painter created [${combined.hashCode }]');

  // ===== 7. Visual demo with CupertinoSwitch and CupertinoSlider =====
  print('--- Usage context ---');
  final switchWidget = CupertinoSwitch(
    value: true,
    onChanged: (v) {},
  );
  print('  CupertinoSwitch uses thumb painter internally');

  final slider = CupertinoSlider(
    value: 0.5,
    onChanged: (v) {},
  );
  print('  CupertinoSlider uses thumb painter internally');

  print('CupertinoThumbPainter test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('ThumbPainter Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CupertinoThumbPainter', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.0),
              Text('Static radius: ${CupertinoThumbPainter.radius}'),
              Text('Static extension: ${CupertinoThumbPainter.extension}'),
              SizedBox(height: 16.0),
              Text('CupertinoSwitch (uses thumb):', style: TextStyle(fontWeight: FontWeight.bold)),
              switchWidget,
              SizedBox(height: 12.0),
              CupertinoSwitch(value: false, onChanged: (v) {}),
              SizedBox(height: 16.0),
              Text('CupertinoSlider (uses thumb):', style: TextStyle(fontWeight: FontWeight.bold)),
              slider,
              SizedBox(height: 8.0),
              CupertinoSlider(value: 0.0, onChanged: (v) {}),
              SizedBox(height: 8.0),
              CupertinoSlider(value: 1.0, onChanged: (v) {}),
            ],
          ),
        ),
      ),
    ),
  );
}
