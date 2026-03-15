// D4rt test script: Tests PageController from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PageController test executing');

  // Test basic PageController
  final controller1 = PageController();
  print('Basic PageController created');
  print('PageController initialPage: ${controller1.initialPage}');
  print('PageController viewportFraction: ${controller1.viewportFraction}');
  print('PageController keepPage: ${controller1.keepPage}');

  // Test PageController with initialPage
  final controller2 = PageController(initialPage: 2);
  print('PageController(initialPage: 2) created');
  print('PageController initialPage: ${controller2.initialPage}');

  // Test PageController with viewportFraction
  final controller3 = PageController(viewportFraction: 0.8);
  print('PageController(viewportFraction: 0.8) created');
  print('PageController viewportFraction: ${controller3.viewportFraction}');

  // Test PageController with all properties
  final controller4 = PageController(
    initialPage: 1,
    viewportFraction: 0.85,
    keepPage: false,
  );
  print(
    'PageController(initialPage: 1, viewportFraction: 0.85, keepPage: false) created',
  );
  print('PageController initialPage: ${controller4.initialPage}');
  print('PageController viewportFraction: ${controller4.viewportFraction}');
  print('PageController keepPage: ${controller4.keepPage}');

  // Test PageController used in PageView
  final pageView1 = SizedBox(
    height: 150.0,
    child: PageView(
      controller: controller3,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          color: Colors.blue,
          child: Center(
            child: Text(
              'Page 0',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          color: Colors.green,
          child: Center(
            child: Text(
              'Page 1',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          color: Colors.orange,
          child: Center(
            child: Text(
              'Page 2',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      ],
    ),
  );
  print('PageView with PageController(viewportFraction: 0.8) created');

  // Test PageView.builder with controller
  final controller5 = PageController(initialPage: 0, viewportFraction: 0.9);
  final pageView2 = SizedBox(
    height: 120.0,
    child: PageView.builder(
      controller: controller5,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(4.0),
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              'Builder Page $index',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
          ),
        );
      },
    ),
  );
  print('PageView.builder with PageController created');

  print('PageController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PageController Tests'),
      SizedBox(height: 8.0),
      pageView1,
      SizedBox(height: 8.0),
      pageView2,
    ],
  );
}
