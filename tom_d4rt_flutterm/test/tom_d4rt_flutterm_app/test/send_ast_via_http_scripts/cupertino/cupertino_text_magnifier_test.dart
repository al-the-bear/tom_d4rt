// D4rt test script: Tests CupertinoTextMagnifier from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoTextMagnifier test executing');

  // ===== 1. Basic CupertinoTextMagnifier with controller =====
  print('--- Basic CupertinoTextMagnifier ---');
  final controller = ValueNotifier(MagnifierInfo.empty);
  final magnifier = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: controller,
  );
  print('  basic magnifier created');
  print('  runtimeType: ${magnifier.runtimeType}');

  // ===== 2. With custom dragResistance =====
  print('--- Custom dragResistance ---');
  final highResistance = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: controller,
    dragResistance: 20.0,
  );
  print('  dragResistance: 20.0 magnifier created');

  final lowResistance = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: controller,
    dragResistance: 5.0,
  );
  print('  dragResistance: 5.0 magnifier created');

  // ===== 3. With custom hideBelowThreshold =====
  print('--- Custom hideBelowThreshold ---');
  final highThreshold = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: controller,
    hideBelowThreshold: 100.0,
  );
  print('  hideBelowThreshold: 100.0');

  final lowThreshold = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: controller,
    hideBelowThreshold: 20.0,
  );
  print('  hideBelowThreshold: 20.0');

  // ===== 4. With custom horizontalScreenEdgePadding =====
  print('--- Custom horizontalScreenEdgePadding ---');
  final widePadding = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: controller,
    horizontalScreenEdgePadding: 24.0,
  );
  print('  horizontalScreenEdgePadding: 24.0');

  // ===== 5. With custom animation curve =====
  print('--- Custom animationCurve ---');
  final linearCurve = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: controller,
    animationCurve: Curves.linear,
  );
  print('  animationCurve: Curves.linear');

  final bounceCurve = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: controller,
    animationCurve: Curves.bounceOut,
  );
  print('  animationCurve: Curves.bounceOut');

  // ===== 6. All custom parameters combined =====
  print('--- All custom parameters ---');
  final fullCustom = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: controller,
    dragResistance: 15.0,
    hideBelowThreshold: 60.0,
    horizontalScreenEdgePadding: 16.0,
    animationCurve: Curves.easeInOut,
  );
  print('  full custom magnifier created');

  // ===== 7. MagnifierInfo with position =====
  print('--- MagnifierInfo values ---');
  final positionedInfo = MagnifierInfo(
    globalGesturePosition: Offset(150.0, 300.0),
    caretRect: Rect.fromLTWH(145.0, 290.0, 2.0, 20.0),
    fieldBounds: Rect.fromLTWH(20.0, 280.0, 340.0, 40.0),
    currentLineBoundaries: Rect.fromLTWH(20.0, 290.0, 340.0, 20.0),
  );
  print('  gesture: ${positionedInfo.globalGesturePosition}');
  print('  caret: ${positionedInfo.caretRect}');
  print('  fieldBounds: ${positionedInfo.fieldBounds}');

  // ===== 8. Context: CupertinoTextField uses magnifier natively =====
  print('--- TextField integration ---');
  final textField = CupertinoTextField(
    placeholder: 'Long press to see magnifier',
    magnifierConfiguration: TextMagnifierConfiguration(),
  );
  print('  text field with magnifier config created');

  controller.dispose();

  print('CupertinoTextMagnifier test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('TextMagnifier Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CupertinoTextMagnifier Tests', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 16.0),
              Text('Magnifier type: ${magnifier.runtimeType}'),
              SizedBox(height: 8.0),
              Text('Custom params tested:'),
              Text('  - dragResistance: 5.0, 10.0, 20.0'),
              Text('  - hideBelowThreshold: 20.0, 48.0, 100.0'),
              Text('  - horizontalScreenEdgePadding: 10.0, 24.0'),
              Text('  - animationCurve: easeOut, linear, bounceOut, easeInOut'),
              SizedBox(height: 16.0),
              Text('TextField with magnifier:'),
              textField,
            ],
          ),
        ),
      ),
    ),
  );
}
