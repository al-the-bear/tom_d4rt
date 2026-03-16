// D4rt test script: Tests SelectionRect from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

dynamic build(BuildContext context) {
  print('SelectionRect test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create SelectionRect instance
  print('\n--- Test 1: Create SelectionRect instance ---');
  try {
    final rect = SelectionRect(
      position: 0,
      bounds: const Rect.fromLTWH(10, 20, 100, 30),
    );
    assert(rect is SelectionRect);
    print('Created SelectionRect successfully');
    print('Position: ${rect.position}');
    print('Bounds: ${rect.bounds}');
    results.add('Test 1 PASSED: Instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test position property
  print('\n--- Test 2: Test position property ---');
  try {
    final positions = [0, 5, 10, 50, 100];
    for (final pos in positions) {
      final rect = SelectionRect(position: pos, bounds: Rect.zero);
      print('Position: ${rect.position}');
      assert(rect.position == pos);
    }
    results.add('Test 2 PASSED: Position property');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test bounds with various rectangles
  print('\n--- Test 3: Test bounds with various rectangles ---');
  try {
    final boundsList = [
      const Rect.fromLTWH(0, 0, 50, 20),
      const Rect.fromLTWH(100, 200, 150, 30),
      const Rect.fromLTWH(50, 50, 200, 40),
      const Rect.fromLTRB(10, 20, 110, 50),
    ];
    for (final bounds in boundsList) {
      final rect = SelectionRect(position: 0, bounds: bounds);
      print('Bounds: ${rect.bounds}');
      print('  Width: ${rect.bounds.width}, Height: ${rect.bounds.height}');
      assert(rect.bounds == bounds);
    }
    results.add('Test 3 PASSED: Various bounds');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test direction property (if available)
  print('\n--- Test 4: Test SelectionRect with direction ---');
  try {
    final rect = SelectionRect(
      position: 5,
      bounds: const Rect.fromLTWH(10, 20, 80, 25),
      direction: TextDirection.ltr,
    );
    print('Direction: ${rect.direction}');
    print('Position: ${rect.position}');
    print('Bounds: ${rect.bounds}');
    results.add('Test 4 PASSED: Direction property');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test RTL direction
  print('\n--- Test 5: Test RTL direction ---');
  try {
    final rect = SelectionRect(
      position: 10,
      bounds: const Rect.fromLTWH(200, 30, 80, 25),
      direction: TextDirection.rtl,
    );
    print('RTL Direction: ${rect.direction}');
    print('Bounds: ${rect.bounds}');
    assert(rect.direction == TextDirection.rtl);
    results.add('Test 5 PASSED: RTL direction');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Create multiple SelectionRects for text line
  print('\n--- Test 6: Create SelectionRects for text line ---');
  try {
    final lineRects = <SelectionRect>[];
    double xOffset = 0;
    for (int i = 0; i < 10; i++) {
      final charWidth = 10.0 + (i % 3) * 2;
      final rect = SelectionRect(
        position: i,
        bounds: Rect.fromLTWH(xOffset, 0, charWidth, 20),
      );
      lineRects.add(rect);
      xOffset += charWidth;
    }
    print('Created ${lineRects.length} character rects');
    for (int i = 0; i < lineRects.length; i++) {
      print(
        'Char $i: pos=${lineRects[i].position}, x=${lineRects[i].bounds.left.toStringAsFixed(1)}',
      );
    }
    results.add('Test 6 PASSED: Text line rects');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test bounds geometry calculations
  print('\n--- Test 7: Test bounds geometry calculations ---');
  try {
    final rect = SelectionRect(
      position: 0,
      bounds: const Rect.fromLTWH(10, 20, 100, 30),
    );
    final bounds = rect.bounds;
    print('Left: ${bounds.left}');
    print('Top: ${bounds.top}');
    print('Right: ${bounds.right}');
    print('Bottom: ${bounds.bottom}');
    print('Width: ${bounds.width}');
    print('Height: ${bounds.height}');
    print('Center: ${bounds.center}');
    assert(bounds.right == 110);
    assert(bounds.bottom == 50);
    results.add('Test 7 PASSED: Geometry calculations');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Test equality comparison
  print('\n--- Test 8: Test equality comparison ---');
  try {
    final rect1 = SelectionRect(
      position: 5,
      bounds: const Rect.fromLTWH(10, 20, 100, 30),
    );
    final rect2 = SelectionRect(
      position: 5,
      bounds: const Rect.fromLTWH(10, 20, 100, 30),
    );
    final rect3 = SelectionRect(
      position: 6,
      bounds: const Rect.fromLTWH(10, 20, 100, 30),
    );
    print('rect1 == rect2: ${rect1 == rect2}');
    print('rect1 == rect3: ${rect1 == rect3}');
    results.add('Test 8 PASSED: Equality comparison');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('SelectionRect test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'SelectionRect Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text(
        'Passed: $testsPassed, Failed: $testsFailed',
        style: TextStyle(
          color: testsFailed == 0 ? Color(0xFF00AA00) : Color(0xFFAA0000),
        ),
      ),
      const SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
