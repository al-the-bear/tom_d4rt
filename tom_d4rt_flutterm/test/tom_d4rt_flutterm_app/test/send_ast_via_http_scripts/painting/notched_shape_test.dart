// D4rt test script: Tests NotchedShape abstract via concrete implementations from painting
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NotchedShape test executing');
  final results = <String>[];

  // ========== NotchedShape Tests via CircularNotchedRectangle ==========
  // NotchedShape is abstract, CircularNotchedRectangle is a concrete implementation
  print('Testing NotchedShape via CircularNotchedRectangle...');

  // Test 1: Create CircularNotchedRectangle
  final notchedRect1 = CircularNotchedRectangle();
  assert(notchedRect1 != null, 'Should create notched rectangle');
  results.add('CircularNotchedRectangle: created');
  print('CircularNotchedRectangle created');

  // Test 2: Get outer path without notch
  final hostRect = Rect.fromLTWH(0, 0, 300, 56);
  final pathNoNotch = notchedRect1.getOuterPath(hostRect, null);
  final boundsNoNotch = pathNoNotch.getBounds();
  assert(boundsNoNotch.width == 300, 'Width should be 300');
  results.add(
    'OuterPath no notch: ${boundsNoNotch.width}x${boundsNoNotch.height}',
  );
  print('OuterPath without notch: $boundsNoNotch');

  // Test 3: Get outer path with circular notch
  final guestRect = Rect.fromCircle(center: Offset(150, 0), radius: 28);
  final pathWithNotch = notchedRect1.getOuterPath(hostRect, guestRect);
  final boundsWithNotch = pathWithNotch.getBounds();
  assert(boundsWithNotch.width >= 300, 'Width should include notch');
  results.add(
    'OuterPath with notch: ${boundsWithNotch.width}x${boundsWithNotch.height}',
  );
  print('OuterPath with notch: $boundsWithNotch');

  // Test 4: Different notch positions - left
  final leftNotch = Rect.fromCircle(center: Offset(50, 0), radius: 28);
  final pathLeftNotch = notchedRect1.getOuterPath(hostRect, leftNotch);
  results.add('Left notch path: created');
  print('Left notch position path created');

  // Test 5: Different notch positions - right
  final rightNotch = Rect.fromCircle(center: Offset(250, 0), radius: 28);
  final pathRightNotch = notchedRect1.getOuterPath(hostRect, rightNotch);
  results.add('Right notch path: created');
  print('Right notch position path created');

  // Test 6: Small notch radius
  final smallNotch = Rect.fromCircle(center: Offset(150, 0), radius: 14);
  final pathSmallNotch = notchedRect1.getOuterPath(hostRect, smallNotch);
  results.add('Small notch (r=14): created');
  print('Small notch path created');

  // Test 7: Large notch radius
  final largeNotch = Rect.fromCircle(center: Offset(150, 0), radius: 40);
  final pathLargeNotch = notchedRect1.getOuterPath(hostRect, largeNotch);
  results.add('Large notch (r=40): created');
  print('Large notch path created');

  // Test 8: AutomaticNotchedShape integration
  final hostShape = RoundedRectangleBorder();
  final guestShape = CircleBorder();
  final autoNotched = AutomaticNotchedShape(hostShape, guestShape);
  assert(autoNotched.host == hostShape, 'Host should match');
  results.add('AutomaticNotchedShape: host=RoundedRect');
  print('AutomaticNotchedShape created');

  // Test 9: AutomaticNotchedShape with null guest
  final autoNotchedNoGuest = AutomaticNotchedShape(hostShape, null);
  assert(autoNotchedNoGuest.guest == null, 'Guest should be null');
  results.add('AutomaticNotchedShape null guest: verified');
  print('AutomaticNotchedShape null guest verified');

  // Test 10: Path operations for notch
  final rect10 = Rect.fromLTWH(0, 0, 200, 50);
  final centerNotch = Rect.fromCircle(center: Offset(100, 0), radius: 20);
  final notchPath = notchedRect1.getOuterPath(rect10, centerNotch);
  final notchBounds = notchPath.getBounds();
  results.add('Center notch bounds: ${notchBounds.height}');
  print('Center notch path bounds: $notchBounds');

  // Test 11: Verify path contains points
  final testPath = notchedRect1.getOuterPath(hostRect, null);
  final containsCenter = testPath.contains(Offset(150, 28));
  results.add('Path contains center: $containsCenter');
  print('Path contains center point: $containsCenter');

  // Test 12: NotchedShape concept with StadiumBorder
  final stadiumHost = StadiumBorder();
  final autoStadium = AutomaticNotchedShape(stadiumHost, guestShape);
  assert(autoStadium.host == stadiumHost, 'Stadium host should match');
  results.add('StadiumBorder host: verified');
  print('AutomaticNotchedShape with StadiumBorder host verified');

  // Test 13: NotchedShape path metrics
  final metricsPath = notchedRect1.getOuterPath(hostRect, guestRect);
  final pathMetrics = metricsPath.computeMetrics();
  for (final metric in pathMetrics) {
    results.add('Path length: ${metric.length.toStringAsFixed(1)}');
    print('Notched path length: ${metric.length}');
    break;
  }

  print('NotchedShape test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NotchedShape Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
