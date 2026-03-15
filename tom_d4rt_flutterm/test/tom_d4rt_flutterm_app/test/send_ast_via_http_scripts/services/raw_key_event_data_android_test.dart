// D4rt test script: Tests RawKeyEventDataAndroid from services
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventDataAndroid test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create RawKeyEventDataAndroid instance
  print('\n--- Test 1: Create RawKeyEventDataAndroid instance ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    assert(data is RawKeyEventDataAndroid);
    assert(data.keyCode == 29);
    print('Created RawKeyEventDataAndroid successfully');
    print('KeyCode: ${data.keyCode}');
    print('ScanCode: ${data.scanCode}');
    results.add('Test 1 PASSED: Instance creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test codePoint and character
  print('\n--- Test 2: Test codePoint and character ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 65,
      plainCodePoint: 65,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    print('CodePoint: ${data.codePoint}');
    print('PlainCodePoint: ${data.plainCodePoint}');
    print('Character from codePoint: ${String.fromCharCode(data.codePoint)}');
    results.add('Test 2 PASSED: CodePoint test');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test metaState flags
  print('\n--- Test 3: Test metaState flags ---');
  try {
    final metaShift = 1;
    final metaCtrl = 4096;
    final metaAlt = 2;
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: metaShift | metaCtrl,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    print('MetaState: ${data.metaState}');
    print('Shift flag included: ${(data.metaState & metaShift) != 0}');
    print('Ctrl flag included: ${(data.metaState & metaCtrl) != 0}');
    print('Alt flag included: ${(data.metaState & metaAlt) != 0}');
    results.add('Test 3 PASSED: MetaState flags');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test logical key extraction
  print('\n--- Test 4: Test logical key extraction ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    final logicalKey = data.logicalKey;
    print('Logical key: ${logicalKey.debugName}');
    print('Logical key ID: ${logicalKey.keyId}');
    results.add('Test 4 PASSED: Logical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test physical key extraction
  print('\n--- Test 5: Test physical key extraction ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    final physicalKey = data.physicalKey;
    print('Physical key: ${physicalKey.debugName}');
    print('USB HID: ${physicalKey.usbHidUsage}');
    results.add('Test 5 PASSED: Physical key extraction');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test repeatCount property
  print('\n--- Test 6: Test repeatCount property ---');
  try {
    final dataNoRepeat = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    final dataWithRepeat = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 5,
    );
    print('RepeatCount (no repeat): ${dataNoRepeat.repeatCount}');
    print('RepeatCount (with repeat): ${dataWithRepeat.repeatCount}');
    assert(dataNoRepeat.repeatCount == 0);
    assert(dataWithRepeat.repeatCount == 5);
    results.add('Test 6 PASSED: RepeatCount property');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test device identifiers
  print('\n--- Test 7: Test device identifiers ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 1234,
      productId: 5678,
      deviceId: 1,
      repeatCount: 0,
    );
    print('VendorId: ${data.vendorId}');
    print('ProductId: ${data.productId}');
    print('DeviceId: ${data.deviceId}');
    assert(data.vendorId == 1234);
    assert(data.productId == 5678);
    results.add('Test 7 PASSED: Device identifiers');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Verify inheritance from RawKeyEventData
  print('\n--- Test 8: Verify inheritance from RawKeyEventData ---');
  try {
    final data = RawKeyEventDataAndroid(
      flags: 0,
      codePoint: 97,
      plainCodePoint: 97,
      keyCode: 29,
      scanCode: 30,
      metaState: 0,
      eventSource: 0x101,
      vendorId: 0,
      productId: 0,
      deviceId: 0,
      repeatCount: 0,
    );
    assert(data is RawKeyEventData);
    print('Inherits from RawKeyEventData: true');
    print('Runtime type: ${data.runtimeType}');
    results.add('Test 8 PASSED: Inheritance verified');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('RawKeyEventDataAndroid test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'RawKeyEventDataAndroid Tests',
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
