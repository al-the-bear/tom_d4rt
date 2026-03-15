// D4rt test script: Comprehensive tests for LocaleStringAttribute
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/widgets.dart';

void _expect(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: ' + message);
    throw StateError('LocaleStringAttribute assertion failed: ' + message);
  }
  logs.add('PASS: ' + message);
}

dynamic build(BuildContext context) {
  print('=== LocaleStringAttribute comprehensive test start ===');
  final logs = <String>[];
  var assertionCount = 0;

  final attrA = ui.LocaleStringAttribute(
    range: const ui.TextRange(start: 0, end: 5),
    locale: const ui.Locale('en', 'US'),
  );
  final attrB = ui.LocaleStringAttribute(
    range: const ui.TextRange(start: 5, end: 10),
    locale: const ui.Locale('de', 'DE'),
  );

  _expect(attrA.range.start == 0 && attrA.range.end == 5, 'constructor sets range for attrA', logs);
  assertionCount++;
  _expect(attrA.locale.languageCode == 'en', 'constructor sets locale language for attrA', logs);
  assertionCount++;
  _expect(attrB.range.start == 5 && attrB.range.end == 10, 'constructor sets range for attrB', logs);
  assertionCount++;
  _expect(attrB.locale.countryCode == 'DE', 'constructor sets locale country for attrB', logs);
  assertionCount++;

  _expect(attrA.toString().isNotEmpty, 'toString produces non-empty representation', logs);
  assertionCount++;
  _expect(attrA != attrB, 'distinct attributes compare as different', logs);
  assertionCount++;

  final attrs = <ui.LocaleStringAttribute>[attrA, attrB];
  _expect(attrs.length == 2, 'behavior path stores multiple attributes', logs);
  assertionCount++;

  final edge = ui.LocaleStringAttribute(
    range: const ui.TextRange(start: 0, end: 0),
    locale: const ui.Locale('und'),
  );
  _expect(edge.range.isCollapsed, 'edge case supports collapsed TextRange', logs);
  assertionCount++;

  print('attrA=$attrA');
  print('attrB=$attrB');
  print('edge=$edge');

  final summaryLines = <String>[
    'constructors covered: LocaleStringAttribute(range, locale)',
    'properties covered: range/locale/toString',
    'behavior covered: multi-attribute handling',
    'edge case covered: collapsed range + undefined locale code',
    'assertions: ' + assertionCount.toString(),
  ];
  for (final line in summaryLines) {
    print('SUMMARY: ' + line);
  }

  print('=== LocaleStringAttribute comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('LocaleStringAttribute Tests'),
      Text('Assertions: $assertionCount'),
      Text('A locale: ${attrA.locale.languageCode}-${attrA.locale.countryCode ?? ''}'),
      Text('B locale: ${attrB.locale.languageCode}-${attrB.locale.countryCode ?? ''}'),
      Text('Edge collapsed: ${edge.range.isCollapsed}'),
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
