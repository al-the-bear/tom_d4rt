// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextSpan, WidgetSpan, InlineSpan from widgets/painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSpan test executing');

  // ========== TEXTSPAN ==========
  print('--- TextSpan Tests ---');

  // Simple TextSpan
  final simpleSpan = TextSpan(text: 'Hello World');
  print('Simple TextSpan created: $simpleSpan');
  print('  text: ${simpleSpan.text}');

  // TextSpan with style
  final styledSpan = TextSpan(
    text: 'Styled text',
    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
  );
  print('Styled TextSpan created: $styledSpan');

  // TextSpan with children
  final parentSpan = TextSpan(
    text: 'Parent ',
    style: TextStyle(fontSize: 16.0),
    children: [
      TextSpan(
        text: 'child1 ',
        style: TextStyle(color: Colors.blue),
      ),
      TextSpan(
        text: 'child2 ',
        style: TextStyle(color: Colors.green),
      ),
      TextSpan(
        text: 'child3',
        style: TextStyle(color: Colors.red),
      ),
    ],
  );
  print('Parent TextSpan with 3 children created');
  print('  children count: ${parentSpan.children?.length}');

  // TextSpan with recognizer (no actual tap handling in D4rt, just verify creation)
  final recognizerSpan = TextSpan(
    text: 'Tappable text',
    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
  );
  print('TextSpan for tapping created: $recognizerSpan');

  // TextSpan with semanticsLabel
  final semanticSpan = TextSpan(text: '🎉', semanticsLabel: 'party popper');
  print('TextSpan with semanticsLabel created');
  print('  semanticsLabel: ${semanticSpan.semanticsLabel}');

  // Test toPlainText
  final plainText = parentSpan.toPlainText();
  print('toPlainText: $plainText');

  // Test TextSpan equality
  final span1 = TextSpan(text: 'test');
  final span2 = TextSpan(text: 'test');
  print('TextSpan equality: ${span1 == span2}');

  // ========== WIDGETSPAN ==========
  print('--- WidgetSpan Tests ---');

  // WidgetSpan embeds a widget in text
  final widgetSpan = WidgetSpan(
    child: Icon(Icons.star, size: 16.0, color: Colors.amber),
  );
  print('WidgetSpan with Icon created: $widgetSpan');

  // WidgetSpan with alignment
  final alignedWidgetSpan = WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Container(width: 20.0, height: 20.0, color: Colors.blue),
  );
  print('WidgetSpan with middle alignment created: $alignedWidgetSpan');

  // WidgetSpan with baseline alignment
  final baselineWidgetSpan = WidgetSpan(
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
    child: Container(
      width: 16.0,
      height: 16.0,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    ),
  );
  print('WidgetSpan with baseline alignment created: $baselineWidgetSpan');

  // ========== RICHTEXT WITH MIXED SPANS ==========
  print('--- RichText with mixed spans ---');

  final richText = RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 16.0, color: Colors.black),
      children: [
        TextSpan(text: 'Hello '),
        WidgetSpan(child: Icon(Icons.favorite, size: 16.0, color: Colors.red)),
        TextSpan(text: ' World '),
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            width: 50.0,
            height: 20.0,
            color: Colors.blue,
            child: Center(
              child: Text(
                'inline',
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              ),
            ),
          ),
        ),
        TextSpan(text: ' end'),
      ],
    ),
  );
  print('RichText with mixed TextSpan/WidgetSpan created');

  print('All TextSpan tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TextSpan / WidgetSpan Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text.rich(parentSpan),
            SizedBox(height: 8.0),
            richText,
            SizedBox(height: 8.0),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Rating: ', style: TextStyle(fontSize: 16.0)),
                  WidgetSpan(
                    child: Icon(Icons.star, size: 16.0, color: Colors.amber),
                  ),
                  WidgetSpan(
                    child: Icon(Icons.star, size: 16.0, color: Colors.amber),
                  ),
                  WidgetSpan(
                    child: Icon(Icons.star, size: 16.0, color: Colors.amber),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.star_half,
                      size: 16.0,
                      color: Colors.amber,
                    ),
                  ),
                  WidgetSpan(
                    child: Icon(
                      Icons.star_border,
                      size: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
