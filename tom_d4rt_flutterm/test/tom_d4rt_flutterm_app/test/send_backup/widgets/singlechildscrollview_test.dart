// D4rt test script: Tests SingleChildScrollView widget from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SingleChildScrollView test executing');

  // Test basic SingleChildScrollView
  final basicScrollView = Container(
    height: 100.0,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(height: 50.0, color: Colors.red),
          Container(height: 50.0, color: Colors.green),
          Container(height: 50.0, color: Colors.blue),
          Container(height: 50.0, color: Colors.yellow),
        ],
      ),
    ),
  );
  print('Basic SingleChildScrollView created');

  // Test SingleChildScrollView with padding
  final paddedScrollView = Container(
    height: 100.0,
    color: Colors.grey.shade200,
    child: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(height: 40.0, color: Colors.purple),
          Container(height: 40.0, color: Colors.orange),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with padding created');

  // Test SingleChildScrollView with horizontal scroll
  final horizontalScrollView = Container(
    height: 60.0,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(width: 100.0, color: Colors.red),
          Container(width: 100.0, color: Colors.green),
          Container(width: 100.0, color: Colors.blue),
          Container(width: 100.0, color: Colors.yellow),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with horizontal scrollDirection created');

  // Test SingleChildScrollView with reverse
  final reverseScrollView = Container(
    height: 80.0,
    child: SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          Container(
            height: 30.0,
            color: Colors.teal,
            child: Center(child: Text('First')),
          ),
          Container(
            height: 30.0,
            color: Colors.cyan,
            child: Center(child: Text('Second')),
          ),
          Container(
            height: 30.0,
            color: Colors.indigo,
            child: Center(child: Text('Third')),
          ),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with reverse=true created');

  // Test SingleChildScrollView with physics
  final physicsScrollView = Container(
    height: 80.0,
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(height: 40.0, color: Colors.pink),
          Container(height: 40.0, color: Colors.lime),
          Container(height: 40.0, color: Colors.amber),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with BouncingScrollPhysics created');

  // Test SingleChildScrollView with ClampingScrollPhysics
  final clampingScrollView = Container(
    height: 80.0,
    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          Container(height: 40.0, color: Colors.brown),
          Container(height: 40.0, color: Colors.grey),
          Container(height: 40.0, color: Colors.blueGrey),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with ClampingScrollPhysics created');

  // Test SingleChildScrollView with primary
  final primaryScrollView = Container(
    height: 80.0,
    child: SingleChildScrollView(
      primary: false,
      child: Column(
        children: [
          Container(height: 50.0, color: Colors.deepOrange),
          Container(height: 50.0, color: Colors.deepPurple),
        ],
      ),
    ),
  );
  print('SingleChildScrollView with primary=false created');

  print('SingleChildScrollView test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Basic ScrollView:', style: TextStyle(fontWeight: FontWeight.bold)),
      basicScrollView,
      SizedBox(height: 8.0),
      Text('With padding:', style: TextStyle(fontWeight: FontWeight.bold)),
      paddedScrollView,
      SizedBox(height: 8.0),
      Text('Horizontal:', style: TextStyle(fontWeight: FontWeight.bold)),
      horizontalScrollView,
      SizedBox(height: 8.0),
      Text('Reverse:', style: TextStyle(fontWeight: FontWeight.bold)),
      reverseScrollView,
    ],
  );
}
