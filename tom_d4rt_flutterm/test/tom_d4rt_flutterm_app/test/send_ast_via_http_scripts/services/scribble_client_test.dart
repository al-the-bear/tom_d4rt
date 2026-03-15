// D4rt test script: Tests ScribbleClient interface from services
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

// Mock implementation of ScribbleClient for testing
class TestScribbleClient implements ScribbleClient {
  String? _insertedText;
  bool _showToolbar = false;
  Rect _bounds = Rect.zero;

  @override
  String get currentTextEditingValue => 'Test text';

  @override
  void insertTextPlaceholder(Size size) {
    print('  insertTextPlaceholder called with size: $size');
  }

  @override
  void performSelector(String selectorName) {
    print('  performSelector called with: $selectorName');
  }

  @override
  void removeTextPlaceholder() {
    print('  removeTextPlaceholder called');
  }

  @override
  void showToolbar() {
    _showToolbar = true;
    print('  showToolbar called');
  }

  @override
  Rect get bounds => _bounds;

  set bounds(Rect r) => _bounds = r;

  @override
  bool isInScribbleRect(Rect rect) {
    final result = _bounds.overlaps(rect);
    print('  isInScribbleRect($rect): $result');
    return result;
  }
}

dynamic build(BuildContext context) {
  print('ScribbleClient test executing');
  final results = <String>[];
  int testsPassed = 0;
  int testsFailed = 0;

  // Test 1: Create ScribbleClient implementation
  print('\n--- Test 1: Create ScribbleClient implementation ---');
  try {
    final client = TestScribbleClient();
    assert(client is ScribbleClient);
    print('TestScribbleClient created successfully');
    print('Is ScribbleClient: true');
    results.add('Test 1 PASSED: Implementation creation');
    testsPassed++;
  } catch (e) {
    print('Test 1 FAILED: $e');
    results.add('Test 1 FAILED: $e');
    testsFailed++;
  }

  // Test 2: Test currentTextEditingValue property
  print('\n--- Test 2: Test currentTextEditingValue property ---');
  try {
    final client = TestScribbleClient();
    final value = client.currentTextEditingValue;
    print('Current text editing value: "$value"');
    assert(value.isNotEmpty);
    results.add('Test 2 PASSED: currentTextEditingValue');
    testsPassed++;
  } catch (e) {
    print('Test 2 FAILED: $e');
    results.add('Test 2 FAILED: $e');
    testsFailed++;
  }

  // Test 3: Test insertTextPlaceholder
  print('\n--- Test 3: Test insertTextPlaceholder ---');
  try {
    final client = TestScribbleClient();
    final sizes = [
      const Size(50, 20),
      const Size(100, 40),
      const Size(200, 80),
    ];
    for (final size in sizes) {
      client.insertTextPlaceholder(size);
    }
    print('Placeholder insertions completed');
    results.add('Test 3 PASSED: insertTextPlaceholder');
    testsPassed++;
  } catch (e) {
    print('Test 3 FAILED: $e');
    results.add('Test 3 FAILED: $e');
    testsFailed++;
  }

  // Test 4: Test removeTextPlaceholder
  print('\n--- Test 4: Test removeTextPlaceholder ---');
  try {
    final client = TestScribbleClient();
    client.insertTextPlaceholder(const Size(100, 30));
    client.removeTextPlaceholder();
    print('Placeholder removed successfully');
    results.add('Test 4 PASSED: removeTextPlaceholder');
    testsPassed++;
  } catch (e) {
    print('Test 4 FAILED: $e');
    results.add('Test 4 FAILED: $e');
    testsFailed++;
  }

  // Test 5: Test showToolbar
  print('\n--- Test 5: Test showToolbar ---');
  try {
    final client = TestScribbleClient();
    client.showToolbar();
    print('Toolbar shown successfully');
    results.add('Test 5 PASSED: showToolbar');
    testsPassed++;
  } catch (e) {
    print('Test 5 FAILED: $e');
    results.add('Test 5 FAILED: $e');
    testsFailed++;
  }

  // Test 6: Test performSelector
  print('\n--- Test 6: Test performSelector ---');
  try {
    final client = TestScribbleClient();
    final selectors = ['cut:', 'copy:', 'paste:', 'selectAll:'];
    for (final selector in selectors) {
      client.performSelector(selector);
    }
    print('Selectors performed successfully');
    results.add('Test 6 PASSED: performSelector');
    testsPassed++;
  } catch (e) {
    print('Test 6 FAILED: $e');
    results.add('Test 6 FAILED: $e');
    testsFailed++;
  }

  // Test 7: Test bounds property
  print('\n--- Test 7: Test bounds property ---');
  try {
    final client = TestScribbleClient();
    client.bounds = const Rect.fromLTWH(10, 20, 200, 50);
    print('Bounds set: ${client.bounds}');
    assert(client.bounds.left == 10);
    assert(client.bounds.top == 20);
    results.add('Test 7 PASSED: bounds property');
    testsPassed++;
  } catch (e) {
    print('Test 7 FAILED: $e');
    results.add('Test 7 FAILED: $e');
    testsFailed++;
  }

  // Test 8: Test isInScribbleRect
  print('\n--- Test 8: Test isInScribbleRect ---');
  try {
    final client = TestScribbleClient();
    client.bounds = const Rect.fromLTWH(0, 0, 100, 100);
    final overlapping = client.isInScribbleRect(
      const Rect.fromLTWH(50, 50, 100, 100),
    );
    final nonOverlapping = client.isInScribbleRect(
      const Rect.fromLTWH(200, 200, 50, 50),
    );
    print('Overlapping rect: $overlapping');
    print('Non-overlapping rect: $nonOverlapping');
    assert(overlapping == true);
    assert(nonOverlapping == false);
    results.add('Test 8 PASSED: isInScribbleRect');
    testsPassed++;
  } catch (e) {
    print('Test 8 FAILED: $e');
    results.add('Test 8 FAILED: $e');
    testsFailed++;
  }

  // Print summary
  print('\n========================================');
  print('ScribbleClient test completed');
  print('Tests passed: $testsPassed');
  print('Tests failed: $testsFailed');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ScribbleClient Tests',
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
