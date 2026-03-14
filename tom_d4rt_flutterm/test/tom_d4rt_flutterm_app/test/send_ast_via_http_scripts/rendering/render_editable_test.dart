// D4rt test script: Tests RenderEditable from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderEditable test executing');

  // ========== RENDER EDITABLE BASICS ==========
  print('--- RenderEditable Basics ---');
  print('RenderEditable is the render object for editable text');
  print('Used by TextField, TextFormField, EditableText');
  print('Handles text layout, selection, and cursor rendering');

  // Test using TextField which uses RenderEditable internally
  final basicTextField = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Basic TextField',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Basic TextField created');
  print('  Uses RenderEditable internally');

  // ========== TEXT PROPERTIES ==========
  print('--- Text Properties ---');

  // Test with initial text
  final textController = TextEditingController(text: 'Hello World');
  final withText = Container(
    width: 250,
    child: TextField(
      controller: textController,
      decoration: InputDecoration(
        labelText: 'With Initial Text',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('TextField with initial text: "${textController.text}"');

  // Test maxLines
  final multiLine = Container(
    width: 250,
    child: TextField(
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Multi-line',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Multi-line TextField: maxLines = 3');

  // Test single line
  final singleLine = Container(
    width: 250,
    child: TextField(
      maxLines: 1,
      decoration: InputDecoration(
        labelText: 'Single Line',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Single-line TextField: maxLines = 1');

  // ========== CURSOR PROPERTIES ==========
  print('--- Cursor Properties ---');

  final customCursor = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Custom Cursor',
        border: OutlineInputBorder(),
      ),
      cursorColor: Colors.red,
      cursorWidth: 4,
      cursorRadius: Radius.circular(2),
    ),
  );
  print('Custom cursor: red, width 4, radius 2');

  final thickCursor = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Thick Cursor',
        border: OutlineInputBorder(),
      ),
      cursorColor: Colors.blue,
      cursorWidth: 6,
    ),
  );
  print('Thick blue cursor: width 6');

  // ========== SELECTION HANDLING ==========
  print('--- Selection Handling ---');
  print('RenderEditable manages TextSelection');
  print('Selection includes base and extent offsets');
  print('Handles drag selection and double-click word selection');

  final selectionController = TextEditingController(text: 'Select this text');
  final selectionField = Container(
    width: 250,
    child: TextField(
      controller: selectionController,
      decoration: InputDecoration(
        labelText: 'Selection Test',
        border: OutlineInputBorder(),
      ),
      enableInteractiveSelection: true,
    ),
  );
  print('TextField with interactive selection enabled');

  // ========== TEXT ALIGNMENT ==========
  print('--- Text Alignment ---');

  final leftAligned = Container(
    width: 250,
    child: TextField(
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        labelText: 'Left Aligned',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Left aligned text');

  final centerAligned = Container(
    width: 250,
    child: TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: 'Center Aligned',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Center aligned text');

  final rightAligned = Container(
    width: 250,
    child: TextField(
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'Right Aligned',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Right aligned text');

  // ========== TEXT DIRECTION ==========
  print('--- Text Direction ---');

  final ltrText = Container(
    width: 250,
    child: TextField(
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        labelText: 'LTR Text',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Left-to-right text direction');

  final rtlText = Container(
    width: 250,
    child: TextField(
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        labelText: 'RTL Text',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Right-to-left text direction');

  // ========== STYLING ==========
  print('--- Text Styling ---');

  final styledText = Container(
    width: 250,
    child: TextField(
      style: TextStyle(
        fontSize: 20,
        color: Colors.purple,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: 'Styled Text',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Styled text: fontSize 20, purple, bold');

  final italicText = Container(
    width: 250,
    child: TextField(
      style: TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
        color: Colors.green[700],
      ),
      decoration: InputDecoration(
        labelText: 'Italic Text',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Italic green text');

  // ========== KEYBOARD INPUT ==========
  print('--- Keyboard Input Types ---');

  final emailInput = Container(
    width: 250,
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Email keyboard type');

  final numberInput = Container(
    width: 250,
    child: TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Number',
        prefixIcon: Icon(Icons.numbers),
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Number keyboard type');

  // ========== OBSCURE TEXT ==========
  print('--- Obscure Text (Passwords) ---');

  final passwordField = Container(
    width: 250,
    child: TextField(
      obscureText: true,
      obscuringCharacter: '•',
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Password field with obscured text');

  // ========== READ ONLY ==========
  print('--- Read Only Mode ---');

  final readOnlyField = Container(
    width: 250,
    child: TextField(
      readOnly: true,
      controller: TextEditingController(text: 'Read only text'),
      decoration: InputDecoration(
        labelText: 'Read Only',
        border: OutlineInputBorder(),
        fillColor: Colors.grey[100],
        filled: true,
      ),
    ),
  );
  print('Read-only text field');

  print('RenderEditable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderEditable Tests'),
      SizedBox(height: 8),
      basicTextField,
      SizedBox(height: 8),
      withText,
      SizedBox(height: 8),
      multiLine,
      SizedBox(height: 8),
      customCursor,
      SizedBox(height: 8),
      styledText,
      SizedBox(height: 8),
      passwordField,
      SizedBox(height: 8),
      Text('All RenderEditable tests passed'),
    ],
  );
}
