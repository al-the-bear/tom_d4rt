// ignore_for_file: avoid_print
// D4rt test script: Tests Text from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Text test executing');

  // Test basic Text
  final basicText = Text('Hello, D4rt!');
  print('Basic Text created');

  // Test Text with style
  final styledText = Text(
    'Styled Text',
    style: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
  );
  print('Styled Text created');

  // Test Text with italic and underline
  final decoratedText = Text(
    'Decorated',
    style: TextStyle(
      fontSize: 18.0,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
      color: Colors.green,
    ),
  );
  print('Decorated Text created');

  // Test Text with letterSpacing and wordSpacing
  final spacedText = Text(
    'Spaced Text Here',
    style: TextStyle(
      fontSize: 16.0,
      letterSpacing: 2.0,
      wordSpacing: 8.0,
      color: Colors.purple,
    ),
  );
  print('Spaced Text created');

  // Test Text with maxLines and overflow
  final overflowText = Text(
    'This is a very long text that should overflow and show ellipsis because maxLines is set to 1',
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontSize: 14.0),
  );
  print('Overflow Text created');

  // Test Text with textAlign
  final centeredText = Text(
    'Centered',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 20.0, color: Colors.orange),
  );
  print('Centered Text created');

  // Test Text with shadow
  final shadowText = Text(
    'Shadow Text',
    style: TextStyle(
      fontSize: 22.0,
      color: Colors.white,
      shadows: [
        Shadow(
          color: Colors.black54,
          offset: Offset(2.0, 2.0),
          blurRadius: 4.0,
        ),
      ],
    ),
  );
  print('Shadow Text created');

  print('Text test completed');

  return Container(
    padding: EdgeInsets.all(16.0),
    color: Colors.grey.shade200,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        basicText,
        SizedBox(height: 8.0),
        styledText,
        SizedBox(height: 8.0),
        decoratedText,
        SizedBox(height: 8.0),
        spacedText,
        SizedBox(height: 8.0),
        Container(width: 200.0, child: overflowText),
        SizedBox(height: 8.0),
        Container(width: 200.0, child: centeredText),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.blueGrey,
          child: shadowText,
        ),
      ],
    ),
  );
}
