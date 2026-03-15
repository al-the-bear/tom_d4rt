// D4rt test script: Tests Positioned widget from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Positioned test executing');

  // Test Positioned with left and top
  final leftTop = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned(
        left: 10.0,
        top: 10.0,
        child: Container(width: 50.0, height: 50.0, color: Colors.blue),
      ),
    ],
  );
  print('Positioned with left=10, top=10 created');

  // Test Positioned with right and bottom
  final rightBottom = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned(
        right: 10.0,
        bottom: 10.0,
        child: Container(width: 50.0, height: 50.0, color: Colors.green),
      ),
    ],
  );
  print('Positioned with right=10, bottom=10 created');

  // Test Positioned with all four positions
  final allPositions = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned(
        left: 20.0,
        top: 20.0,
        right: 20.0,
        bottom: 20.0,
        child: Container(color: Colors.orange),
      ),
    ],
  );
  print('Positioned with all four positions created');

  // Test Positioned with width and height
  final sized = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned(
        left: 10.0,
        top: 10.0,
        width: 80.0,
        height: 40.0,
        child: Container(color: Colors.purple),
      ),
    ],
  );
  print('Positioned with width and height created');

  // Test Positioned.fill
  final fill = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned.fill(child: Container(color: Colors.red.withOpacity(0.5))),
    ],
  );
  print('Positioned.fill created');

  // Test Positioned.fromRect
  final fromRect = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned.fromRect(
        rect: Rect.fromLTWH(30.0, 20.0, 60.0, 50.0),
        child: Container(color: Colors.teal),
      ),
    ],
  );
  print('Positioned.fromRect created');

  // Test PositionedDirectional
  final directional = Directionality(
    textDirection: TextDirection.rtl,
    child: Stack(
      children: [
        Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
        PositionedDirectional(
          start: 10.0,
          top: 10.0,
          child: Container(width: 50.0, height: 50.0, color: Colors.pink),
        ),
      ],
    ),
  );
  print('PositionedDirectional with start=10 created');

  // Test multiple Positioned widgets
  final multiple = Stack(
    children: [
      Container(width: 150.0, height: 100.0, color: Colors.grey.shade200),
      Positioned(
        left: 5.0,
        top: 5.0,
        child: Container(width: 30.0, height: 30.0, color: Colors.red),
      ),
      Positioned(
        right: 5.0,
        top: 5.0,
        child: Container(width: 30.0, height: 30.0, color: Colors.green),
      ),
      Positioned(
        left: 5.0,
        bottom: 5.0,
        child: Container(width: 30.0, height: 30.0, color: Colors.blue),
      ),
      Positioned(
        right: 5.0,
        bottom: 5.0,
        child: Container(width: 30.0, height: 30.0, color: Colors.yellow),
      ),
    ],
  );
  print('Multiple Positioned widgets created');

  print('Positioned test completed');

  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        leftTop,
        SizedBox(height: 8.0),
        rightBottom,
        SizedBox(height: 8.0),
        allPositions,
        SizedBox(height: 8.0),
        sized,
        SizedBox(height: 8.0),
        fill,
        SizedBox(height: 8.0),
        fromRect,
        SizedBox(height: 8.0),
        multiple,
      ],
    ),
  );
}
