// D4rt test script: Tests FormState, FormFieldState from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FormState test executing');

  // Create a GlobalKey to access FormState directly
  final formKey = GlobalKey<FormState>();

  return Form(
    key: formKey,
    autovalidateMode: AutovalidateMode.disabled,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Use Builder to get a context that is a descendant of the Form
        Builder(builder: (formContext) {
          final formState = Form.of(formContext);
          print('Form.of(formContext): ${formState?.runtimeType}');

          // Also access via GlobalKey
          // Note: formKey.currentState may be null during first build
          final keyState = formKey.currentState;
          print('formKey.currentState: ${keyState?.runtimeType}');

          return TextFormField(
            initialValue: 'test value',
            decoration: InputDecoration(
              labelText: 'Test Field',
              hintText: 'Enter text',
            ),
            validator: (value) {
              print('Validator called with: $value');
              if (value == null || value.isEmpty) {
                return 'Field is required';
              }
              return null;
            },
            onSaved: (value) {
              print('onSaved called with: $value');
            },
            onChanged: (value) {
              print('onChanged: $value');
            },
          );
        }),
        SizedBox(height: 16.0),
        // Second field to test multiple form fields
        TextFormField(
          initialValue: 'second field',
          decoration: InputDecoration(labelText: 'Second Field'),
          validator: (value) {
            print('Second validator called: $value');
            return null;
          },
        ),
        SizedBox(height: 16.0),
        // Button to trigger validation
        Builder(builder: (btnContext) {
          return ElevatedButton(
            onPressed: () {
              final state = Form.of(btnContext);
              if (state != null) {
                final isValid = state.validate();
                print('Form.validate() result: $isValid');
                if (isValid) {
                  state.save();
                  print('Form.save() called');
                }
              }
            },
            child: Text('Validate Form'),
          );
        }),
        SizedBox(height: 8.0),
        // Reset button
        Builder(builder: (btnContext) {
          return ElevatedButton(
            onPressed: () {
              final state = Form.of(btnContext);
              state?.reset();
              print('Form.reset() called');
            },
            child: Text('Reset Form'),
          );
        }),
        SizedBox(height: 16.0),
        Text('FormState test rendered'),
      ],
    ),
  );
}
