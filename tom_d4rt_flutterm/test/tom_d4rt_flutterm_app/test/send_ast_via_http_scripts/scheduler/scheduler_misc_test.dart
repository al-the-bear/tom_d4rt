// D4rt test script: Tests Priority, SchedulerPhase from scheduler
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Scheduler misc test executing');

  // ========== SCHEDULERPHASE ==========
  print('--- SchedulerPhase Tests ---');

  print('SchedulerPhase.idle: ${SchedulerPhase.idle}');
  print(
    'SchedulerPhase.transientCallbacks: ${SchedulerPhase.transientCallbacks}',
  );
  print(
    'SchedulerPhase.midFrameMicrotasks: ${SchedulerPhase.midFrameMicrotasks}',
  );
  print(
    'SchedulerPhase.persistentCallbacks: ${SchedulerPhase.persistentCallbacks}',
  );
  print(
    'SchedulerPhase.postFrameCallbacks: ${SchedulerPhase.postFrameCallbacks}',
  );
  print('SchedulerPhase.values count: ${SchedulerPhase.values.length}');

  // Test enum names and indices
  print('idle.name: ${SchedulerPhase.idle.name}');
  print('idle.index: ${SchedulerPhase.idle.index}');
  print('transientCallbacks.index: ${SchedulerPhase.transientCallbacks.index}');
  print(
    'persistentCallbacks.index: ${SchedulerPhase.persistentCallbacks.index}',
  );

  // Get current scheduler phase
  final binding = SchedulerBinding.instance;
  print('Current schedulerPhase: ${binding.schedulerPhase}');

  // ========== PRIORITY ==========
  print('--- Priority Tests ---');

  // Priority class defines scheduler task priorities
  print('Priority.idle: ${Priority.idle}');
  print('Priority.animation: ${Priority.animation}');
  print('Priority.touch: ${Priority.touch}');
  print('Priority.kMaxOffset: ${Priority.kMaxOffset}');

  // Test priority values
  final idlePriority = Priority.idle;
  print('idle.value: ${idlePriority.value}');

  final animPriority = Priority.animation;
  print('animation.value: ${animPriority.value}');

  final touchPriority = Priority.touch;
  print('touch.value: ${touchPriority.value}');

  // Test priority arithmetic (+ operator)
  final offsetPriority = Priority.idle + 100;
  print('Priority.idle + 100: ${offsetPriority.value}');

  final negOffset = Priority.animation + (-50);
  print('Priority.animation + (-50): ${negOffset.value}');

  // Priority comparison (higher value = higher priority)
  print('touch > animation: ${touchPriority.value > animPriority.value}');
  print('animation > idle: ${animPriority.value > idlePriority.value}');

  print('All scheduler misc tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scheduler Misc Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text('SchedulerPhase values: ${SchedulerPhase.values.length}'),
            Text('Current phase: ${binding.schedulerPhase}'),
            SizedBox(height: 8.0),
            Text('Priority.idle: ${idlePriority.value}'),
            Text('Priority.animation: ${animPriority.value}'),
            Text('Priority.touch: ${touchPriority.value}'),
          ],
        ),
      ),
    ),
  );
}
