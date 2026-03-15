// D4rt test script: Tests BinaryMessenger from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:typed_data';

dynamic build(BuildContext context) {
  print('BinaryMessenger comprehensive test executing');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Helper to record test results
  void recordTest(String name, bool passed) {
    if (passed) {
      passCount++;
      results.add('✓ $name');
      print('PASS: $name');
    } else {
      failCount++;
      results.add('✗ $name');
      print('FAIL: $name');
    }
  }

  // Test 1: BinaryMessenger interface purpose
  print('\n--- Test 1: BinaryMessenger interface purpose ---');
  try {
    print('BinaryMessenger is the low-level platform channel interface');
    print('It provides:');
    print('  - Raw byte-based communication');
    print('  - Foundation for MethodChannel, BasicMessageChannel');
    print('  - Direct platform message handling');
    recordTest('BinaryMessenger interface purpose', true);
  } catch (e) {
    print('Error: $e');
    recordTest('BinaryMessenger interface purpose', false);
  }

  // Test 2: Default binary messenger
  print('\n--- Test 2: Default binary messenger ---');
  try {
    final messenger = ServicesBinding.instance.defaultBinaryMessenger;
    print('Default messenger type: ${messenger.runtimeType}');
    assert(messenger != null);
    recordTest('Default binary messenger', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Default binary messenger', false);
  }

  // Test 3: Channel name conventions
  print('\n--- Test 3: Channel name conventions ---');
  try {
    final channels = [
      'flutter/platform',
      'flutter/navigation',
      'flutter/textinput',
      'flutter/lifecycle',
      'flutter/keyevent',
      'flutter/system',
    ];
    print('Flutter system channels:');
    for (final ch in channels) {
      print('  - $ch');
      assert(ch.startsWith('flutter/'));
    }
    recordTest('Channel name conventions', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Channel name conventions', false);
  }

  // Test 4: Plugin channel naming
  print('\n--- Test 4: Plugin channel naming ---');
  try {
    final pluginChannels = [
      'plugins.flutter.io/path_provider',
      'plugins.flutter.io/shared_preferences',
      'plugins.flutter.io/url_launcher',
      'dev.flutter.pigeon.MyApi',
    ];
    print('Plugin channel naming:');
    for (final ch in pluginChannels) {
      print('  - $ch');
    }
    recordTest('Plugin channel naming', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Plugin channel naming', false);
  }

  // Test 5: ByteData creation
  print('\n--- Test 5: ByteData creation ---');
  try {
    final bytes = Uint8List.fromList([0x01, 0x02, 0x03, 0x04]);
    final byteData = ByteData.view(bytes.buffer);
    assert(byteData.lengthInBytes == 4);
    print('ByteData length: ${byteData.lengthInBytes}');
    final firstByte = byteData.getUint8(0);
    print('First byte: 0x${firstByte.toRadixString(16)}');
    assert(firstByte == 0x01);
    recordTest('ByteData creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('ByteData creation', false);
  }

  // Test 6: ByteData write operations
  print('\n--- Test 6: ByteData write operations ---');
  try {
    final byteData = ByteData(8);
    byteData.setUint8(0, 0xFF);
    byteData.setUint16(1, 0x1234, Endian.big);
    byteData.setUint32(3, 0xDEADBEEF, Endian.big);
    print('Wrote: 0xFF at 0');
    print('Wrote: 0x1234 at 1 (2 bytes)');
    print('Wrote: 0xDEADBEEF at 3 (4 bytes)');
    assert(byteData.getUint8(0) == 0xFF);
    recordTest('ByteData write operations', true);
  } catch (e) {
    print('Error: $e');
    recordTest('ByteData write operations', false);
  }

  // Test 7: Send method concept
  print('\n--- Test 7: Send method concept ---');
  try {
    print('BinaryMessenger.send(String channel, ByteData? message):');
    print('  - Sends message to platform');
    print('  - Returns Future<ByteData?>');
    print('  - Response is platform reply');
    print('  - Null message is valid');
    recordTest('Send method concept', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Send method concept', false);
  }

  // Test 8: setMessageHandler concept
  print('\n--- Test 8: setMessageHandler concept ---');
  try {
    print('setMessageHandler(String channel, MessageHandler? handler):');
    print('  - Registers handler for incoming messages');
    print('  - Handler: Future<ByteData?> Function(ByteData?)');
    print('  - Null handler unregisters');
    print('  - Only one handler per channel');
    recordTest('setMessageHandler concept', true);
  } catch (e) {
    print('Error: $e');
    recordTest('setMessageHandler concept', false);
  }

  // Test 9: handlePlatformMessage concept
  print('\n--- Test 9: handlePlatformMessage concept ---');
  try {
    print('handlePlatformMessage(channel, data, callback):');
    print('  - Called by engine for incoming messages');
    print('  - Routes to registered handler');
    print('  - Callback sends response back');
    print('  - Core of message routing');
    recordTest('handlePlatformMessage concept', true);
  } catch (e) {
    print('Error: $e');
    recordTest('handlePlatformMessage concept', false);
  }

  // Test 10: Mock messenger for testing
  print('\n--- Test 10: Mock messenger for testing ---');
  try {
    print('TestDefaultBinaryMessenger:');
    print('  - Used in widget tests');
    print('  - setMockMethodCallHandler for mocking');
    print('  - setMockDecodedMessageHandler');
    print('  - Allows isolated testing');
    recordTest('Mock messenger for testing', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Mock messenger for testing', false);
  }

  // Test 11: Endianness handling
  print('\n--- Test 11: Endianness handling ---');
  try {
    final byteData = ByteData(4);
    byteData.setUint32(0, 0x12345678, Endian.big);
    final bigEndian = byteData.getUint32(0, Endian.big);
    final littleEndian = byteData.getUint32(0, Endian.little);
    print('Value: 0x12345678');
    print('Read as big endian: 0x${bigEndian.toRadixString(16)}');
    print('Read as little endian: 0x${littleEndian.toRadixString(16)}');
    assert(bigEndian == 0x12345678);
    recordTest('Endianness handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Endianness handling', false);
  }

  // Print summary
  print('\n========================================');
  print('BinaryMessenger Test Summary');
  print('========================================');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('Total:  ${passCount + failCount}');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'BinaryMessenger Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount | Failed: $failCount',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
