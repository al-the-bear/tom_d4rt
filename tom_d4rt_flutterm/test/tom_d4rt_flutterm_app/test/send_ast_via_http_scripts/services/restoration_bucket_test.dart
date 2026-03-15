// D4rt test script: Tests RestorationBucket from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorationBucket test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Test RestorationBucket.empty constructor
  print('\n--- Test 1: Test RestorationBucket.empty constructor ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket',
      debugOwner: null,
    );
    assert(bucket is RestorationBucket);
    print('Created empty RestorationBucket');
    print('Restoration ID: ${bucket.restorationId}');
    results.add('Test 1 PASSED: Empty bucket creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test writing and reading primitive values
  print('\n--- Test 2: Test writing and reading primitive values ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket_2',
      debugOwner: null,
    );
    bucket.write<int>('counter', 42);
    bucket.write<String>('name', 'TestValue');
    bucket.write<bool>('enabled', true);
    bucket.write<double>('ratio', 3.14);
    final counter = bucket.read<int>('counter');
    final name = bucket.read<String>('name');
    final enabled = bucket.read<bool>('enabled');
    final ratio = bucket.read<double>('ratio');
    print('Counter: $counter');
    print('Name: $name');
    print('Enabled: $enabled');
    print('Ratio: $ratio');
    assert(counter == 42);
    assert(name == 'TestValue');
    results.add('Test 2 PASSED: Primitive value read/write');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test reading non-existent values
  print('\n--- Test 3: Test reading non-existent values ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket_3',
      debugOwner: null,
    );
    final missing = bucket.read<String>('nonexistent');
    print('Missing value is null: ${missing == null}');
    assert(missing == null);
    results.add('Test 3 PASSED: Non-existent value returns null');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test contains method
  print('\n--- Test 4: Test contains method ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket_4',
      debugOwner: null,
    );
    bucket.write<String>('existing_key', 'value');
    final hasExisting = bucket.contains('existing_key');
    final hasMissing = bucket.contains('missing_key');
    print('Contains existing_key: $hasExisting');
    print('Contains missing_key: $hasMissing');
    assert(hasExisting == true);
    assert(hasMissing == false);
    results.add('Test 4 PASSED: Contains method');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test remove method
  print('\n--- Test 5: Test remove method ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket_5',
      debugOwner: null,
    );
    bucket.write<String>('to_remove', 'value');
    print('Before remove, contains: ${bucket.contains('to_remove')}');
    bucket.remove<String>('to_remove');
    print('After remove, contains: ${bucket.contains('to_remove')}');
    results.add('Test 5 PASSED: Remove method');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test overwriting values
  print('\n--- Test 6: Test overwriting values ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'test_bucket_6',
      debugOwner: null,
    );
    bucket.write<int>('value', 1);
    print('Initial value: ${bucket.read<int>('value')}');
    bucket.write<int>('value', 100);
    print('Overwritten value: ${bucket.read<int>('value')}');
    assert(bucket.read<int>('value') == 100);
    results.add('Test 6 PASSED: Overwriting values');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test child bucket creation
  print('\n--- Test 7: Test child bucket creation ---');
  try {
    final parentBucket = RestorationBucket.empty(
      restorationId: 'parent',
      debugOwner: null,
    );
    final childBucket = parentBucket.claimChild(
      'child_bucket',
      debugOwner: null,
    );
    assert(childBucket != null);
    print('Child bucket created');
    print('Child restoration ID: ${childBucket.restorationId}');
    childBucket.write<String>('child_data', 'child_value');
    print('Child data: ${childBucket.read<String>('child_data')}');
    results.add('Test 7 PASSED: Child bucket creation');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Test bucket disposal
  print('\n--- Test 8: Test bucket disposal ---');
  try {
    final bucket = RestorationBucket.empty(
      restorationId: 'disposable',
      debugOwner: null,
    );
    bucket.write<String>('data', 'value');
    print('Bucket created and data written');
    bucket.dispose();
    print('Bucket disposed successfully');
    results.add('Test 8 PASSED: Bucket disposal');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RestorationBucket test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'RestorationBucket Tests',
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
