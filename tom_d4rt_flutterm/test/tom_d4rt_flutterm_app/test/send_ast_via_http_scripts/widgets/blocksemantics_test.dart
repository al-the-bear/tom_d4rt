// D4rt test script: Tests BlockSemantics and IndexedSemantics from widgets
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BlockSemantics test executing');

  // Test BlockSemantics with blocking=true (default)
  final block1 = BlockSemantics(
    child: Container(
      width: 150.0,
      height: 60.0,
      color: Colors.blue,
      child: Center(
        child: Text('Blocked', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('BlockSemantics(blocking: true) created');

  // Test BlockSemantics with blocking=false
  final block2 = BlockSemantics(
    blocking: false,
    child: Container(
      width: 150.0,
      height: 60.0,
      color: Colors.green,
      child: Center(
        child: Text('Not blocked', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('BlockSemantics(blocking: false) created');

  // Test BlockSemantics wrapping interactive content
  final block3 = BlockSemantics(
    child: ElevatedButton(
      child: Text('Semantically Blocked Button'),
      onPressed: () => print('Blocked button pressed'),
    ),
  );
  print('BlockSemantics wrapping ElevatedButton created');

  // Test IndexedSemantics with various indices
  final indexed1 = IndexedSemantics(
    index: 0,
    child: Container(
      width: 150.0,
      height: 50.0,
      color: Colors.orange,
      child: Center(child: Text('Index 0')),
    ),
  );
  print('IndexedSemantics(index: 0) created');

  final indexed2 = IndexedSemantics(
    index: 1,
    child: Container(
      width: 150.0,
      height: 50.0,
      color: Colors.purple,
      child: Center(
        child: Text('Index 1', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('IndexedSemantics(index: 1) created');

  final indexed3 = IndexedSemantics(
    index: 5,
    child: Container(
      width: 150.0,
      height: 50.0,
      color: Colors.teal,
      child: Center(
        child: Text('Index 5', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('IndexedSemantics(index: 5) created');

  // Test IndexedSemantics in a list-like context
  final indexedList = Column(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(4, (index) {
      return IndexedSemantics(
        index: index,
        child: Container(
          width: 200.0,
          height: 40.0,
          margin: EdgeInsets.symmetric(vertical: 2.0),
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              'List item $index',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }),
  );
  print('IndexedSemantics list with 4 items created');

  // Test combination: BlockSemantics containing IndexedSemantics
  final combined = BlockSemantics(
    child: IndexedSemantics(
      index: 10,
      child: Container(
        width: 180.0,
        height: 50.0,
        color: Colors.indigo,
        child: Center(
          child: Text('Block+Index=10', style: TextStyle(color: Colors.white)),
        ),
      ),
    ),
  );
  print('BlockSemantics containing IndexedSemantics(index: 10) created');

  print('BlockSemantics test completed');
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('BlockSemantics / IndexedSemantics Tests'),
        SizedBox(height: 8.0),
        block1,
        block2,
        block3,
        SizedBox(height: 8.0),
        indexed1,
        indexed2,
        indexed3,
        SizedBox(height: 8.0),
        indexedList,
        SizedBox(height: 8.0),
        combined,
      ],
    ),
  );
}
