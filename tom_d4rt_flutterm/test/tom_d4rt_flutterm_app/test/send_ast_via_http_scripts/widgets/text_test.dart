// D4rt test script: Tests Text from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Text test executing');

  // Test basic Text
  final basicText = Text('Hello, D4rt!');
  print('Basic Text created');

  // Test Text with style
  final styledText = Text(
    'Styled Text',
    style: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
  );
  print('Styled Text created');

  // Test Text with italic and underline
  final decoratedText = Text(
    'Decorated',
    style: TextStyle(
      fontSize: 18.0,
      fontStyle: FontStyle.italic,
      decoration: TextDecoration.underline,
      color: Colors.green,
    ),
  );
  print('Decorated Text created');

  // Test Text with letterSpacing and wordSpacing
  final spacedText = Text(
    'Spaced Text Here',
    style: TextStyle(
      fontSize: 16.0,
      letterSpacing: 2.0,
      wordSpacing: 8.0,
      color: Colors.purple,
    ),
  );
  print('Spaced Text created');

  // Test Text with maxLines and overflow
  final overflowText = Text(
    'This is a very long text that should overflow and show ellipsis because maxLines is set to 1',
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(fontSize: 14.0),
  );
  print('Overflow Text created');

  // Test Text with textAlign
  final centeredText = Text(
    'Centered',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 20.0, color: Colors.orange),
  );
  print('Centered Text created');

  // Test Text with shadow
  final shadowText = Text(
    'Shadow Text',
    style: TextStyle(
      fontSize: 22.0,
      color: Colors.white,
      shadows: [
        Shadow(
          color: Colors.black54,
          offset: Offset(2.0, 2.0),
          blurRadius: 4.0,
        ),
      ],
    ),
  );
  print('Shadow Text created');

  print('Text test completed');

  return Container(
    padding: EdgeInsets.all(16.0),
    color: Colors.grey.shade200,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        basicText,
        SizedBox(height: 8.0),
        styledText,
        SizedBox(height: 8.0),
        decoratedText,
        SizedBox(height: 8.0),
        spacedText,
        SizedBox(height: 8.0),
        Container(width: 200.0, child: overflowText),
        SizedBox(height: 8.0),
        Container(width: 200.0, child: centeredText),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(8.0),
          color: Colors.blueGrey,
          child: shadowText,
        ),
      ],
    ),
  );
}
