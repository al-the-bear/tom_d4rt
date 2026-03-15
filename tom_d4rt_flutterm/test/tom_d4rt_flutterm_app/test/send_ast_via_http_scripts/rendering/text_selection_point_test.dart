// D4rt test script: Tests TextSelectionPoint from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelectionPoint test executing');
  final results = <String>[];

  // ========== Section 1: Basic Creation ==========
  print('--- Section 1: Basic TextSelectionPoint Creation ---');

  final point1 = TextSelectionPoint(Offset(100.0, 50.0), TextDirection.ltr);
  print('Created TextSelectionPoint: ${point1.runtimeType}');
  print('point: ${point1.point}');
  print('direction: ${point1.direction}');
  results.add('Basic creation successful');

  // ========== Section 2: Various Points ==========
  print('--- Section 2: Various Points ---');

  final points = [
    Offset(0, 0),
    Offset(50, 25),
    Offset(100, 100),
    Offset(200, 150),
    Offset(500, 300),
  ];
  for (final point in points) {
    final tsp = TextSelectionPoint(point, TextDirection.ltr);
    print('Point $point: ${tsp.point}');
  }
  results.add('Tested ${points.length} points');

  // ========== Section 3: Text Direction LTR ==========
  print('--- Section 3: Text Direction LTR ---');

  final ltrPoint = TextSelectionPoint(Offset(100.0, 50.0), TextDirection.ltr);
  print('LTR direction: ${ltrPoint.direction}');
  print('Is LTR: ${ltrPoint.direction == TextDirection.ltr}');
  results.add('LTR direction tested');

  // ========== Section 4: Text Direction RTL ==========
  print('--- Section 4: Text Direction RTL ---');

  final rtlPoint = TextSelectionPoint(Offset(100.0, 50.0), TextDirection.rtl);
  print('RTL direction: ${rtlPoint.direction}');
  print('Is RTL: ${rtlPoint.direction == TextDirection.rtl}');
  results.add('RTL direction tested');

  // ========== Section 5: Null Direction ==========
  print('--- Section 5: Null Direction ---');

  final nullDirPoint = TextSelectionPoint(Offset(100.0, 50.0), null);
  print('Null direction: ${nullDirPoint.direction}');
  print('Is null: ${nullDirPoint.direction == null}');
  results.add('Null direction tested');

  // ========== Section 6: Point Components ==========
  print('--- Section 6: Point Components ---');

  final point2 = TextSelectionPoint(Offset(150.0, 75.0), TextDirection.ltr);
  print('point.dx: ${point2.point.dx}');
  print('point.dy: ${point2.point.dy}');
  print('point.distance: ${point2.point.distance}');
  print('point.direction: ${point2.point.direction}');
  results.add('Point components tested');

  // ========== Section 7: Multiple Instances with Different Directions ==========
  print('--- Section 7: Multiple Instances with Different Directions ---');

  final directions = [TextDirection.ltr, TextDirection.rtl, null];
  for (final dir in directions) {
    final tsp = TextSelectionPoint(Offset(100.0, 50.0), dir);
    print('Direction $dir: ${tsp.direction}');
  }
  results.add('Tested ${directions.length} directions');

  // ========== Section 8: Negative Point Coordinates ==========
  print('--- Section 8: Negative Point Coordinates ---');

  final negativePoints = [
    Offset(-10, -5),
    Offset(-50, 25),
    Offset(100, -50),
    Offset(-200, -150),
  ];
  for (final point in negativePoints) {
    final tsp = TextSelectionPoint(point, TextDirection.ltr);
    print('Negative point $point: ${tsp.point}');
  }
  results.add('Tested ${negativePoints.length} negative points');

  // ========== Section 9: Large Point Coordinates ==========
  print('--- Section 9: Large Point Coordinates ---');

  final largePoints = [
    Offset(10000, 5000),
    Offset(50000, 25000),
    Offset(100000, 50000),
  ];
  for (final point in largePoints) {
    final tsp = TextSelectionPoint(point, TextDirection.ltr);
    print('Large point: dx=${tsp.point.dx}, dy=${tsp.point.dy}');
  }
  results.add('Tested ${largePoints.length} large points');

  // ========== Section 10: Fractional Point Coordinates ==========
  print('--- Section 10: Fractional Point Coordinates ---');

  final fractionalPoints = [
    Offset(0.1, 0.2),
    Offset(1.5, 2.5),
    Offset(10.123, 20.456),
    Offset(100.999, 200.001),
  ];
  for (final point in fractionalPoints) {
    final tsp = TextSelectionPoint(point, TextDirection.ltr);
    print('Fractional point: ${tsp.point}');
  }
  results.add('Tested ${fractionalPoints.length} fractional points');

  // ========== Section 11: Runtime Type Check ==========
  print('--- Section 11: Runtime Type Check ---');

  final point3 = TextSelectionPoint(Offset(100.0, 50.0), TextDirection.ltr);
  print('runtimeType: ${point3.runtimeType}');
  print('Is TextSelectionPoint: ${point3 is TextSelectionPoint}');
  results.add('Runtime type verified');

  // ========== Section 12: TextDirection Enum Values ==========
  print('--- Section 12: TextDirection Enum Values ---');

  for (final dir in TextDirection.values) {
    print('TextDirection.${dir.name}: index=${dir.index}');
  }
  print('Total TextDirection values: ${TextDirection.values.length}');
  results.add('TextDirection enum: ${TextDirection.values.length} values');

  print('TextSelectionPoint test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionPoint Tests'),
      Text('Results: ${results.length} sections'),
      ...results.map((r) => Text(r)),
    ],
  );
}
