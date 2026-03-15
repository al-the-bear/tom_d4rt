// D4rt test script: Tests GridView widget from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GridView test executing');

  // Test basic GridView.count
  final countGridView = Container(
    height: 150.0,
    child: GridView.count(
      crossAxisCount: 3,
      children: [
        Container(color: Colors.red),
        Container(color: Colors.green),
        Container(color: Colors.blue),
        Container(color: Colors.yellow),
        Container(color: Colors.purple),
        Container(color: Colors.orange),
      ],
    ),
  );
  print('GridView.count with crossAxisCount=3 created');

  // Test GridView.count with spacing
  final spacedGridView = Container(
    height: 150.0,
    child: GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: [
        Container(color: Colors.red),
        Container(color: Colors.green),
        Container(color: Colors.blue),
        Container(color: Colors.yellow),
      ],
    ),
  );
  print('GridView.count with spacing created');

  // Test GridView.count with childAspectRatio
  final aspectGridView = Container(
    height: 100.0,
    child: GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 2.0,
      children: [
        Container(color: Colors.teal),
        Container(color: Colors.cyan),
        Container(color: Colors.indigo),
      ],
    ),
  );
  print('GridView.count with childAspectRatio=2.0 created');

  // Test GridView.extent
  final extentGridView = Container(
    height: 150.0,
    child: GridView.extent(
      maxCrossAxisExtent: 80.0,
      children: [
        Container(color: Colors.pink),
        Container(color: Colors.lime),
        Container(color: Colors.amber),
        Container(color: Colors.brown),
      ],
    ),
  );
  print('GridView.extent with maxCrossAxisExtent=80 created');

  // Test GridView.builder
  final builderGridView = Container(
    height: 150.0,
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text('$index', style: TextStyle(color: Colors.white)),
          ),
        );
      },
    ),
  );
  print('GridView.builder with itemCount=9 created');

  // Test GridView with padding
  final paddedGridView = Container(
    height: 120.0,
    color: Colors.grey.shade200,
    child: GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      children: [
        Container(color: Colors.red),
        Container(color: Colors.blue),
      ],
    ),
  );
  print('GridView with padding created');

  // Test GridView with scrollDirection horizontal
  final horizontalGridView = Container(
    height: 100.0,
    child: GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.horizontal,
      children: [
        Container(color: Colors.red),
        Container(color: Colors.green),
        Container(color: Colors.blue),
        Container(color: Colors.yellow),
        Container(color: Colors.purple),
        Container(color: Colors.orange),
      ],
    ),
  );
  print('GridView with horizontal scrollDirection created');

  print('GridView test completed');

  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GridView.count (3 cols):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        countGridView,
        SizedBox(height: 8.0),
        Text(
          'GridView with spacing:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        spacedGridView,
        SizedBox(height: 8.0),
        Text('GridView.extent:', style: TextStyle(fontWeight: FontWeight.bold)),
        extentGridView,
        SizedBox(height: 8.0),
        Text(
          'GridView.builder:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        builderGridView,
      ],
    ),
  );
}
