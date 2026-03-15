// D4rt test script: Tests TimeOfDay from Flutter material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TimeOfDay test executing');

  // Variation 1: Basic TimeOfDay
  final time1 = TimeOfDay(hour: 10, minute: 30);
  print('TimeOfDay(hour: 10, minute: 30) created');
  print('time1.hour: ${time1.hour}');
  print('time1.minute: ${time1.minute}');
  print('time1.period: ${time1.period}');
  print('time1.hourOfPeriod: ${time1.hourOfPeriod}');
  print('time1.format: ${time1.format(context)}');

  // Variation 2: Midnight
  final time2 = TimeOfDay(hour: 0, minute: 0);
  print('TimeOfDay(hour: 0, minute: 0) created - midnight');
  print('time2.hour: ${time2.hour}');
  print('time2.minute: ${time2.minute}');
  print('time2.period: ${time2.period}');
  print('time2.hourOfPeriod: ${time2.hourOfPeriod}');

  // Variation 3: End of day
  final time3 = TimeOfDay(hour: 23, minute: 59);
  print('TimeOfDay(hour: 23, minute: 59) created - end of day');
  print('time3.hour: ${time3.hour}');
  print('time3.minute: ${time3.minute}');
  print('time3.period: ${time3.period}');

  // Variation 4: Now
  final time4 = TimeOfDay.now();
  print('TimeOfDay.now() created');
  print('time4.hour: ${time4.hour}');
  print('time4.minute: ${time4.minute}');

  // Variation 5: Comparisons
  print('time1.hour == 10: ${time1.hour == 10}');
  print('time1.minute == 30: ${time1.minute == 30}');
  print('time2.hour == 0: ${time2.hour == 0}');
  print('time3.hour == 23: ${time3.hour == 23}');

  // Variation 6: Replacing
  final time5 = time1.replacing(hour: 12);
  print('time1.replacing(hour: 12) created');
  print('time5.hour: ${time5.hour}');
  print('time5.minute: ${time5.minute}');

  final time6 = time1.replacing(minute: 45);
  print('time1.replacing(minute: 45) created');
  print('time6.hour: ${time6.hour}');
  print('time6.minute: ${time6.minute}');

  print('TimeOfDay test completed');
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time1: ${time1.format(context)} (10:30)'),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time2: ${time2.format(context)} (midnight 0:00)'),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time3: ${time3.format(context)} (23:59)'),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time4 (now): ${time4.format(context)}'),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text('time5 (replaced hour): ${time5.format(context)} (12:30)'),
      ),
      Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          'time6 (replaced minute): ${time6.format(context)} (10:45)',
        ),
      ),
    ],
  );
}
