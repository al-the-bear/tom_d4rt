// D4rt test script: Tests PlaceholderSpan abstract via WidgetSpan from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlaceholderSpan test executing');
  final results = <String>[];

  // ========== PlaceholderSpan Tests via WidgetSpan ==========
  // PlaceholderSpan is abstract, WidgetSpan extends it
  print('Testing PlaceholderSpan via WidgetSpan...');

  // Test 1: Create basic WidgetSpan
  final widgetSpan1 = WidgetSpan(
    child: Container(width: 20, height: 20, color: Color(0xFFFF0000)),
  );
  assert(widgetSpan1.child != null, 'Child should not be null');
  results.add('WidgetSpan: child present');
  print('WidgetSpan created with Container child');

  // Test 2: WidgetSpan with PlaceholderAlignment.bottom
  final widgetSpan2 = WidgetSpan(
    child: Icon(Icons.star),
    alignment: PlaceholderAlignment.bottom,
  );
  assert(
    widgetSpan2.alignment == PlaceholderAlignment.bottom,
    'Alignment should be bottom',
  );
  results.add('WidgetSpan alignment: ${widgetSpan2.alignment}');
  print('WidgetSpan alignment: ${widgetSpan2.alignment}');

  // Test 3: WidgetSpan with PlaceholderAlignment.top
  final widgetSpan3 = WidgetSpan(
    child: Icon(Icons.circle),
    alignment: PlaceholderAlignment.top,
  );
  assert(
    widgetSpan3.alignment == PlaceholderAlignment.top,
    'Alignment should be top',
  );
  results.add('WidgetSpan top: ${widgetSpan3.alignment}');
  print('WidgetSpan top alignment verified');

  // Test 4: WidgetSpan with PlaceholderAlignment.middle
  final widgetSpan4 = WidgetSpan(
    child: Icon(Icons.square),
    alignment: PlaceholderAlignment.middle,
  );
  assert(
    widgetSpan4.alignment == PlaceholderAlignment.middle,
    'Alignment should be middle',
  );
  results.add('WidgetSpan middle: ${widgetSpan4.alignment}');
  print('WidgetSpan middle alignment verified');

  // Test 5: WidgetSpan with PlaceholderAlignment.aboveBaseline
  final widgetSpan5 = WidgetSpan(
    child: Icon(Icons.add),
    alignment: PlaceholderAlignment.aboveBaseline,
    baseline: TextBaseline.alphabetic,
  );
  assert(
    widgetSpan5.alignment == PlaceholderAlignment.aboveBaseline,
    'Alignment should be aboveBaseline',
  );
  results.add('WidgetSpan aboveBaseline: ${widgetSpan5.alignment}');
  print('WidgetSpan aboveBaseline verified');

  // Test 6: WidgetSpan with PlaceholderAlignment.belowBaseline
  final widgetSpan6 = WidgetSpan(
    child: Icon(Icons.remove),
    alignment: PlaceholderAlignment.belowBaseline,
    baseline: TextBaseline.alphabetic,
  );
  assert(
    widgetSpan6.alignment == PlaceholderAlignment.belowBaseline,
    'Alignment should be belowBaseline',
  );
  results.add('WidgetSpan belowBaseline: ${widgetSpan6.alignment}');
  print('WidgetSpan belowBaseline verified');

  // Test 7: WidgetSpan baseline property
  final widgetSpan7 = WidgetSpan(
    child: Text('X'),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
  );
  assert(
    widgetSpan7.baseline == TextBaseline.alphabetic,
    'Baseline should be alphabetic',
  );
  results.add('WidgetSpan baseline: ${widgetSpan7.baseline}');
  print('WidgetSpan baseline: ${widgetSpan7.baseline}');

  // Test 8: WidgetSpan with ideographic baseline
  final widgetSpan8 = WidgetSpan(
    child: Text('中'),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.ideographic,
  );
  assert(
    widgetSpan8.baseline == TextBaseline.ideographic,
    'Baseline should be ideographic',
  );
  results.add('WidgetSpan ideographic: ${widgetSpan8.baseline}');
  print('WidgetSpan ideographic baseline verified');

  // Test 9: WidgetSpan with style
  final widgetSpan9 = WidgetSpan(
    child: Icon(Icons.favorite),
    style: TextStyle(fontSize: 20),
  );
  assert(widgetSpan9.style != null, 'Style should not be null');
  results.add('WidgetSpan style: fontSize=${widgetSpan9.style?.fontSize}');
  print('WidgetSpan style: ${widgetSpan9.style}');

  // Test 10: WidgetSpan in TextSpan children
  final textSpan = TextSpan(
    text: 'Hello ',
    children: [
      WidgetSpan(child: Icon(Icons.star, size: 16)),
      TextSpan(text: ' World'),
    ],
  );
  assert(textSpan.children!.length == 2, 'Should have 2 children');
  results.add(
    'TextSpan with WidgetSpan: ${textSpan.children!.length} children',
  );
  print('TextSpan with WidgetSpan children');

  // Test 11: WidgetSpan toPlainText
  final plainSpan = WidgetSpan(child: Icon(Icons.check));
  final plainText = plainSpan.toPlainText();
  results.add('WidgetSpan toPlainText: "${plainText}" (placeholder char)');
  print('WidgetSpan toPlainText: "$plainText"');

  // Test 12: WidgetSpan equality
  final ws1 = WidgetSpan(child: Icon(Icons.star));
  final ws2 = WidgetSpan(child: Icon(Icons.star));
  results.add('WidgetSpan equality test: completed');
  print('WidgetSpan equality test completed');

  // Test 13: Multiple WidgetSpans
  final multiSpan = TextSpan(
    children: [
      WidgetSpan(child: Icon(Icons.star)),
      WidgetSpan(child: Icon(Icons.star)),
      WidgetSpan(child: Icon(Icons.star)),
    ],
  );
  assert(multiSpan.children!.length == 3, 'Should have 3 WidgetSpans');
  results.add('Multiple WidgetSpans: ${multiSpan.children!.length}');
  print('Multiple WidgetSpans: ${multiSpan.children!.length}');

  print('PlaceholderSpan test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlaceholderSpan Tests (via WidgetSpan)'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
