// D4rt test script: Tests RichText widget from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RichText test executing');

  // Test basic RichText with TextSpan
  final basicRichText = RichText(
    text: TextSpan(
      text: 'Hello ',
      style: TextStyle(color: Colors.black, fontSize: 16.0),
      children: [
        TextSpan(
          text: 'World',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ],
    ),
  );
  print('Basic RichText with TextSpan created');

  // Test RichText with multiple styled spans
  final multiStyleRichText = RichText(
    text: TextSpan(
      style: TextStyle(color: Colors.black, fontSize: 14.0),
      children: [
        TextSpan(text: 'Normal '),
        TextSpan(
          text: 'Bold ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: 'Italic ',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        TextSpan(
          text: 'Colored',
          style: TextStyle(color: Colors.red),
        ),
      ],
    ),
  );
  print('RichText with multiple styled spans created');

  // Test RichText with textAlign
  final alignedRichText = RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: 'Center Aligned Text',
      style: TextStyle(color: Colors.green, fontSize: 16.0),
    ),
  );
  print('RichText with textAlign.center created');

  // Test RichText with maxLines and overflow
  final overflowRichText = RichText(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(
      text: 'This is a very long text that will be truncated with ellipsis',
      style: TextStyle(color: Colors.purple, fontSize: 14.0),
    ),
  );
  print('RichText with maxLines=1 and overflow.ellipsis created');

  // Test RichText with nested TextSpans
  final nestedRichText = RichText(
    text: TextSpan(
      text: 'Root ',
      style: TextStyle(color: Colors.black, fontSize: 14.0),
      children: [
        TextSpan(
          text: 'Level 1 ',
          style: TextStyle(color: Colors.blue),
          children: [
            TextSpan(
              text: 'Level 2',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
  print('RichText with nested TextSpans created');

  // Test RichText with textScaleFactor (deprecated but still used)
  final scaledRichText = RichText(
    textScaler: TextScaler.linear(1.5),
    text: TextSpan(
      text: 'Scaled Text',
      style: TextStyle(color: Colors.orange, fontSize: 14.0),
    ),
  );
  print('RichText with textScaler created');

  print('RichText test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      basicRichText,
      SizedBox(height: 8.0),
      multiStyleRichText,
      SizedBox(height: 8.0),
      Container(width: 200.0, child: alignedRichText),
      SizedBox(height: 8.0),
      Container(width: 150.0, child: overflowRichText),
      SizedBox(height: 8.0),
      nestedRichText,
      SizedBox(height: 8.0),
      scaledRichText,
    ],
  );
}
