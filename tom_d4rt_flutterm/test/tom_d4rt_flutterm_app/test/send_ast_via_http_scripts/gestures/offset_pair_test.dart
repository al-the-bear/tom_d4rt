import 'package:flutter/gestures.dart';
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('OffsetPair test failed: $message');
  }
  logs.add('PASS: $message');
}

dynamic build(BuildContext context) {
  print('=== OffsetPair comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final pairA = OffsetPair(
    local: const Offset(10, 20),
    global: const Offset(100, 200),
  );
  final pairB = OffsetPair(
    local: const Offset(-3, 5),
    global: const Offset(40, 80),
  );
  final zero = OffsetPair.zero;

  _expectCondition(
    pairA.local == Offset(10, 20),
    'constructor sets local on pairA',
    logs,
  );
  assertionCount++;
  _expectCondition(
    pairA.global == Offset(100, 200),
    'constructor sets global on pairA',
    logs,
  );
  assertionCount++;

  _expectCondition(
    pairB.local == Offset(-3, 5),
    'constructor sets local on pairB',
    logs,
  );
  assertionCount++;
  _expectCondition(
    pairB.global == Offset(40, 80),
    'constructor sets global on pairB',
    logs,
  );
  assertionCount++;

  _expectCondition(
    zero.local == Offset.zero,
    'OffsetPair.zero has zero local',
    logs,
  );
  assertionCount++;
  _expectCondition(
    zero.global == Offset.zero,
    'OffsetPair.zero has zero global',
    logs,
  );
  assertionCount++;

  final added = pairA + pairB;
  final subtracted = pairA - pairB;

  _expectCondition(
    added.local == Offset(7, 25),
    'operator + combines local offsets',
    logs,
  );
  assertionCount++;
  _expectCondition(
    added.global == Offset(140, 280),
    'operator + combines global offsets',
    logs,
  );
  assertionCount++;

  _expectCondition(
    subtracted.local == Offset(13, 15),
    'operator - subtracts local offsets',
    logs,
  );
  assertionCount++;
  _expectCondition(
    subtracted.global == Offset(60, 120),
    'operator - subtracts global offsets',
    logs,
  );
  assertionCount++;

  final transformed = pairA * 2.0;
  _expectCondition(
    transformed.local == Offset(20, 40),
    'operator * scales local offsets',
    logs,
  );
  assertionCount++;
  _expectCondition(
    transformed.global == Offset(200, 400),
    'operator * scales global offsets',
    logs,
  );
  assertionCount++;

  final event = PointerMoveEvent(
    position: const Offset(55, 66),
    localPosition: const Offset(5, 6),
    delta: const Offset(2, 3),
    localDelta: const Offset(1, 1),
  );

  final fromPosition = OffsetPair.fromEventPosition(event);
  final fromDelta = OffsetPair.fromEventDelta(event);

  _expectCondition(
    fromPosition.local == Offset(5, 6),
    'fromEventPosition captures local position',
    logs,
  );
  assertionCount++;
  _expectCondition(
    fromPosition.global == Offset(55, 66),
    'fromEventPosition captures global position',
    logs,
  );
  assertionCount++;

  _expectCondition(
    fromDelta.local == Offset(1, 1),
    'fromEventDelta captures local delta',
    logs,
  );
  assertionCount++;
  _expectCondition(
    fromDelta.global == Offset(2, 3),
    'fromEventDelta captures global delta',
    logs,
  );
  assertionCount++;

  print('pairA: local=${pairA.local}, global=${pairA.global}');
  print('pairB: local=${pairB.local}, global=${pairB.global}');
  print('added: local=${added.local}, global=${added.global}');
  print('subtracted: local=${subtracted.local}, global=${subtracted.global}');
  print('scaled: local=${transformed.local}, global=${transformed.global}');
  print(
    'fromPosition: local=${fromPosition.local}, global=${fromPosition.global}',
  );
  print('fromDelta: local=${fromDelta.local}, global=${fromDelta.global}');

  final summary = <String>[
    'constructors covered: named + zero + factory constructors',
    'properties covered: local/global fields',
    'behavior covered: +, -, * operators',
    'edge cases covered: negative components and pointer event factories',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== OffsetPair comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('OffsetPair Tests'),
      Text('Assertions: $assertionCount'),
      Text('pairA: ${pairA.local} / ${pairA.global}'),
      Text('Added: ${added.local} / ${added.global}'),
      Text('Subtracted: ${subtracted.local} / ${subtracted.global}'),
      Text('From delta: ${fromDelta.local} / ${fromDelta.global}'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
