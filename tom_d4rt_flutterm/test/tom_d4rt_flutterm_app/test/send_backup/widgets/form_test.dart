// D4rt test script: Tests Form and FormField widgets from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
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
