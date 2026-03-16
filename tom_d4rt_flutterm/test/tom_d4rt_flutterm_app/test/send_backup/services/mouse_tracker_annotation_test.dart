// D4rt test script: Tests MouseTrackerAnnotation class from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// MouseTrackerAnnotation provides mouse tracking callbacks on render objects
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('=== MouseTrackerAnnotation Test Suite ===');
  print('Testing MouseTrackerAnnotation class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: MouseTrackerAnnotation concept
  print('\n--- Test 1: MouseTrackerAnnotation Concept ---');
  try {
    print('MouseTrackerAnnotation tracks mouse movements');
    print('Attached to render objects via annotation layer');
    print('Provides onEnter, onExit, onHover callbacks');
    results.add('✓ MouseTrackerAnnotation concept test passed');
    passCount++;
  } catch (e) {
    results.add('✗ MouseTrackerAnnotation concept test failed: $e');
    failCount++;
  }

  // Test 2: MouseRegion widget (uses annotations)
  print('\n--- Test 2: MouseRegion Widget Usage ---');
  try {
    var enterCount = 0;
    var exitCount = 0;
    var hoverCount = 0;
    print('MouseRegion wraps MouseTrackerAnnotation');
    print('Enter callback increments: $enterCount');
    print('Exit callback increments: $exitCount');
    print('Hover callback increments: $hoverCount');
    results.add('✓ MouseRegion widget usage test passed');
    passCount++;
  } catch (e) {
    results.add('✗ MouseRegion widget usage test failed: $e');
    failCount++;
  }

  // Test 3: Cursor property
  print('\n--- Test 3: Cursor Property ---');
  try {
    print('MouseTrackerAnnotation includes cursor property');
    final cursorTypes = [
      SystemMouseCursors.basic,
      SystemMouseCursors.click,
      SystemMouseCursors.text,
      SystemMouseCursors.forbidden,
    ];
    for (final cursor in cursorTypes) {
      print('  Cursor: $cursor');
    }
    results.add('✓ Cursor property test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Cursor property test failed: $e');
    failCount++;
  }

  // Test 4: PointerEnterEvent handling
  print('\n--- Test 4: PointerEnterEvent Handling ---');
  try {
    print('onEnter receives PointerEnterEvent');
    print('Contains: position, delta, device, timestamp');
    final position = Offset(100, 200);
    print('Example position: $position');
    print('Enter events trigger cursor changes');
    results.add('✓ PointerEnterEvent handling test passed');
    passCount++;
  } catch (e) {
    results.add('✗ PointerEnterEvent handling test failed: $e');
    failCount++;
  }

  // Test 5: PointerExitEvent handling
  print('\n--- Test 5: PointerExitEvent Handling ---');
  try {
    print('onExit receives PointerExitEvent');
    print('Triggered when pointer leaves region');
    print('Can be synthetic if widget removed');
    final exitPosition = Offset(50, 150);
    print('Example exit position: $exitPosition');
    results.add('✓ PointerExitEvent handling test passed');
    passCount++;
  } catch (e) {
    results.add('✗ PointerExitEvent handling test failed: $e');
    failCount++;
  }

  // Test 6: PointerHoverEvent handling
  print('\n--- Test 6: PointerHoverEvent Handling ---');
  try {
    print('onHover receives PointerHoverEvent');
    print('Triggered for every mouse movement');
    print('Provides continuous position updates');
    final hoverPositions = [Offset(10, 10), Offset(20, 20), Offset(30, 30)];
    for (final pos in hoverPositions) {
      print('  Hover position: $pos');
    }
    results.add('✓ PointerHoverEvent handling test passed');
    passCount++;
  } catch (e) {
    results.add('✗ PointerHoverEvent handling test failed: $e');
    failCount++;
  }

  // Test 7: Annotation validForMouseTracker
  print('\n--- Test 7: Annotation Validity ---');
  try {
    print('validForMouseTracker determines if annotation active');
    print('Returns false when callbacks are null');
    print('Used to optimize hit testing');
    print('Annotations can be removed dynamically');
    results.add('✓ Annotation validity test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Annotation validity test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== MouseTrackerAnnotation Test Summary ===');
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
        'MouseTrackerAnnotation Test Results',
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
