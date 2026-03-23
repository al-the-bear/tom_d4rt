// ignore_for_file: avoid_print
// D4rt test script: Tests Form and FormField widgets from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Form test executing');

  // Create GlobalKey for Form
  final formKey = GlobalKey<FormState>();
  print('GlobalKey<FormState> created');

  // Test basic Form
  final basicForm = Form(
    key: formKey,
    child: Column(
      children: [
        TextFormField(decoration: InputDecoration(labelText: 'Name')),
        TextFormField(decoration: InputDecoration(labelText: 'Email')),
      ],
    ),
  );
  print('Basic Form with 2 TextFormFields created');

  // Test Form with autovalidateMode
  final alwaysValidate = Form(
    autovalidateMode: AutovalidateMode.always,
    child: TextFormField(
      decoration: InputDecoration(labelText: 'Always Validate'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required field';
        }
        return null;
      },
    ),
  );
  print('Form with autovalidateMode=always created');

  final validateOnInteraction = Form(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: TextFormField(
      decoration: InputDecoration(labelText: 'Validate on Interaction'),
      validator: (value) => value!.isEmpty ? 'Required' : null,
    ),
  );
  print('Form with autovalidateMode=onUserInteraction created');

  final disabledValidation = Form(
    autovalidateMode: AutovalidateMode.disabled,
    child: TextFormField(
      decoration: InputDecoration(labelText: 'Disabled Validation'),
    ),
  );
  print('Form with autovalidateMode=disabled created');

  // Test Form with onWillPop (deprecated but testing concept)
  print('Form onWillPop callback tests unsaved changes');

  // Test Form with onChanged
  final onChangedForm = Form(
    onChanged: () {
      print('Form changed');
    },
    child: Column(
      children: [
        TextFormField(decoration: InputDecoration(labelText: 'Field 1')),
        TextFormField(decoration: InputDecoration(labelText: 'Field 2')),
      ],
    ),
  );
  print('Form with onChanged callback created');

  // Test FormField widget directly
  final customFormField = FormField<String>(
    initialValue: 'initial',
    builder: (FormFieldState<String> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: state.hasError ? Colors.red : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(state.value ?? ''),
          ),
          if (state.hasError)
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                state.errorText!,
                style: TextStyle(color: Colors.red, fontSize: 12.0),
              ),
            ),
        ],
      );
    },
    validator: (value) {
      if (value != 'valid') {
        return 'Value must be "valid"';
      }
      return null;
    },
  );
  print('Custom FormField with builder created');

  // Test FormField with onSaved
  final savedFormField = FormField<int>(
    initialValue: 0,
    onSaved: (value) {
      print('FormField saved with value: $value');
    },
    builder: (state) {
      return Container(
        padding: EdgeInsets.all(8.0),
        child: Text('Value: ${state.value}'),
      );
    },
  );
  print('FormField with onSaved callback created');

  // Test TextFormField validators
  final emailValidator = TextFormField(
    decoration: InputDecoration(
      labelText: 'Email',
      hintText: 'Enter your email',
    ),
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }
      if (!value.contains('@')) {
        return 'Enter a valid email';
      }
      return null;
    },
  );
  print('TextFormField with email validator created');

  final passwordValidator = TextFormField(
    decoration: InputDecoration(
      labelText: 'Password',
      hintText: 'Enter password',
    ),
    obscureText: true,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      if (value.length < 8) {
        return 'Password must be at least 8 characters';
      }
      return null;
    },
  );
  print('TextFormField with password validator created');

  // Test Form validation workflow
  print('Form.of(context).validate() - validates all fields');
  print('Form.of(context).save() - calls onSaved on all fields');
  print('Form.of(context).reset() - resets all fields');

  // Test FormFieldState methods
  print('FormFieldState.validate() - validates single field');
  print('FormFieldState.save() - saves single field');
  print('FormFieldState.reset() - resets single field');
  print('FormFieldState.didChange(value) - updates value');

  // Test TextFormField with controller
  final textController = TextEditingController(text: 'Initial text');
  final withController = TextFormField(
    controller: textController,
    decoration: InputDecoration(labelText: 'With Controller'),
  );
  print('TextFormField with TextEditingController created');

  // Test TextFormField with focusNode
  final focusNode = FocusNode();
  final withFocus = TextFormField(
    focusNode: focusNode,
    decoration: InputDecoration(labelText: 'With FocusNode'),
  );
  print('TextFormField with FocusNode created');

  // Test TextFormField with inputFormatters concept
  print(
    'TextFormField inputFormatters: FilteringTextInputFormatter, LengthLimitingTextInputFormatter',
  );

  // Test TextFormField with maxLength
  final maxLengthField = TextFormField(
    maxLength: 50,
    decoration: InputDecoration(
      labelText: 'Max 50 chars',
      counterText: '', // Hide counter if needed
    ),
  );
  print('TextFormField with maxLength=50 created');

  // Test TextFormField with maxLines
  final multiLineField = TextFormField(
    maxLines: 4,
    decoration: InputDecoration(
      labelText: 'Multi-line Input',
      border: OutlineInputBorder(),
    ),
  );
  print('TextFormField with maxLines=4 created');

  // Test TextFormField enabled/readOnly
  final readOnlyField = TextFormField(
    readOnly: true,
    initialValue: 'Read only value',
    decoration: InputDecoration(labelText: 'Read Only'),
  );
  print('TextFormField with readOnly=true created');

  final disabledField = TextFormField(
    enabled: false,
    initialValue: 'Disabled value',
    decoration: InputDecoration(labelText: 'Disabled'),
  );
  print('TextFormField with enabled=false created');

  print('Form test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Form Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        basicForm,
        SizedBox(height: 24.0),
        alwaysValidate,
        SizedBox(height: 16.0),
        validateOnInteraction,
        SizedBox(height: 16.0),
        customFormField,
        SizedBox(height: 16.0),
        emailValidator,
        SizedBox(height: 16.0),
        passwordValidator,
        SizedBox(height: 16.0),
        withController,
        SizedBox(height: 16.0),
        maxLengthField,
        SizedBox(height: 16.0),
        multiLineField,
        SizedBox(height: 16.0),
        readOnlyField,
        SizedBox(height: 16.0),
        disabledField,
      ],
    ),
  );
}
