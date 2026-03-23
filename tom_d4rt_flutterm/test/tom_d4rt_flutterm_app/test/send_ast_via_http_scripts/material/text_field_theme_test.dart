// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InputDecorationTheme, TextSelectionThemeData,
// TextSelectionControls, TextField advanced, TextEditingController advanced,
// MaxLengthEnforcement, SmartDashesType, SmartQuotesType
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Text field theme test executing');

  // ========== InputDecorationTheme ==========
  print('--- InputDecorationTheme Tests ---');
  final inputTheme = InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.blue),
    floatingLabelStyle: TextStyle(color: Colors.blue[700]),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    helperStyle: TextStyle(color: Colors.grey),
    helperMaxLines: 1,
    hintStyle: TextStyle(color: Colors.grey),
    hintFadeDuration: Duration(milliseconds: 200),
    errorStyle: TextStyle(color: Colors.red),
    errorMaxLines: 2,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    isDense: false,
    isCollapsed: false,
    iconColor: Colors.grey,
    prefixIconColor: Colors.grey,
    prefixStyle: TextStyle(color: Colors.black),
    suffixIconColor: Colors.grey,
    suffixStyle: TextStyle(color: Colors.black),
    counterStyle: TextStyle(fontSize: 12),
    filled: true,
    fillColor: Colors.grey[100],
    focusColor: Colors.blue[50],
    hoverColor: Colors.blue[25],
    activeIndicatorBorder: BorderSide(color: Colors.blue, width: 2),
    outlineBorder: BorderSide(color: Colors.grey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[300]!),
      borderRadius: BorderRadius.circular(8),
    ),
    alignLabelWithHint: false,
    constraints: BoxConstraints(maxWidth: 400),
  );
  print('InputDecorationTheme created');

  // ========== TextSelectionThemeData ==========
  print('--- TextSelectionThemeData Tests ---');
  final selectionTheme = TextSelectionThemeData(
    cursorColor: Colors.blue,
    selectionColor: Colors.blue[200],
    selectionHandleColor: Colors.blue[700],
  );
  print('TextSelectionThemeData created');
  print('  cursorColor: ${selectionTheme.cursorColor}');
  print('  selectionColor: ${selectionTheme.selectionColor}');
  print('  selectionHandleColor: ${selectionTheme.selectionHandleColor}');

  // ========== TextEditingController advanced ==========
  print('--- TextEditingController Advanced Tests ---');
  final controller = TextEditingController(text: 'Hello World');
  print('TextEditingController created: text=${controller.text}');
  print('  value: ${controller.value}');

  controller.selection = TextSelection(baseOffset: 0, extentOffset: 5);
  print('  selection: ${controller.selection}');

  final selectedText = controller.selection.textInside(controller.text);
  print('  selectedText: $selectedText');

  controller.text = 'New Text';
  print('  Updated text: ${controller.text}');

  controller.clear();
  print('  After clear: "${controller.text}"');

  // ========== TextField advanced ==========
  print('--- TextField Advanced Tests ---');
  final textField = TextField(
    controller: TextEditingController(text: 'Test'),
    decoration: InputDecoration(
      labelText: 'Advanced Field',
      border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.done,
    textCapitalization: TextCapitalization.sentences,
    style: TextStyle(fontSize: 16),
    strutStyle: StrutStyle(fontSize: 16, height: 1.5),
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.center,
    textDirection: TextDirection.ltr,
    readOnly: false,
    showCursor: true,
    autofocus: false,
    obscureText: false,
    obscuringCharacter: '•',
    autocorrect: true,
    smartDashesType: SmartDashesType.enabled,
    smartQuotesType: SmartQuotesType.enabled,
    enableSuggestions: true,
    maxLines: 1,
    minLines: 1,
    expands: false,
    maxLength: 100,
    maxLengthEnforcement: MaxLengthEnforcement.enforced,
    onChanged: (value) => print('  Changed: $value'),
    onEditingComplete: () => print('  Editing complete'),
    onSubmitted: (value) => print('  Submitted: $value'),
    onTap: () => print('  Tapped'),
    onTapOutside: (event) => print('  Tapped outside'),
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
      LengthLimitingTextInputFormatter(100),
    ],
    enabled: true,
    cursorWidth: 2.0,
    cursorHeight: 20.0,
    cursorRadius: Radius.circular(2),
    cursorColor: Colors.blue,
    cursorOpacityAnimates: true,
    selectionHeightStyle: BoxHeightStyle.tight,
    selectionWidthStyle: BoxWidthStyle.tight,
    scrollPadding: EdgeInsets.all(20),
    enableInteractiveSelection: true,
    clipBehavior: Clip.hardEdge,
    enableIMEPersonalizedLearning: true,
    scribbleEnabled: true,
  );
  print('TextField advanced created');

  // ========== MaxLengthEnforcement ==========
  print('--- MaxLengthEnforcement Tests ---');
  for (final enforcement in MaxLengthEnforcement.values) {
    print('  MaxLengthEnforcement.$enforcement');
  }

  // ========== SmartDashesType ==========
  print('--- SmartDashesType Tests ---');
  for (final t in SmartDashesType.values) {
    print('  SmartDashesType.$t');
  }

  // ========== SmartQuotesType ==========
  print('--- SmartQuotesType Tests ---');
  for (final t in SmartQuotesType.values) {
    print('  SmartQuotesType.$t');
  }

  // ========== TextInputType ==========
  print('--- TextInputType Tests ---');
  final types = [
    TextInputType.text,
    TextInputType.multiline,
    TextInputType.number,
    TextInputType.phone,
    TextInputType.datetime,
    TextInputType.emailAddress,
    TextInputType.url,
    TextInputType.visiblePassword,
    TextInputType.name,
    TextInputType.streetAddress,
    TextInputType.none,
  ];
  for (final t in types) {
    print('  TextInputType: $t');
  }

  print('All text field theme tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(
      inputDecorationTheme: inputTheme,
      textSelectionTheme: selectionTheme,
    ),
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [textField]),
      ),
    ),
  );
}
