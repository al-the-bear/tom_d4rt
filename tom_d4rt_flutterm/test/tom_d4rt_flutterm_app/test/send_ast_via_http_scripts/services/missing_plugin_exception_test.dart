// D4rt test script: Tests MissingPluginException class from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// MissingPluginException is thrown when a platform channel method has no handler
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('=== MissingPluginException Test Suite ===');
  print('Testing MissingPluginException class from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: Create MissingPluginException with message
  print('\n--- Test 1: Create MissingPluginException ---');
  try {
    final exception = MissingPluginException('Plugin not found');
    print('Created exception: $exception');
    print('Message: ${exception.message}');
    assert(exception.message == 'Plugin not found', 'Message mismatch');
    results.add('✓ MissingPluginException creation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ MissingPluginException creation test failed: $e');
    failCount++;
  }

  // Test 2: Exception without message
  print('\n--- Test 2: Exception Without Message ---');
  try {
    final exception = MissingPluginException();
    print('Created exception without message');
    print('Message: ${exception.message}');
    assert(exception.message == null, 'Message should be null');
    results.add('✓ Exception without message test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Exception without message test failed: $e');
    failCount++;
  }

  // Test 3: Exception toString
  print('\n--- Test 3: Exception toString ---');
  try {
    final exception = MissingPluginException('test_channel');
    final str = exception.toString();
    print('toString: $str');
    assert(str.contains('MissingPluginException'), 'Should contain class name');
    results.add('✓ Exception toString test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Exception toString test failed: $e');
    failCount++;
  }

  // Test 4: Throw and catch exception
  print('\n--- Test 4: Throw and Catch Exception ---');
  try {
    try {
      throw MissingPluginException('Method not implemented');
    } on MissingPluginException catch (e) {
      print('Caught MissingPluginException');
      print('Message: ${e.message}');
      assert(e.message == 'Method not implemented', 'Message mismatch');
    }
    results.add('✓ Throw and catch exception test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Throw and catch exception test failed: $e');
    failCount++;
  }

  // Test 5: Exception type checking
  print('\n--- Test 5: Exception Type Checking ---');
  try {
    final exception = MissingPluginException('test');
    print('Exception type: ${exception.runtimeType}');
    assert(exception is Exception, 'Should be an Exception');
    assert(exception is! Error, 'Should not be an Error');
    results.add('✓ Exception type checking test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Exception type checking test failed: $e');
    failCount++;
  }

  // Test 6: Common use case scenarios
  print('\n--- Test 6: Common Use Case Scenarios ---');
  try {
    // Scenario 1: Channel not registered
    final channelError = MissingPluginException(
        'No implementation found for method getName on channel example.com/test');
    print('Channel error: ${channelError.message}');
    
    // Scenario 2: Platform not supported
    final platformError = MissingPluginException(
        'Plugin example_plugin not available on web platform');
    print('Platform error: ${platformError.message}');
    
    // Scenario 3: Method not implemented
    final methodError = MissingPluginException(
        'Method doSomething has not been implemented');
    print('Method error: ${methodError.message}');
    
    results.add('✓ Common use case scenarios test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Common use case scenarios test failed: $e');
    failCount++;
  }

  // Test 7: Exception handling patterns
  print('\n--- Test 7: Exception Handling Patterns ---');
  try {
    Future<void> simulatePluginCall() async {
      throw MissingPluginException('simulated.channel');
    }
    
    try {
      await simulatePluginCall();
    } on MissingPluginException catch (e) {
      print('Handled missing plugin: ${e.message}');
      // In real code, might provide fallback behavior
    }
    results.add('✓ Exception handling patterns test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Exception handling patterns test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== MissingPluginException Test Summary ===');
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
      Text('MissingPluginException Test Results',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Tests passed: $passCount'),
      Text('Tests failed: $failCount'),
      SizedBox(height: 8),
      ...results.map((r) => Text(r)),
    ],
  );
}
