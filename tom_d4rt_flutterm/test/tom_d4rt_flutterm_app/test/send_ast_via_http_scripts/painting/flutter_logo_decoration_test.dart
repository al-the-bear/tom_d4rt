// D4rt test script: Tests FlutterLogoDecoration from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlutterLogoDecoration test executing');
  final results = <String>[];

  // ========== FlutterLogoDecoration Tests ==========
  print('Testing FlutterLogoDecoration...');

  // Test 1: Default FlutterLogoDecoration
  final logoDeco1 = FlutterLogoDecoration();
  assert(logoDeco1.style == FlutterLogoStyle.markOnly, 'Default style should be markOnly');
  results.add('FlutterLogoDecoration default style: ${logoDeco1.style}');
  print('FlutterLogoDecoration default: ${logoDeco1.style}');

  // Test 2: FlutterLogoDecoration with markOnly style
  final logoDeco2 = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  assert(logoDeco2.style == FlutterLogoStyle.markOnly, 'Style should be markOnly');
  results.add('FlutterLogoDecoration markOnly: ${logoDeco2.style}');
  print('FlutterLogoDecoration markOnly verified');

  // Test 3: FlutterLogoDecoration with horizontal style
  final logoDeco3 = FlutterLogoDecoration(style: FlutterLogoStyle.horizontal);
  assert(logoDeco3.style == FlutterLogoStyle.horizontal, 'Style should be horizontal');
  results.add('FlutterLogoDecoration horizontal: ${logoDeco3.style}');
  print('FlutterLogoDecoration horizontal: ${logoDeco3.style}');

  // Test 4: FlutterLogoDecoration with stacked style
  final logoDeco4 = FlutterLogoDecoration(style: FlutterLogoStyle.stacked);
  assert(logoDeco4.style == FlutterLogoStyle.stacked, 'Style should be stacked');
  results.add('FlutterLogoDecoration stacked: ${logoDeco4.style}');
  print('FlutterLogoDecoration stacked: ${logoDeco4.style}');

  // Test 5: FlutterLogoDecoration with textColor
  final logoDeco5 = FlutterLogoDecoration(textColor: Color(0xFF000000));
  assert(logoDeco5.textColor == Color(0xFF000000), 'TextColor should be black');
  results.add('FlutterLogoDecoration textColor: ${logoDeco5.textColor}');
  print('FlutterLogoDecoration textColor: ${logoDeco5.textColor}');

  // Test 6: FlutterLogoDecoration with custom textColor
  final logoDeco6 = FlutterLogoDecoration(textColor: Color(0xFFFF0000));
  assert(logoDeco6.textColor == Color(0xFFFF0000), 'TextColor should be red');
  results.add('FlutterLogoDecoration red textColor: ${logoDeco6.textColor}');
  print('FlutterLogoDecoration custom textColor verified');

  // Test 7: FlutterLogoDecoration with margin
  final logoDeco7 = FlutterLogoDecoration(margin: EdgeInsets.all(10.0));
  assert(logoDeco7.margin == EdgeInsets.all(10.0), 'Margin should be 10.0 all');
  results.add('FlutterLogoDecoration margin: ${logoDeco7.margin}');
  print('FlutterLogoDecoration margin: ${logoDeco7.margin}');

  // Test 8: FlutterLogoDecoration with zero margin
  final logoDeco8 = FlutterLogoDecoration(margin: EdgeInsets.zero);
  assert(logoDeco8.margin == EdgeInsets.zero, 'Margin should be zero');
  results.add('FlutterLogoDecoration zero margin: ${logoDeco8.margin}');
  print('FlutterLogoDecoration zero margin verified');

  // Test 9: FlutterLogoDecoration lerp
  final logoDecoA = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  final logoDecoB = FlutterLogoDecoration(style: FlutterLogoStyle.horizontal);
  final lerped = FlutterLogoDecoration.lerp(logoDecoA, logoDecoB, 0.5);
  assert(lerped != null, 'Lerped decoration should not be null');
  results.add('FlutterLogoDecoration lerp: computed');
  print('FlutterLogoDecoration lerp: $lerped');

  // Test 10: FlutterLogoDecoration lerp with matching styles
  final logoDecoC = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  final logoDecoD = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  final lerped2 = FlutterLogoDecoration.lerp(logoDecoC, logoDecoD, 0.5);
  assert(lerped2 != null, 'Same style lerp should not be null');
  results.add('FlutterLogoDecoration same style lerp: computed');
  print('FlutterLogoDecoration same style lerp verified');

  // Test 11: FlutterLogoDecoration with horizontal and text color
  final logoDeco11 = FlutterLogoDecoration(
    style: FlutterLogoStyle.horizontal,
    textColor: Color(0xFF0000FF),
  );
  assert(logoDeco11.style == FlutterLogoStyle.horizontal, 'Style should be horizontal');
  assert(logoDeco11.textColor == Color(0xFF0000FF), 'TextColor should be blue');
  results.add('FlutterLogoDecoration horizontal+blue: verified');
  print('FlutterLogoDecoration horizontal with blue text verified');

  // Test 12: FlutterLogoDecoration equality
  final logoA = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  final logoB = FlutterLogoDecoration(style: FlutterLogoStyle.markOnly);
  assert(logoA == logoB, 'Equal decorations should be equal');
  results.add('FlutterLogoDecoration equality: ${logoA == logoB}');
  print('FlutterLogoDecoration equality verified');

  // Test 13: FlutterLogoDecoration hashCode
  final hashA = logoA.hashCode;
  final hashB = logoB.hashCode;
  assert(hashA == hashB, 'Equal decorations should have same hash');
  results.add('FlutterLogoDecoration hashCode: $hashA');
  print('FlutterLogoDecoration hashCode verified');

  print('FlutterLogoDecoration test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlutterLogoDecoration Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
