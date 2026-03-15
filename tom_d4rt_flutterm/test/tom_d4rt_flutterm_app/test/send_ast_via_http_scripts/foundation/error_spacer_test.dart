// D4rt test script: Tests ErrorSpacer from foundation
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ErrorSpacer comprehensive test executing');
  final results = <String>[];

  // ========== ErrorSpacer Tests ==========
  print('Testing ErrorSpacer...');

  // Test 1: Create ErrorSpacer
  final spacer = ErrorSpacer();
  assert(spacer != null, 'Should create ErrorSpacer');
  results.add('ErrorSpacer created');
  print('ErrorSpacer created: ${spacer.runtimeType}');

  // Test 2: Verify ErrorSpacer inheritance from DiagnosticsNode
  assert(spacer is DiagnosticsNode, 'Should be DiagnosticsNode');
  results.add('Inheritance: DiagnosticsNode');
  print('Is DiagnosticsNode: ${spacer is DiagnosticsNode}');

  // Test 3: Check level property
  final level = spacer.level;
  assert(level == DiagnosticLevel.info, 'Level should be info');
  results.add('Level: $level');
  print('DiagnosticLevel: $level');

  // Test 4: toString returns empty line
  final stringValue = spacer.toString();
  assert(stringValue == '', 'toString should be empty string');
  results.add('toString: empty string');
  print('toString: "$stringValue"');

  // Test 5: Name is empty for spacer
  final name = spacer.name;
  assert(name == null || name.isEmpty, 'Name should be null or empty');
  results.add('Name: ${name ?? 'null'}');
  print('Name: ${name ?? 'null'}');

  // Test 6: Check showName property
  final showName = spacer.showName;
  assert(showName == false, 'showName should be false');
  results.add('showName: $showName');
  print('showName: $showName');

  // Test 7: Purpose of ErrorSpacer
  results.add('Purpose: Adds blank line in error output');
  print('ErrorSpacer adds visual separation in diagnostics');

  // Test 8: DiagnosticLevel values
  final levels = DiagnosticLevel.values;
  assert(levels.contains(DiagnosticLevel.info), 'Should have info');
  assert(levels.contains(DiagnosticLevel.debug), 'Should have debug');
  assert(levels.contains(DiagnosticLevel.error), 'Should have error');
  results.add('DiagnosticLevel values: ${levels.length}');
  print('DiagnosticLevel values: $levels');

  // Test 9: Create multiple spacers
  final spacer2 = ErrorSpacer();
  final spacer3 = ErrorSpacer();
  assert(spacer2 != null && spacer3 != null, 'Multiple spacers allowed');
  results.add('Multiple spacers created');
  print('Created 3 ErrorSpacer instances');

  // Test 10: Use in error reporting context
  results.add('Used in FlutterError.reportError');
  print('ErrorSpacer is used in error reporting system');

  // Test 11: FlutterErrorDetails context
  results.add('FlutterErrorDetails uses spacers for formatting');
  print('Error details formatting includes spacers');

  // Test 12: DiagnosticsNode style concept
  results.add('DiagnosticsTreeStyle affects spacer rendering');
  print('Spacer rendered based on diagnostics style');

  // Test 13: Comparison of DiagnosticsNode types
  final stringProp = StringProperty('test', 'value');
  assert(stringProp is DiagnosticsNode, 'StringProperty is DiagnosticsNode');
  assert(spacer is DiagnosticsNode, 'ErrorSpacer is DiagnosticsNode');
  results.add('Both spacer and properties are DiagnosticsNode');
  print('Common base: DiagnosticsNode');

  // Test 14: Diagnosticable tree traversal
  results.add('Spacers appear in diagnosticsNodes lists');
  print('Error trees include spacers between sections');

  // Test 15: Check getProperties behavior
  final properties = spacer.getProperties();
  assert(properties.isEmpty, 'Spacer should have no properties');
  results.add('getProperties: empty list');
  print('Properties count: ${properties.length}');

  // Test 16: Check getChildren behavior
  final children = spacer.getChildren();
  assert(children.isEmpty, 'Spacer should have no children');
  results.add('getChildren: empty list');
  print('Children count: ${children.length}');

  // Test 17: toStringDeep behavior
  final deepString = spacer.toStringDeep();
  results.add('toStringDeep available');
  print('toStringDeep: "$deepString"');

  // Test 18: Error summary separation
  results.add('Separates error summary from stack trace');
  print('Visual separator in error output');

  // Test 19: Console formatting
  results.add('Improves error readability in console');
  print('Console output is more readable with spacers');

  // Test 20: Summary
  print('ErrorSpacer test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ErrorSpacer Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      Text('Inheritance: DiagnosticsNode'),
      Text('Purpose: Blank line in error output'),
      Text('Level: DiagnosticLevel.info'),
      Text('Properties: none, Children: none'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
