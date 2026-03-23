// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests EditorText related - SpellCheckConfiguration,
// EditableText concepts, TextInputConfiguration, TextInputClient
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Editable text misc test executing');

  // ========== SpellCheckConfiguration ==========
  print('--- SpellCheckConfiguration Tests ---');
  final spellConfig = SpellCheckConfiguration.disabled();
  print('SpellCheckConfiguration.disabled created');

  // ========== EditableText ==========
  print('--- EditableText Tests ---');
  final editController = TextEditingController(text: 'Hello World');
  final focusNode = FocusNode(debugLabel: 'edit');
  final style = TextStyle(fontSize: 16.0, color: Colors.black);

  final editableText = EditableText(
    controller: editController,
    focusNode: focusNode,
    style: style,
    cursorColor: Colors.blue,
    backgroundCursorColor: Colors.grey,
    keyboardType: TextInputType.text,
    textAlign: TextAlign.left,
    maxLines: 1,
    autocorrect: true,
    enableSuggestions: true,
  );
  print('EditableText created');
  print('  controller text: ${editController.text}');
  print('  keyboardType: text');

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
  ];
  for (final t in types) {
    print('TextInputType: $t');
  }

  // ========== TextCapitalization ==========
  print('--- TextCapitalization Tests ---');
  for (final cap in TextCapitalization.values) {
    print('TextCapitalization: ${cap.name}');
  }

  // Cleanup
  editController.dispose();
  focusNode.dispose();
  print('Controllers disposed');

  print('All editable text misc tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'EditableText Misc Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('SpellCheckConfiguration.disabled'),
            Text('EditableText with controller'),
            Text('TextInputType: ${types.length} types'),
            Text(
              'TextCapitalization: ${TextCapitalization.values.length} values',
            ),
          ],
        ),
      ),
    ),
  );
}
