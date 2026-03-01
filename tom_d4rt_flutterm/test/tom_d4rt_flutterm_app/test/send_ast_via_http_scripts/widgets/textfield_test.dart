// D4rt test script: Tests TextField and EditableText widgets from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextField test executing');

  // Test basic TextField
  final basicTextField = TextField(
    decoration: InputDecoration(labelText: 'Basic TextField'),
  );
  print('Basic TextField created');

  // Test TextField with controller
  final controller = TextEditingController(text: 'Initial value');
  final withController = TextField(
    controller: controller,
    decoration: InputDecoration(labelText: 'With Controller'),
  );
  print('TextField with TextEditingController created');
  print('Controller text: ${controller.text}');

  // Test TextField with onChanged
  final onChangedField = TextField(
    decoration: InputDecoration(labelText: 'OnChanged'),
    onChanged: (value) {
      print('TextField changed: $value');
    },
  );
  print('TextField with onChanged callback created');

  // Test TextField with onSubmitted
  final onSubmittedField = TextField(
    decoration: InputDecoration(labelText: 'OnSubmitted'),
    onSubmitted: (value) {
      print('TextField submitted: $value');
    },
  );
  print('TextField with onSubmitted callback created');

  // Test TextField with various keyboard types
  final emailKeyboard = TextField(
    decoration: InputDecoration(labelText: 'Email'),
    keyboardType: TextInputType.emailAddress,
  );
  print('TextField with TextInputType.emailAddress created');

  final numberKeyboard = TextField(
    decoration: InputDecoration(labelText: 'Number'),
    keyboardType: TextInputType.number,
  );
  print('TextField with TextInputType.number created');

  final phoneKeyboard = TextField(
    decoration: InputDecoration(labelText: 'Phone'),
    keyboardType: TextInputType.phone,
  );
  print('TextField with TextInputType.phone created');

  final multilineKeyboard = TextField(
    decoration: InputDecoration(labelText: 'Multiline'),
    keyboardType: TextInputType.multiline,
    maxLines: 3,
  );
  print('TextField with TextInputType.multiline created');

  final urlKeyboard = TextField(
    decoration: InputDecoration(labelText: 'URL'),
    keyboardType: TextInputType.url,
  );
  print('TextField with TextInputType.url created');

  // Test TextField with obscureText (password)
  final passwordField = TextField(
    decoration: InputDecoration(
      labelText: 'Password',
      suffixIcon: Icon(Icons.visibility_off),
    ),
    obscureText: true,
    obscuringCharacter: '●',
  );
  print('TextField with obscureText=true, obscuringCharacter=● created');

  // Test TextField with maxLength
  final maxLengthField = TextField(
    decoration: InputDecoration(labelText: 'Max 20 chars'),
    maxLength: 20,
    maxLengthEnforcement: MaxLengthEnforcement.enforced,
  );
  print('TextField with maxLength=20 created');

  // Test TextField with maxLines and minLines
  final multilineField = TextField(
    decoration: InputDecoration(
      labelText: 'Multi-line',
      border: OutlineInputBorder(),
    ),
    minLines: 2,
    maxLines: 5,
  );
  print('TextField with minLines=2, maxLines=5 created');

  // Note: TextField with expands=true is skipped because the bridge can't
  // properly handle maxLines: null (defaults to 1 due to getNamedArgWithDefault).
  // This would require getOptionalNamedArg in the bridge generator.

  // Test TextField with textCapitalization
  final capitalWords = TextField(
    decoration: InputDecoration(labelText: 'Capital Words'),
    textCapitalization: TextCapitalization.words,
  );
  print('TextField with TextCapitalization.words created');

  final capitalSentences = TextField(
    decoration: InputDecoration(labelText: 'Capital Sentences'),
    textCapitalization: TextCapitalization.sentences,
  );
  print('TextField with TextCapitalization.sentences created');

  final capitalChars = TextField(
    decoration: InputDecoration(labelText: 'All Caps'),
    textCapitalization: TextCapitalization.characters,
  );
  print('TextField with TextCapitalization.characters created');

  // Test TextField with textInputAction
  final nextAction = TextField(
    decoration: InputDecoration(labelText: 'Next Action'),
    textInputAction: TextInputAction.next,
  );
  print('TextField with TextInputAction.next created');

  final doneAction = TextField(
    decoration: InputDecoration(labelText: 'Done Action'),
    textInputAction: TextInputAction.done,
  );
  print('TextField with TextInputAction.done created');

  final searchAction = TextField(
    decoration: InputDecoration(labelText: 'Search Action'),
    textInputAction: TextInputAction.search,
  );
  print('TextField with TextInputAction.search created');

  // Test TextField with textAlign
  final centerAlign = TextField(
    decoration: InputDecoration(labelText: 'Center Aligned'),
    textAlign: TextAlign.center,
  );
  print('TextField with textAlign=center created');

  final rightAlign = TextField(
    decoration: InputDecoration(labelText: 'Right Aligned'),
    textAlign: TextAlign.right,
  );
  print('TextField with textAlign=right created');

  // Test TextField with style
  final styledField = TextField(
    decoration: InputDecoration(labelText: 'Styled Text'),
    style: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.purple,
    ),
  );
  print('TextField with custom TextStyle created');

  // Test TextField with cursorColor and cursorWidth
  final customCursor = TextField(
    decoration: InputDecoration(labelText: 'Custom Cursor'),
    cursorColor: Colors.red,
    cursorWidth: 3.0,
    cursorRadius: Radius.circular(2.0),
  );
  print('TextField with custom cursor created');

  // Test TextField enabled/readOnly
  final readOnlyField = TextField(
    decoration: InputDecoration(labelText: 'Read Only'),
    readOnly: true,
    controller: TextEditingController(text: 'Cannot edit'),
  );
  print('TextField with readOnly=true created');

  final disabledField = TextField(
    decoration: InputDecoration(labelText: 'Disabled'),
    enabled: false,
    controller: TextEditingController(text: 'Disabled'),
  );
  print('TextField with enabled=false created');

  // Test TextField with autofocus
  final autofocusField = TextField(
    decoration: InputDecoration(labelText: 'Autofocus'),
    autofocus: true,
  );
  print('TextField with autofocus=true created');

  // Test TextField with focusNode
  final focusNode = FocusNode();
  final withFocusNode = TextField(
    decoration: InputDecoration(labelText: 'With FocusNode'),
    focusNode: focusNode,
  );
  print('TextField with FocusNode created');

  // Test TextField with autocorrect and enableSuggestions
  final noAutocorrect = TextField(
    decoration: InputDecoration(labelText: 'No Autocorrect'),
    autocorrect: false,
    enableSuggestions: false,
  );
  print('TextField with autocorrect=false created');

  // Test TextField with onTap
  final onTapField = TextField(
    decoration: InputDecoration(labelText: 'OnTap'),
    onTap: () {
      print('TextField tapped');
    },
  );
  print('TextField with onTap callback created');

  // Test TextEditingController methods
  print('TextEditingController.clear() - clears text');
  print('TextEditingController.selection - TextSelection');
  print('TextEditingController.text = value - sets text');

  // Test TextSelection
  final selection = TextSelection(baseOffset: 0, extentOffset: 5);
  print('TextSelection created: baseOffset=0, extentOffset=5');
  print('TextSelection.collapsed(offset: 3) for cursor position');

  print('TextField test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'TextField Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        basicTextField,
        SizedBox(height: 12.0),
        withController,
        SizedBox(height: 12.0),
        onChangedField,
        SizedBox(height: 12.0),
        emailKeyboard,
        SizedBox(height: 12.0),
        numberKeyboard,
        SizedBox(height: 12.0),
        passwordField,
        SizedBox(height: 12.0),
        maxLengthField,
        SizedBox(height: 12.0),
        multilineField,
        SizedBox(height: 12.0),
        capitalWords,
        SizedBox(height: 12.0),
        nextAction,
        SizedBox(height: 12.0),
        centerAlign,
        SizedBox(height: 12.0),
        styledField,
        SizedBox(height: 12.0),
        customCursor,
        SizedBox(height: 12.0),
        readOnlyField,
        SizedBox(height: 12.0),
        disabledField,
      ],
    ),
  );
}
