// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RichText widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RichText test executing');

  // Test basic RichText with TextSpan
  final basicRichText = RichText(
    text: TextSpan(
      text: 'Hello ',
      style: TextStyle(color: Colors.black, fontSize: 16.0),
      children: [
        TextSpan(
          text: 'World',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ],
    ),
  );
  print('Basic RichText with TextSpan created');

  // Test RichText with multiple styled spans
  final multiStyleRichText = RichText(
    text: TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 14.0),
      children: [
        TextSpan(text: 'Normal '),
        TextSpan(
          text: 'Bold ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: 'Italic ',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        TextSpan(
          text: 'Colored',
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  );
  print('RichText with multiple styled spans created');

  // Test RichText with textAlign
  final alignedRichText = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: 'Center Aligned Text',
      style: TextStyle(color: Colors.green, fontSize: 16.0),
    ),
  );
  print('RichText with textAlign.center created');

  // Test RichText with maxLines and overflow
  final overflowRichText = RichText(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      text: 'This is a very long text that will be truncated with ellipsis',
      style: TextStyle(color: Colors.purple, fontSize: 14.0),
    ),
  );
  print('RichText with maxLines=1 and overflow.ellipsis created');

  // Test RichText with nested TextSpans
  final nestedRichText = RichText(
    text: TextSpan(
      text: 'Root ',
      style: TextStyle(color: Colors.black, fontSize: 14.0),
      children: [
        TextSpan(
          text: 'Level 1 ',
          style: TextStyle(color: Colors.blue),
          children: [
            TextSpan(
              text: 'Level 2',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
  print('RichText with nested TextSpans created');

  // Test RichText with textScaleFactor (deprecated but still used)
  final scaledRichText = RichText(
    textScaler: TextScaler.linear(1.5),
    text: TextSpan(
      text: 'Scaled Text',
      style: TextStyle(color: Colors.orange, fontSize: 14.0),
    ),
  );
  print('RichText with textScaler created');

  print('RichText test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      basicRichText,
      SizedBox(height: 8.0),
      multiStyleRichText,
      SizedBox(height: 8.0),
      SizedBox(width: 200.0, child: alignedRichText),
      SizedBox(height: 8.0),
      SizedBox(width: 150.0, child: overflowRichText),
      SizedBox(height: 8.0),
      nestedRichText,
      SizedBox(height: 8.0),
      scaledRichText,
    ],
  );
}
