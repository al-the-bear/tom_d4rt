// D4rt test script: Tests InlineSpan abstract via TextSpan from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InlineSpan test executing');
  final results = <String>[];

  // ========== InlineSpan Tests via TextSpan ==========
  // InlineSpan is abstract, TextSpan is the concrete implementation
  print('Testing InlineSpan via TextSpan...');

  // Test 1: Create basic TextSpan
  final span1 = TextSpan(text: 'Hello World');
  assert(span1.text == 'Hello World', 'Text should match');
  results.add('TextSpan text: ${span1.text}');
  print('TextSpan created: ${span1.text}');

  // Test 2: TextSpan with style
  final span2 = TextSpan(
    text: 'Styled Text',
    style: TextStyle(fontSize: 16.0, color: Color(0xFF000000)),
  );
  assert(span2.style != null, 'Style should not be null');
  assert(span2.style!.fontSize == 16.0, 'Font size should be 16.0');
  results.add('TextSpan style: fontSize=${span2.style!.fontSize}');
  print('TextSpan style verified');

  // Test 3: TextSpan with children
  final span3 = TextSpan(
    text: 'Parent ',
    children: [
      TextSpan(text: 'Child 1 '),
      TextSpan(text: 'Child 2'),
    ],
  );
  assert(span3.children != null, 'Children should not be null');
  assert(span3.children!.length == 2, 'Should have 2 children');
  results.add('TextSpan children: ${span3.children!.length}');
  print('TextSpan children: ${span3.children!.length}');

  // Test 4: Nested TextSpan styles
  final span4 = TextSpan(
    text: 'Normal ',
    style: TextStyle(fontSize: 14.0),
    children: [
      TextSpan(
        text: 'Bold',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  );
  assert(span4.style!.fontSize == 14.0, 'Parent font size should be 14.0');
  results.add('Nested TextSpan: parent size=${span4.style!.fontSize}');
  print('Nested TextSpan styles verified');

  // Test 5: TextSpan toPlainText
  final span5 = TextSpan(
    text: 'Hello ',
    children: [TextSpan(text: 'World')],
  );
  final plainText = span5.toPlainText();
  assert(plainText == 'Hello World', 'Plain text should be "Hello World"');
  results.add('TextSpan toPlainText: $plainText');
  print('TextSpan toPlainText: $plainText');

  // Test 6: TextSpan with recognizer (conceptual)
  final span6 = TextSpan(
    text: 'Clickable',
    style: TextStyle(color: Color(0xFF0000FF)),
  );
  assert(span6.text == 'Clickable', 'Text should be Clickable');
  results.add('TextSpan clickable: ${span6.text}');
  print('TextSpan clickable text verified');

  // Test 7: TextSpan codeUnitAt
  final span7 = TextSpan(text: 'ABC');
  final codeUnit = span7.codeUnitAt(0);
  assert(codeUnit == 65, 'First code unit should be 65 (A)');
  results.add('TextSpan codeUnitAt(0): $codeUnit');
  print('TextSpan codeUnitAt: $codeUnit');

  // Test 8: TextSpan compareTo
  final spanA = TextSpan(text: 'A');
  final spanB = TextSpan(text: 'B');
  final comparison = spanA.compareTo(spanB);
  assert(comparison.isNegative, 'A should come before B');
  results.add('TextSpan compareTo: $comparison');
  print('TextSpan compareTo: $comparison');

  // Test 9: TextSpan with locale
  final span9 = TextSpan(
    text: 'Localized',
    locale: Locale('en', 'US'),
  );
  assert(span9.locale == Locale('en', 'US'), 'Locale should match');
  results.add('TextSpan locale: ${span9.locale}');
  print('TextSpan locale: ${span9.locale}');

  // Test 10: TextSpan with spellOut
  final span10 = TextSpan(
    text: 'Spell check',
    spellOut: true,
  );
  assert(span10.spellOut == true, 'SpellOut should be true');
  results.add('TextSpan spellOut: ${span10.spellOut}');
  print('TextSpan spellOut verified');

  // Test 11: TextSpan visitChildren
  final visitedTexts = <String>[];
  final rootSpan = TextSpan(
    text: 'Root',
    children: [
      TextSpan(text: ' Child1'),
      TextSpan(text: ' Child2'),
    ],
  );
  rootSpan.visitChildren((span) {
    if (span is TextSpan && span.text != null) {
      visitedTexts.add(span.text!);
    }
    return true;
  });
  assert(visitedTexts.length == 2, 'Should visit 2 children');
  results.add('TextSpan visitChildren: ${visitedTexts.length} visited');
  print('TextSpan visitChildren: ${visitedTexts.length}');

  // Test 12: TextSpan equality
  final eq1 = TextSpan(text: 'Same');
  final eq2 = TextSpan(text: 'Same');
  assert(eq1 == eq2, 'Same text spans should be equal');
  results.add('TextSpan equality: ${eq1 == eq2}');
  print('TextSpan equality verified');

  print('InlineSpan test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InlineSpan Tests (via TextSpan)'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
