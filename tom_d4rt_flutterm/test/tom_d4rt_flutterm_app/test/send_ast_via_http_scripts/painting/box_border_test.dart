// D4rt test script: Tests BoxBorder abstract and Border concrete class from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxBorder test executing');
  final results = <String>[];

  // ========== Border (concrete implementation of BoxBorder) Tests ==========
  print('Testing Border class (BoxBorder implementation)...');

  // Test 1: Default Border.all constructor
  final border1 = Border.all(color: Color(0xFF000000), width: 1.0);
  assert(border1.top.width == 1.0, 'Top border width should be 1.0');
  assert(border1.bottom.width == 1.0, 'Bottom border width should be 1.0');
  assert(border1.left.width == 1.0, 'Left border width should be 1.0');
  assert(border1.right.width == 1.0, 'Right border width should be 1.0');
  results.add('Border.all: width=${border1.top.width}');
  print('Border.all: width=${border1.top.width}');

  // Test 2: Border.all with custom width
  final border2 = Border.all(color: Color(0xFFFF0000), width: 2.5);
  assert(border2.top.width == 2.5, 'Border width should be 2.5');
  assert(border2.top.color == Color(0xFFFF0000), 'Border color should be red');
  results.add(
    'Border.all custom: width=${border2.top.width}, color=${border2.top.color}',
  );
  print('Border.all custom width verified');

  // Test 3: Border with individual sides
  final border3 = Border(
    top: BorderSide(color: Color(0xFFFF0000), width: 1.0),
    bottom: BorderSide(color: Color(0xFF00FF00), width: 2.0),
    left: BorderSide(color: Color(0xFF0000FF), width: 3.0),
    right: BorderSide(color: Color(0xFFFFFF00), width: 4.0),
  );
  assert(border3.top.width == 1.0, 'Top should be 1.0');
  assert(border3.bottom.width == 2.0, 'Bottom should be 2.0');
  assert(border3.left.width == 3.0, 'Left should be 3.0');
  assert(border3.right.width == 4.0, 'Right should be 4.0');
  results.add('Border individual sides: verified');
  print('Border individual sides verified');

  // Test 4: Border.symmetric constructor
  final border4 = Border.symmetric(
    vertical: BorderSide(color: Color(0xFFFF0000), width: 2.0),
    horizontal: BorderSide(color: Color(0xFF0000FF), width: 3.0),
  );
  assert(border4.top.width == 2.0, 'Vertical top should be 2.0');
  assert(border4.bottom.width == 2.0, 'Vertical bottom should be 2.0');
  assert(border4.left.width == 3.0, 'Horizontal left should be 3.0');
  assert(border4.right.width == 3.0, 'Horizontal right should be 3.0');
  results.add(
    'Border.symmetric: vertical=${border4.top.width}, horizontal=${border4.left.width}',
  );
  print('Border.symmetric verified');

  // Test 5: Border dimensions calculation
  final border5 = Border.all(width: 5.0);
  final dimensions = border5.dimensions;
  assert(dimensions.horizontal == 10.0, 'Horizontal dimensions should be 10.0');
  assert(dimensions.vertical == 10.0, 'Vertical dimensions should be 10.0');
  results.add(
    'Border dimensions: h=${dimensions.horizontal}, v=${dimensions.vertical}',
  );
  print('Border dimensions: ${dimensions}');

  // Test 6: Border isUniform check
  final uniformBorder = Border.all(color: Color(0xFF000000), width: 2.0);
  assert(uniformBorder.isUniform == true, 'Border.all should be uniform');
  results.add('Border isUniform: ${uniformBorder.isUniform}');
  print('Border isUniform: ${uniformBorder.isUniform}');

  // Test 7: Border with BorderSide.none
  final borderWithNone = Border(
    top: BorderSide(color: Color(0xFFFF0000), width: 1.0),
    bottom: BorderSide.none,
    left: BorderSide.none,
    right: BorderSide.none,
  );
  assert(borderWithNone.bottom == BorderSide.none, 'Bottom should be none');
  results.add('Border with none sides: verified');
  print('Border with BorderSide.none verified');

  // Test 8: Border scale method
  final scaledBorder = border1.scale(2.0);
  assert(scaledBorder.top.width == 2.0, 'Scaled width should be 2.0');
  results.add('Border scaled: ${scaledBorder.top.width}');
  print('Border scale: ${scaledBorder.top.width}');

  // Test 9: BorderSide styles
  final solidBorder = BorderSide(
    color: Color(0xFF000000),
    width: 1.0,
    style: BorderStyle.solid,
  );
  assert(solidBorder.style == BorderStyle.solid, 'Style should be solid');
  results.add('BorderSide style: ${solidBorder.style}');
  print('BorderSide style: ${solidBorder.style}');

  // Test 10: Border equality
  final borderA = Border.all(color: Color(0xFF000000), width: 1.0);
  final borderB = Border.all(color: Color(0xFF000000), width: 1.0);
  assert(borderA == borderB, 'Equal borders should be equal');
  results.add('Border equality: ${borderA == borderB}');
  print('Border equality verified');

  // Test 11: Border hashCode
  final hashA = borderA.hashCode;
  final hashB = borderB.hashCode;
  assert(hashA == hashB, 'Equal borders should have same hashCode');
  results.add('Border hashCode: $hashA == $hashB');
  print('Border hashCode verified');

  // Test 12: Border add operation
  final addedBorder = Border.all(
    width: 1.0,
  ).add(Border.all(width: 1.0), reversed: false);
  results.add('Border add: $addedBorder');
  print('Border add operation tested');

  print('BoxBorder test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxBorder Tests (Border implementation)'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
