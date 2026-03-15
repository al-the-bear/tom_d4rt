// D4rt test script: Tests OutlinedBorder abstract via RoundedRectangleBorder from painting
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OutlinedBorder test executing');
  final results = <String>[];

  // ========== OutlinedBorder Tests via RoundedRectangleBorder ==========
  // OutlinedBorder is abstract, RoundedRectangleBorder extends it
  print('Testing OutlinedBorder via RoundedRectangleBorder...');

  // Test 1: Default RoundedRectangleBorder
  final border1 = RoundedRectangleBorder();
  assert(border1.side == BorderSide.none, 'Default side should be none');
  results.add('RoundedRectangleBorder default: side=${border1.side}');
  print('RoundedRectangleBorder default created');

  // Test 2: RoundedRectangleBorder with borderRadius
  final border2 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );
  assert(
    border2.borderRadius == BorderRadius.circular(10.0),
    'Radius should be 10.0',
  );
  results.add('RoundedRectangleBorder radius: ${border2.borderRadius}');
  print('RoundedRectangleBorder borderRadius: ${border2.borderRadius}');

  // Test 3: RoundedRectangleBorder with side
  final border3 = RoundedRectangleBorder(
    side: BorderSide(color: Color(0xFF000000), width: 2.0),
    borderRadius: BorderRadius.circular(8.0),
  );
  assert(border3.side.width == 2.0, 'Side width should be 2.0');
  results.add('RoundedRectangleBorder side: width=${border3.side.width}');
  print('RoundedRectangleBorder side: width=${border3.side.width}');

  // Test 4: CircleBorder (another OutlinedBorder implementation)
  final circleBorder = CircleBorder();
  assert(
    circleBorder.side == BorderSide.none,
    'Default circle side should be none',
  );
  results.add('CircleBorder: side=${circleBorder.side}');
  print('CircleBorder created');

  // Test 5: CircleBorder with side
  final circleBorder2 = CircleBorder(
    side: BorderSide(color: Color(0xFFFF0000), width: 3.0),
  );
  assert(circleBorder2.side.width == 3.0, 'Circle side width should be 3.0');
  results.add('CircleBorder side: width=${circleBorder2.side.width}');
  print('CircleBorder side: width=${circleBorder2.side.width}');

  // Test 6: StadiumBorder (another OutlinedBorder)
  final stadiumBorder = StadiumBorder();
  assert(
    stadiumBorder.side == BorderSide.none,
    'Default stadium side should be none',
  );
  results.add('StadiumBorder: created');
  print('StadiumBorder created');

  // Test 7: StadiumBorder with side
  final stadiumBorder2 = StadiumBorder(
    side: BorderSide(color: Color(0xFF00FF00), width: 1.5),
  );
  assert(stadiumBorder2.side.width == 1.5, 'Stadium side width should be 1.5');
  results.add('StadiumBorder side: width=${stadiumBorder2.side.width}');
  print('StadiumBorder side: width=${stadiumBorder2.side.width}');

  // Test 8: BeveledRectangleBorder
  final beveledBorder = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  );
  assert(
    beveledBorder.borderRadius == BorderRadius.circular(5.0),
    'Bevel radius should match',
  );
  results.add('BeveledRectangleBorder radius: ${beveledBorder.borderRadius}');
  print('BeveledRectangleBorder created');

  // Test 9: OutlinedBorder copyWith (via RoundedRectangleBorder)
  final copied = border3.copyWith(
    side: BorderSide(width: 5.0, color: Color(0xFF0000FF)),
  );
  assert(copied.side.width == 5.0, 'Copied side width should be 5.0');
  results.add('copyWith side: width=${copied.side.width}');
  print('OutlinedBorder copyWith: width=${copied.side.width}');

  // Test 10: OutlinedBorder getOuterPath
  final rect10 = Rect.fromLTWH(0, 0, 100, 50);
  final outerPath = border2.getOuterPath(rect10);
  final outerBounds = outerPath.getBounds();
  assert(outerBounds.width == 100, 'Outer width should be 100');
  results.add('getOuterPath: ${outerBounds.width}x${outerBounds.height}');
  print('OutlinedBorder getOuterPath: $outerBounds');

  // Test 11: OutlinedBorder getInnerPath
  final innerPath = border3.getInnerPath(rect10);
  final innerBounds = innerPath.getBounds();
  results.add('getInnerPath: ${innerBounds.width}x${innerBounds.height}');
  print('OutlinedBorder getInnerPath: $innerBounds');

  // Test 12: OutlinedBorder scale
  final scaled = border3.scale(2.0);
  results.add('scale(2.0): applied');
  print('OutlinedBorder scale applied');

  // Test 13: OutlinedBorder lerp
  final borderA = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),
  );
  final borderB = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  );
  final lerped = ShapeBorder.lerp(borderA, borderB, 0.5);
  assert(lerped != null, 'Lerped border should not be null');
  results.add('ShapeBorder.lerp: computed');
  print('OutlinedBorder lerp computed');

  // Test 14: OutlinedBorder equality
  final eq1 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
  final eq2 = RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0));
  assert(eq1 == eq2, 'Equal borders should be equal');
  results.add('OutlinedBorder equality: ${eq1 == eq2}');
  print('OutlinedBorder equality verified');

  print('OutlinedBorder test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OutlinedBorder Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
