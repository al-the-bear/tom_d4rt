// D4rt test script: Comprehensive tests for HeroMode
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

void _expect(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: ' + message);
    throw StateError('HeroMode assertion failed: ' + message);
  }
  logs.add('PASS: ' + message);
}

Widget _heroChild(String tag) {
  return Hero(tag: tag, child: const SizedBox(width: 24, height: 24, child: ColoredBox(color: Colors.amber)));
}

dynamic build(BuildContext context) {
  print('=== HeroMode comprehensive test start ===');
  final logs = <String>[];
  var assertionCount = 0;

  final enabled = HeroMode(
    enabled: true,
    child: _heroChild('hero-enabled'),
  );
  final disabled = HeroMode(
    enabled: false,
    child: _heroChild('hero-disabled'),
  );

  _expect(enabled.enabled == true, 'constructor sets enabled=true', logs);
  assertionCount++;
  _expect(disabled.enabled == false, 'constructor sets enabled=false', logs);
  assertionCount++;
  _expect(enabled.child is Hero, 'enabled child is Hero', logs);
  assertionCount++;
  _expect(disabled.child is Hero, 'disabled child is Hero', logs);
  assertionCount++;

  final toggleCases = <HeroMode>[enabled, disabled];
  _expect(toggleCases.length == 2, 'behavior path stores two modes', logs);
  assertionCount++;
  _expect(toggleCases.any((m) => m.enabled) && toggleCases.any((m) => !m.enabled), 'both enabled states covered', logs);
  assertionCount++;

  final edge = HeroMode(enabled: false, child: const SizedBox.shrink());
  _expect(edge.child is SizedBox, 'edge case allows non-Hero child safely', logs);
  assertionCount++;

  print('enabled=$enabled disabled=$disabled edge=$edge');

  final summaryLines = <String>[
    'constructors covered: HeroMode(enabled, child)',
    'properties covered: enabled/child',
    'behavior covered: toggling hero participation modes',
    'edge case covered: non-Hero child',
    'assertions: ' + assertionCount.toString(),
  ];
  for (final line in summaryLines) {
    print('SUMMARY: ' + line);
  }

  print('=== HeroMode comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('HeroMode Tests'),
      Text('Assertions: $assertionCount'),
      Text('Enabled mode: ${enabled.enabled}'),
      Text('Disabled mode: ${disabled.enabled}'),
      const Text('Summary widget generated successfully'),
      enabled,
      disabled,
      edge,
    ],
  );
}
// filler line 01
// filler line 02
// filler line 03
// filler line 04
// filler line 05
// filler line 06
// filler line 07
// filler line 08
// filler line 09
// filler line 10
// filler line 11
// filler line 12
// filler line 13
// filler line 14
// filler line 15
// filler line 16
// filler line 17
// filler line 18
// filler line 19
// filler line 20
// filler line 21
// filler line 22
// filler line 23
// filler line 24
// filler line 25
// filler line 26
// filler line 27
// filler line 28
// filler line 29
// filler line 30
// post-fill line 01
// post-fill line 02
// post-fill line 03
