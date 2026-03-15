// D4rt test script: Comprehensive tests for Size
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

void _expect(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: ' + message);
    throw StateError('Size assertion failed: ' + message);
  }
  logs.add('PASS: ' + message);
}

dynamic build(BuildContext context) {
  print('=== Size comprehensive test start ===');
  final logs = <String>[];
  var assertionCount = 0;

  const s1 = ui.Size(100, 50);
  const s2 = ui.Size.square(40);
  const s3 = ui.Size.fromWidth(120);
  const s4 = ui.Size.fromHeight(90);

  _expect(s1.width == 100 && s1.height == 50, 'primary constructor sets width/height', logs);
  assertionCount++;
  _expect(s2.width == 40 && s2.height == 40, 'square constructor sets equal sides', logs);
  assertionCount++;
  _expect(s3.width == 120 && s3.height == 0, 'fromWidth behavior validated', logs);
  assertionCount++;
  _expect(s4.height == 90 && s4.width == 0, 'fromHeight behavior validated', logs);
  assertionCount++;

  _expect(s1.shortestSide == 50, 'shortestSide computed correctly', logs);
  assertionCount++;
  _expect(s1.longestSide == 100, 'longestSide computed correctly', logs);
  assertionCount++;

  final added = s1 + const ui.Size(10, 20);
  final subtracted = s1 - const ui.Size(10, 20);
  final multiplied = s1 * 2.0;
  final divided = s1 / 2.0;

  _expect(added == const ui.Size(110, 70), 'operator + works', logs);
  assertionCount++;
  _expect(subtracted == const ui.Size(90, 30), 'operator - works', logs);
  assertionCount++;
  _expect(multiplied == const ui.Size(200, 100), 'operator * works', logs);
  assertionCount++;
  _expect(divided == const ui.Size(50, 25), 'operator / works', logs);
  assertionCount++;

  const edge = ui.Size.zero;
  _expect(edge.isEmpty, 'Size.zero reports isEmpty', logs);
  assertionCount++;
  _expect(edge.width == 0 && edge.height == 0, 'Size.zero dimensions are zero', logs);
  assertionCount++;

  print('s1=$s1 s2=$s2 s3=$s3 s4=$s4 edge=$edge');
  print('added=$added subtracted=$subtracted multiplied=$multiplied divided=$divided');

  final summaryLines = <String>[
    'constructors covered: default/square/fromWidth/fromHeight',
    'properties covered: width/height/shortestSide/longestSide/isEmpty',
    'behavior covered: arithmetic operators',
    'edge case covered: Size.zero',
    'assertions: ' + assertionCount.toString(),
  ];
  for (final line in summaryLines) {
    print('SUMMARY: ' + line);
  }

  print('=== Size comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Size Tests'),
      Text('Assertions: $assertionCount'),
      Text('s1: $s1'),
      Text('added: $added'),
      Text('edge isEmpty: ${edge.isEmpty}'),
      const Text('Summary widget generated successfully'),
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
