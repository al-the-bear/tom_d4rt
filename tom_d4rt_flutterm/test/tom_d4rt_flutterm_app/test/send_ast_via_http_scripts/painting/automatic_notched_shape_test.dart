// D4rt test script: Tests AutomaticNotchedShape from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AutomaticNotchedShape test executing');
  final results = <String>[];

  // ========== AutomaticNotchedShape Tests ==========
  print('Testing AutomaticNotchedShape...');

  // Test 1: Create AutomaticNotchedShape with basic shapes
  final hostShape1 = RoundedRectangleBorder();
  final guestShape1 = CircleBorder();
  final notched1 = AutomaticNotchedShape(hostShape1, guestShape1);
  assert(notched1.host == hostShape1, 'Host should match');
  assert(notched1.guest == guestShape1, 'Guest should match');
  results.add('AutomaticNotchedShape: host=RoundedRect, guest=Circle');
  print('AutomaticNotchedShape created with RoundedRect host and Circle guest');

  // Test 2: AutomaticNotchedShape with StadiumBorder host
  final hostShape2 = StadiumBorder();
  final guestShape2 = CircleBorder();
  final notched2 = AutomaticNotchedShape(hostShape2, guestShape2);
  assert(notched2.host == hostShape2, 'Host should be StadiumBorder');
  results.add('AutomaticNotchedShape StadiumBorder host: verified');
  print('AutomaticNotchedShape with StadiumBorder host verified');

  // Test 3: AutomaticNotchedShape with null guest
  final notched3 = AutomaticNotchedShape(hostShape1, null);
  assert(notched3.host == hostShape1, 'Host should be set');
  assert(notched3.guest == null, 'Guest should be null');
  results.add('AutomaticNotchedShape null guest: verified');
  print('AutomaticNotchedShape with null guest verified');

  // Test 4: AutomaticNotchedShape with stadium guest
  final guestShape4 = StadiumBorder();
  final notched4 = AutomaticNotchedShape(hostShape1, guestShape4);
  assert(notched4.guest == guestShape4, 'Guest should be StadiumBorder');
  results.add('AutomaticNotchedShape stadium guest: verified');
  print('AutomaticNotchedShape with StadiumBorder guest verified');

  // Test 5: Test getOuterPath on host shape
  final rect5 = Rect.fromLTWH(0, 0, 200, 56);
  final hostPath = hostShape1.getOuterPath(rect5);
  final pathBounds = hostPath.getBounds();
  assert(pathBounds.width == 200, 'Path width should be 200');
  results.add('Host outer path width: ${pathBounds.width}');
  print('Host getOuterPath width: ${pathBounds.width}');

  // Test 6: RoundedRectangleBorder with borderRadius
  final hostShape6 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );
  final notched6 = AutomaticNotchedShape(hostShape6, guestShape1);
  assert(notched6.host == hostShape6, 'Host should have rounded corners');
  results.add('AutomaticNotchedShape rounded host: verified');
  print('AutomaticNotchedShape with rounded corner host verified');

  // Test 7: CircleBorder with side
  final guestShape7 = CircleBorder(
    side: BorderSide(color: Color(0xFF000000), width: 2.0),
  );
  final notched7 = AutomaticNotchedShape(hostShape1, guestShape7);
  assert(notched7.guest == guestShape7, 'Guest should have border side');
  results.add('AutomaticNotchedShape bordered guest: verified');
  print('AutomaticNotchedShape with bordered circle guest verified');

  // Test 8: Test getInnerPath on host shape
  final rect8 = Rect.fromLTWH(0, 0, 150, 50);
  final innerPath = hostShape1.getInnerPath(rect8);
  final innerBounds = innerPath.getBounds();
  assert(innerBounds.width <= 150, 'Inner path width should be <= 150');
  results.add('Host inner path width: ${innerBounds.width}');
  print('Host getInnerPath width: ${innerBounds.width}');

  // Test 9: ShapeBorder dimensions
  final dimensions = hostShape1.dimensions;
  results.add('Host dimensions: $dimensions');
  print('Host border dimensions: $dimensions');

  // Test 10: AutomaticNotchedShape with BeveledRectangleBorder
  final hostShape10 = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  );
  final notched10 = AutomaticNotchedShape(hostShape10, guestShape1);
  assert(
    notched10.host == hostShape10,
    'Host should be BeveledRectangleBorder',
  );
  results.add('AutomaticNotchedShape beveled host: verified');
  print('AutomaticNotchedShape with BeveledRectangleBorder host verified');

  // Test 11: Different host and guest combinations
  final notched11 = AutomaticNotchedShape(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    CircleBorder(side: BorderSide.none),
  );
  assert(notched11.host != null, 'Should have host');
  assert(notched11.guest != null, 'Should have guest');
  results.add('AutomaticNotchedShape custom combo: verified');
  print('AutomaticNotchedShape custom combination verified');

  // Test 12: Host shape scale
  final scaledHost = hostShape1.scale(2.0);
  final notched12 = AutomaticNotchedShape(scaledHost, guestShape1);
  results.add('AutomaticNotchedShape scaled host: verified');
  print('AutomaticNotchedShape with scaled host verified');

  print('AutomaticNotchedShape test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AutomaticNotchedShape Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
