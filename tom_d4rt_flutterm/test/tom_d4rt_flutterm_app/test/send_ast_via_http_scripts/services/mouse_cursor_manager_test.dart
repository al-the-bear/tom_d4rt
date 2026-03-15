// D4rt test script: Tests MouseCursorManager class from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// MouseCursorManager manages cursor appearance across the application
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('=== MouseCursorManager Test Suite ===');
  print('Testing MouseCursorManager class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: MouseCursor types
  print('\n--- Test 1: MouseCursor Types ---');
  try {
    final cursors = <String, MouseCursor>{
      'basic': SystemMouseCursors.basic,
      'click': SystemMouseCursors.click,
      'forbidden': SystemMouseCursors.forbidden,
      'wait': SystemMouseCursors.wait,
      'progress': SystemMouseCursors.progress,
      'text': SystemMouseCursors.text,
      'help': SystemMouseCursors.help,
      'move': SystemMouseCursors.move,
    };
    for (final entry in cursors.entries) {
      print('Cursor ${entry.key}: ${entry.value}');
    }
    results.add('✓ MouseCursor types test passed');
    passCount++;
  } catch (e) {
    results.add('✗ MouseCursor types test failed: $e');
    failCount++;
  }

  // Test 2: SystemMouseCursors availability
  print('\n--- Test 2: SystemMouseCursors Availability ---');
  try {
    final basic = SystemMouseCursors.basic;
    final click = SystemMouseCursors.click;
    print('Basic cursor: $basic');
    print('Click cursor: $click');
    assert(basic != click, 'Cursors should be different');
    results.add('✓ SystemMouseCursors availability test passed');
    passCount++;
  } catch (e) {
    results.add('✗ SystemMouseCursors availability test failed: $e');
    failCount++;
  }

  // Test 3: Resize cursors
  print('\n--- Test 3: Resize Cursors ---');
  try {
    final resizeCursors = [
      SystemMouseCursors.resizeColumn,
      SystemMouseCursors.resizeRow,
      SystemMouseCursors.resizeUp,
      SystemMouseCursors.resizeDown,
      SystemMouseCursors.resizeLeft,
      SystemMouseCursors.resizeRight,
      SystemMouseCursors.resizeUpDown,
      SystemMouseCursors.resizeLeftRight,
    ];
    print('Available resize cursors: ${resizeCursors.length}');
    for (final cursor in resizeCursors) {
      print('  - $cursor');
    }
    results.add('✓ Resize cursors test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Resize cursors test failed: $e');
    failCount++;
  }

  // Test 4: Corner resize cursors
  print('\n--- Test 4: Corner Resize Cursors ---');
  try {
    final cornerCursors = [
      SystemMouseCursors.resizeUpLeft,
      SystemMouseCursors.resizeUpRight,
      SystemMouseCursors.resizeDownLeft,
      SystemMouseCursors.resizeDownRight,
      SystemMouseCursors.resizeUpLeftDownRight,
      SystemMouseCursors.resizeUpRightDownLeft,
    ];
    print('Corner resize cursors: ${cornerCursors.length}');
    for (final cursor in cornerCursors) {
      print('  - $cursor');
    }
    results.add('✓ Corner resize cursors test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Corner resize cursors test failed: $e');
    failCount++;
  }

  // Test 5: MouseCursor.defer
  print('\n--- Test 5: MouseCursor.defer ---');
  try {
    final deferred = MouseCursor.defer;
    print('MouseCursor.defer: $deferred');
    print('Used to defer cursor decision to ancestors');
    results.add('✓ MouseCursor.defer test passed');
    passCount++;
  } catch (e) {
    results.add('✗ MouseCursor.defer test failed: $e');
    failCount++;
  }

  // Test 6: MouseCursor.uncontrolled
  print('\n--- Test 6: MouseCursor.uncontrolled ---');
  try {
    final uncontrolled = MouseCursor.uncontrolled;
    print('MouseCursor.uncontrolled: $uncontrolled');
    print('Used when widget does not control cursor');
    results.add('✓ MouseCursor.uncontrolled test passed');
    passCount++;
  } catch (e) {
    results.add('✗ MouseCursor.uncontrolled test failed: $e');
    failCount++;
  }

  // Test 7: Special purpose cursors
  print('\n--- Test 7: Special Purpose Cursors ---');
  try {
    final specialCursors = <String, MouseCursor>{
      'none': SystemMouseCursors.none,
      'grab': SystemMouseCursors.grab,
      'grabbing': SystemMouseCursors.grabbing,
      'noDrop': SystemMouseCursors.noDrop,
      'alias': SystemMouseCursors.alias,
      'copy': SystemMouseCursors.copy,
      'disappearing': SystemMouseCursors.disappearing,
      'allScroll': SystemMouseCursors.allScroll,
      'cell': SystemMouseCursors.cell,
      'contextMenu': SystemMouseCursors.contextMenu,
    };
    print('Special purpose cursors:');
    for (final entry in specialCursors.entries) {
      print('  ${entry.key}: ${entry.value}');
    }
    results.add('✓ Special purpose cursors test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Special purpose cursors test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== MouseCursorManager Test Summary ===');
  print('Total tests: ${passCount + failCount}');
  print('Passed: $passCount');
  print('Failed: $failCount');
  for (final result in results) {
    print(result);
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'MouseCursorManager Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
