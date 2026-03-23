// ignore_for_file: avoid_print
// D4rt test script: Tests SelectableText from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectableText test executing');

  // Test basic SelectableText
  final selectBasic = SelectableText('This is selectable text');
  print('SelectableText basic created');

  // Test SelectableText with style
  final selectStyled = SelectableText(
    'Styled selectable text',
    style: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
  );
  print('SelectableText with style created');

  // Test SelectableText with textAlign center
  final selectCenter = SelectableText(
    'Center aligned selectable text',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with textAlign=center created');

  // Test SelectableText with textAlign right
  final selectRight = SelectableText(
    'Right aligned selectable text',
    textAlign: TextAlign.right,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with textAlign=right created');

  // Test SelectableText with maxLines
  final selectMaxLines = SelectableText(
    'This is a long selectable text that should be limited to two lines maximum. It will be truncated if it exceeds the maximum number of lines specified.',
    maxLines: 2,
    style: TextStyle(fontSize: 14.0),
  );
  print('SelectableText with maxLines=2 created');

  // Test SelectableText with maxLines=1
  final selectSingleLine = SelectableText(
    'Single line selectable text that might overflow',
    maxLines: 1,
    style: TextStyle(fontSize: 14.0),
  );
  print('SelectableText with maxLines=1 created');

  // Test SelectableText with cursorColor
  final selectCursor = SelectableText(
    'Custom cursor color',
    cursorColor: Colors.red,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with cursorColor=red created');

  // Test SelectableText with cursorWidth
  final selectCursorWidth = SelectableText(
    'Wide cursor',
    cursorWidth: 4.0,
    cursorColor: Colors.blue,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with cursorWidth=4 created');

  // Test SelectableText with semanticsLabel
  final selectSemantics = SelectableText(
    'Accessible text',
    semanticsLabel: 'This is accessible selectable text for screen readers',
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with semanticsLabel created');

  // Test SelectableText with showCursor
  final selectShowCursor = SelectableText(
    'Always show cursor',
    showCursor: true,
    cursorColor: Colors.green,
    cursorWidth: 2.0,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with showCursor=true created');

  // Test SelectableText with textDirection
  final selectDirection = SelectableText(
    'Left to right text',
    textDirection: TextDirection.ltr,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with textDirection=ltr created');

  // Test SelectableText with large text
  final selectLarge = SelectableText(
    'Large selectable',
    style: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.purple,
    ),
  );
  print('SelectableText with large font created');

  // Test SelectableText with italic style
  final selectItalic = SelectableText(
    'Italic selectable text',
    style: TextStyle(
      fontSize: 16.0,
      fontStyle: FontStyle.italic,
      color: Colors.deepOrange,
    ),
  );
  print('SelectableText with italic style created');

  // Test SelectableText with onTap
  final selectTap = SelectableText(
    'Tap me - I am selectable',
    onTap: () {
      print('SelectableText tapped');
    },
    style: TextStyle(
      fontSize: 16.0,
      color: Colors.teal,
      decoration: TextDecoration.underline,
    ),
  );
  print('SelectableText with onTap created');

  // Test SelectableText with textScaler
  final selectScaled = SelectableText(
    'Scaled text',
    textScaler: TextScaler.linear(1.5),
    style: TextStyle(fontSize: 14.0),
  );
  print('SelectableText with textScaler=1.5 created');

  print('All SelectableText tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== SelectableText Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectBasic,
        SizedBox(height: 8.0),
        Text('Styled:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectStyled,
        SizedBox(height: 8.0),
        Text('Center aligned:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 300.0, child: selectCenter),
        SizedBox(height: 8.0),
        Text('Right aligned:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 300.0, child: selectRight),
        SizedBox(height: 8.0),
        Text('MaxLines=2:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 250.0, child: selectMaxLines),
        SizedBox(height: 8.0),
        Text('Single line:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 200.0, child: selectSingleLine),
        SizedBox(height: 8.0),
        Text(
          'Cursor color=red:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        selectCursor,
        SizedBox(height: 8.0),
        Text('Cursor width=4:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectCursorWidth,
        SizedBox(height: 8.0),
        Text('Semantics label:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectSemantics,
        SizedBox(height: 8.0),
        Text('Show cursor:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectShowCursor,
        SizedBox(height: 8.0),
        Text('Text direction:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectDirection,
        SizedBox(height: 8.0),
        Text('Large font:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectLarge,
        SizedBox(height: 8.0),
        Text('Italic:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectItalic,
        SizedBox(height: 8.0),
        Text('With onTap:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectTap,
        SizedBox(height: 8.0),
        Text('Scaled 1.5x:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectScaled,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• SelectableText allows user to select and copy text'),
        Text('• style controls text appearance (font, color, weight)'),
        Text('• textAlign controls horizontal alignment'),
        Text('• maxLines limits visible lines'),
        Text('• cursorColor and cursorWidth customize the cursor'),
        Text('• semanticsLabel provides screen reader description'),
      ],
    ),
  );
}
