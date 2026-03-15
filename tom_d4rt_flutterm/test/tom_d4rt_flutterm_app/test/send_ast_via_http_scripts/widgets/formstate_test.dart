// D4rt test script: Tests FormState, FormFieldState from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
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
        Builder(
          builder: (formContext) {
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
          },
        ),
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
        Builder(
          builder: (btnContext) {
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
          },
        ),
        SizedBox(height: 8.0),
        // Reset button
        Builder(
          builder: (btnContext) {
            return ElevatedButton(
              onPressed: () {
                final state = Form.of(btnContext);
                state?.reset();
                print('Form.reset() called');
              },
              child: Text('Reset Form'),
            );
          },
        ),
        SizedBox(height: 16.0),
        Text('FormState test rendered'),
      ],
    ),
  );
}
