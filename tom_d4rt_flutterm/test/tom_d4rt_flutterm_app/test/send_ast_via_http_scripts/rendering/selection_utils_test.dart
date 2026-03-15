// D4rt test script: Tests SelectionUtils from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionUtils test executing');
  final results = <String>[];

  // ========== Section 1: SelectionUtils Overview ==========
  print('--- Section 1: SelectionUtils Overview ---');

  print('SelectionUtils provides utility methods for selection operations');
  print('It is a class with static helper methods');
  results.add('SelectionUtils is utility class');

  // ========== Section 2: getResultBasedOnRect ==========
  print('--- Section 2: getResultBasedOnRect ---');

  // Test with different rect and point combinations
  final testRect = Rect.fromLTWH(100, 100, 200, 50);
  print('Test rect: $testRect');

  // Point before rect (left of rect)
  final pointBefore = Offset(50, 125);
  final resultBefore = SelectionUtils.getResultBasedOnRect(
    testRect,
    pointBefore,
  );
  print('Point before rect ($pointBefore): $resultBefore');
  results.add('getResultBasedOnRect before: $resultBefore');

  // Point in rect
  final pointInside = Offset(200, 125);
  final resultInside = SelectionUtils.getResultBasedOnRect(
    testRect,
    pointInside,
  );
  print('Point inside rect ($pointInside): $resultInside');
  results.add('getResultBasedOnRect inside: $resultInside');

  // Point after rect (right of rect)
  final pointAfter = Offset(350, 125);
  final resultAfter = SelectionUtils.getResultBasedOnRect(testRect, pointAfter);
  print('Point after rect ($pointAfter): $resultAfter');
  results.add('getResultBasedOnRect after: $resultAfter');

  // ========== Section 3: SelectionResult Enum ==========
  print('--- Section 3: SelectionResult Enum ---');

  for (final result in SelectionResult.values) {
    print('  ${result.name}: index=${result.index}');
  }
  print('Total SelectionResult values: ${SelectionResult.values.length}');
  results.add('SelectionResult values: ${SelectionResult.values.length}');

  // ========== Section 4: Edge Cases for getResultBasedOnRect ==========
  print('--- Section 4: Edge Cases ---');

  // Point above rect
  final pointAbove = Offset(200, 50);
  final resultAbove = SelectionUtils.getResultBasedOnRect(testRect, pointAbove);
  print('Point above ($pointAbove): $resultAbove');

  // Point below rect
  final pointBelow = Offset(200, 200);
  final resultBelow = SelectionUtils.getResultBasedOnRect(testRect, pointBelow);
  print('Point below ($pointBelow): $resultBelow');

  // Point at exact left edge
  final pointAtLeft = Offset(100, 125);
  final resultAtLeft = SelectionUtils.getResultBasedOnRect(
    testRect,
    pointAtLeft,
  );
  print('Point at left edge ($pointAtLeft): $resultAtLeft');

  // Point at exact right edge
  final pointAtRight = Offset(300, 125);
  final resultAtRight = SelectionUtils.getResultBasedOnRect(
    testRect,
    pointAtRight,
  );
  print('Point at right edge ($pointAtRight): $resultAtRight');
  results.add('Edge cases tested');

  // ========== Section 5: Different Rect Sizes ==========
  print('--- Section 5: Different Rect Sizes ---');

  final smallRect = Rect.fromLTWH(0, 0, 10, 10);
  final largeRect = Rect.fromLTWH(0, 0, 1000, 500);
  final thinRect = Rect.fromLTWH(0, 0, 5, 100);
  final wideRect = Rect.fromLTWH(0, 0, 500, 20);

  print('Small rect (10x10): $smallRect');
  print('Large rect (1000x500): $largeRect');
  print('Thin rect (5x100): $thinRect');
  print('Wide rect (500x20): $wideRect');

  // Test same point with different rects
  final testPoint = Offset(50, 50);
  print('Test point: $testPoint');
  print(
    '  vs small rect: ${SelectionUtils.getResultBasedOnRect(smallRect, testPoint)}',
  );
  print(
    '  vs large rect: ${SelectionUtils.getResultBasedOnRect(largeRect, testPoint)}',
  );
  results.add('Tested various rect sizes');

  // ========== Section 6: Rect Corners ==========
  print('--- Section 6: Rect Corners ---');

  final cornerRect = Rect.fromLTWH(100, 100, 100, 100);

  // Test corners
  final topLeft = Offset(100, 100);
  final topRight = Offset(200, 100);
  final bottomLeft = Offset(100, 200);
  final bottomRight = Offset(200, 200);

  print('Rect corners test ($cornerRect):');
  print(
    '  Top-left (${topLeft}): ${SelectionUtils.getResultBasedOnRect(cornerRect, topLeft)}',
  );
  print(
    '  Top-right (${topRight}): ${SelectionUtils.getResultBasedOnRect(cornerRect, topRight)}',
  );
  print(
    '  Bottom-left (${bottomLeft}): ${SelectionUtils.getResultBasedOnRect(cornerRect, bottomLeft)}',
  );
  print(
    '  Bottom-right (${bottomRight}): ${SelectionUtils.getResultBasedOnRect(cornerRect, bottomRight)}',
  );
  results.add('Rect corners tested');

  // ========== Section 7: Negative Coordinates ==========
  print('--- Section 7: Negative Coordinates ---');

  final negativeRect = Rect.fromLTWH(-50, -50, 100, 100);
  print('Negative rect: $negativeRect');

  final negPoint1 = Offset(-75, -25);
  final negPoint2 = Offset(0, 0);
  final negPoint3 = Offset(75, 25);

  print(
    'Point in negative space ($negPoint1): ${SelectionUtils.getResultBasedOnRect(negativeRect, negPoint1)}',
  );
  print(
    'Point at origin ($negPoint2): ${SelectionUtils.getResultBasedOnRect(negativeRect, negPoint2)}',
  );
  print(
    'Point in positive space ($negPoint3): ${SelectionUtils.getResultBasedOnRect(negativeRect, negPoint3)}',
  );
  results.add('Negative coordinates tested');

  // ========== Section 8: Zero-Size Rect ==========
  print('--- Section 8: Zero-Size Rect ---');

  final zeroRect = Rect.fromLTWH(50, 50, 0, 0);
  print('Zero-size rect: $zeroRect');

  final zeroTestPoint = Offset(50, 50);
  print(
    'Point at zero rect ($zeroTestPoint): ${SelectionUtils.getResultBasedOnRect(zeroRect, zeroTestPoint)}',
  );
  results.add('Zero-size rect tested');

  // ========== Section 9: Very Large Offsets ==========
  print('--- Section 9: Very Large Offsets ---');

  final normalRect = Rect.fromLTWH(0, 0, 100, 100);
  final veryFarPoint = Offset(10000, 10000);
  final veryNegativePoint = Offset(-10000, -10000);

  print(
    'Very far point ($veryFarPoint): ${SelectionUtils.getResultBasedOnRect(normalRect, veryFarPoint)}',
  );
  print(
    'Very negative point ($veryNegativePoint): ${SelectionUtils.getResultBasedOnRect(normalRect, veryNegativePoint)}',
  );
  results.add('Large offsets tested');

  print('SelectionUtils test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionUtils Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          ...results.map(
            (r) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Text('✓ $r', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    ),
  );
}
