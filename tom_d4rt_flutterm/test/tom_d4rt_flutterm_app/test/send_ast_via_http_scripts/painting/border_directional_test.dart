// D4rt test script: Tests BorderDirectional from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BorderDirectional test executing');
  final results = <String>[];

  // ========== BorderDirectional Tests ==========
  print('Testing BorderDirectional...');

  // Test 1: Create basic BorderDirectional
  final border1 = BorderDirectional(
    top: BorderSide(color: Color(0xFFFF0000), width: 1.0),
    bottom: BorderSide(color: Color(0xFF00FF00), width: 2.0),
    start: BorderSide(color: Color(0xFF0000FF), width: 3.0),
    end: BorderSide(color: Color(0xFFFFFF00), width: 4.0),
  );
  assert(border1.top.width == 1.0, 'Top width should be 1.0');
  assert(border1.bottom.width == 2.0, 'Bottom width should be 2.0');
  assert(border1.start.width == 3.0, 'Start width should be 3.0');
  assert(border1.end.width == 4.0, 'End width should be 4.0');
  results.add(
    'BorderDirectional: top=${border1.top.width}, start=${border1.start.width}',
  );
  print('BorderDirectional created with all sides');

  // Test 2: BorderDirectional with only top
  final border2 = BorderDirectional(
    top: BorderSide(color: Color(0xFF000000), width: 2.0),
  );
  assert(border2.top.width == 2.0, 'Top width should be 2.0');
  assert(border2.bottom == BorderSide.none, 'Bottom should be none');
  results.add('BorderDirectional top only: ${border2.top.width}');
  print('BorderDirectional top only verified');

  // Test 3: BorderDirectional with only bottom
  final border3 = BorderDirectional(
    bottom: BorderSide(color: Color(0xFF000000), width: 3.0),
  );
  assert(border3.bottom.width == 3.0, 'Bottom width should be 3.0');
  results.add('BorderDirectional bottom only: ${border3.bottom.width}');
  print('BorderDirectional bottom only verified');

  // Test 4: BorderDirectional with start and end (RTL-aware)
  final border4 = BorderDirectional(
    start: BorderSide(color: Color(0xFFFF0000), width: 5.0),
    end: BorderSide(color: Color(0xFF0000FF), width: 2.0),
  );
  assert(border4.start.width == 5.0, 'Start width should be 5.0');
  assert(border4.end.width == 2.0, 'End width should be 2.0');
  results.add(
    'BorderDirectional start/end: start=${border4.start.width}, end=${border4.end.width}',
  );
  print('BorderDirectional start/end verified');

  // Test 5: BorderDirectional dimensions
  final border5 = BorderDirectional(
    top: BorderSide(width: 10.0),
    bottom: BorderSide(width: 10.0),
    start: BorderSide(width: 5.0),
    end: BorderSide(width: 5.0),
  );
  final dims = border5.dimensions;
  assert(dims.vertical == 20.0, 'Vertical dimensions should be 20.0');
  assert(dims.horizontal == 10.0, 'Horizontal dimensions should be 10.0');
  results.add(
    'BorderDirectional dimensions: h=${dims.horizontal}, v=${dims.vertical}',
  );
  print('BorderDirectional dimensions: $dims');

  // Test 6: BorderDirectional isUniform
  final uniformBorder = BorderDirectional(
    top: BorderSide(color: Color(0xFF000000), width: 1.0),
    bottom: BorderSide(color: Color(0xFF000000), width: 1.0),
    start: BorderSide(color: Color(0xFF000000), width: 1.0),
    end: BorderSide(color: Color(0xFF000000), width: 1.0),
  );
  assert(uniformBorder.isUniform == true, 'Should be uniform');
  results.add('BorderDirectional isUniform: ${uniformBorder.isUniform}');
  print('BorderDirectional isUniform: ${uniformBorder.isUniform}');

  // Test 7: BorderDirectional non-uniform
  final nonUniformBorder = BorderDirectional(
    top: BorderSide(width: 1.0),
    bottom: BorderSide(width: 2.0),
  );
  assert(nonUniformBorder.isUniform == false, 'Should not be uniform');
  results.add('BorderDirectional non-uniform: ${nonUniformBorder.isUniform}');
  print('BorderDirectional non-uniform verified');

  // Test 8: BorderDirectional scale
  final scaledBorder = border1.scale(2.0);
  assert(scaledBorder.top.width == 2.0, 'Scaled top should be 2.0');
  results.add('BorderDirectional scaled: ${scaledBorder.top.width}');
  print('BorderDirectional scale verified');

  // Test 9: BorderDirectional lerp
  final borderA = BorderDirectional(top: BorderSide(width: 0.0));
  final borderB = BorderDirectional(top: BorderSide(width: 10.0));
  final lerped = BorderDirectional.lerp(borderA, borderB, 0.5);
  assert(lerped != null, 'Lerped border should not be null');
  results.add('BorderDirectional lerp: applied');
  print('BorderDirectional lerp applied');

  // Test 10: BorderDirectional with BorderSide.none
  final borderNone = BorderDirectional(
    top: BorderSide(width: 1.0),
    bottom: BorderSide.none,
    start: BorderSide.none,
    end: BorderSide.none,
  );
  assert(borderNone.bottom == BorderSide.none, 'Bottom should be none');
  results.add('BorderDirectional with none sides: verified');
  print('BorderDirectional with none sides verified');

  // Test 11: BorderDirectional equality
  final bdA = BorderDirectional(top: BorderSide(width: 1.0));
  final bdB = BorderDirectional(top: BorderSide(width: 1.0));
  assert(bdA == bdB, 'Equal borders should be equal');
  results.add('BorderDirectional equality: ${bdA == bdB}');
  print('BorderDirectional equality verified');

  // Test 12: BorderDirectional hashCode
  final hashA = bdA.hashCode;
  final hashB = bdB.hashCode;
  assert(hashA == hashB, 'Equal borders should have same hash');
  results.add('BorderDirectional hashCode: $hashA');
  print('BorderDirectional hashCode verified');

  print('BorderDirectional test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BorderDirectional Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
