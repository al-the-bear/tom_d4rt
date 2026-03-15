// D4rt test script: Tests MessageCodec interface from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// MessageCodec is the base interface for encoding/decoding platform messages
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';

dynamic build(BuildContext context) {
  print('=== MessageCodec Test Suite ===');
  print('Testing MessageCodec interface from Flutter services');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Test 1: BinaryCodec (implements MessageCodec)
  print('\n--- Test 1: BinaryCodec Implementation ---');
  try {
    final codec = const BinaryCodec();
    print('BinaryCodec implements MessageCodec<ByteData>');
    final data = ByteData(4);
    data.setInt32(0, 42);
    final encoded = codec.encodeMessage(data);
    print('Original data: 42');
    print('Encoded: $encoded');
    final decoded = codec.decodeMessage(encoded);
    print('Decoded value: ${decoded?.getInt32(0)}');
    assert(decoded?.getInt32(0) == 42, 'Should decode to 42');
    results.add('✓ BinaryCodec implementation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ BinaryCodec implementation test failed: $e');
    failCount++;
  }

  // Test 2: StringCodec (implements MessageCodec)
  print('\n--- Test 2: StringCodec Implementation ---');
  try {
    final codec = const StringCodec();
    print('StringCodec implements MessageCodec<String>');
    const message = 'Hello, Flutter!';
    final encoded = codec.encodeMessage(message);
    print('Original message: $message');
    print('Encoded bytes: ${encoded?.lengthInBytes}');
    final decoded = codec.decodeMessage(encoded);
    print('Decoded message: $decoded');
    assert(decoded == message, 'Decoded should match original');
    results.add('✓ StringCodec implementation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ StringCodec implementation test failed: $e');
    failCount++;
  }

  // Test 3: JSONMessageCodec (implements MessageCodec)
  print('\n--- Test 3: JSONMessageCodec Implementation ---');
  try {
    final codec = const JSONMessageCodec();
    print('JSONMessageCodec implements MessageCodec<Object?>');
    final message = {
      'key': 'value',
      'number': 42,
      'list': [1, 2, 3],
    };
    final encoded = codec.encodeMessage(message);
    print('Original: $message');
    print('Encoded bytes: ${encoded?.lengthInBytes}');
    final decoded = codec.decodeMessage(encoded) as Map<String, Object?>;
    print('Decoded: $decoded');
    assert(decoded['key'] == 'value', 'Key should be value');
    assert(decoded['number'] == 42, 'Number should be 42');
    results.add('✓ JSONMessageCodec implementation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ JSONMessageCodec implementation test failed: $e');
    failCount++;
  }

  // Test 4: StandardMessageCodec (implements MessageCodec)
  print('\n--- Test 4: StandardMessageCodec Implementation ---');
  try {
    final codec = const StandardMessageCodec();
    print('StandardMessageCodec implements MessageCodec<Object?>');
    final message = {
      'string': 'test',
      'int': 123,
      'double': 3.14,
      'bool': true,
      'null': null,
      'list': [1, 2, 3],
    };
    final encoded = codec.encodeMessage(message);
    print('Encoded complex message');
    final decoded = codec.decodeMessage(encoded) as Map;
    print('Decoded string: ${decoded['string']}');
    print('Decoded int: ${decoded['int']}');
    print('Decoded double: ${decoded['double']}');
    assert(decoded['string'] == 'test', 'String mismatch');
    results.add('✓ StandardMessageCodec implementation test passed');
    passCount++;
  } catch (e) {
    results.add('✗ StandardMessageCodec implementation test failed: $e');
    failCount++;
  }

  // Test 5: Encode null message
  print('\n--- Test 5: Null Message Encoding ---');
  try {
    final codec = const JSONMessageCodec();
    final encoded = codec.encodeMessage(null);
    print('Encoding null message');
    print('Result: $encoded');
    final decoded = codec.decodeMessage(encoded);
    print('Decoded: $decoded');
    results.add('✓ Null message encoding test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Null message encoding test failed: $e');
    failCount++;
  }

  // Test 6: Empty data handling
  print('\n--- Test 6: Empty Data Handling ---');
  try {
    final codec = const StringCodec();
    const emptyString = '';
    final encoded = codec.encodeMessage(emptyString);
    print('Encoding empty string');
    print('Encoded bytes: ${encoded?.lengthInBytes}');
    final decoded = codec.decodeMessage(encoded);
    print('Decoded: "$decoded"');
    assert(decoded == '', 'Should decode to empty string');
    results.add('✓ Empty data handling test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Empty data handling test failed: $e');
    failCount++;
  }

  // Test 7: Unicode string encoding
  print('\n--- Test 7: Unicode String Encoding ---');
  try {
    final codec = const StringCodec();
    const unicodeStr = '你好世界 🌍 مرحبا';
    final encoded = codec.encodeMessage(unicodeStr);
    print('Unicode string: $unicodeStr');
    print('Encoded bytes: ${encoded?.lengthInBytes}');
    final decoded = codec.decodeMessage(encoded);
    print('Decoded: $decoded');
    assert(decoded == unicodeStr, 'Unicode should match');
    results.add('✓ Unicode string encoding test passed');
    passCount++;
  } catch (e) {
    results.add('✗ Unicode string encoding test failed: $e');
    failCount++;
  }

  // Print test summary
  print('\n=== MessageCodec Test Summary ===');
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
        'MessageCodec Test Results',
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
