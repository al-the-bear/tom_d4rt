// D4rt test script: Tests LinearBorderEdge from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LinearBorderEdge test executing');
  final results = <String>[];

  // ========== LinearBorderEdge Tests ==========
  print('Testing LinearBorderEdge...');

  // Test 1: Default LinearBorderEdge
  final edge1 = LinearBorderEdge();
  assert(edge1.size == 1.0, 'Default size should be 1.0');
  assert(edge1.alignment == 0.0, 'Default alignment should be 0.0');
  results.add(
    'LinearBorderEdge default: size=${edge1.size}, align=${edge1.alignment}',
  );
  print(
    'LinearBorderEdge default: size=${edge1.size}, alignment=${edge1.alignment}',
  );

  // Test 2: LinearBorderEdge with custom size
  final edge2 = LinearBorderEdge(size: 0.5);
  assert(edge2.size == 0.5, 'Size should be 0.5');
  results.add('LinearBorderEdge size: ${edge2.size}');
  print('LinearBorderEdge size: ${edge2.size}');

  // Test 3: LinearBorderEdge with custom alignment
  final edge3 = LinearBorderEdge(alignment: 0.5);
  assert(edge3.alignment == 0.5, 'Alignment should be 0.5');
  results.add('LinearBorderEdge alignment: ${edge3.alignment}');
  print('LinearBorderEdge alignment: ${edge3.alignment}');

  // Test 4: LinearBorderEdge with both parameters
  final edge4 = LinearBorderEdge(size: 0.75, alignment: -1.0);
  assert(edge4.size == 0.75, 'Size should be 0.75');
  assert(edge4.alignment == -1.0, 'Alignment should be -1.0');
  results.add(
    'LinearBorderEdge full: size=${edge4.size}, align=${edge4.alignment}',
  );
  print(
    'LinearBorderEdge custom: size=${edge4.size}, alignment=${edge4.alignment}',
  );

  // Test 5: LinearBorderEdge alignment at start (-1.0)
  final edgeStart = LinearBorderEdge(size: 0.5, alignment: -1.0);
  assert(edgeStart.alignment == -1.0, 'Start alignment should be -1.0');
  results.add('LinearBorderEdge start align: ${edgeStart.alignment}');
  print('LinearBorderEdge start alignment verified');

  // Test 6: LinearBorderEdge alignment at center (0.0)
  final edgeCenter = LinearBorderEdge(size: 0.5, alignment: 0.0);
  assert(edgeCenter.alignment == 0.0, 'Center alignment should be 0.0');
  results.add('LinearBorderEdge center align: ${edgeCenter.alignment}');
  print('LinearBorderEdge center alignment verified');

  // Test 7: LinearBorderEdge alignment at end (1.0)
  final edgeEnd = LinearBorderEdge(size: 0.5, alignment: 1.0);
  assert(edgeEnd.alignment == 1.0, 'End alignment should be 1.0');
  results.add('LinearBorderEdge end align: ${edgeEnd.alignment}');
  print('LinearBorderEdge end alignment verified');

  // Test 8: LinearBorderEdge.none constant
  final edgeNone = LinearBorderEdge.none;
  assert(edgeNone.size == 0.0, 'None edge size should be 0.0');
  results.add('LinearBorderEdge.none: size=${edgeNone.size}');
  print('LinearBorderEdge.none: size=${edgeNone.size}');

  // Test 9: LinearBorderEdge lerp
  final edgeA = LinearBorderEdge(size: 0.0, alignment: -1.0);
  final edgeB = LinearBorderEdge(size: 1.0, alignment: 1.0);
  final lerped = LinearBorderEdge.lerp(edgeA, edgeB, 0.5);
  assert(lerped != null, 'Lerped edge should not be null');
  assert(lerped!.size == 0.5, 'Lerped size should be 0.5');
  assert(lerped.alignment == 0.0, 'Lerped alignment should be 0.0');
  results.add(
    'LinearBorderEdge lerp: size=${lerped.size}, align=${lerped.alignment}',
  );
  print(
    'LinearBorderEdge lerp: size=${lerped.size}, alignment=${lerped.alignment}',
  );

  // Test 10: LinearBorderEdge small size
  final edgeSmall = LinearBorderEdge(size: 0.1);
  assert(edgeSmall.size == 0.1, 'Small size should be 0.1');
  results.add('LinearBorderEdge small: ${edgeSmall.size}');
  print('LinearBorderEdge small size verified');

  // Test 11: LinearBorderEdge full size
  final edgeFull = LinearBorderEdge(size: 1.0);
  assert(edgeFull.size == 1.0, 'Full size should be 1.0');
  results.add('LinearBorderEdge full size: ${edgeFull.size}');
  print('LinearBorderEdge full size verified');

  // Test 12: LinearBorderEdge equality
  final eq1 = LinearBorderEdge(size: 0.5, alignment: 0.5);
  final eq2 = LinearBorderEdge(size: 0.5, alignment: 0.5);
  assert(eq1 == eq2, 'Equal edges should be equal');
  results.add('LinearBorderEdge equality: ${eq1 == eq2}');
  print('LinearBorderEdge equality verified');

  // Test 13: LinearBorderEdge inequality
  final ne1 = LinearBorderEdge(size: 0.5);
  final ne2 = LinearBorderEdge(size: 0.6);
  assert(ne1 != ne2, 'Different edges should not be equal');
  results.add('LinearBorderEdge inequality: ${ne1 != ne2}');
  print('LinearBorderEdge inequality verified');

  // Test 14: LinearBorderEdge hashCode
  final hash1 = eq1.hashCode;
  final hash2 = eq2.hashCode;
  assert(hash1 == hash2, 'Equal edges should have same hash');
  results.add('LinearBorderEdge hashCode: $hash1');
  print('LinearBorderEdge hashCode: $hash1');

  print('LinearBorderEdge test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LinearBorderEdge Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
