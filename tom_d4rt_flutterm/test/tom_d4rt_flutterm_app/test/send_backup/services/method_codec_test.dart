// D4rt test script: Tests MethodCodec interface from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// MethodCodec is used for encoding method calls and results in platform channels
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';

dynamic build(BuildContext context) {
  print('=== MethodCodec Test Suite ===');
  print('Testing MethodCodec interface from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: StandardMethodCodec instance
  print('\n--- Test 1: StandardMethodCodec Instance ---');
  try {
    final codec = const StandardMethodCodec();
    print('StandardMethodCodec implements MethodCodec');
    print('Uses StandardMessageCodec for serialization');
    results.add('✓ StandardMethodCodec instance test passed');
    passCount++;
  } catch (e) {
    results.add('✗ StandardMethodCodec instance test failed: $e');
    failCount++;
  }

  // Test 2: Encode method call
  print('\n--- Test 2: Encode Method Call ---');
  try {
    final codec = const StandardMethodCodec();
    final call = MethodCall('testMethod', {'arg1': 'value1', 'arg2': 42});
    final encoded = codec.encodeMethodCall(call);
    print('Method name: ${call.method}');
    print('Arguments: ${call.arguments}');
    print('Encoded bytes: ${encoded.lengthInBytes}');
    assert(encoded.lengthInBytes > 0, 'Should have encoded data');
    results.add('✓ Encode method call test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Encode method call test failed: $e');
    failCount++;
  }

  // Test 3: Decode method call
  print('\n--- Test 3: Decode Method Call ---');
  try {
    final codec = const StandardMethodCodec();
    final originalCall = MethodCall('getData', [1, 2, 3]);
    final encoded = codec.encodeMethodCall(originalCall);
    final decoded = codec.decodeMethodCall(encoded);
    print('Original method: ${originalCall.method}');
    print('Decoded method: ${decoded.method}');
    print('Original args: ${originalCall.arguments}');
    print('Decoded args: ${decoded.arguments}');
    assert(decoded.method == originalCall.method, 'Method name mismatch');
    results.add('✓ Decode method call test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Decode method call test failed: $e');
    failCount++;
  }

  // Test 4: Encode successful result
  print('\n--- Test 4: Encode Successful Result ---');
  try {
    final codec = const StandardMethodCodec();
    final result = {
      'status': 'success',
      'data': [1, 2, 3],
    };
    final encoded = codec.encodeSuccessEnvelope(result);
    print('Result: $result');
    print('Encoded bytes: ${encoded.lengthInBytes}');
    assert(encoded.lengthInBytes > 0, 'Should have encoded data');
    results.add('✓ Encode successful result test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Encode successful result test failed: $e');
    failCount++;
  }

  // Test 5: Encode error result
  print('\n--- Test 5: Encode Error Result ---');
  try {
    final codec = const StandardMethodCodec();
    final encoded = codec.encodeErrorEnvelope(
      code: 'ERROR_001',
      message: 'Something went wrong',
      details: {'errorType': 'validation'},
    );
    print('Error code: ERROR_001');
    print('Error message: Something went wrong');
    print('Encoded bytes: ${encoded.lengthInBytes}');
    assert(encoded.lengthInBytes > 0, 'Should have encoded error');
    results.add('✓ Encode error result test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Encode error result test failed: $e');
    failCount++;
  }

  // Test 6: Decode envelope (success)
  print('\n--- Test 6: Decode Success Envelope ---');
  try {
    final codec = const StandardMethodCodec();
    const successData = 'Operation completed';
    final encoded = codec.encodeSuccessEnvelope(successData);
    final decoded = codec.decodeEnvelope(encoded);
    print('Original data: $successData');
    print('Decoded data: $decoded');
    assert(decoded == successData, 'Data mismatch');
    results.add('✓ Decode success envelope test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Decode success envelope test failed: $e');
    failCount++;
  }

  // Test 7: JSONMethodCodec
  print('\n--- Test 7: JSONMethodCodec ---');
  try {
    final codec = const JSONMethodCodec();
    final call = MethodCall('jsonMethod', {'key': 'value'});
    final encoded = codec.encodeMethodCall(call);
    final decoded = codec.decodeMethodCall(encoded);
    print('JSON codec method: ${decoded.method}');
    print('JSON codec args: ${decoded.arguments}');
    assert(decoded.method == 'jsonMethod', 'Method name mismatch');
    results.add('✓ JSONMethodCodec test passed');
    passCount++;
  } catch (e) {
    results.add('✗ JSONMethodCodec test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== MethodCodec Test Summary ===');
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
        'MethodCodec Test Results',
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
