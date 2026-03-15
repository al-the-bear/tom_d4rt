// D4rt test script: Tests SelectionEdgeUpdateEvent from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionEdgeUpdateEvent test executing');

  // ========== Basic SelectionEdgeUpdateEvent creation ==========
  print('--- Basic SelectionEdgeUpdateEvent ---');
  final event1 = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 200.0),
  );
  print('  created: ${event1.runtimeType}');
  print('  type: ${event1.type}');
  print('  globalPosition: ${event1.globalPosition}');

  // ========== ForStart factory ==========
  print('--- ForStart factory ---');
  final startEvent = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(50.0, 75.0),
  );
  print('  startEvent created');
  print('  globalPosition: ${startEvent.globalPosition}');
  print('  type: ${startEvent.type}');

  // ========== ForEnd factory ==========
  print('--- ForEnd factory ---');
  final endEvent = SelectionEdgeUpdateEvent.forEnd(
    globalPosition: Offset(250.0, 300.0),
  );
  print('  endEvent created');
  print('  globalPosition: ${endEvent.globalPosition}');
  print('  type: ${endEvent.type}');

  // ========== Granularity options ==========
  print('--- Granularity options ---');
  final eventWithCharGranularity = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
    granularity: TextGranularity.character,
  );
  final eventWithWordGranularity = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
    granularity: TextGranularity.word,
  );
  final eventWithLineGranularity = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
    granularity: TextGranularity.line,
  );
  final eventWithDocGranularity = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
    granularity: TextGranularity.document,
  );
  print('  character granularity: ${eventWithCharGranularity.granularity}');
  print('  word granularity: ${eventWithWordGranularity.granularity}');
  print('  line granularity: ${eventWithLineGranularity.granularity}');
  print('  document granularity: ${eventWithDocGranularity.granularity}');

  // ========== TextGranularity enumeration ==========
  print('--- TextGranularity values ---');
  for (final granularity in TextGranularity.values) {
    print('  ${granularity.name}: ${granularity.index}');
  }
  print('  Total granularity values: ${TextGranularity.values.length}');

  // ========== Different positions ==========
  print('--- Different positions ---');
  final zeroPos = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset.zero,
  );
  final negativePos = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(-50.0, -50.0),
  );
  final largePos = SelectionEdgeUpdateEvent.forEnd(
    globalPosition: Offset(10000.0, 20000.0),
  );
  print('  zero position: ${zeroPos.globalPosition}');
  print('  negative position: ${negativePos.globalPosition}');
  print('  large position: ${largePos.globalPosition}');

  // ========== Event type verification ==========
  print('--- Event type ---');
  print('  event1.type: ${event1.type}');
  print(
    '  is startEdgeUpdate: ${event1.type == SelectionEventType.startEdgeUpdate}',
  );
  print(
    '  is endEdgeUpdate: ${event1.type == SelectionEventType.endEdgeUpdate}',
  );

  // ========== Multiple events ==========
  print('--- Multiple events ---');
  final events = <SelectionEdgeUpdateEvent>[
    SelectionEdgeUpdateEvent.forStart(globalPosition: Offset(0.0, 0.0)),
    SelectionEdgeUpdateEvent.forStart(globalPosition: Offset(50.0, 50.0)),
    SelectionEdgeUpdateEvent.forEnd(globalPosition: Offset(100.0, 100.0)),
    SelectionEdgeUpdateEvent.forEnd(globalPosition: Offset(150.0, 150.0)),
  ];
  print('  Created ${events.length} events');
  for (var i = 0; i < events.length; i++) {
    print('  [$i] type: ${events[i].type}, pos: ${events[i].globalPosition}');
  }

  // ========== Equality behavior ==========
  print('--- Equality behavior ---');
  final eventA = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
  );
  final eventB = SelectionEdgeUpdateEvent.forStart(
    globalPosition: Offset(100.0, 100.0),
  );
  print('  eventA == eventA: ${eventA == eventA}');
  print('  eventA == eventB: ${eventA == eventB}');
  print(
    '  eventA.globalPosition == eventB.globalPosition: ${eventA.globalPosition == eventB.globalPosition}',
  );

  // ========== ToString ==========
  print('--- ToString ---');
  print('  event1.toString(): ${event1.toString()}');

  print('SelectionEdgeUpdateEvent test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectionEdgeUpdateEvent Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Start event position: ${startEvent.globalPosition}'),
          Text('End event position: ${endEvent.globalPosition}'),
          Text('Granularity types: ${TextGranularity.values.length}'),
          Text('Events created: ${events.length}'),
        ],
      ),
    ),
  );
}
