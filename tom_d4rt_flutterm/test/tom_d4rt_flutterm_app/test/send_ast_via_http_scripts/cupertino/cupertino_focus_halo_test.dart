// ignore_for_file: avoid_print
// D4rt test script: Tests CupertinoFocusHalo from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoFocusHalo test executing');

  // ===== 1. CupertinoFocusHalo.withRect — wrapping a button =====
  print('--- CupertinoFocusHalo.withRect ---');
  final rectHalo = CupertinoFocusHalo.withRect(
    child: CupertinoButton(
      child: Text('Rect Focus'),
      onPressed: () {},
    ),
  );
  print('  withRect halo created');
  print('  child type: ${rectHalo.child.runtimeType}');

  // ===== 2. CupertinoFocusHalo.withRRect — with border radius =====
  print('--- CupertinoFocusHalo.withRRect ---');
  final rRectHalo = CupertinoFocusHalo.withRRect(
    borderRadius: BorderRadius.circular(12.0),
    child: CupertinoButton.filled(
      child: Text('RRect Focus'),
      onPressed: () {},
    ),
  );
  print('  withRRect halo created');
  print('  borderRadius: 12.0');
  print('  child type: ${rRectHalo.child.runtimeType}');

  // ===== 3. withRRect with zero radius (effectively rect) =====
  print('--- withRRect zero radius ---');
  final zeroRadius = CupertinoFocusHalo.withRRect(
    borderRadius: BorderRadius.zero,
    child: Container(
      width: 100.0,
      height: 40.0,
      color: CupertinoColors.activeBlue,
      child: Center(child: Text('Zero', style: TextStyle(color: CupertinoColors.white))),
    ),
  );
  print('  zero-radius halo created');

  // ===== 4. withRRect large radius =====
  print('--- withRRect large radius ---');
  final largeRadius = CupertinoFocusHalo.withRRect(
    borderRadius: BorderRadius.circular(50.0),
    child: Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        color: CupertinoColors.systemGreen,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Center(child: Text('Circle')),
    ),
  );
  print('  large-radius halo created (borderRadius: 50.0)');

  // ===== 5. Wrapping different interactive widgets =====
  print('--- Various child widgets ---');
  final switchHalo = CupertinoFocusHalo.withRect(
    child: CupertinoSwitch(value: true, onChanged: (v) {}),
  );
  print('  switch halo created');

  final textFieldHalo = CupertinoFocusHalo.withRRect(
    borderRadius: BorderRadius.circular(8.0),
    child: CupertinoTextField(placeholder: 'Focused field'),
  );
  print('  text field halo created');

  print('CupertinoFocusHalo test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('FocusHalo Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('withRect:', style: TextStyle(fontWeight: FontWeight.bold)),
              rectHalo,
              SizedBox(height: 16.0),
              Text('withRRect (r=12):', style: TextStyle(fontWeight: FontWeight.bold)),
              rRectHalo,
              SizedBox(height: 16.0),
              Text('withRRect (r=0):', style: TextStyle(fontWeight: FontWeight.bold)),
              zeroRadius,
              SizedBox(height: 16.0),
              Text('withRRect (r=50):', style: TextStyle(fontWeight: FontWeight.bold)),
              largeRadius,
              SizedBox(height: 16.0),
              Text('Switch:', style: TextStyle(fontWeight: FontWeight.bold)),
              switchHalo,
              SizedBox(height: 16.0),
              Text('TextField:', style: TextStyle(fontWeight: FontWeight.bold)),
              textFieldHalo,
            ],
          ),
        ),
      ),
    ),
  );
}
